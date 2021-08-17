ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Armory"
ENT.Author = "Owain Owjo"
ENT.Category = "The XYZ Network Custom Stuff"
ENT.RenderGroup = RENDERGROUP_BOTH
ENT.Spawnable = true
ENT.AdminSpawnable = true

function ENT:SetupDataTables()
	self:NetworkVar("Int", 0, "Cooldown")
	self:NetworkVar("Int", 1, "Holding")
end

local function lockpickable(ply, entity)
	if entity:GetCooldown() > CurTime() then
		if CLIENT then
			XYZShit.Msg("Armory", Color(0, 50, 150), "The police armory is currently on a cooldown. Please wait roughly "..math.Round(entity:GetCooldown()-CurTime(), 0).." seconds before trying to raid it again.", ply)
		end
		return false
	end
	entity:SetCooldown(CurTime()+1)

	if SERVER and timer.Exists("xyz_meeting_end_timer") and XYZMeeting.MeetingData.stopCrime then
		XYZShit.Msg("Armory", Color(0, 50, 150), "There's an ongoing meeting...", ply)
		return false
	end

	if XYZShit.IsGovernment(ply:Team(), true) then
		if CLIENT then
			XYZShit.Msg("Armory", Color(0, 50, 150), "Police cannot rob the armory...", ply)
		end
		return false
	end

	if player.GetCount() < 10 then
		if CLIENT then
			XYZShit.Msg("Armory", Color(0, 50, 150), "Not enough players to rob the armory.", ply)
		end
		return false
	end

	local cops = 0
	for k, v in pairs(player.GetAll()) do
		if v:isCP() then cops = cops + 1 continue end
		if XYZShit.IsGovernment(v:Team()) then cops = cops + 1 continue end
	end

	if player.GetCount()*0.2 > cops then
		if CLIENT then
			XYZShit.Msg("Armory", Color(0, 50, 150), "Not enough police to rob the armory.", ply)
		end
		return false
	end

	return true
end

hook.Add("canLockpick", "xyz_armory_lockpick", function(ply, ent)
	if ent:GetClass() == "xyz_armory" then
		return lockpickable(ply, ent)
	end
end)

hook.Add("onLockpickCompleted", "xyz_armory_lockpick_complete", function(ply, bool, ent)
	if not IsValid(ent) then return end
	if ent:GetClass() == "xyz_armory" then
		if bool then
			if SERVER then
				XYZShit.Msg("Armory", Color(0, 50, 150), "Stay near the armory for 30 seconds.", ply)
				XYZShit.Msg("Armory", Color(0, 50, 150), "The police armory is being robbed.")
				hook.Call("XYZArmoryRob", nil, ply)
				ply.xyz_armory_active = ent
				timer.Create("xyz_armory_reward", 30, 1, function()
					ply.xyz_armory_active = nil

					if not IsValid(ent) or not IsValid(ent) then return end
					if ply:GetPos():Distance(ent:GetPos()) > 400 then
						XYZShit.Msg("Armory", Color(0, 50, 150), "You are too far away from the armory", ply)
						return
					end
					
					XYZShit.Msg("Armory", Color(0, 50, 150), "You have taken $100,000 from the vault.", ply)
					XYZShit.Msg("Armory", Color(0, 50, 150), ply:Name().." has robbed the police armory.")
					hook.Call("XYZArmoryRobbed", nil, ply, 100000)
					--ply:addMoney(40000)
					local bag = ents.Create("pvault_moneybag")
					bag:SetPos(ent:GetPos()+(ent:GetForward()*40))
					bag:Spawn()
					bag.cooldown = CurTime()+2
					bag:SetValue(100000)

					ent:CloseDoor()
					ent:SetCooldown(CurTime()+1200)
					ent:SetHolding(0)
					timer.Simple(1200, function()
						if not IsValid(ent) then return end
						hook.Call("XYZArmoryRestock", nil, ent, 100000)
						ent:SetHolding(100000)
					end)
				end)
				ent:OpenDoor()
			end
		end
	end
end)