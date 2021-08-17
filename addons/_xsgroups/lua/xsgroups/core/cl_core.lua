net.Receive("xSGroupsNetworkIDRank", function()
	local plyID = net.ReadString()
	local rank = net.ReadString()
	xSGroups.Users[plyID] = rank
end)

net.Receive("xSGroupsNetworkExistingUsers", function()
	local tbl = net.ReadTable()
	xSGroups.Users = tbl
end)