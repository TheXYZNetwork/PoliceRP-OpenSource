local PrVeh = "prop_vehicle_jeep"
local Cat = "TDM Commercial"

local V = {
			Name = "Orion VII NG", 
			Class = PrVeh,
			Category = Cat,
			Author = "TheDanishMaster, Ubisoft",
			Information = "A drivable Bus by TheDanishMaster",
				Model = "models/tdmcars/bus.mdl",
							KeyValues = {
							vehiclescript	=	"scripts/vehicles/tdmcars/bus.txt"
							}
			}
list.Set("Vehicles", "bustdm", V)

local V = {
			Name = "Courier Truck", 
			Class = PrVeh,
			Category = Cat,
			Author = "TheDanishMaster, Ubisoft",
			Information = "A drivable Courier Truck by TheDanishMaster",
				Model = "models/tdmcars/courier_truck.mdl",
							KeyValues = {
							vehiclescript	=	"scripts/vehicles/tdmcars/courier_truck.txt"
							}
			}
list.Set("Vehicles", "courier_trucktdm", V)
