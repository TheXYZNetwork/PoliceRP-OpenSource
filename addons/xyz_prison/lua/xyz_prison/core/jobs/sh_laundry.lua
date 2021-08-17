if SERVER then
	local cartCache = {}
	PrisonSystem.RegisterJob("laundry", function(ply)
		local ent = ents.Create("xyz_prison_laundry_cart")
		ent:SetPos(ply:GetPos() - (ply:GetUp() * -20) - (ply:GetRight() * -50))
		ent:Spawn()

		cartCache[ply:SteamID64()] = ent
	end,
	function(ply)
		if IsValid(cartCache[ply:SteamID64()]) then
			cartCache[ply:SteamID64()]:Remove()
		end
	end)

	hook.Add("AllowPlayerPickup", "PrisonSystem:AllowCartPickup", function(ply, ent)
    	if ent:GetClass() == "xyz_prison_laundry_cart" then return true end
	end)

	local existingClothes = {}
	
	timer.Create("PrisonerSystem:SpawnShirt", 60, 0, function()
		-- Validate the existing clothes
		for k, v in pairs(existingClothes) do
			if not IsValid(v) then
				existingClothes[k] = nil
			end
		end

		if table.Count(existingClothes) >= table.Count(PrisonSystem.Config.Laundry.ClothePositions) then return end

		for k, v in ipairs(PrisonSystem.Config.Laundry.ClothePositions) do
			if not existingClothes[k] then
				local shirt = ents.Create("xyz_prison_laundry_clothes")
				shirt:SetPos(v.pos)
				shirt:SetAngles(v.ang)
				shirt:Spawn()
				existingClothes[k] = shirt
			end
		end
	end)
end