local Category = "ST Cars"

local V = {
				// Required information
				Name =	"Dodge Ram 3500 Laramie Tow Truck",
				Class = "prop_vehicle_jeep",
				Category = Category,

				// Optional information
				Author = "State Trooper, Criterion",
				Information = "vroom vroom",
				Model =	"models/statetrooper/ram_tow.mdl",

			
				KeyValues = {				
								vehiclescript =	"scripts/vehicles/statetrooper/ram3500_tow.txt"
					    }
}

list.Set( "Vehicles", "ram3500_tow", V )
