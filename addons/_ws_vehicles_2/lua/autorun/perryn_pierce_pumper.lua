local Category = "Perryn's Ported Vehicles"

local V = {
				// Required information
				Name =	"Pierce Contender Pumper",
				Class = "prop_vehicle_jeep",
				Category = Category,

				// Optional information
				Author = "Perryn",
				Information = "Drive Carefully",
				Model =	"models/perrynsvehicles/pierce_pumper/pierce_pumper.mdl",

				KeyValues = {				
								vehiclescript =	"scripts/vehicles/perryn/pierce_pumper.txt"
					    }
}

list.Set( "Vehicles", "perryn_pierce_pumper", V )
