local Category = "SGM Cars"

local V = {
				// Required information
				Name =	"1927 Ford Model T",
				Class = "prop_vehicle_jeep",
				Category = Category,

				// Optional information
				Author = "SentryGunMan",
				Information = "vroom vroom",
				Model =	"models/sentry/modelt.mdl",
 
                                           

				KeyValues = {				
								vehiclescript =	"scripts/vehicles/sentry/modelt.txt"
					    }
}

list.Set( "Vehicles", "modelt_sgm", V )