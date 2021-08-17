local Category = "Perryn's Ported Vehicles"

local V = {
				// Required information
				Name =	"Chevrolet Suburban 2015",
				Class = "prop_vehicle_jeep",
				Category = Category,

				// Optional information
				Author = "Perryn",
				Information = "Drive Carefully",
				Model =	"models/perrynsvehicles/chevrolet_suburban_2015/chevrolet_suburban_2015.mdl",

				KeyValues = {				
								vehiclescript =	"scripts/vehicles/perryn/chevrolet_suburban_2015.txt"
					    }
}

list.Set( "Vehicles", "perryn_chevrolet_suburban_2015", V )