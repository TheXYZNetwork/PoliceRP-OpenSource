local V = {
			Name = "Hummer H1", 
			Class = "prop_vehicle_jeep",
			Category = "TDM Cars",
			Author = "TheDanishMaster, freemmaann, Turn 10",
			Information = "A drivable Hummer H1 by TheDanishMaster",
			Model = "models/tdmcars/hummerh1.mdl",
			//Vehicle Controller
			VC_Lights = { //Pos can be a simple Vector() relative to the vehicle or an attachment name, else is self explanatory, can be an infinite amount of these.
						{Pos = Vector(-40, -112.3, 46.7), Mat = "sprites/glow1.vmt", Alpha = 180, Size = 0.4, DynLight = true, ReverseColor = "255 255 255"},
						{Pos = Vector(40, -112.3, 46.7), Mat = "sprites/glow1.vmt", Alpha = 180, Size = 0.4, DynLight = true, ReverseColor = "255 255 255"},
						
						{Pos = Vector(-40, -112.3, 43.5), Mat = "sprites/glow1.vmt", Alpha = 220, Size = 0.7, DynLight = true, NormalColor = "255 0 0", BrakeColor = "255 0 0"},
						{Pos = Vector(40, -112.3, 43.5), Mat = "sprites/glow1.vmt", Alpha = 220, Size = 0.7, DynLight = true, NormalColor = "255 0 0", BrakeColor = "255 0 0"},

						{Pos = Vector(-43.7, 100, 39.8), Mat = "sprites/glow1.vmt", Alpha = 220, Size = 0.35, DynLight = true, NormalColor = "255 130 0"},
						{Pos = Vector(43.7, 100, 39.8), Mat = "sprites/glow1.vmt", Alpha = 220, Size = 0.35, DynLight = true, NormalColor = "255 130 0"},
						{Pos = Vector(-6.2, 35.8, 77.6), Mat = "sprites/glow1.vmt", Alpha = 220, Size = 0.5, DynLight = true, NormalColor = "255 130 0"},
						{Pos = Vector(6.2, 35.8, 77.6), Mat = "sprites/glow1.vmt", Alpha = 220, Size = 0.5, DynLight = true, NormalColor = "255 130 0"},
						{Pos = Vector(0, 35.8, 77.6), Mat = "sprites/glow1.vmt", Alpha = 220, Size = 0.5, DynLight = true, NormalColor = "255 130 0"},
						{Pos = Vector(-14, -112.7, 36.2), Mat = "sprites/glow1.vmt", Alpha = 220, Size = 0.5, DynLight = true, NormalColor = "255 0 0"},
						{Pos = Vector(14, -112.7, 36.2), Mat = "sprites/glow1.vmt", Alpha = 220, Size = 0.5, DynLight = true, NormalColor = "255 0 0"},
						{Pos = Vector(0, -112.7, 36.2), Mat = "sprites/glow1.vmt", Alpha = 220, Size = 0.5, DynLight = true, NormalColor = "255 0 0"},
						
						{Pos = Vector(-41.8, -109.2, 43.6), Mat = "sprites/glow1.vmt", Alpha = 220, Size = 0.5, DynLight = true, BlinkersColor = "255 130 0"},
						{Pos = Vector(41.8, -109.2, 43.6), Mat = "sprites/glow1.vmt", Alpha = 220, Size = 0.5, DynLight = true, BlinkersColor = "255 130 0"},
						
						{Pos = Vector(-40.6, 98.7, 45.1), Mat = "sprites/glow1.vmt", Alpha = 220, Size = 0.6, DynLight = true, BlinkersColor = "255 130 0"},
						{Pos = Vector(40.6, 98.7, 45.1), Mat = "sprites/glow1.vmt", Alpha = 220, Size = 0.6, DynLight = true, BlinkersColor = "255 130 0"},
						{Pos = Vector(-47.5, -112.3, 52), Mat = "sprites/glow1.vmt", Alpha = 220, Size = 0.5, DynLight = true, BlinkersColor = "255 0 0"},
						{Pos = Vector(47.5, -112.3, 52), Mat = "sprites/glow1.vmt", Alpha = 220, Size = 0.5, DynLight = true, BlinkersColor = "255 0 0"},

						{Pos = Vector(-22, 88.7, 41.2), Size = 1, GlowSize = 1, HeadLightAngle = Angle(-5, 95, 0)},
						{Pos = Vector(22, 88.7, 41.2), Size = 1, GlowSize = 1, HeadLightAngle = Angle(-5, 85, 0)}
						},
			VC_Exhaust_Dissipate = true, 
			VC_Exhaust = { //Exhaust effect, only active when engine is on, can be infinite amount.
						{Pos = Vector(-47.5, -112.3, 20.5), Ang = Angle(0,90,0), EffectIdle = "Exhaust", EffectStress = "Exhaust"}
						},
			VC_ExtraSeats = { //Can be an infinite amount of seats, Pos and ExitPos can be a simple Vector() or an attachment name, other options are self explanatory.
						{Pos = Vector(30, 10, 40), Ang = Angle(0, 0, 8), EnterRange = 80, ExitAng = Angle(0, -90, 0), Model = "models/props_phx/carseat2.mdl", ModelOffset = Vector(12, 0, 4), Hide = true, DoorSounds = true, RadioControl = true},
						{Pos = Vector(30, -29, 40), Ang = Angle(0, 0, 8), EnterRange = 80, ExitAng = Angle(0, -90, 0), Model = "models/props_phx/carseat2.mdl", ModelOffset = Vector(12, 0, 4), Hide = true, DoorSounds = true, RadioControl = false},
						{Pos = Vector(-30, -29, 40), Ang = Angle(0, 0, 8), EnterRange = 80, ExitAng = Angle(0, -90, 0), Model = "models/props_phx/carseat2.mdl", ModelOffset = Vector(12, 0, 4), Hide = true, DoorSounds = true, RadioControl = false}
						},
			VC_Horn = {Sound = "vehicles/vc_horn_heavy.wav", Pitch = 110, Looping = false}, //Horn sound the car will use.
						
			KeyValues = {
							vehiclescript	=	"scripts/vehicles/TDMCars/h1.txt"
							}
			}
list.Set("Vehicles", "h1tdm", V)