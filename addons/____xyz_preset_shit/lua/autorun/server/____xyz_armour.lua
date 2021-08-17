XYZ_VIP_ARMOUR = {}
print("[XYZ Armour Donation Package] Loaded script")
hook.Add("PlayerSpawn", "xyz_armour", function(ply)
	if XYZ_VIP_ARMOUR[ply:SteamID64()] then
		print("[XYZ Armour Donation Package] Giving "..ply:Nick().." armour")
		timer.Simple(0, function()
			ply:SetArmor(100)
		end)
	end
end)