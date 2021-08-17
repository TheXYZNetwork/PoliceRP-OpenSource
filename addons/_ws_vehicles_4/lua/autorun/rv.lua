local Category = "SGM Cars"

local V = {
				// Required information
				Name =	"1980s RV",
				Class = "prop_vehicle_jeep",
				Category = Category,

				// Optional information
				Author = "SentryGunMan, Ubisoft",
				Information = "vroom vroom",
				Model =	"models/sentry/rv.mdl",

			
				KeyValues = {				
								vehiclescript =	"scripts/vehicles/sentry/rv.txt"
					    }
}

list.Set( "Vehicles", "rv", V )
