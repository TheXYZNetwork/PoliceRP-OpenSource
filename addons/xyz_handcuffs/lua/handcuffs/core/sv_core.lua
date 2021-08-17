local meta = FindMetaTable("Player")

function meta:XYZIsArrested()
	return self.XYZisArrested
end

function meta:XYZIsZiptied()
	return self.XYZisZiptied
end

function meta:XYZZiptie(kidnapper)
	self.ziptiedWeapons = {}
	for k, v in pairs(self:GetWeapons()) do
		if v.blockDrop then continue end
		self.ziptiedWeapons[v:GetClass()] = v.xStore and "xstore" or true
	end

	self:StripWeapons()
	self:UnLock()
	self:SetRunSpeed(160)
	self:Give("weapon_ziptied")
	self.XYZisZiptied = true
	Emote.Core.EndAnimation(self)

	hook.Call("XYZHandcuffsCuffed", nil, kidnapper, self) -- no need for a new hook
end

function meta:XYZBlindfold(kidnapper, suppressNoti) -- function name is confusing - it's a toggle.
	self.XYZisBlindfolded = (self.XYZisBlindfolded == nil and true or not self.XYZisBlindfolded)
	net.Start("hc_blindfold")
	net.Send(self)
	if not self.XYZisBlindfolded and not suppressNoti then
		XYZShit.Msg("Handcuffs", Color(200, 100, 40), "You have unblindfolded "..self:Name(), kidnapper)
		xLogs.Log(xLogs.Core.Player(kidnapper).." unblindfolded "..xLogs.Core.Player(self), "Handcuffs")
	elseif self.XYZisBlindfolded then
		XYZShit.Msg("Handcuffs", Color(200, 100, 40), "You have blindfolded "..self:Name(), kidnapper)
		xLogs.Log(xLogs.Core.Player(kidnapper).." blindfolded "..xLogs.Core.Player(self), "Handcuffs")
	end
end

function meta:XYZUnziptie(unkidnapper)
	if self:Alive() then
		if self.ziptiedWeapons then
			timer.Simple(0.5, function()
				for k, v in pairs(self.ziptiedWeapons) do
					local weapon = self:Give(k)
					if v == "xstore" then weapon.xStore = true end
				end
				self.ziptiedWeapons = {}
			end)
		end
		
		if not PrisonSystem.IsArrested(self) then
			hook.Run("PlayerLoadout", self, true)
		end
	end

	if IsValid(self.XYZdragger) then
		self.XYZdragger.XYZdragging = nil
	end
	self.XYZdragger = nil
	self:Freeze(false)
	self:SetRunSpeed(240)
	self.XYZisZiptied = false

	if self:Alive() then
		if self:GetWeapons()[1] and not (self:GetWeapons()[1]:GetClass() == "weapon_ziptied") then
			self:SelectWeapon(self:GetWeapons()[1]:GetClass())
		elseif self:GetWeapons()[2] and (self:GetWeapons()[1]:GetClass() == "weapon_ziptied") then
			self:SelectWeapon(self:GetWeapons()[2]:GetClass())
		end
	
		self:StripWeapon("weapon_ziptied")
	end

	if self.XYZisBlindfolded then
		self:XYZBlindfold(unkidnapper, true)
		if not IsValid(unkidnapper) then return end
		XYZShit.Msg("Handcuffs", Color(200, 100, 40), "You have released "..self:Name().." and removed a blindfold from them", unkidnapper)
	else
		if not IsValid(unkidnapper) then return end
		XYZShit.Msg("Handcuffs", Color(200, 100, 40), "You have released "..self:Name(), unkidnapper)
	end
	hook.Call("XYZHandcuffsUncuffed", nil, unkidnapper, self)
end

function meta:XYZArrest(arrester)
	self.arrestedWeapons = {}
	for k, v in pairs(self:GetWeapons()) do
		if v.blockDrop then continue end
		self.arrestedWeapons[v:GetClass()] = v.xStore and "xstore" or true
	end

	self:StripWeapons()
	self:UnLock()
	self:Freeze(true)
	self:Give("weapon_cuffed")
	self.XYZisArrested = true
	Emote.Core.EndAnimation(self)

	hook.Call("XYZHandcuffsCuffed", nil, arrester, self)
end

