local PrVeh = "prop_vehicle_jeep"
local Cat = "CrSk — Motorcycles"

local function HandlePHXAirboatAnimation( vehicle, ply )
	return ply:SelectWeightedSequence( ACT_DRIVE_AIRBOAT ) 
end

local V = {
	-- Required information
	Name = "Jawa 350/634 1978",
	Model = "models/crsk_autos/jawa/350_634.mdl",
	Class = PrVeh,
	Category = Cat,

	-- Optional information
	Author = "CrushingSkirmish",
	Information = "",

	KeyValues = {
		vehiclescript = "scripts/vehicles/crsk_autos/crsk_jawa_350_634.txt"
	},
	Members = {
		HandleAnimation = HandlePHXAirboatAnimation,
	}
}
list.Set( "Vehicles", "crsk_jawa_350_634", V )

