XYZ_PERMA_RAIDER = {}

print("[XYZ Perma Raider Donation Package] Loaded script")
hook.Add("PlayerSpawn", "xyz_perma_raider", function(ply)
	if XYZShit.IsGovernment(ply:Team(), true) then return end
	
	if XYZ_PERMA_RAIDER[ply:SteamID64()] then
		timer.Simple(0, function()
			print("[XYZ Perma Raider Donation Package] Giving "..ply:Nick().." pro_lockpick_update")
			ply:Give("pro_lockpick_update")
			print("[XYZ Perma Raider Donation Package] Giving "..ply:Nick().." prokeypadcracker")
			ply:Give("prokeypadcracker")
		end)
	end
end)