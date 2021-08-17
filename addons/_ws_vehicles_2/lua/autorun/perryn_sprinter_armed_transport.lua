local Category = "Perryn's Ported Vehicles"

local V = {
				// Required information
				Name =	"2016 Sprinter Armed Transport",
				Class = "prop_vehicle_jeep",
				Category = Category,

				// Optional information
				Author = "Perryn",
				Information = "Drive Carefully",
				Model =	"models/perrynsvehicles/sprinter_armed_transport/sprinter_armed_transport.mdl",

				KeyValues = {				
								vehiclescript =	"scripts/vehicles/perryn/sprinter_armed_transport.txt"
					    }
}

list.Set( "Vehicles", "perryn_sprinter_armed_transport", V )