local Category = "SGM Cars"

local V = {
				// Required information
				Name =	"Golf Cart",
				Class = "prop_vehicle_jeep",
				Category = Category,

				// Optional information
				Author = "SentryGunMan, Turn 10",
				Information = "vroom vroom",
				Model =	"models/sentry/golfcart.mdl",

				KeyValues = {				
								vehiclescript =	"scripts/vehicles/sentry/golfcart.txt"
					    }
}

list.Set( "Vehicles", "golfcart_sgm", V )