net.Receive("xyz_g4s_robbery", function()
	local pos = net.ReadVector()
	local curtime = CurTime()
	Minimap.AddWaypoint("g4s_"..curtime, "g4s_marker", "Truck is being robbed!", Color(200, 0, 0), 1.3, pos)

	timer.Simple(120, function()
		Minimap.RemoveWaypoint("g4s_"..curtime)
	end)
end)