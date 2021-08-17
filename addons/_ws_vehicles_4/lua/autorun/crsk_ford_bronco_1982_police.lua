local PrVeh = "prop_vehicle_jeep"
local Cat = "CrSk — Emergency Vehicles"


local V = {
	-- Required information
	Name = "Ford Bronco XLT 1982 Police",
	Model = "models/crsk_autos/ford/bronco_1982_police.mdl",
	Class = PrVeh,
	Category = Cat,

	-- Optional information
	Author = "CrushingSkirmish",
	Information = "",

	KeyValues = {
		vehiclescript = "scripts/vehicles/crsk_autos/crsk_ford_bronco_1982_police.txt"
	}
}
list.Set( "Vehicles", "crsk_ford_bronco_1982_police", V )

