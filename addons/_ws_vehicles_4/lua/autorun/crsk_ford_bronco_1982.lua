local PrVeh = "prop_vehicle_jeep"
local Cat = "CrSk Autos"


local V = {
	-- Required information
	Name = "Ford Bronco XLT 1982",
	Model = "models/crsk_autos/ford/bronco_1982.mdl",
	Class = PrVeh,
	Category = Cat,

	-- Optional information
	Author = "CrushingSkirmish",
	Information = "",

	KeyValues = {
		vehiclescript = "scripts/vehicles/crsk_autos/crsk_ford_bronco_1982.txt"
	}
}
list.Set( "Vehicles", "crsk_ford_bronco_1982", V )

