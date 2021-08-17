local Category = "Perryn's Ported Vehicles"

local V = {
				// Required information
				Name =	"BearCat G3",
				Class = "prop_vehicle_jeep",
				Category = Category,

				// Optional information
				Author = "Perryn",
				Information = "Drive Carefully",
				Model =	"models/perrynsvehicles/bearcat_g3/bearcat_g3.mdl",

				KeyValues = {				
								vehiclescript =	"scripts/vehicles/perryn/bearcat_g3.txt"
					    }
}

list.Set( "Vehicles", "perryn_bearcat_g3", V )