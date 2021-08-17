local V = {
			Name = "Toyota Supra", 
			Class = "prop_vehicle_jeep",
			Category = "TDM Cars",
			Author = "TheDanishMaster, freemmaann, Turn 10",
			Information = "A drivable Toyota Supra by TheDanishMaster",
			Model = "models/tdmcars/supra.mdl",
			//Vehicle Controller
			VC_Lights = { //Pos can be a simple Vector() relative to the vehicle or an attachment name, else is self explanatory, can be an infinite amount of these.
						{Pos = Vector(-12.6, -104.5, 41.1), Mat = "sprites/glow1.vmt", Alpha = 180, Size = 0.5, DynLight = true, ReverseColor = "255 255 255"},
						{Pos = Vector(12.6, -104.5, 41.1), Mat = "sprites/glow1.vmt", Alpha = 180, Size = 0.5, DynLight = true, ReverseColor = "255 255 255"},
						{Pos = Vector(-2.2, -105.3, 48.3), Mat = "sprites/glow1.vmt", Alpha = 180, Size = 0.3, DynLight = true, NormalColor = "255 0 0", BrakeColor = "255 0 0"},
						{Pos = Vector(2.2, -105.3, 48.3), Mat = "sprites/glow1.vmt", Alpha = 180, Size = 0.3, DynLight = true, NormalColor = "255 0 0", BrakeColor = "255 0 0"},
						{Pos = Vector(0, -105.3, 48.3), Mat = "sprites/glow1.vmt", Alpha = 180, Size = 0.3, DynLight = true, NormalColor = "255 0 0", BrakeColor = "255 0 0"},
						{Pos = Vector(-6.3, -105.3, 48.3), Mat = "sprites/glow1.vmt", Alpha = 180, Size = 0.3, DynLight = true, NormalColor = "255 0 0", BrakeColor = "255 0 0"},
						{Pos = Vector(6.3, -105.3, 48.3), Mat = "sprites/glow1.vmt", Alpha = 180, Size = 0.3, DynLight = true, NormalColor = "255 0 0", BrakeColor = "255 0 0"},
						{Pos = Vector(-4.4, -105.3, 48.3), Mat = "sprites/glow1.vmt", Alpha = 180, Size = 0.3, DynLight = true, NormalColor = "255 0 0", BrakeColor = "255 0 0"},
						{Pos = Vector(4.4, -105.3, 48.3), Mat = "sprites/glow1.vmt", Alpha = 180, Size = 0.3, DynLight = true, NormalColor = "255 0 0", BrakeColor = "255 0 0"},
						{Pos = Vector(-17.7, -103.9, 41.1), Mat = "sprites/glow1.vmt", Alpha = 180, Size = 0.9, DynLight = true, NormalColor = "255 0 0"},
						{Pos = Vector(17.7, -103.9, 41.1), Mat = "sprites/glow1.vmt", Alpha = 180, Size = 0.9, DynLight = true, NormalColor = "255 0 0"},						
						{Pos = Vector(-23, -103.2, 41.3), Mat = "sprites/glow1.vmt", Alpha = 180, Size = 0.9, DynLight = true, NormalColor = "255 0 0", BrakeColor = "255 0 0"},
						{Pos = Vector(23, -103.2, 41.3), Mat = "sprites/glow1.vmt", Alpha = 180, Size = 0.9, DynLight = true, NormalColor = "255 0 0", BrakeColor = "255 0 0"},						
						{Pos = Vector(-28.5, -102.4, 41.3), Mat = "sprites/glow1.vmt", Alpha = 220, Size = 0.9, DynLight = true, BlinkersColor = "255 130 0"},
						{Pos = Vector(28.5, -102.4, 41.3), Mat = "sprites/glow1.vmt", Alpha = 220, Size = 0.9, DynLight = true, BlinkersColor = "255 130 0"},
						{Pos = Vector(-42.3, 89.4, 24.7), Mat = "sprites/glow1.vmt", Alpha = 220, Size = 0.5, DynLight = true, BlinkersColor = "255 130 0"},
						{Pos = Vector(42.3, 89.4, 24.7), Mat = "sprites/glow1.vmt", Alpha = 220, Size = 0.5, DynLight = true, BlinkersColor = "255 130 0"},
						{Pos = Vector(-31.6, 98.1, 30.9), Mat = "sprites/glow1.vmt", Alpha = 220, Size = 0.6, DynLight = true, NormalColor = "169 215 255"},
						{Pos = Vector(31.6, 98.1, 30.9), Mat = "sprites/glow1.vmt", Alpha = 220, Size = 0.6, DynLight = true, NormalColor = "169 215 255"},
						{Pos = Vector(-26.9, 101.9, 31.5), Mat = "sprites/glow1.vmt", Alpha = 220, Size = 0.8, DynLight = true, NormalColor = "169 215 255"},
						{Pos = Vector(26.9, 101.9, 31.5), Mat = "sprites/glow1.vmt", Alpha = 220, Size = 0.8, DynLight = true, NormalColor = "169 215 255"},
						{Pos = Vector(20.7, 101.2, 31.9), Size = 1, GlowSize = 1, HeadLightAngle = Angle(5, 85, 0)},
						{Pos = Vector(-20.7, 101.2, 31.9), Size = 1, GlowSize = 1, HeadLightAngle = Angle(5, 95, 0)}
						},
			VC_Exhaust = { //Exhaust effect, only active when engine is on, can be infinite amount.
						{Pos = Vector(-27, -107.7, 15.8), Ang = Angle(45,0,90), EffectIdle = "Exhaust", EffectStress = "Exhaust"}
						},
			VC_ExtraSeats = { //Can be an infinite amount of seats, Pos and ExitPos can be a simple Vector() or an attachment name, other options are self explanatory.
						{Pos = Vector(-17.8, -5.2, 24), Ang = Angle(0, 0, 8), EnterRange = 80, ExitAng = Angle(0, -90, 0), Model = "models/props_phx/carseat2.mdl", ModelOffset = Vector(12, 0, 4), Hide = true, DoorSounds = true, RadioControl = true},
						{Pos = Vector(-17.8, -38.4, 23.5), Ang = Angle(0, 0, 8), EnterRange = 80, ExitAng = Angle(0, -90, 0), Model = "models/props_phx/carseat2.mdl", ModelOffset = Vector(12, 0, 4), Hide = true, DoorSounds = true, RadioControl = true},
						{Pos = Vector(17.8, -38.4, 23.5), Ang = Angle(0, 0, 8), EnterRange = 80, ExitAng = Angle(0, -90, 0), Model = "models/props_phx/carseat2.mdl", ModelOffset = Vector(12, 0, 4), Hide = true, DoorSounds = true, RadioControl = true}
						},
			VC_Horn = {Sound = "vehicles/vc_horn_light.wav", Pitch = 100, Looping = false}, //Horn sound the car will use.
						
			KeyValues = {
							vehiclescript	=	"scripts/vehicles/TDMCars/supra.txt"
							}
			}
list.Set("Vehicles", "supratdm", V)