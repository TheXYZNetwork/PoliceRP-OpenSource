net.Receive("XYZChristmasAdvent:CurrentDay", function()
	XYZChristmasAdvent.CurrentDay = net.ReadInt(32)
	XYZChristmasAdvent.OpenedDoors = net.ReadTable()
end)