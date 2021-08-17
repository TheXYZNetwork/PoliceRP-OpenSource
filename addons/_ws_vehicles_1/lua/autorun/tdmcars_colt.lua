local V = {
			Name = "Mitsubishi Colt Ralliart", 
			Class = "prop_vehicle_jeep",
			Category = "TDM Cars",
			Author = "TheDanishMaster, freemmaann, Turn 10",
			Information = "A drivable Mitsubishi Colt Ralliart by TheDanishMaster",
			Model = "models/tdmcars/coltralliart.mdl",
			//Vehicle Controller
			VC_Lights = { //Pos can be a simple Vector() relative to the vehicle or an attachment name, else is self explanatory, can be an infinite amount of these.
						{Pos = Vector(-33.4, -73.3, 48.8), Mat = "sprites/glow1.vmt", Alpha = 180, Size = 0.7, DynLight = true, NormalColor = "255 0 0", BrakeColor = "255 0 0"},
						{Pos = Vector(33.4, -73.3, 48.8), Mat = "sprites/glow1.vmt", Alpha = 180, Size = 0.7, DynLight = true, NormalColor = "255 0 0", BrakeColor = "255 0 0"},
						{Pos = Vector(0, -69.9, 68.3), Mat = "sprites/glow1.vmt", Alpha = 180, Size = 0.1, DynLight = true, NormalColor = "255 0 0", BrakeColor = "255 0 0"},
						{Pos = Vector(-1.7, -69.9, 68.3), Mat = "sprites/glow1.vmt", Alpha = 180, Size = 0.1, DynLight = true, NormalColor = "255 0 0", BrakeColor = "255 0 0"},
						{Pos = Vector(1.7, -69.9, 68.3), Mat = "sprites/glow1.vmt", Alpha = 180, Size = 0.1, DynLight = true, NormalColor = "255 0 0", BrakeColor = "255 0 0"},
						{Pos = Vector(-2.5, -69.9, 68.3), Mat = "sprites/glow1.vmt", Alpha = 180, Size = 0.1, DynLight = true, NormalColor = "255 0 0", BrakeColor = "255 0 0"},
						{Pos = Vector(2.5, -69.9, 68.3), Mat = "sprites/glow1.vmt", Alpha = 180, Size = 0.1, DynLight = true, NormalColor = "255 0 0", BrakeColor = "255 0 0"},
						{Pos = Vector(-32.4, 89.3, 18.6), Mat = "sprites/glow1.vmt", Alpha = 180, Size = 0.6, DynLight = true, NormalColor = "255 255 255"},
						{Pos = Vector(32.4, 89.3, 18.6), Mat = "sprites/glow1.vmt", Alpha = 180, Size = 0.6, DynLight = true, NormalColor = "255 255 255"},
						{Pos = Vector(23, -81.4, 46.2), Mat = "sprites/glow1.vmt", Alpha = 180, Size = 0.3, DynLight = true, ReverseColor = "255 255 255"},
						{Pos = Vector(-35.2, 81.3, 36.5), Mat = "sprites/glow1.vmt", Alpha = 220, Size = 0.7, DynLight = true, BlinkersColor = "255 130 0"},
						{Pos = Vector(35.2, 81.3, 36.5), Mat = "sprites/glow1.vmt", Alpha = 220, Size = 0.7, DynLight = true, BlinkersColor = "255 130 0"},
						{Pos = Vector(-40.8, 43.7, 40.7), Mat = "sprites/glow1.vmt", Alpha = 220, Size = 0.2, DynLight = true, BlinkersColor = "255 130 0"},
						{Pos = Vector(40.8, 43.7, 40.7), Mat = "sprites/glow1.vmt", Alpha = 220, Size = 0.2, DynLight = true, BlinkersColor = "255 130 0"},
						{Pos = Vector(-29.8, -77.8, 48.5), Mat = "sprites/glow1.vmt", Alpha = 220, Size = 0.4, DynLight = true, BlinkersColor = "255 130 0"},
						{Pos = Vector(29.8, -77.8, 48.5), Mat = "sprites/glow1.vmt", Alpha = 220, Size = 0.4, DynLight = true, BlinkersColor = "255 130 0"},
						{Pos = Vector(-27.7, 76.7, 35.8), Size = 1, GlowSize = 1, HeadLightAngle = Angle(-5, 95, 0)},
						{Pos = Vector(27.7, 76.7, 35.8), Size = 1, GlowSize = 1, HeadLightAngle = Angle(-5, 85, 0)}
						},
			VC_Exhaust_Dissipate = true,
			VC_Exhaust = { //Exhaust effect, only active when engine is on, can be infinite amount.
						{Pos = Vector(18.2, -83.1, 11.8), Ang = Angle(0,0,90), EffectIdle = "Exhaust", EffectStress = "Exhaust"}
						},
			VC_ExtraSeats = { //Can be an infinite amount of seats, Pos and ExitPos can be a simple Vector() or an attachment name, other options are self explanatory.
						{Pos = Vector(-19, 5, 29), Ang = Angle(0, 0, 8), EnterRange = 80, ExitAng = Angle(0, -90, 0), Model = "models/props_phx/carseat2.mdl", ModelOffset = Vector(12, 0, 4), Hide = true, DoorSounds = true, RadioControl = true},
						{Pos = Vector(17, -38, 30), Ang = Angle(0, 0, 8), EnterRange = 80, ExitAng = Angle(0, -90, 0), Model = "models/props_phx/carseat2.mdl", ModelOffset = Vector(12, 0, 4), Hide = true, DoorSounds = true, RadioControl = false},
						{Pos = Vector(-17, -38, 30), Ang = Angle(0, 0, 8), EnterRange = 80, ExitAng = Angle(0, -90, 0), Model = "models/props_phx/carseat2.mdl", ModelOffset = Vector(12, 0, 4), Hide = true, DoorSounds = true, RadioControl = false}
						},
			VC_Horn = {Sound = "vehicles/vc_horn_light.wav", Pitch = 100, Looping = false}, //Horn sound the car will use.
						
			KeyValues = {
							vehiclescript	=	"scripts/vehicles/TDMCars/colt.txt"
							}
			}
list.Set("Vehicles", "colttdm", V)