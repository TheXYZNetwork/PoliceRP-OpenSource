local V = {
			Name = "Caterham R500 Superlight", 
			Class = "prop_vehicle_jeep",
			Category = "LW Cars",
			Author = "LoneWolfie",
			Information = "Driveable Caterham R500 Superlight by LoneWolfie",
			Model = "models/LoneWolfie/caterham_r500_superlight.mdl",
			VC_Lights = { 			
				{Pos = Vector(19.8, 58.8, 30.9), Mat = "sprites/blueflare1.vmt", Alpha = 225, Size = 0.7, DynLight = true, NormalColor = "255 232 171"},
				{Pos = Vector(-19.8, 58.8, 30.9), Mat = "sprites/blueflare1.vmt", Alpha = 225, Size = 0.7, DynLight = true, NormalColor = "255 232 171"},

				{Pos = Vector(19.8, 61.3, 24.3), Mat = "sprites/blueflare1.vmt", Alpha = 225, Size = 0.4, DynLight = true, BlinkersColor = "200 80 0"},
				{Pos = Vector(-19.8, 61.3, 24.3), Mat = "sprites/blueflare1.vmt", Alpha = 225, Size = 0.4, DynLight = true, BlinkersColor = "200 80 0"},
	
				{Pos = Vector(30.8, -71.6, 22.6), Mat = "sprites/blueflare1.vmt", Alpha = 225, Size = 0.4, DynLight = true, BrakeColor = "255 0 0"},
				{Pos = Vector(-30.8, -71.6, 22.6), Mat = "sprites/blueflare1.vmt", Alpha = 225, Size = 0.4, DynLight = true, BrakeColor = "255 0 0"},
	
				{Pos = Vector(33.7, -71.6, 22.6), Mat = "sprites/blueflare1.vmt", Alpha = 225, Size = 0.5, DynLight = true, BlinkersColor = "200 80 0"},
				{Pos = Vector(-33.7, -71.6, 22.6), Mat = "sprites/blueflare1.vmt", Alpha = 225, Size = 0.5, DynLight = true, BlinkersColor = "200 80 0"},

				{Pos = Vector(27.9, -71.6, 22.6), Mat = "sprites/blueflare1.vmt", Alpha = 225, Size = 0.5, DynLight = true, NormalColor = "255 0 0"},
				{Pos = Vector(-27.9, -71.6, 22.6), Mat = "sprites/blueflare1.vmt", Alpha = 225, Size = 0.5, DynLight = true, NormalColor = "255 0 0"},

				{Pos = Vector(15.7, -76.6, 15.3), Mat = "sprites/blueflare1.vmt", Alpha = 225, Size = 0.5, DynLight = true, ReverseColor = "255 255 255"},
				{Pos = Vector(-15.7, -76.6, 15.3), Mat = "sprites/blueflare1.vmt", Alpha = 225, Size = 0.5, DynLight = true, ReverseColor = "255 255 255"},
				
				{Pos = Vector(19.8, 58.8, 30.9), Size = 0.3, GlowSize = 0.4, HeadLightAngle = Angle(-5, 90, 0)},
				{Pos = Vector(-19.8, 58.8, 30.9), Size = 0.3, GlowSize = 0.4, HeadLightAngle = Angle(-5, 90, 0)}				
						},
						

			VC_Exhaust_Dissipate = true,
			
			VC_Exhaust = { 
				{Pos = Vector(34.8, -32.3, 8.3), Ang = Angle(0,0,-90), EffectIdle = "Exhaust", EffectStress = "Exhaust"},
						},
						
			VC_ExtraSeats = { 
				{Pos = Vector(-12.4, -39.8, 13.5), Ang = Angle(0, 0, 0), EnterRange = 80, ExitAng = Angle(0, -90, 0), Model = "models/props_phx/carseat2.mdl", ModelOffset = Vector(0, 0, 0), Hide = true, DoorSounds = true, RadioControl = true},						
							},
							
			VC_Horn = {Sound = "vehicles/vc_horn_light.wav", Pitch = 100, Looping = false}, 
						
			KeyValues = {
							vehiclescript	=	"scripts/vehicles/LWCars/caterham_r500_superlight.txt"
							}
			}
list.Set("Vehicles", "caterham_r500_superlight_lw", V)
