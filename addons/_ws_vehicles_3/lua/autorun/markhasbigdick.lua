local PrVeh = "prop_vehicle_jeep"
local Cat = "JM Cars"


local V = {
	-- Required information
	Name = "2016 Cadillac XTS Royale",
	Model = "models/jm_cars/cadillac/royale/xts.mdl",
	Class = PrVeh,
	Category = Cat,

	-- Optional information
	Author = "JustMark",
	Information = "",

	KeyValues = {
		vehiclescript = "scripts/vehicles/jm_cars/jm_caddylimo.txt"
	}
}
list.Set( "Vehicles", "jm_caddylimo", V )
