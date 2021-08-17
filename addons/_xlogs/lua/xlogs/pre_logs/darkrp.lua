xLogs.RegisterCategory("Adverts", "DarkRP")
xLogs.RegisterCategory("Arrests", "DarkRP")
xLogs.RegisterCategory("Battering Ram", "DarkRP")
xLogs.RegisterCategory("Cheques", "DarkRP")
xLogs.RegisterCategory("Commands", "DarkRP")
xLogs.RegisterCategory("Demotes", "DarkRP")
xLogs.RegisterCategory("Doors", "DarkRP")
xLogs.RegisterCategory("Economy", "DarkRP")
xLogs.RegisterCategory("Job Changes", "DarkRP")
xLogs.RegisterCategory("Laws", "DarkRP")
xLogs.RegisterCategory("Lockpicking", "DarkRP")
xLogs.RegisterCategory("Purchases", "DarkRP")
xLogs.RegisterCategory("Shipments", "DarkRP")
xLogs.RegisterCategory("RPName Changes", "DarkRP")
xLogs.RegisterCategory("Wanted", "DarkRP")
xLogs.RegisterCategory("Warrants", "DarkRP")

hook.Add("playerAdverted", "xLogsDarkRP-Adverts", function(ply, args, ent)
	if not IsValid(ply) or not ply:IsPlayer() then return end
	xLogs.Log(xLogs.Core.Player(ply).." adverted "..xLogs.Core.Color(args, Color(240,230,140)), "Adverts")
end)

hook.Add("RHC_jailed", "xLogsDarkRP-Arrests", function(vic, jailer, time, reason)
	if not IsValid(vic) or not vic:IsPlayer() then return end
	if not IsValid(jailer) or not jailer:IsPlayer() then return end
	xLogs.Log(xLogs.Core.Player(vic).." was jailed by "..xLogs.Core.Player(jailer).." for "..xLogs.Core.Color(time, Color(255,218,185)).." seconds. Reason: "..xLogs.Core.Color(reason, Color(173,255,47)), "Arrests")
end)

hook.Add("onDoorRamUsed", "xLogsDarkRP-BatteringRam", function(success, ply, trace)
	if not IsValid(ply) or not ply:IsPlayer() then return end
	local doorPly = trace.Entity:getDoorOwner()
	if IsValid( doorPly ) then
		xLogs.Log(xLogs.Core.Player(ply).." used a battering ram on a door owned by "..xLogs.Core.Player(doorPly), "Battering Ram")
	else
		xLogs.Log(xLogs.Core.Player(ply).." used a battering ram on a door owned by no-one", "Battering Ram")
	end
end)

hook.Add("playerDroppedCheque", "xLogsDarkRP-Cheques-Drop", function(ply, ply2, amount)
	if not IsValid(ply) or not ply:IsPlayer() then return end
	if not IsValid(ply2) or not ply2:IsPlayer() then return end
	xLogs.Log(xLogs.Core.Player(ply).." wrote a cheque for "..xLogs.Core.Player(ply2)..". Amount: $"..xLogs.Core.Color(amount, Color(34,139,34)), "Cheques")
end)

hook.Add("playerPickedUpCheque", "xLogsDarkRP-Cheques-Pickup", function(ply, ply2, amount)
	if not IsValid(ply) or not ply:IsPlayer() then return end
	if not IsValid(ply2) or not ply2:IsPlayer() then return end
	xLogs.Log(xLogs.Core.Player(ply).." picked up a cheque from "..xLogs.Core.Player(ply2)..". Amount: $"..xLogs.Core.Color(amount, Color(34,139,34)), "Cheques")
end)

hook.Add("onChatCommand", "xLogsDarkRP-Commands", function(ply, command)
	if not IsValid(ply) or not ply:IsPlayer() then return end
	xLogs.Log(xLogs.Core.Player(ply).." ran command: "..xLogs.Core.Color(command, Color(255,69,0)), "Commands")
end)

hook.Add("onPlayerDemoted", "xLogsDarkRP-Demotes", function(ply, ply2, reason)
	if not IsValid(ply) or not ply:IsPlayer() then return end
	if not IsValid(ply2) or not ply2:IsPlayer() then return end
	xLogs.Log(xLogs.Core.Player(ply).." demoted "..xLogs.Core.Player(ply2).." for: "..xLogs.Core.Color(reason, Color(255,99,71)), "Demotes")
end)

hook.Add("playerBoughtDoor", "xLogsDarkRP-Door-Bought", function(ply, ent, cost)
	if not IsValid(ply) or not ply:IsPlayer() then return end
	xLogs.Log(xLogs.Core.Player(ply).." bought a door for "..xLogs.Core.Color(DarkRP.formatMoney(cost), Color(34,139,34)), "Doors")
end)

hook.Add("playerSellDoor", "xLogsDarkRP-Door-Sell", function(ply, ent)
	if not IsValid(ply) or not ply:IsPlayer() then return end
	xLogs.Log(xLogs.Core.Player(ply).." sold a door", "Doors")
end)

hook.Add("playerDroppedMoney", "xLogsDarkRP-Economy-Drop", function(ply, amount, ent)
	if not IsValid(ply) or not ply:IsPlayer() then return end
	xLogs.Log(xLogs.Core.Player(ply).." dropped "..xLogs.Core.Color(DarkRP.formatMoney(amount), Color(34,139,34)), "Economy")
end)

