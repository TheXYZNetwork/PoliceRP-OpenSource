local PrVeh = "prop_vehicle_jeep"
local Cat = "CrSk Autos"


local V = {
	-- Required information
	Name = "Land Rover Series IIa Station Wagon 1967",
	Model = "models/crsk_autos/landrover/series_IIa_stationwagon.mdl",
	Class = PrVeh,
	Category = Cat,

	-- Optional information
	Author = "CrushingSkirmish",
	Information = "",

	KeyValues = {
		vehiclescript = "scripts/vehicles/crsk_autos/crsk_landrover_series_IIa_stationwagon.txt"
	}
}
list.Set( "Vehicles", "crsk_landrover_series_IIa_stationwagon", V )

