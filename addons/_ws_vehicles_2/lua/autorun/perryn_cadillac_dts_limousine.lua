local Category = "Perryn's Ported Vehicles"

local V = {
				// Required information
				Name =	"Cadillac DTS Limousine",
				Class = "prop_vehicle_jeep",
				Category = Category,

				// Optional information
				Author = "Perryn",
				Information = "Drive Carefully",
				Model =	"models/perrynsvehicles/cadillac_dts_limousine/cadillac_dts_limousine.mdl",

				KeyValues = {				
								vehiclescript =	"scripts/vehicles/perryn/cadillac_dts_limousine.txt"
					    }
}

list.Set( "Vehicles", "perryn_cadillac_dts_limousine", V )