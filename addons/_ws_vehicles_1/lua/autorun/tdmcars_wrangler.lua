local V = {
			Name = "Jeep Wrangler", 
			Class = "prop_vehicle_jeep",
			Category = "TDM Cars",
			Author = "TheDanishMaster, freemmaann, Turn 10",
			Information = "A drivable Jeep Wrangler by TheDanishMaster",
			Model = "models/tdmcars/wrangler.mdl",
			//Vehicle Controller
			VC_Lights = { //Pos can be a simple Vector() relative to the vehicle or an attachment name, else is self explanatory, can be an infinite amount of these.
						{Pos = Vector(-34, -84.8, 50), Mat = "sprites/glow1.vmt", Alpha = 180, Size = 0.8, DynLight = true, NormalColor = "255 0 0", BrakeColor = "255 0 0", BlinkersColor = "255 0 0"},
						{Pos = Vector(34, -84.8, 50), Mat = "sprites/glow1.vmt", Alpha = 180, Size = 0.8, DynLight = true, NormalColor = "255 0 0", BrakeColor = "255 0 0", BlinkersColor = "255 0 0"},

						{Pos = Vector(-34, -84.8, 46.5), Mat = "sprites/glow1.vmt", Alpha = 180, Size = 0.6, DynLight = true, ReverseColor = "255 255 255"},
						{Pos = Vector(34, -84.8, 46.5), Mat = "sprites/glow1.vmt", Alpha = 180, Size = 0.6, DynLight = true, ReverseColor = "255 255 255"},

						{Pos = Vector(-24.5, 86, 38.8), Mat = "sprites/glow1.vmt", Alpha = 220, Size = 0.6, DynLight = true, BlinkersColor = "255 130 0"},
						{Pos = Vector(24.5, 86, 38.8), Mat = "sprites/glow1.vmt", Alpha = 220, Size = 0.6, DynLight = true, BlinkersColor = "255 130 0"},

						{Pos = Vector(-23.4, 77, 46.9), Size = 1, GlowSize = 1, HeadLightAngle = Angle(-5, 95, 0)},
						{Pos = Vector(23.4, 77, 46.9), Size = 1, GlowSize = 1, HeadLightAngle = Angle(-5, 85, 0)}
						},
			VC_Exhaust_Dissipate = true,
			VC_Exhaust = { //Exhaust effect, only active when engine is on, can be infinite amount.
						{Pos = Vector(22.5, -89, 22), Ang = Angle(0,0,90), EffectIdle = "Exhaust", EffectStress = "Exhaust"}
						},
			VC_ExtraSeats = { //Can be an infinite amount of seats, Pos and ExitPos can be a simple Vector() or an attachment name, other options are self explanatory.
						{Pos = Vector(20,-2, 42), Ang = Angle(0, 0, 8), EnterRange = 80, ExitAng = Angle(0, -90, 0), Model = "models/props_phx/carseat2.mdl", ModelOffset = Vector(12, 0, 4), Hide = true, DoorSounds = true, RadioControl = true},
						{Pos = Vector(18, -48, 40), Ang = Angle(0, 0, 8), EnterRange = 80, ExitAng = Angle(0, -90, 0), Model = "models/props_phx/carseat2.mdl", ModelOffset = Vector(12, 0, 4), Hide = true, DoorSounds = true, RadioControl = false},
						{Pos = Vector(-18, -48, 40), Ang = Angle(0, 0, 8), EnterRange = 80, ExitAng = Angle(0, -90, 0), Model = "models/props_phx/carseat2.mdl", ModelOffset = Vector(12, 0, 4), Hide = true, DoorSounds = true, RadioControl = false}
						},
			VC_Horn = {Sound = "vehicles/vc_horn_light.wav", Pitch = 100, Looping = false}, //Horn sound the car will use.
						
			KeyValues = {
							vehiclescript	=	"scripts/vehicles/TDMCars/wrangler.txt"
							}
			}
list.Set("Vehicles", "wranglertdm", V)