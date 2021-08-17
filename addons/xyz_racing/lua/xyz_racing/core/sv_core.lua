XYZRacing.Core.AllowRaces = true
function XYZRacing.Core.InActiveRace(ply)
	if not IsValid(ply) then return end
	if XYZRacing.Races[ply:SteamID64()] then
		return XYZRacing.Races[ply:SteamID64()]
	end

	for k, v in pairs(XYZRacing.Races) do
		for n, m in pairs(v.racers) do
			if ply == m then
				return v
			end
		end
	end
	return false
end

function XYZRacing.Core.CanEnterRace(ply)
	for k, v in pairs(XYZRacing.Races) do
		for n, m in pairs(v.allowed) do
			if ply == m then
				return v
			end
		end
	end
	return false
end

function XYZRacing.Core.StartRace(data)
	for k, v in pairs(data.racers) do
		v.raceActive = true
	end

	data.allowed = {}
	
	net.Start("xyz_racing_start")
		net.WriteVector(data.platform:GetPos())
	net.Send(data.racers)
end

function XYZRacing.Core.Finish(data, winner)
	winner:addMoney(#data.racers*data.bid)
	XYZShit.Msg("Race", Color(147, 112, 219), "The race has ended. "..winner:Name().." has won "..DarkRP.formatMoney(#data.racers*data.bid), data.racers)
	
	net.Start("xyz_racing_finish")
	net.Send(data.racers)
	for k, v in pairs(data.racers) do
		v.raceActive = false
	end
	XYZRacing.Races[data.host:SteamID64()] = nil

	Quest.Core.ProgressQuest(winner, "joyrider", 4)
end

function XYZRacing.Core.CancelRaceThroughLeader(leaderID)
	XYZShit.Msg("Race", Color(147, 112, 219), "The race has been canceled", XYZRacing.Races[leaderID].racers)
	
	for k, v in pairs(XYZRacing.Races[leaderID].racers) do
		if IsValid(v) then
			if not (v == XYZRacing.Races[leaderID].host) then 
				v:addMoney(XYZRacing.Races[leaderID].bid)
				v.raceActive = false
			end
		end
	end

	net.Start("xyz_racing_finish")
	net.Send(XYZRacing.Races[leaderID].racers)

	XYZRacing.Races[leaderID] = nil
end

function XYZRacing.Core.LeaveRace(racer)
	if XYZRacing.Races[racer:SteamID64()] then
		XYZRacing.Core.CancelRaceThroughLeader(racer:SteamID64())
		return
	end

	local race = XYZRacing.Core.InActiveRace(racer)
	if not race then return end

	table.RemoveByValue(race.racers, racer)
	if not racer.raceActive then
		racer:addMoney(race.bid)
	end
	racer.raceActive = false

	XYZShit.Msg("Race", Color(147, 112, 219), "You have left the race", racer)
	net.Start("xyz_racing_finish")
	net.Send(racer)

	XYZShit.Msg("Race", Color(147, 112, 219), racer:Name().." has left the race", race.racers)
end



hook.Add("PlayerSay", "xyz_racing_chat", function(ply, msg)
	if not XYZRacing.Core.AllowRaces then return end

	local command = string.Split(msg, " ")
	if not command[1] then return end

	if string.lower(command[1]) == "/race" then
		if ply:isCP() then
			XYZShit.Msg("Race", Color(147, 112, 219), "You cannot start illegal races", ply)
			return ""
		end

		if not ply:InVehicle() then
			XYZShit.Msg("Race", Color(147, 112, 219), "Please enter a vehicle before attempting to race", ply)
			return ""
		end

		if ply:GetVehicle():GetClass() == "prop_vehicle_prisoner_pod" then
			XYZShit.Msg("Race", Color(147, 112, 219), "You are not the driver", ply)
			return ""
		end

		if XYZRacing.Core.InActiveRace(ply) then
			XYZShit.Msg("Race", Color(147, 112, 219), "You already have an active race", ply)
			return ""
		end

		-- Validate price
		if not command[2] or not isnumber(tonumber(command[2])) or tonumber(command[2]) <= 0 then
			XYZShit.Msg("Race", Color(147, 112, 219), "Please provide a valid bet amount", ply)
			return ""
		end
		command[2] = tonumber(command[2])

		if not ply:canAfford(command[2]) then
			XYZShit.Msg("Race", Color(147, 112, 219), "You cannot afford to bet that much", ply)
			return ""
		end


		XYZShit.Msg("Race", Color(147, 112, 219), "We have invited near by players to join your race. If no one joins in the next 30 seconds the race will be canceled. (Do not leave this general area)", ply)

		XYZRacing.Races[ply:SteamID64()] = {}
		XYZRacing.Races[ply:SteamID64()].host = ply
		XYZRacing.Races[ply:SteamID64()].bid = command[2]
		XYZRacing.Races[ply:SteamID64()].allowed = {}
		XYZRacing.Races[ply:SteamID64()].racers = {ply}
		XYZRacing.Races[ply:SteamID64()].start = ply:GetPos()

		local endPoints = {}
		for k, v in pairs(XYZRacing.Platforms) do
			if ply:GetPos():Distance(v:GetPos()) < 15000 then continue end
			table.insert(endPoints, v)
		end
		if #endPoints <= 0 then
			XYZShit.Msg("Race", Color(147, 112, 219), "There seems to be an issue with finding a race location. The race has been abandoned...", XYZRacing.Races[ply:SteamID64()].allowed)
			XYZRacing.Races[ply:SteamID64()] = nil
			return ""
		end
		XYZRacing.Races[ply:SteamID64()].platform = table.Random(endPoints)
		endPoints = nil

		for k, v in pairs(player.GetAll()) do
			if v == ply then continue end
			if v:GetPos():Distance(ply:GetPos()) < 1500 then
				if not v:InVehicle() then continue end
				if not v:GetVehicle():GetDriver() == v then continue end
				table.insert(XYZRacing.Races[ply:SteamID64()].allowed, v)
			end
		end
		XYZShit.Msg("Race", Color(147, 112, 219), "You have been invited to a race for "..DarkRP.formatMoney(command[2])..". If you wish to enter type /accept", XYZRacing.Races[ply:SteamID64()].allowed)

		timer.Create("xyz_race_"..ply:SteamID64(), 30, 1, function()
			if not IsValid(ply) then return end
			if not XYZRacing.Races[ply:SteamID64()] then return end
			if not XYZRacing.Races[ply:SteamID64()].racers[2] then
				XYZShit.Msg("Race", Color(147, 112, 219), "The race has expired. You have been refunded", ply)
				ply:addMoney(command[2])
				XYZRacing.Races[ply:SteamID64()] = nil
			else
				local i = 3
				XYZShit.Msg("Race", Color(147, 112, 219), "The race will start in:", XYZRacing.Races[ply:SteamID64()].racers)
				timer.Create("xyz_race_"..ply:SteamID64().."_counter", 1, 4, function()
					if i > 0 then
						XYZShit.Msg("Race", Color(147, 112, 219), i, XYZRacing.Races[ply:SteamID64()].racers)
						i = i-1
					else
						XYZShit.Msg("Race", Color(147, 112, 219), "Go!", XYZRacing.Races[ply:SteamID64()].racers)
						XYZRacing.Core.StartRace(XYZRacing.Races[ply:SteamID64()])
					end
				end)
			end
		end)

		ply:addMoney(-command[2])

		Quest.Core.ProgressQuest(ply, "joyrider", 3)
		return ""
	elseif string.lower(command[1]) == "/accept" then
		local raceData = XYZRacing.Core.CanEnterRace(ply)

		if ply:isCP() then
			XYZShit.Msg("Race", Color(147, 112, 219), "You cannot partake in illegal races", ply)
			return ""
		end

		if not ply:InVehicle() then
			XYZShit.Msg("Race", Color(147, 112, 219), "Please enter a vehicle before attempting to race", ply)
			return ""
		end

		if ply:GetVehicle():GetClass() == "prop_vehicle_prisoner_pod" then
			XYZShit.Msg("Race", Color(147, 112, 219), "You are not the driver", ply)
			return ""
		end

		if not raceData then
			XYZShit.Msg("Race", Color(147, 112, 219), "There is currently no race to enter", ply)
			return ""
		end

		if XYZRacing.Core.InActiveRace(ply) then
			XYZShit.Msg("Race", Color(147, 112, 219), "You already have an active race", ply)
			table.RemoveByValue(raceData.allowed, ply)
			return ""
		end

		if not ply:canAfford(raceData.bid) then
			XYZShit.Msg("Race", Color(147, 112, 219), "You cannot afford to enter the race", ply)
			table.RemoveByValue(raceData.allowed, ply)
			return ""
		end

		table.RemoveByValue(raceData.allowed, ply)
		XYZShit.Msg("Race", Color(147, 112, 219), ply:Name().." has joined the race", raceData.racers)
		ply:addMoney(-raceData.bid)

		table.insert(raceData.racers, ply)
		XYZShit.Msg("Race", Color(147, 112, 219), "You have joined the race (Do not leave the general area)", ply)

		Quest.Core.ProgressQuest(ply, "joyrider", 3)

		return ""
	end
end)

hook.Add("PlayerDisconnected", "xyz_racing_disconnect", function(ply)
	if XYZRacing.Races[ply:SteamID64()] then
		XYZRacing.Core.CancelRaceThroughLeader(ply:SteamID64())
	end
end)

hook.Add("PlayerLeaveVehicle", "xyz_racing_exit_car", function(ply)
	XYZRacing.Core.LeaveRace(ply)
end)