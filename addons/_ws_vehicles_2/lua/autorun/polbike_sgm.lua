local Category = "SGM Cars [VisionRP.net]"

local function HandlePHXAirboatAnimation( vehicle, ply )
	return ply:SelectWeightedSequence( ACT_DRIVE_AIRBOAT ) 
end


local V = {
				// Required information
				Name =	"Police Motorcycle",
				Class = "prop_vehicle_jeep",
				Category = Category,

				// Optional information
				Author = "SentryGunMan, Turn 10",
				Information = "vroom vroom",
				Model =	"models/sentry/polbike.mdl",

				KeyValues = {				
								vehiclescript =	"scripts/vehicles/sentry/polbike.txt"
					    },
	Members = {
		HandleAnimation = HandlePHXAirboatAnimation,
	}
}

list.Set( "Vehicles", "polbike_sgm", V )