local Category = "SGM Cars"

local V = {
				// Required information
				Name =	"GTA V Armored Kuruma",
				Class = "prop_vehicle_jeep",
				Category = Category,

				// Optional information
				Author = "SentryGunMan",
				Information = "vroom vroom",
				Model =	"models/sentry/kuruma.mdl",
 
                                           

				KeyValues = {				
								vehiclescript =	"scripts/vehicles/sentry/kuruma.txt"
					    }
}

list.Set( "Vehicles", "kuruma_sgm", V )