hook.Add("playerPickedUpMoney", "xLogsDarkRP-Economy-Pickup", function(ply, amount, ent)
	if not IsValid(ply) or not ply:IsPlayer() then return end
	xLogs.Log(xLogs.Core.Player(ply).." picked up "..xLogs.Core.Color(DarkRP.formatMoney(amount), Color(34,139,34)), "Economy")
end)

hook.Add("OnPlayerChangedTeam", "xLogsDarkRP-JobChanges", function(ply, before, after)
	if not IsValid(ply) or not ply:IsPlayer() then return end
	xLogs.Log(xLogs.Core.Player(ply).." changed job from "..xLogs.Core.Color(team.GetName(before), team.GetColor(before) or Color(128, 0, 0)).." to "..xLogs.Core.Color(team.GetName(after), team.GetColor(after) or Color(0, 100, 0)), "Job Changes")
end)

hook.Add("addLaw", "xLogsDarkRP-Laws-Add", function(index, law)
	if not IsValid(ply) or not ply:IsPlayer() then return end
	xLogs.Log("A new law has been added: "..xLogs.Core.Color(law, Color(221,160,221)), "Laws")
end)

hook.Add("removeLaw", "xLogsDarkRP-Laws-Remove", function(index, law)
	if not IsValid(ply) or not ply:IsPlayer() then return end
	xLogs.Log("A law has been removed: "..xLogs.Core.Color(law, Color(221,160,221)), "Laws")
end)

hook.Add("lockpickStarted", "xLogsDarkRP-Lockpicking-Start", function(ply, ent)
	if not IsValid(ply) or not ply:IsPlayer() then return end
	if ent:IsVehicle() then
		xLogs.Log(xLogs.Core.Player(ply).." started locking "..xLogs.Core.Color(ent:GetVehicleClass(), Color(0, 0, 200)).." ("..xLogs.Core.Player(ent:CPPIGetOwner())..")", "Lockpicking")
	else
		xLogs.Log(xLogs.Core.Player(ply).." started locking "..ent:GetClass(), "Lockpicking")
	end
end)
hook.Add("onLockpickCompleted", "xLogsDarkRP-Lockpicking-Complete", function(ply, success, ent)
	if not IsValid(ply) or not ply:IsPlayer() then return end
	if not IsValid(ent) then return end
	if ent:IsVehicle() then
		xLogs.Log(xLogs.Core.Player(ply).." started locking "..xLogs.Core.Color(ent:GetVehicleClass(), Color(0, 0, 200)).." ("..xLogs.Core.Player(ent:CPPIGetOwner())..")", "Lockpicking")
	else
		xLogs.Log(xLogs.Core.Player(ply).." started locking "..ent:GetClass(), "Lockpicking")
	end
end)

hook.Add("playerBoughtCustomEntity", "xLogsDarkRP-Purchases", function(ply, entTable, ent, price)
	if not IsValid(ply) or not ply:IsPlayer() then return end
	local entprintname = ""
	if (IsValid(ent)) then
		local entTable = ent:GetTable()
		if (entTable) then
			entprintname = entTable.PrintName or entTable.name
		end
	end	
	xLogs.Log(xLogs.Core.Player(ply).." purchased a: "..xLogs.Core.Color(entprintname, Color(221,160,221)).." for "..xLogs.Core.Color(DarkRP.formatMoney(price), Color(34,139,34)), "Purchases")
end)

hook.Add("playerBoughtShipment", "xLogsDarkRP-Shipments", function(ply, entTable, ent, price)
	if not IsValid(ply) or not ply:IsPlayer() then return end
	local entprintname = ""
	xLogs.Log(xLogs.Core.Player(ply).." purchased shipment: "..xLogs.Core.Color(entTable.name or "Unknown", Color(221,160,221)).." for "..xLogs.Core.Color(DarkRP.formatMoney(price), Color(34,139,34)), "Shipments")
end)

hook.Add("onPlayerChangedName", "xLogsDarkRP-RPNameChanges", function(ply, before, after)
	if not IsValid(ply) or not ply:IsPlayer() then return end
	xLogs.Log(xLogs.Core.Player(ply).." changed name from "..xLogs.Core.Color(before, Color(128,0,0)).." to "..xLogs.Core.Color(before, Color(0,100,0)), "RPName Changes")
end)

hook.Add("playerWanted", "xLogsDarkRP-Wanted-Wanted", function(ply, ply2, reason)
	if not IsValid(ply) or not ply:IsPlayer() then return end
	if not IsValid(ply2) or not ply2:IsPlayer() then return end
	xLogs.Log(xLogs.Core.Player(ply2).." has wanted "..xLogs.Core.Player(ply).." for: "..xLogs.Core.Color(reason, Color(255,99,71)), "Wanted")
end)

hook.Add("playerUnWanted", "xLogsDarkRP-Wanted-UnWanted", function(ply)
	if not IsValid(ply) or not ply:IsPlayer() then return end
	xLogs.Log(xLogs.Core.Player(ply2).." is no longer wanted", "Wanted")
end)

hook.Add("playerWarranted", "xLogsDarkRP-Warrant-Warrant", function(ply, ply2, reason)
	xLogs.Log(xLogs.Core.Player(ply2).." placed a warrant on "..xLogs.Core.Player(ply).." for: "..xLogs.Core.Color(reason, Color(255,99,71)), "Warrants")
end)

hook.Add("playerUnWarranted", "xLogsDarkRP-Warrant-Unwarrant", function(ply)
	xLogs.Log(xLogs.Core.Player(ply).." no longer has a warrant", "Warrants")
end)