function meta:XYZUnarrest(unarrester)
	if self:Alive() then
		if self.arrestedWeapons then
			timer.Simple(0.5, function()
				for k, v in pairs(self.arrestedWeapons) do
					local weapon = self:Give(k)
					if v == "xstore" then weapon.xStore = true end
				end
				self.arrestedWeapons = {}
			end)
		end

		if not PrisonSystem.IsArrested(self) then
			hook.Run("PlayerLoadout", self, true)
		end
	end

	if IsValid(self.XYZdragger) then
		self.XYZdragger.XYZdragging = nil
	end
	self.XYZdragger = nil
	self:Freeze(false)
	self.XYZisArrested = false

	if self:Alive() then
		if self:GetWeapons()[1] and not (self:GetWeapons()[1]:GetClass() == "weapon_cuffed") then
			self:SelectWeapon(self:GetWeapons()[1]:GetClass())
		elseif self:GetWeapons()[2] and (self:GetWeapons()[1]:GetClass() == "weapon_cuffed") then
			self:SelectWeapon(self:GetWeapons()[2]:GetClass())
		end
	
		self:StripWeapon("weapon_cuffed")
	end

	hook.Call("XYZHandcuffsUncuffed", nil, unarrester, self)
end

function meta:XYZDragPlayer(ply)
	if not IsValid(ply) then return end
	if IsValid(ply.XYZdragger) and not (ply.XYZdragger == self) then return end
	if IsValid(ply.XYZdragger) and ply.XYZdragger == self then
		ply.XYZdragger = nil
		self.XYZdragging = nil
		if ply:XYZIsZiptied() then 
			ply:Freeze(false)
		end
		hook.Call("XYZHandcuffsDragging", nil, self, ply, false)
	else
		ply.XYZdragger = self
		self.XYZdragging = ply
		if ply:XYZIsZiptied() then 
			ply:Freeze(true)
		end
		hook.Call("XYZHandcuffsDragging", nil, self, ply, true)
	end
end


hook.Add("Move", "xyz_handcuff_move", function(ply, mv)
	if not IsValid(ply) then return end
    if IsValid(ply.XYZdragging) and (ply.XYZdragging:XYZIsArrested() or ply.XYZdragging:XYZIsZiptied()) then
		local draggerPos = ply:GetPos()
		local targetPos = ply.XYZdragging:GetPos()
		local dist = draggerPos:DistToSqr(targetPos)

		local ang = mv:GetMoveAngles()
        local pos = mv:GetOrigin()
        local vel = mv:GetVelocity()
		
        vel.x = vel.x * 2
        vel.y = vel.y * 2
		vel.z = 0
		
		if dist > 15000 then
			ply:XYZDragPlayer(ply.XYZdragging)
		elseif dist > 4000 then
			ply.XYZdragging:SetVelocity(vel)
		end
    end
end)


hook.Add("SetupMove", "xyz_handcuff_move", function(ply, mv)
	if not IsValid(ply) then return end
    if IsValid(ply.XYZdragging) then
        mv:SetMaxClientSpeed(mv:GetMaxClientSpeed()*0.7)
    end
end)


hook.Add("KeyPress", "xyz_handcuff_drag_player", function(ply, key)
	if not IsValid(ply) then return end
	if key == IN_USE then
        if !ply:InVehicle() then
			local target = ply:GetEyeTrace().Entity
			if IsValid(target) and target:IsPlayer() and (target:XYZIsArrested() or target:XYZIsZiptied()) then
				ply:XYZDragPlayer(target)			
			end
		end
    end
end)

hook.Add("PostPlayerDeath", "xyz_handcuff_death", function(ply)
	if not IsValid(ply) then return end
	if ply:XYZIsArrested() then
		ply:XYZUnarrest()
	elseif ply:XYZIsZiptied() then
		ply:XYZUnziptie()
	end
end)

hook.Add("VC_canEnterPassengerSeat", "xyz_handcuff_enter_seat", function(ply, seat, vehicle)
	if not IsValid(ply) then return end
    if IsValid(ply.XYZdragging) then
        ply.XYZdragging:EnterVehicle(seat)
		ply.XYZdragging.XYZdragger = nil
		ply.XYZdragging = nil
        return false
    end
end)

hook.Add("VC_CanEnterDriveBy", "xyz_handcuff_driveby", function(ply)
	if not IsValid(ply) then return end
	if ply:XYZIsArrested() or ply:XYZIsZiptied() then
		return false
	end
end)

hook.Add("VC_CanSwitchSeat", "xyz_handcuff_switchseat", function(ply)
	if not IsValid(ply) then return end
	if ply:XYZIsArrested() or ply:XYZIsZiptied() then
		return false
	end
end)

