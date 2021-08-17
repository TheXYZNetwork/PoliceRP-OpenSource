hook.Add("PlayerInitialSpawn", "xSGroupsLoadPlayerRank", function(ply)
	xSGroups.Database.GetUsersGroup(ply:SteamID64(), function(data)
		if not data or not data[1] then
			xSGroups.Users[ply:SteamID64()] = nil
		else
			xSGroups.Users[ply:SteamID64()] = data[1].rank
		end

		if xSGroups.Users[ply:SteamID64()] then
			net.Start("xSGroupsNetworkIDRank")
				net.WriteString(ply:SteamID64())
				net.WriteString(xSGroups.Users[ply:SteamID64()])
			net.Broadcast()
		end


		net.Start("xSGroupsNetworkExistingUsers")
			net.WriteTable(xSGroups.Users)
		net.Send(ply)
	end)
end)

hook.Add("PlayerDisconnected", "xSGroupsDisconnectPlayerRank", function(ply)
	xSGroups.Users[ply:SteamID64()] = nil
end)
