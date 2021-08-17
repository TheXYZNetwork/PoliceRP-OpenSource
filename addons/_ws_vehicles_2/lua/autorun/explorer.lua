local Category = "SGM Cars"

local V = {
				// Required information
				Name =	"2013 Ford Explorer",
				Class = "prop_vehicle_jeep",
				Category = Category,

				// Optional information
				Author = "SentryGunMan, Criterion",
				Information = "vroom vroom",
				Model =	"models/sentry/explorer.mdl",

			
				KeyValues = {				
								vehiclescript =	"scripts/vehicles/sentry/explorer.txt"
					    }
}

list.Set( "Vehicles", "explorer", V )