hook.Add("CanExitVehicle", "xyz_handcuff_exit_vehicle", function(Vehicle, ply)
	if not IsValid(ply) then return end
	if ply:XYZIsArrested() or ply:XYZIsZiptied() then return false end
end)

hook.Add("CanPlayerEnterVehicle", "xyz_handcuff_drive", function(ply, vehicle)
	if not IsValid(ply) then return end
	if (ply:XYZIsArrested() or ply:XYZIsZiptied()) and !ply.XYZdragger then return false end
	if IsValid(ply.XYZdragging) then return false end
end)


hook.Add("playerCanChangeTeam", "xyz_handcuff_block_change", function(ply, Team)
	if not IsValid(ply) then return end
	if ply:XYZIsArrested() or ply:XYZIsZiptied() then return false end
end)

local userCooldown = {}
net.Receive("hc_front_desk_jail", function(_, ply)
	local npc = net.ReadEntity()
	local prisoner = net.ReadEntity()
	local reasons = net.ReadTable()
	local time = 0

	if not npc:GetClass() == "handcuff_front_desk" then return end
	if npc:GetPos():Distance(ply:GetPos()) > 500 then return end
	if not IsValid(prisoner) then return end
	if not prisoner:IsPlayer() then return end
	if XYZShit.IsGovernment(prisoner:Team()) or prisoner.UCOriginalJob then return end
	if not XYZShit.IsGovernment(ply:Team()) and not ply.UCOriginalJob then return end
	if not ply:isCP() and not ply.UCOriginalJob then return end
	for k, v in pairs(reasons) do
		if k == "custom" then
            if not v.time or v.time < 1 or not v.name or v.name == "" then return end
            if v.time > 10 then 
                XYZShit.Msg("Front Desk", Color(200, 100, 40), "You can't make your custom time that high.", ply)
                return
            end
            time = time + v.time
        else
        	time = time + handcuffs.Config.Punishments[k].time
        end
    end
	if time < 1 then XYZShit.Msg("Front Desk", Color(200, 100, 40), "You need to provide atleast 1 reason for why you are jailing them.", ply) return end
	if time > 10 then time = 10 end
	if not IsValid(ply.XYZdragging) then XYZShit.Msg("Front Desk", Color(200, 100, 40), "You are currently not dragging anyone...", ply) return end
	if not prisoner:XYZIsArrested() then return end

	prisoner:XYZUnarrest()
	prisoner:Freeze(false)
	prisoner:UnLock(false)
	prisoner.hc_releaseAt = CurTime() + (time*60)

	PrisonSystem.Arrest(prisoner, time*60)

	XYZShit.Msg("Front Desk", Color(200, 100, 40), "You have been arrested for the following reasons:", prisoner)
	for k, v in pairs(reasons) do
		if k == "custom" then
			XYZShit.Msg("-", Color(255, 255, 255), v.name, prisoner)
		else
			XYZShit.Msg("-", Color(255, 255, 255), handcuffs.Config.Punishments[k].name, prisoner)
		end
	end

	if not PNC.Core.Arrests[prisoner:SteamID64()] then 
		PNC.Core.Arrests[prisoner:SteamID64()] = {}
	end
	
	-- Completely change table for database
	local nreasons = {}
	for k, v in pairs(reasons) do
		if k == "custom" then
			nreasons[#nreasons+1] = v.name
		else
			nreasons[#nreasons+1] = handcuffs.Config.Punishments[k].name
		end
	end
	PNC.Core.Arrests[prisoner:SteamID64()][os.time()] = nreasons
	
	XYZShit.DataBase.Query(string.format("INSERT INTO pnc_arrests(userid, arrestby, time, charges) VALUES('%s', '%s', %i, '%s');", prisoner:SteamID64(), ply:SteamID64(), os.time(), util.TableToJSON(nreasons)))
	XYZShit.Msg("Front Desk", Color(200, 100, 40), prisoner:Name().." has been arrested by "..ply:Name())
	
	if not userCooldown[ply] then userCooldown[ply] = 0 end
	if userCooldown[ply] < os.time() then
		ply:addMoney(math.Clamp(handcuffs.Config.JailPay * time, 0, handcuffs.Config.JailPayCap))
		userCooldown[ply] = os.time() + (10*60)
	end

	hook.Run("XYZFrontDeskJail", ply, prisoner, time)
end)

net.Receive("hc_front_desk_bail", function(_, ply)
	local npc = net.ReadEntity()
	local prisoner = net.ReadEntity()

	local isArrested, time = PrisonSystem.IsArrested(ply)
	if isArrested then return end

	if not npc:GetClass() == "handcuff_front_desk" then return end
	if npc:GetPos():Distance(ply:GetPos()) > 500 then return end
	if not IsValid(prisoner) then return end
	if not prisoner:IsPlayer() then return end

	local isArrested, time = PrisonSystem.IsArrested(prisoner)
	if not isArrested then return end

	if ply:isCP() then return end
	local time = 0
	local reasons = PNC.Core.Arrests[prisoner:SteamID64()][table.maxn(PNC.Core.Arrests[prisoner:SteamID64()])]
	for k, v in pairs(reasons) do
		if handcuffs.Config.Punishments[k].cannotBail then XYZShit.Msg("Front Desk", Color(200, 100, 40), "You can't bail "..prisoner:Name(), ply) return end
        time = time + handcuffs.Config.Punishments[k].time
    end
    local bailPrice = handcuffs.Config.BailPrice * time

	if not ply:canAfford(bailPrice) then XYZShit.Msg("Front Desk", Color(200, 100, 40), "You cannot afford the "..DarkRP.formatMoney(bailPrice).." bail price", ply) return end

	if prisoner.hc_releaseAt and (prisoner.hc_releaseAt - CurTime()) > 300 then
		XYZShit.Msg("Front Desk", Color(200, 100, 40), "Please wait "..math.Round((prisoner.hc_releaseAt - CurTime())-300).." more seconds before you try to bail "..prisoner:Name(), ply)
		return
	end

	if XYZShit.CoolDown.Check("XYZFrontDeskBail", 300, ply) then XYZShit.Msg("Front Desk", Color(200, 100, 40), "Cooldown!", ply) return end
    ply:addMoney(-bailPrice)
	prisoner:Freeze(false)
	prisoner:UnLock(false)
	
	prisoner.XYZdragger = nil
	prisoner.XYZisArrested = false
    PrisonSystem.UnArrest(prisoner)
    prisoner:XYZUnarrest(ply)


	XYZShit.Msg("Front Desk", Color(200, 100, 40), prisoner:Name().." has been bailed by "..ply:Name())
	hook.Call("XYZFrontDeskBail", nil, ply, prisoner, bailPrice)
end)

hook.Add("Inventory.CanPickup", "xyz_handcuff_block_use", function(ply, ent)
	if ply:XYZIsArrested() or ply:XYZIsZiptied() then return false end
end)
hook.Add("Inventory.CanHolster", "xyz_handcuff_block_use", function(ply, ent)
	if ply:XYZIsArrested() or ply:XYZIsZiptied() then return false end
end)
hook.Add("Inventory.CanDrop", "xyz_handcuff_block_use", function(ply, ent)
	if ply:XYZIsArrested() or ply:XYZIsZiptied() then return false end
end)
hook.Add("Inventory.CanEquip", "xyz_handcuff_block_use", function(ply, ent)
	if ply:XYZIsArrested() or ply:XYZIsZiptied() then return false end
end)

hook.Add("playerUnArrested", "xyz_handcuff_unfreeze_unjail", function(ply)
	ply:Freeze(false)
	ply:UnLock(false)
	ply.XYZisArrested = false

	gamemode.Call("PlayerLoadout", ply, true)
end)

hook.Add("Inventory.CanEquip", "xyz_handcuff_block_use", function(ply, ent)
	if ply:XYZIsArrested() or ply:XYZIsZiptied() then return false end
end)

hook.Add("canChatCommand", "xyz_handcuff_block", function(ply, command, args)
	if not (command == "advert") then return end
	if ply:XYZIsArrested() or ply:XYZIsZiptied() then return false end
end)


hook.Add("canBuyCustomEntity", "xyz_handcuff_block_handcuffs", function(ply)
	if ply:XYZIsArrested() or ply:XYZIsZiptied() then return false end
end)
hook.Add("PlayerSpawnProp", "xyz_handcuff_block_handcuffs", function(ply)
	if ply:XYZIsArrested() or ply:XYZIsZiptied() then return false end
end)

hook.Add("Inventory.CanEquip", "xyz_handcuff_block_use", function(ply, ent)
	if ply:XYZIsArrested() or ply:XYZIsZiptied() then return false end
end)

