local Category = "SGM Cars"

local V = {
				// Required information
				Name =	"2015 Chevrolet Camaro SS (Cop)",
				Class = "prop_vehicle_jeep",
				Category = Category,

				// Optional information
				Author = "SentryGunMan",
				Information = "vroom vroom",
				Model =	"models/sentry/15camaro_cop.mdl",
 
                                           

				KeyValues = {				
								vehiclescript =	"scripts/vehicles/sentry/15camaro.txt"
					    }
}

list.Set( "Vehicles", "15camaro_cop_sgm", V )