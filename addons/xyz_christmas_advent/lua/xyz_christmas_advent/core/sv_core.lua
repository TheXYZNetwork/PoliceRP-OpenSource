function XYZChristmasAdvent.Core.PickReward()
	local rewardPool = {}

	for k, v in pairs(XYZChristmasAdvent.Config.Rewards) do
		for i=1, v.chance do
			table.insert(rewardPool, k)
		end
	end

	return XYZChristmasAdvent.Config.Rewards[table.Random(rewardPool)]
end

hook.Add("PlayerInitialSpawn", "XYZChristmasAdvent:NetworkCurrentDay", function(ply)
	XYZChristmasAdvent.OpenedDoors[ply:SteamID64()] = {}

	XYZChristmasAdvent.Core.GetOpenedDoors(ply, function(data)
		for k, v in pairs(data) do
			XYZChristmasAdvent.OpenedDoors[ply:SteamID64()][v.door] = true
		end

		net.Start("XYZChristmasAdvent:CurrentDay")
			net.WriteInt(XYZChristmasAdvent.CurrentDay, 32)
			net.WriteTable(XYZChristmasAdvent.OpenedDoors[ply:SteamID64()])
		net.Send(ply)
	end)

end)

net.Receive("XYZChristmasAdvent:OpenToday", function(_, ply)
	if XYZChristmasAdvent.OpenedDoors[ply:SteamID64()][XYZChristmasAdvent.CurrentDay] then return end

	local reward = XYZChristmasAdvent.Core.PickReward()
	if not reward then return end

	if reward.canGet then
		while reward.canGet do
			if reward.canGet(ply) then break end
			reward = XYZChristmasAdvent.Core.PickReward()
		end
	end

	reward.action(ply)

	XYZChristmasAdvent.OpenedDoors[ply:SteamID64()][XYZChristmasAdvent.CurrentDay] = true
	XYZChristmasAdvent.Core.RegisterDoorOpening(ply, reward.name)
	XYZShit.Msg("Advent Calendar", Color(246, 70, 99), ply:Name().." has just opened "..reward.name)
end)
