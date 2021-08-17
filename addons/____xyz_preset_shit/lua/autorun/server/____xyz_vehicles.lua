-- Remove AFK vehicles
hook.Add("PlayerLeaveVehicle", "xyz_remove_ditched_cars", function(ply, vehicle)
	if vehicle:GetClass() == "prop_vehicle_prisoner_pod" then return end
	timer.Remove("xyzRemoveCar_"..vehicle:EntIndex())

	local targetOwner = vehicle.owner
	if not targetOwner and vehicle:getDoorData().owner then
		targetOwner = Player(vehicle:getDoorData().owner)
	end

	timer.Create("xyzRemoveCar_"..vehicle:EntIndex(), 9*60, 1, function()
		if not IsValid(vehicle) or not vehicle then return end
		if IsValid(targetOwner) then
			XYZShit.Msg("Server", Color(83, 210, 210), "Your car will be removed in 1 minute unless used.", targetOwner)
		end
		timer.Create("xyzRemoveCar_"..vehicle:EntIndex(), 1*60, 1, function()
			if not IsValid(vehicle) or not vehicle then return end
			if IsValid(targetOwner) then
				XYZShit.Msg("Server", Color(83, 210, 210), "Your car was removed.", targetOwner)
			end
			vehicle:Remove()
		end)
	end)
end)

hook.Add("PlayerEnteredVehicle", "xyz_remove_ditched_cars_enter", function(ply, vehicle)
	timer.Remove("xyzRemoveCar_"..vehicle:EntIndex())
end)

hook.Add("EntityRemoved", "xyz_remove_ditched_cars_removed", function(vehicle)
	timer.Remove("xyzRemoveCar_"..vehicle:EntIndex())
end)


-- Disallow selling of any vehicle
hook.Add("playerSellVehicle", "xyz_disallow_vehsell", function(ply, veh)
    return false
end)
-- Disallow battering ramming of any vehicle
hook.Add("canDoorRam", "xyz_disallow_vehbattram", function(ply, tr, ent)
	if ent:IsVehicle() then return false end
end)
-- Disallow stealing of certain vehicles
local vehicles = {
	["perryn_bearcat_g3"] = {canAccess = function(ply)
		return XYZShit.IsGovernment(ply:Team())
	end},
	["17raptor_cop_sgm"] = {canAccess = function(ply)
		return XYZShit.IsGovernment(ply:Team())
	end},
	["perryn_cadillac_dts_limousine"] = {canAccess = function(ply)
		return XYZShit.IsGovernment(ply:Team())
	end},
	["perryn_pierce_pumper"] = {canAccess = function(ply)
		return XYZShit.IsGovernment(ply:Team(), true)
	end},
	["ford_f350_ambu_lw"] = {canAccess = function(ply)
		return XYZShit.IsGovernment(ply:Team(), true)
	end},
	["bustdm"] = {canAccess = function(ply)
		return false
	end},
	["courier_trucktdm"] = {canAccess = function(ply)
		return false
	end},
	["forcrownvicpoltdm"] = {canAccess = function(ply, veh)
		if not (veh:GetSkin() == 2) then return end
		return (XYZShit.IsGovernment(ply:Team(), true))
	end},
	["chev_suburban_pol"] = {canAccess = function(ply, veh)
		if not (veh:GetSkin() == 8) then return end
		
		return (XYZShit.IsGovernment(ply:Team(), true))
	end},
	["perryn_sprinter_armed_transport"] = {canAccess = function(ply)
		return XYZShit.Jobs.Government.List[ply:Team()] or false
	end},
    ["dannio_2002_international_durastar"] = {canAccess = function(ply)
		return false
	end},
	["pbus"] = {canAccess = function(ply)
		return XYZShit.Jobs.Government.List[ply:Team()] or false
	end},
	["mcc"] = {canAccess = function(ply)
		return XYZShit.Jobs.Government.List[ply:Team()] or false
	end},
}

hook.Add("CanPlayerEnterVehicle", "xyz_disallow_vehsteal", function(ply, veh)
	if veh:isKeysOwnedBy(ply) then return true end
	if vehicles[veh:GetVehicleClass()] then
		return vehicles[veh:GetVehicleClass()].canAccess(ply, veh)
	end
end)
