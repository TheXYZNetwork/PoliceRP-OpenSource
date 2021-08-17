ENT.Type = "anim"
ENT.Base = "base_gmodentity"

ENT.Spawnable = true

function ENT:SetupDataTables()
    self:NetworkVar("Int", 1, "Cooldown")
end

ENT.consideredPolice = {}
--[[for k, v in pairs(XYZShit.Jobs.Government.All) do
	ENT.consideredPolice[v] = true
end]]


local function lockpickable(ply, entity)
	if SERVER and timer.Exists("xyz_meeting_end_timer") and XYZMeeting.MeetingData.stopCrime then
		XYZShit.Msg("President", Color(0, 50, 150), "There's a meeting ongoing...", ply)
		return false
	end
	
	if SERVER and XYZPresident.TotalMoney <= 0 then
		XYZShit.Msg("President", Color(0, 50, 150), "The president's funds are currently empty...", ply)
		return false
	end

	if entity:GetCooldown() > CurTime() then
		if SERVER then
			XYZShit.Msg("President", Color(0, 50, 150), "The president's funds are currently on a cooldown. Please wait roughly "..math.Round(entity:GetCooldown()-CurTime(), 0).." seconds before trying to raid it again.", ply)
		end
		return false
	end

	if entity.consideredPolice[ply:Team()] then
		if SERVER then
			XYZShit.Msg("President", Color(0, 50, 150), "Police cannot rob the president's funds...", ply)
		end
		return false
	end

	if player.GetCount() < 0 then
		if SERVER then
			XYZShit.Msg("President", Color(0, 50, 150), "Not enough players to rob the president's funds.", ply)
		end
		return false
	end

	local cops = 0
	local pres = nil
	for k, v in pairs(player.GetAll()) do
		if v:Team() == TEAM_PRESIDENT then pres = v end
		if v:isCP() then cops = cops + 1 continue end
		if entity.consideredPolice[v:Team()] then cops = cops + 1 continue end
	end

	if player.GetCount()*0 > cops then
		if SERVER then
			XYZShit.Msg("President", Color(0, 50, 150), "Not enough police to rob the president's funds.", ply)
		end
		return false
	end

	if not pres then
		if SERVER then
			XYZShit.Msg("President", Color(0, 50, 150), "There is currently no president online.", ply)
		end
		return false
	end

	if pres:GetPos():DistToSqr(entity:GetPos()) > 150000 then
		if SERVER then
			XYZShit.Msg("President", Color(0, 50, 150), "The President is too far away. He must be next to the computer in order to rob it.", ply)
		end
		return false
	end

	return true
end

hook.Add("canLockpick", "xyz_president_lockpick", function(ply, ent)
	if not IsValid(ent) then return end
	if ent:GetClass() == "xyz_president_comp" then
		return lockpickable(ply, ent)
	end
end)

hook.Add("onLockpickCompleted", "xyz_president_lockpick_complete", function(ply, bool, ent)
	if not IsValid(ent) then return end
	if ent:GetClass() == "xyz_president_comp" then
		if bool then
			if SERVER then
				XYZShit.Msg("President", Color(0, 50, 150), "Stay near the president's funds for 30 seconds.", ply)
				XYZShit.Msg("President", Color(0, 50, 150), "The president's funds are being robbed.")
				ply.xyz_president_active = ent
				timer.Create("xyz_president_reward", 30, 1, function()
					ply.xyz_president_active = nil

					if not IsValid(ent) or not IsValid(ent) then return end
					if ply:GetPos():Distance(ent:GetPos()) > 400 then
						XYZShit.Msg("President", Color(0, 50, 150), "You are too far away from the president's funds", ply)
						return
					end

					local seq = ent:LookupSequence("open")
					ent:ResetSequence(seq)

					ent:EmitSound("doors/metal_move1.wav")

					timer.Simple(30, function()
						local seq = ent:LookupSequence("close")
						ent:ResetSequence(seq)
					end)
					
					XYZShit.Msg("President", Color(0, 50, 150), "You have taken "..DarkRP.formatMoney(XYZPresident.TotalMoney).." from the president's funds.", ply)
					XYZShit.Msg("President", Color(0, 50, 150), ply:Name().." has robbed the president's funds.")

					local bag = ents.Create("pvault_moneybag")
					bag:SetPos(ent:GetPos()+(ent:GetForward()*40))
					bag:Spawn()
					bag.cooldown = CurTime()+2
					bag:SetValue( XYZPresident.TotalMoney )

					XYZPresident.Stats.Stolen = XYZPresident.TotalMoney
					XYZPresident.TotalMoney = 0
					ent:SetCooldown(CurTime()+1200)
				end)
			end
		end
	end
end)