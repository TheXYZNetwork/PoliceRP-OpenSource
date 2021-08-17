local Category = "SGM Cars"

local V = {
				// Required information
				Name =	"XA-180 APC",
				Class = "prop_vehicle_jeep",
				Category = Category,

				// Optional information
				Author = "SentryGunMan",
				Information = "vroom vroom",
				Model =	"models/sentry/l4dapc.mdl",
 
                                            

				KeyValues = {				
								vehiclescript =	"scripts/vehicles/sentry/l4dapc.txt"
					    }
}

list.Set( "Vehicles", "l4dapc_sgm", V )