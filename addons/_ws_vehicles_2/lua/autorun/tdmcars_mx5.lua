local V = {
			Name = "Mazda MX-5 2007", 
			Class = "prop_vehicle_jeep",
			Category = "TDM Cars",
			Author = "TheDanishMaster, freemmaann, Turn 10",
			Information = "A drivable Mazda MX-5 2007 by TheDanishMaster",
			Model = "models/tdmcars/mx5.mdl",
			//Vehicle Controller
			VC_Lights = { //Pos can be a simple Vector() relative to the vehicle or an attachment name, else is self explanatory, can be an infinite amount of these.
						{Pos = Vector(-21, -89.5, 35.3), Mat = "sprites/glow1.vmt", Alpha = 180, Size = 0.6, DynLight = true, NormalColor = "255 0 0", BrakeColor = "255 0 0", ReverseColor = "255 255 255"},
						{Pos = Vector(21, -89.5, 35.3), Mat = "sprites/glow1.vmt", Alpha = 180, Size = 0.6, DynLight = true, NormalColor = "255 0 0", BrakeColor = "255 0 0"},
						{Pos = Vector(0, -59.1, 46.8), Mat = "sprites/glow1.vmt", Alpha = 180, Size = 0.1, DynLight = true, NormalColor = "255 0 0", BrakeColor = "255 0 0"},
						{Pos = Vector(-2.3, -59.1, 46.8), Mat = "sprites/glow1.vmt", Alpha = 180, Size = 0.1, DynLight = true, NormalColor = "255 0 0", BrakeColor = "255 0 0"},
						{Pos = Vector(2.3, -59.1, 46.8), Mat = "sprites/glow1.vmt", Alpha = 180, Size = 0.1, DynLight = true, NormalColor = "255 0 0", BrakeColor = "255 0 0"},
						{Pos = Vector(-4.5, -59.1, 46.8), Mat = "sprites/glow1.vmt", Alpha = 180, Size = 0.1, DynLight = true, NormalColor = "255 0 0", BrakeColor = "255 0 0"},
						{Pos = Vector(4.5, -59.1, 46.8), Mat = "sprites/glow1.vmt", Alpha = 180, Size = 0.1, DynLight = true, NormalColor = "255 0 0", BrakeColor = "255 0 0"},
						{Pos = Vector(-6.8, -59.1, 46.8), Mat = "sprites/glow1.vmt", Alpha = 180, Size = 0.1, DynLight = true, NormalColor = "255 0 0", BrakeColor = "255 0 0"},
						{Pos = Vector(6.8, -59.1, 46.8), Mat = "sprites/glow1.vmt", Alpha = 180, Size = 0.1, DynLight = true, NormalColor = "255 0 0", BrakeColor = "255 0 0"},
						{Pos = Vector(-29, -86.6, 34.9), Mat = "sprites/glow1.vmt", Alpha = 180, Size = 0.4, DynLight = true, NormalColor = "255 0 0"},
						{Pos = Vector(29, -86.6, 34.9), Mat = "sprites/glow1.vmt", Alpha = 180, Size = 0.4, DynLight = true, NormalColor = "255 0 0"},
						{Pos = Vector(-25.3, -87.7, 34.9), Mat = "sprites/glow1.vmt", Alpha = 180, Size = 0.4, DynLight = true, BlinkersColor = "255 130 0"},
						{Pos = Vector(25.3, -87.7, 34.9), Mat = "sprites/glow1.vmt", Alpha = 180, Size = 0.4, DynLight = true, BlinkersColor = "255 130 0"},
						{Pos = Vector(-41.5, 36.8, 28.3), Mat = "sprites/glow1.vmt", Alpha = 180, Size = 0.2, DynLight = true, BlinkersColor = "255 130 0"},
						{Pos = Vector(41.5, 36.8, 28.3), Mat = "sprites/glow1.vmt", Alpha = 180, Size = 0.2, DynLight = true, BlinkersColor = "255 130 0"},
						{Pos = Vector(-30.1, 82.6, 32.6), Mat = "sprites/glow1.vmt", Alpha = 180, Size = 0.4, DynLight = true, BlinkersColor = "255 130 0"},
						{Pos = Vector(30.1, 82.6, 32.6), Mat = "sprites/glow1.vmt", Alpha = 180, Size = 0.4, DynLight = true, BlinkersColor = "255 130 0"},
						{Pos = Vector(-21, 84.2, 31.8), Mat = "sprites/glow1.vmt", Alpha = 180, Size = 0.6, DynLight = true, NormalColor = "255 255 255"},
						{Pos = Vector(21, 84.2, 31.8), Mat = "sprites/glow1.vmt", Alpha = 180, Size = 0.6, DynLight = true, NormalColor = "255 255 255"},
						{Pos = Vector(-18.5, 88.4, 31.1), Mat = "sprites/glow1.vmt", Alpha = 180, Size = 0.3, DynLight = true, NormalColor = "255 255 255"},
						{Pos = Vector(18.5, 88.4, 31.1), Mat = "sprites/glow1.vmt", Alpha = 180, Size = 0.3, DynLight = true, NormalColor = "255 255 255"},

						{Pos = Vector(-25.6, 80.2, 32.1), Size = 1, GlowSize = 1, HeadLightAngle = Angle(-5, 95, 0)},
						{Pos = Vector(25.6, 80.2, 32.1), Size = 1, GlowSize = 1, HeadLightAngle = Angle(-5, 85, 0)}
						},
			VC_Exhaust_Dissipate = true,
			VC_Exhaust = { //Exhaust effect, only active when engine is on, can be infinite amount.
						{Pos = Vector(-21.1, -89.7, 12.4), Ang = Angle(0,0,90), EffectIdle = "Exhaust", EffectStress = "Exhaust"},
						{Pos = Vector(21.1, -89.7, 12.4), Ang = Angle(0,0,90), EffectIdle = "Exhaust", EffectStress = "Exhaust"}
						},
			VC_ExtraSeats = { //Can be an infinite amount of seats, Pos and ExitPos can be a simple Vector() or an attachment name, other options are self explanatory.
						{Pos = Vector(-18, -5, 20), Ang = Angle(0, 0, 8), EnterRange = 80, ExitAng = Angle(0, -90, 0), Model = "models/props_phx/carseat2.mdl", ModelOffset = Vector(12, 0, 4), Hide = true, DoorSounds = true, RadioControl = false}
						},
			VC_Horn = {Sound = "vehicles/vc_horn_light.wav", Pitch = 100, Looping = false}, //Horn sound the car will use.
						
			KeyValues = {
							vehiclescript	=	"scripts/vehicles/TDMCars/mx5.txt"
							}
			}
list.Set("Vehicles", "mx5tdm", V)