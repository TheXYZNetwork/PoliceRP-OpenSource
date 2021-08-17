hook.Add("PlayerEnteredVehicle", "XYZBusEnterPassenger", function(ply, ent)
	local bus = ent:GetParent()
	if not IsValid(bus) then return end
	if not bus.isBus then return end
	if ply == bus.busDriver then return end

	bus.passengers[ply:SteamID64()] = CurTime()
	XYZShit.Msg("Bus", Color(200, 0, 200), "You are now riding a bus and will be charged the bus fare of "..DarkRP.formatMoney(bus.busPrice)..". Leave now or you will be charged the fare price for every minute you spend on the bus.", ply)

	Quest.Core.ProgressQuest(bus.busDriver, "front_of_the_bus", 2)
end)

hook.Add("PlayerLeaveVehicle", "XYZBusExitPassenger", function(ply, ent)
	local bus = ent:GetParent()
	if not IsValid(bus) then return end
	if not bus.isBus then return end
	if ply == bus.busDriver then return end


	local time = bus.passengers[ply:SteamID64()]
	if not time then return end

	time = math.floor((CurTime()-time)/60)
	if time == 0 then return end
	local fare = math.Clamp(time*bus.busPrice, 0, tonumber(ply:getDarkRPVar("money")))

	bus.passengers[ply:SteamID64()] = nil

	XYZShit.Msg("Bus", Color(200, 0, 200), "You have been charged "..DarkRP.formatMoney(fare).." in bus fare.", ply)
	XYZShit.Msg("Bus", Color(200, 0, 200), "You have been given "..DarkRP.formatMoney(fare).." in bus fare by "..ply:Name()..".", bus.busDriver)

	ply:addMoney(-fare)
	bus.busDriver:addMoney(fare)
	
	Quest.Core.ProgressQuest(bus.busDriver, "front_of_the_bus", 3, fare)
end)

hook.Add("PlayerSay", "XYZBusFare", function(ply, msg)
	local command = string.Split(msg, " ")
	if not command[1] then return end
	if string.lower(command[1]) == "/busprice" then
		if not IsValid(ply.busEnt) then return end

		-- Validate price
		if not command[2] or not isnumber(tonumber(command[2])) then
			XYZShit.Msg("Bus", Color(200, 0, 200), "Please provide a valid fare amount", ply)
			return ""
		end

		command[2] = math.Clamp(tonumber(command[2]), 0, 1000)

		ply.busEnt.busPrice = command[2]

		XYZShit.Msg("Bus", Color(200, 0, 200), "You have set your bus fare to $"..command[2], ply)
		return ""
	end
end)