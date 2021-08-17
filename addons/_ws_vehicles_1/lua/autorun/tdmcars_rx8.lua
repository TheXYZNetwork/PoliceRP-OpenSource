local V = {
			Name = "Mazda RX-8", 
			Class = "prop_vehicle_jeep",
			Category = "TDM Cars",
			Author = "TheDanishMaster, freemmaann, Turn 10",
			Information = "A drivable Mazda RX-8 by TheDanishMaster",
			Model = "models/tdmcars/rx8.mdl",
			//Vehicle Controller
			VC_Lights = { //Pos can be a simple Vector() relative to the vehicle or an attachment name, else is self explanatory, can be an infinite amount of these.
						{Pos = Vector(30, -92.8, 48.7), Mat = "sprites/glow1.vmt", Alpha = 180, Size = 0.5, DynLight = true, ReverseColor = "255 255 255"},
						{Pos = Vector(-30, -92.8, 48.7), Mat = "sprites/glow1.vmt", Alpha = 180, Size = 0.5, DynLight = true, ReverseColor = "255 255 255"},
						{Pos = Vector(25, -98.4, 48.2), Mat = "sprites/glow1.vmt", Alpha = 180, Size = 0.8, DynLight = true, NormalColor = "255 0 0", BrakeColor = "255 0 0"},
						{Pos = Vector(-25, -98.4, 48.2), Mat = "sprites/glow1.vmt", Alpha = 180, Size = 0.8, DynLight = true, NormalColor = "255 0 0", BrakeColor = "255 0 0"},
						{Pos = Vector(2.9, -100.9, 54.3), Mat = "sprites/glow1.vmt", Alpha = 180, Size = 0.3, DynLight = true, NormalColor = "255 0 0", BrakeColor = "255 0 0"},
						{Pos = Vector(-2.9, -100.9, 54.3), Mat = "sprites/glow1.vmt", Alpha = 180, Size = 0.3, DynLight = true, NormalColor = "255 0 0", BrakeColor = "255 0 0"},
						{Pos = Vector(0, -100.9, 54.3), Mat = "sprites/glow1.vmt", Alpha = 180, Size = 0.3, DynLight = true, NormalColor = "255 0 0", BrakeColor = "255 0 0"},					

						{Pos = Vector(33.2, -92.4, 48.7), Mat = "sprites/glow1.vmt", Alpha = 220, Size = 0.5, DynLight = true, BlinkersColor = "255 130 0"},
						{Pos = Vector(-33.2, -92.4, 48.7), Mat = "sprites/glow1.vmt", Alpha = 220, Size = 0.5, DynLight = true, BlinkersColor = "255 130 0"},
						{Pos = Vector(35.3, 85.8, 40.6), Mat = "sprites/glow1.vmt", Alpha = 220, Size = 0.5, DynLight = true, BlinkersColor = "255 130 0"},
						{Pos = Vector(-35.3, 85.8, 40.6), Mat = "sprites/glow1.vmt", Alpha = 220, Size = 0.5, DynLight = true, BlinkersColor = "255 130 0"},
						{Pos = Vector(26.8, 88.7, 39.2), Mat = "sprites/glow1.vmt", Alpha = 220, Size = 0.8, DynLight = true, NormalColor = "169 215 255"},
						{Pos = Vector(-26.8, 88.7, 39.2), Mat = "sprites/glow1.vmt", Alpha = 220, Size = 0.8, DynLight = true, NormalColor = "169 215 255"},
						{Pos = Vector(31, 90.2, 39.3), Size = 1, GlowSize = 1, HeadLightAngle = Angle(5, 85, 0)},
						{Pos = Vector(-31, 90.2, 39.3), Size = 1, GlowSize = 1, HeadLightAngle = Angle(5, 95, 0)}
						},
			VC_Exhaust = { //Exhaust effect, only active when engine is on, can be infinite amount.
						{Pos = Vector(-31.3, -95.7, 24.3), Ang = Angle(45,0,90), EffectIdle = "Exhaust", EffectStress = "Exhaust"},
						{Pos = Vector(31.3, -95.7, 24.3), Ang = Angle(45,0,90), EffectIdle = "Exhaust", EffectStress = "Exhaust"}
						},
			VC_ExtraSeats = { //Can be an infinite amount of seats, Pos and ExitPos can be a simple Vector() or an attachment name, other options are self explanatory.
						{Pos = Vector(-17.8, -2.2, 27.3), Ang = Angle(0, 0, 8), EnterRange = 80, ExitAng = Angle(0, -90, 0), Model = "models/props_phx/carseat2.mdl", ModelOffset = Vector(12, 0, 4), Hide = true, DoorSounds = true, RadioControl = true},
						{Pos = Vector(-17.8, -38.4, 27.3), Ang = Angle(0, 0, 8), EnterRange = 80, ExitAng = Angle(0, -90, 0), Model = "models/props_phx/carseat2.mdl", ModelOffset = Vector(12, 0, 4), Hide = true, DoorSounds = true, RadioControl = true},
						{Pos = Vector(17.8, -38.4, 27.3), Ang = Angle(0, 0, 8), EnterRange = 80, ExitAng = Angle(0, -90, 0), Model = "models/props_phx/carseat2.mdl", ModelOffset = Vector(12, 0, 4), Hide = true, DoorSounds = true, RadioControl = true}
						},
			VC_Horn = {Sound = "vehicles/vc_horn_light.wav", Pitch = 100, Looping = false}, //Horn sound the car will use.
						
			KeyValues = {
							vehiclescript	=	"scripts/vehicles/TDMCars/rx8.txt"
							}
			}
list.Set("Vehicles", "rx8tdm", V)