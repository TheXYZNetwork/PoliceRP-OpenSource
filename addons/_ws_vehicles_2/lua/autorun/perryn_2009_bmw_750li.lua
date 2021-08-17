local Category = "Perryn's Ported Vehicles"

local V = {
				// Required information
				Name =	"2009 BMW 750li",
				Class = "prop_vehicle_jeep",
				Category = Category,

				// Optional information
				Author = "Perryn",
				Information = "Drive Carefully",
				Model =	"models/perrynsvehicles/2009_bmw_750li/2009_bmw_750li.mdl",

				KeyValues = {				
								vehiclescript =	"scripts/vehicles/perryn/2009_bmw_750li.txt"
					    }
}

list.Set( "Vehicles", "perryn_2009_bmw_750li", V )