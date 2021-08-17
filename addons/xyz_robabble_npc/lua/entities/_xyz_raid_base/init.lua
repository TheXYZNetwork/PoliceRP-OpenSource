AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
sound.Add({name = "rob_alarm", channel = CHAN_STREAM, volume = 1.0, level = 80, pitch = { 95, 110 }, sound = "ambient/alarms/alarm1.wav"})

function ENT:Initialize()
	self:SetModel(self.Model)
	self:SetHullType(HULL_HUMAN)
	self:SetHullSizeNormal()
	self:SetNPCState(NPC_STATE_SCRIPT)
	self:SetSolid(SOLID_BBOX)
	self:SetUseType(SIMPLE_USE)
	self:DropToFloor()
	
	self:CapabilitiesAdd(CAP_ANIMATEDFACE + CAP_TURN_HEAD)

	self.Cooldown = 0
	self.RobCooldown = 0
end

function ENT:OnTakeDamage()        
	return 0    
end

function ENT:AcceptInput(name, ply, caller)
	if ply:IsPlayer() == false then return end

	if self.Cooldown > CurTime() then return end
	self.Cooldown = CurTime() + 1

	if timer.Exists("xyz_meeting_end_timer") and XYZMeeting.MeetingData.stopCrime then
		XYZShit.Msg(self.StoreName, self.StoreColor, "I can't help you right now...", ply)
		return
	end

	if timer.Exists("robbable_npc_"..self:EntIndex()) then
		XYZShit.Msg(self.StoreName, self.StoreColor, "I'm going as fast as I can, give me a second!", ply)
		return
	end

	if ply:GetPos():DistToSqr(self:GetPos()) > 50000 then
		XYZShit.Msg(self.StoreName, self.StoreColor, "I can't hear you from all the way over there.", ply)
		return
	end

	if ply:Team() == G4S.Config.Job and not (self.RobCooldown > CurTime()) then
		if not IsValid(ply.g4struck) then XYZShit.Msg(self.StoreName, self.StoreColor, "Where's your truck?", ply) return end
		XYZShit.Msg(self.StoreName, self.StoreColor, "Here's your money. Please transport it safely...", ply)
		local bag = ents.Create("pvault_moneybag")
		bag:SetPos(self:GetPos()+(self:GetForward()*40)+(self:GetUp()*60))
		bag:Spawn()
		bag.cooldown = CurTime()+2
		bag:SetValue(math.random(self.MinEarning, self.MaxEarning))
		self.RobCooldown = CurTime() + self.CooldownTime

		Quest.Core.ProgressQuest(ply, "money_guard", 3)
		Quest.Core.ProgressQuest(ply, "money_guard", 4)
		return
	elseif ply:Team() == G4S.Config.Job and self.RobCooldown > CurTime() then
		XYZShit.Msg(self.StoreName, self.StoreColor, "I don't have anything for you...", ply)
		return
	end

	if not table.HasValue(XYZShit.Jobs.Criminals.All, ply:Team()) then
		XYZShit.Msg(self.StoreName, self.StoreColor, "Hahaha, you're going to try and hold up my store? You couldn't hurt a fly.", ply)
		return
	end

	if not self.AllowedBases[ply:GetActiveWeapon().Base] then
		XYZShit.Msg(self.StoreName, self.StoreColor, "If you're going to try and hold up my store atleast bring a weapon first...", ply)
		return
	end

	if self.RobCooldown > CurTime() then
		XYZShit.Msg(self.StoreName, self.StoreColor, "Come on, someone just hit my store. I've got nothing for you to take...", ply)
		return
	end

	if not ply:Alive() then
		XYZShit.Msg(self.StoreName, self.StoreColor, "How are you going to rob me when you're dead?", ply)
		return
	end

	if player.GetCount() < self.NeededPlayers then
		XYZShit.Msg(self.StoreName, self.StoreColor, "The city is too empty to rob me...", ply)
		return
	end

	local cops = 0
	for k, v in pairs(player.GetAll()) do
		if v:isCP() then
			cops = cops + 1
		end
	end
	if cops < self.NeededCops then
		XYZShit.Msg(self.StoreName, self.StoreColor, "Come on, at least give the police a fair chance...", ply)
		return
	end
	self:StartRob(ply)
end

function ENT:StartRob(ply)
	for k, v in pairs(player.GetAll()) do
		if v:isCP() then
			XYZShit.Msg(self.StoreName, self.StoreColor, ply:Name().." is robbing "..self.StoreNameDisplay.."!", v)
		else
			XYZShit.Msg(self.StoreName, self.StoreColor, ply:Name().." has started a store robbery!", v)
		end
	end

	ply._activeRobbery = self

	ply:wanted(nil, "Store robbery", self.CooldownTime)

	xLogs.Log(xLogs.Core.Player(ply).." has started robbing "..xLogs.Core.Color(self.StoreNameDisplay, Color(0, 200, 200)), "Store Robbery")

	timer.Create("robbable_npc_"..self:EntIndex(), self.RobTime, 1, function()
		if ply:GetPos():DistToSqr(self:GetPos()) > 250000 then
			self:CancelRobbery(ply)
		else
			self:StopRobbery(ply)
		end
	end)
	self:EmitSound("rob_alarm")

	for k, v in pairs(player.GetAll()) do
		if not XYZShit.IsGovernment(v:Team(), true) and not v.UCOriginalJob then continue end
		net.Start("RobbableNPC:UI")
			net.WriteVector(self:GetPos())
		net.Send(v)
	end
end

function ENT:StopRobbery(ply)
	self:StopSound("rob_alarm")
	XYZShit.Msg(self.StoreName, self.StoreColor, ply:Name().." has successfully robbed a store!")
	self.RobCooldown = CurTime() + self.CooldownTime

	ply._activeRobbery = false

	xLogs.Log(xLogs.Core.Player(ply).." has finshed robbing "..xLogs.Core.Color(self.StoreNameDisplay, Color(0, 200, 200)), "Store Robbery")

	local bag = ents.Create("pvault_moneybag")
	bag:SetPos(self:GetPos()+(self:GetForward()*40)+(self:GetUp()*60))
	bag:Spawn()
	bag.cooldown = CurTime()+2
	bag:SetValue(math.random(self.MinEarning, self.MaxEarning))

	Quest.Core.ProgressQuest(ply, "life_of_crime", 7)
end

function ENT:CancelRobbery(ply)
	self:StopSound("rob_alarm")
	XYZShit.Msg(self.StoreName, self.StoreColor, ply:Name().." was unable to rob a store!")
	timer.Remove("robbable_npc_"..self:EntIndex())
	self.RobCooldown = CurTime() + self.CooldownTime

	xLogs.Log(xLogs.Core.Player(ply).." has failed to rob "..xLogs.Core.Color(self.StoreNameDisplay, Color(0, 200, 200)), "Store Robbery")

	ply._activeRobbery = false
end