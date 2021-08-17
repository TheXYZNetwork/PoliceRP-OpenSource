net.Receive("CarDealer:Vehicle:Load", function()
	local data = net.ReadTable()
 
	CarDealer.Vehicles = data
end)

net.Receive("CarDealer:Vehicle:Update", function()
	local data = net.ReadTable()
 
	CarDealer.Vehicles[data.id] = data
end)

net.Receive("CarDealer:Vehicle:Remove", function()
	local vehicleID = net.ReadUInt(32)

	CarDealer.Vehicles[vehicleID] = nil
end)

net.Receive("CarDealer:Vehicle:New", function()
	local data = net.ReadTable()

	CarDealer.Vehicles[data.id] = data
end)