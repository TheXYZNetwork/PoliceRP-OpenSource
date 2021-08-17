local Category = "SGM Cars"


local V = {
				// Required information
				Name =	"Space Docker",
				Class = "prop_vehicle_jeep",
				Category = Category,

				// Optional information
				Author = "SentryGunMan, Turn 10",
				Information = "vroom vroom",
				Model =	"models/sentry/spacecar.mdl",

				KeyValues = {				
								vehiclescript =	"scripts/vehicles/sentry/spacecar.txt"
					    }
}

list.Set( "Vehicles", "spacecar_sgm", V )