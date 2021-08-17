local G4SPress = {}

hook.Add("OnPlayerChangedTeam", "xyz_g4s_jobchange", function(ply, before, after)
	if before == G4S.Config.Job then
		if IsValid(ply.g4struck) then ply.g4struck:Remove() end
	end
end)

hook.Add("canLockpick", "lockpick_g4s", function(ply, ent)
	if not IsValid(ent) then return end
	if ent.isG4Struck then 
		if #ent.holdingBags > 0 then return true end
	end
end)

hook.Add("onLockpickCompleted", "lockpick_g4s_complete", function(ply, bool, ent)
	if not IsValid(ent) then return end
	if not bool then return end
	if ent.isG4Struck and #ent.holdingBags > 0 then
		local fwd = -175
		for k, v in ipairs(ent.holdingBags) do
			fwd = fwd - 25
			local bag = ents.Create("pvault_moneybag")
			bag:SetPos(ent:GetPos()+(ent:GetForward()*fwd)+(ent:GetUp()*60))
			bag:Spawn()
			bag.cooldown = CurTime()+2
			bag:SetValue(v)
		end

		ent:SetBodygroup(2, 1)
		XYZShit.Msg("Gruppe 6", G4S.Config.Color, "You robbed the G4S truck and found "..#ent.holdingBags.." money bags!", ply)
		ent.holdingBags = {}

		for _, v in pairs(player.GetAll()) do
			if not XYZShit.IsGovernment(v:Team(), true) and not v.UCOriginalJob then continue end
			net.Start("xyz_g4s_robbery")
				net.WriteVector(ent:GetPos())
			net.Send(v)
		end
	end
end)

hook.Add("CanPlayerEnterVehicle", "g4s_block_entry", function(ply, vehicle)
	if not vehicle.isG4Struck then return end

	if (not perfectVault.Core.ActiveBags[ply:SteamID64()]) or (table.IsEmpty(perfectVault.Core.ActiveBags[ply:SteamID64()])) then return end

	XYZShit.Msg("Gruppe 6", G4S.Config.Color, "Place the money bag in your truck before attempting to get in it...", ply)
	return false
end)
hook.Add("PlayerEnteredVehicle", "g4s_inform_cmd", function(ply, vehicle)
	if vehicle.isG4Struck then 
		XYZShit.Msg("Gruppe 6", G4S.Config.Color, "You can press and hold G for two seconds to unload money bags one by one.", ply)
	end
end)

hook.Add("PlayerButtonDown", "G4SDown", function(ply, button)
	if button == KEY_G and IsValid(ply:GetVehicle()) and ply:GetVehicle().isG4Struck then
		G4SPress[ply:SteamID64()] = CurTime() + 2
		XYZShit.Msg("Gruppe 6", G4S.Config.Color, "Hold for two more seconds.", ply)
	end
end)

hook.Add("PlayerButtonUp", "G4SUp", function(ply, button)
	if button == KEY_G and G4SPress[ply:SteamID64()] and ply:GetVehicle().isG4Struck then
		local vehicle = ply:GetVehicle()
		if CurTime() < G4SPress[ply:SteamID64()] then 
			G4SPress[ply:SteamID64()] = nil 
			return
		end
		G4SPress[ply:SteamID64()] = nil

		if #vehicle.holdingBags > 0 then 
			local bag = ents.Create("pvault_moneybag")
			bag:SetPos(vehicle:GetPos()+(vehicle:GetForward()*-175)+(vehicle:GetUp()*60))
			bag:Spawn()
			bag.cooldown = CurTime()+2
			bag:SetValue(vehicle.holdingBags[1])
			table.remove(vehicle.holdingBags, 1)
			XYZShit.Msg("Gruppe 6", G4S.Config.Color, "Money bag unloaded.", ply)
		end
	end
end)
