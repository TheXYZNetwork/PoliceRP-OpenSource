hook.Add("CanPlayerEnterVehicle", "xyzTowEnterVehicle", function(ply, ent)
	if IsValid(ent.ishooked) then return false end
	if ent:GetVehicleClass() == "tow_truck" then
		if not ent.trailer.boolLocked then return false end
	end
end )

hook.Add("VC_RM_canUse", "xyzTowRepairManCanUse", function(npc, ply)
	local mechanic = false
	for _, v in pairs(player.GetAll()) do
		if v:Team() == TEAM_MECHANIC then mechanic = true break end
	end
	if mechanic == true then
		XYZShit.Msg("Mechanic", Color(213, 195, 30), "There's a mechanic on! PM a mechanic asking for a repair", ply)
		return false
	end
end)