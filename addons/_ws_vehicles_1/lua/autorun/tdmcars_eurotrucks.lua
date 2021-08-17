local PrVeh = "prop_vehicle_jeep"
local Cat = "TDM Trucks"

local V = {
			Name = "Scania 2009 4x2", 
			Class = PrVeh,
			Category = Cat,
			Author = "TheDanishMaster, SCS Software",
			Information = "A drivable Scania 2009 by TheDanishMaster",
			Model = "models/tdmcars/trucks/scania_4x2.mdl",		
			KeyValues = {
							vehiclescript	=	"scripts/vehicles/TDMCars/scania4x2.txt"
							}
			}
list.Set("Vehicles", "scania09tdm", V)
local V = {
			Name = "Scania 2009 4x2 (No jiggle)", 
			Class = PrVeh,
			Category = Cat,
			Author = "TheDanishMaster, SCS Software",
			Information = "A drivable Scania 2009 by TheDanishMaster",
			Model = "models/tdmcars/trucks/scania_4x2_nojiggle.mdl",		
			KeyValues = {
							vehiclescript	=	"scripts/vehicles/TDMCars/scania4x2.txt"
							}
			}
list.Set("Vehicles", "scania09jigtdm", V)

local V = {
			Name = "Volvo FH16 2012 4x2", 
			Class = PrVeh,
			Category = Cat,
			Author = "TheDanishMaster, SCS Software",
			Information = "A drivable Volvo FH16 2012 by TheDanishMaster",
			Model = "models/tdmcars/trucks/vol_fh1612_short.mdl",		
			KeyValues = {
							vehiclescript	=	"scripts/vehicles/TDMCars/volvo_fh16.txt"
							}
			}
list.Set("Vehicles", "volvofh16shorttdm", V)

local V = {
			Name = "Volvo FH16 2012 6x2", 
			Class = PrVeh,
			Category = Cat,
			Author = "TheDanishMaster, SCS Software",
			Information = "A drivable Volvo FH16 2012 by TheDanishMaster",
			Model = "models/tdmcars/trucks/vol_fh1612_long.mdl",		
			KeyValues = {
							vehiclescript	=	"scripts/vehicles/TDMCars/volvo_fh166x2.txt"
							}
			}
list.Set("Vehicles", "volvofh16longtdm", V)