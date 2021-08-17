local Category = "SGM Cars"

local V = {
				// Required information
				Name =	"2021 Tesla Cybertruck",
				Class = "prop_vehicle_jeep",
				Category = Category,

				// Optional information
				Author = "SentryGunMan, Turn 10",
				Information = "vroom vroom",
				Model =	"models/sentry/cybertruck.mdl",

				KeyValues = {				
								vehiclescript =	"scripts/vehicles/sentry/cybertruck.txt"
					    }
}

list.Set( "Vehicles", "cybertruck_sgm", V )