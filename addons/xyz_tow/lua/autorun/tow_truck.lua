local V = {
	-- Required information
	Name = "Tow Truck",
	Model = "models/cipro/tow_truck/towtruck.mdl",
	Class = "prop_vehicle_jeep",
	Category = "Mechanical System",

	-- Optional information
	Author = "SlownLS & Slawer",
	Information = "Drivable Tow Truck",

	KeyValues = {
		vehiclescript = "scripts/vehicles/tow_truck/tow_truck.txt"
	}
}
list.Set( "Vehicles", "tow_truck", V )
