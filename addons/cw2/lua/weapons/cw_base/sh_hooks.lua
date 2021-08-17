local function CW20_PlayerEnteredVehicle(ply, vehicle, role)
	local wep = ply:GetActiveWeapon()
	
	if IsValid(wep) then
		if wep.CW20Weapon then
			wep.dt.State = CW_ACTION -- set the state to 'action' so that the player 'holsters' it
		end
	end
end

hook.Add("PlayerEnteredVehicle", "CW20_PlayerEnteredVehicle", CW20_PlayerEnteredVehicle)