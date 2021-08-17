local V = {
			Name = "Volvo S60 R Police", 
			Class = "prop_vehicle_jeep",
			Category = "LW Emergency Vehicles",
			Author = "LoneWolfie",
			Information = "Driveable s60 by LoneWolfie",
			Model = "models/LoneWolfie/volvo_s60_pol.mdl",
																	//Vehicle Controller
			VC_Lights = { //Pos can be a simple Vector() relative to the vehicle or an attachment name, else is self explanatory, can be an infinite amount of these.

						{Pos = Vector(-37.3, 103.9, 44.8), Mat = "sprites/glow1.vmt", Alpha = 170, Size = 0.6, DynLight = true, BlinkersColor = "200 80 0"},
						{Pos = Vector(37.3, 103.9, 44.8), Mat = "sprites/glow1.vmt", Alpha = 170, Size = 0.6, DynLight = true,  BlinkersColor = "200 80 0"},
						
						{Pos = Vector(23.8, 106.7, 44.8), Mat = "sprites/glow1.vmt", Alpha = 230, Size = 0.7, DynLight = true, NormalColor = "230 230 230"},
						{Pos = Vector(-23.8, 106.7, 44.8), Mat = "sprites/glow1.vmt", Alpha = 230, Size = 0.7, DynLight = true, NormalColor = "230 230 230"},
						
						{Pos = Vector(31.5, 110, 28.6), Mat = "sprites/glow1.vmt", Alpha = 170, Size = 0.7, DynLight = true, NormalColor = "200 200 235"},
						{Pos = Vector(-31.5, 110, 28.6), Mat = "sprites/glow1.vmt", Alpha = 170, Size = 0.7, DynLight = true, NormalColor = "200 200 235"},
						

						{Pos = Vector(30.9, -108.5, 55.8), Mat = "sprites/glow1.vmt", Alpha = 200, Size = 0.8, DynLight = true, NormalColor = "200 0 0", BrakeColor = "255 0 0"},
						{Pos = Vector(-30.9, -108.5, 55.8), Mat = "sprites/glow1.vmt", Alpha = 200, Size = 0.8, DynLight = true, NormalColor = "200 0 0", BrakeColor = "255 0 0"},
						
			
						{Pos = Vector(28.9, -111, 50.7), Mat = "sprites/glow1.vmt", Alpha = 170, Size = 0.4, DynLight = true, BlinkersColor = "200 80 0"},
						{Pos = Vector(-28.9, -111, 50.7), Mat = "sprites/glow1.vmt", Alpha = 170, Size = 0.4, DynLight = true,  BlinkersColor = "200 80 0"},
						{Pos = Vector(33.0, -110, 50.7), Mat = "sprites/glow1.vmt", Alpha = 170, Size = 0.4, DynLight = true, BlinkersColor = "200 80 0"},
						{Pos = Vector(-33.0, -110, 50.7), Mat = "sprites/glow1.vmt", Alpha = 170, Size = 0.4, DynLight = true,  BlinkersColor = "200 80 0"},
						{Pos = Vector(36.0, -108, 50.7), Mat = "sprites/glow1.vmt", Alpha = 170, Size = 0.4, DynLight = true, BlinkersColor = "200 80 0"},
						{Pos = Vector(-36.0, -108, 50.7), Mat = "sprites/glow1.vmt", Alpha = 170, Size = 0.4, DynLight = true,  BlinkersColor = "200 80 0"},
						
						{Pos = Vector(27.9, -111, 47.7), Mat = "sprites/glow1.vmt", Alpha = 110, Size = 0.5, DynLight = true, ReverseColor = "220 220 220"},
						{Pos = Vector(-27.9, -111, 47.7), Mat = "sprites/glow1.vmt", Alpha = 110, Size = 0.5, DynLight = true,  ReverseColor = "220 220 220"},
						{Pos = Vector(33.0, -110, 47.7), Mat = "sprites/glow1.vmt", Alpha = 110, Size = 0.5, DynLight = true, ReverseColor = "220 220 220"},
						{Pos = Vector(-33.0, -110, 47.7), Mat = "sprites/glow1.vmt", Alpha = 110, Size = 0.5, DynLight = true,  ReverseColor = "220 220 220"},
						{Pos = Vector(37.0, -108, 47.7), Mat = "sprites/glow1.vmt", Alpha = 110, Size = 0.5, DynLight = true, ReverseColor = "220 220 220"},
						{Pos = Vector(-37.0, -108, 47.7), Mat = "sprites/glow1.vmt", Alpha = 110, Size = 0.5, DynLight = true,  ReverseColor = "220 220 220"},
					
				
						{Pos = Vector(-31.1, 106.2, 44.8), Size = 0.4, GlowSize = 0.5, HeadLightAngle = Angle(-5, 95, 0)},
						{Pos = Vector(31.1, 106.2, 44.8), Size = 0.4, GlowSize = 0.5, HeadLightAngle = Angle(-5, 85, 0)}
						},
			VC_Exhaust_Dissipate = true,
			VC_Exhaust = { //Exhaust effect, only active when engine is on, can be infinite amount.
						{Pos = Vector(-28.3, -109.6, 27.6), Ang = Angle(0,0,90), EffectIdle = "Exhaust", EffectStress = "Exhaust"},
						{Pos = Vector(-26.3, -109.6, 27.6), Ang = Angle(0,0,90), EffectIdle = "Exhaust", EffectStress = "Exhaust"},

						},
			VC_ExtraSeats = { //Can be an infinite amount of seats, Pos and ExitPos can be a simple Vector() or an attachment name, other options are self explanatory.
						{Pos = Vector(20.9, -5.5, 40), Ang = Angle(0, 0, 8), EnterRange = 80, ExitAng = Angle(0, -90, 0), Model = "models/props_phx/carseat2.mdl", ModelOffset = Vector(12, 0, 4), Hide = true, DoorSounds = true, RadioControl = true},
						{Pos = Vector(20.9, -47.5, 40), Ang = Angle(0, 0, 8), EnterRange = 80, ExitAng = Angle(0, -90, 0), Model = "models/props_phx/carseat2.mdl", ModelOffset = Vector(12, 0, 4), Hide = true, DoorSounds = true, RadioControl = false},
						{Pos = Vector(-20.9, -47.5, 40), Ang = Angle(0, 0, 8), EnterRange = 80, ExitAng = Angle(0, -90, 0), Model = "models/props_phx/carseat2.mdl", ModelOffset = Vector(12, 0, 4), Hide = true, DoorSounds = true, RadioControl = false},
	},
			VC_Horn = {Sound = "vehicles/vc_horn_light.wav", Pitch = 110, Looping = false}, //Horn sound the car will use.
			
			KeyValues = {
							vehiclescript	=	"scripts/vehicles/LWCars/volvo_stock.txt"
							}
			}
list.Set("Vehicles", "volvo_s60_pol", V)