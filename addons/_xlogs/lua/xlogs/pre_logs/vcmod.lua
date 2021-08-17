xLogs.RegisterCategory("Car Dealer", "VCMod")
xLogs.RegisterCategory("Vehicle Damage", "VCMod")
hook.Add("VC_CD_playerPurchasedVehicle", "xLogsVCMod-CarDealer", function(ply, ID, price, NPC)
	if not IsValid(ply) or not ply:IsPlayer() then return end
	xLogs.Log(xLogs.Core.Player(ply).." purchased vehicle "..xLogs.Core.Color(ID, Color(0, 0, 200)).." for "..xLogs.Core.Color(DarkRP.formatMoney(price), Color(0, 200, 0)), "Car Dealer")
end)

hook.Add("VC_CD_playerSoldVehicle", "xLogsVCMod-CarDealer", function(ply, ID, price, NPC)
	if not IsValid(ply) or not ply:IsPlayer() then return end
	xLogs.Log(xLogs.Core.Player(ply).." sold vehicle "..xLogs.Core.Color(ID, Color(0, 0, 200)).." for "..xLogs.Core.Color(DarkRP.formatMoney(price), Color(0, 200, 0)), "Car Dealer")
end)

hook.Add("VC_CD_spawnedVehicle", "xLogsVCMod-CarDealer", function(ply, ent, test)
	print("Spawned car")
	if not IsValid(ply) or not ply:IsPlayer() then return end
	if test then
		xLogs.Log(xLogs.Core.Player(ply).." has started test driving "..xLogs.Core.Color(ent:GetVehicleClass(), Color(0, 0, 200)), "Car Dealer")
	else
		xLogs.Log(xLogs.Core.Player(ply).." has spawned their car "..xLogs.Core.Color(ent:GetVehicleClass(), Color(0, 0, 200)), "Car Dealer")
	end
end)

hook.Add("VC_partDamaged", "xLogsVCMod-VehicleDamage", function(ent, class, obj, att, inf)
	if not att then return end
	if not att:IsPlayer() then return end
	xLogs.Log(xLogs.Core.Color(ent:GetVehicleClass(), Color(0, 0, 200)).." ("..xLogs.Core.Player(ent:CPPIGetOwner())..")".." took damage from "..xLogs.Core.Player(att), "Vehicle Damage")
end)