local V = {
			Name = "Dodge Charger Daytona HEMI", 
			Class = "prop_vehicle_jeep",
			Category = "LW Cars",
			Author = "LoneWolfie",
			Information = "Driveable daytona by LoneWolfie",
			Model = "models/LoneWolfie/dodge_daytona.mdl",
																							//Vehicle Controller
			VC_Lights = { //Pos can be a simple Vector() relative to the vehicle or an attachment name, else is self explanatory, can be an infinite amount of these.

						{Pos = Vector(33.0,-134, 41.6), Mat = "sprites/glow1.vmt", Alpha = 210, Size = 0.34, DynLight = true, BrakeColor = "255 0 0", BlinkersColor = "255 0 0", NormalColor = "255 0 0"},
						{Pos = Vector(30.0,-134, 41.6), Mat = "sprites/glow1.vmt", Alpha = 210, Size = 0.34, DynLight = true, BrakeColor = "255 0 0", BlinkersColor = "255 0 0", NormalColor = "255 0 0"},
						{Pos = Vector(36.0,-134, 41.6), Mat = "sprites/glow1.vmt", Alpha = 210, Size = 0.34, DynLight = true, BrakeColor = "255 0 0", BlinkersColor = "255 0 0", NormalColor = "255 0 0"},
						{Pos = Vector(33.0,-134, 41.6), Mat = "sprites/glow1.vmt", Alpha = 210, Size = 0.37, DynLight = true, BrakeColor = "245 0 0", BlinkersColor = "255 0 0", NormalColor = "255 0 0"},
						
					    {Pos = Vector(-33.0,-134, 41.6), Mat = "sprites/glow1.vmt", Alpha = 210, Size = 0.34, DynLight = true, BrakeColor = "255 0 0", BlinkersColor = "255 0 0", NormalColor = "230 0 0"},
						{Pos = Vector(-30.0,-134, 41.6), Mat = "sprites/glow1.vmt", Alpha = 210, Size = 0.34, DynLight = true, BrakeColor = "255 0 0", BlinkersColor = "255 0 0", NormalColor = "230 0 0"},
						{Pos = Vector(-36.0,-134, 41.6), Mat = "sprites/glow1.vmt", Alpha = 210, Size = 0.34, DynLight = true, BrakeColor = "255 0 0", BlinkersColor = "255 0 0", NormalColor = "230 0 0"},
						{Pos = Vector(-33.0,-134, 41.6), Mat = "sprites/glow1.vmt", Alpha = 210, Size = 0.37, DynLight = true, BrakeColor = "245 0 0", BlinkersColor = "255 0 0", NormalColor = "230 0 0"},

						{Pos = Vector(23.9,-134, 41.6), Mat = "sprites/glow1.vmt", Alpha = 210, Size = 0.34, DynLight = true, BrakeColor = "255 0 0", BlinkersColor = "255 0 0", NormalColor = "255 0 0"},
						{Pos = Vector(20.9,-134, 41.6), Mat = "sprites/glow1.vmt", Alpha = 210, Size = 0.34, DynLight = true, BrakeColor = "255 0 0", BlinkersColor = "255 0 0", NormalColor = "255 0 0"},
						{Pos = Vector(26.0,-134, 41.6), Mat = "sprites/glow1.vmt", Alpha = 210, Size = 0.34, DynLight = true, BrakeColor = "255 0 0", BlinkersColor = "255 0 0", NormalColor = "255 0 0"},
						{Pos = Vector(23.9,-134, 41.6), Mat = "sprites/glow1.vmt", Alpha = 210, Size = 0.37, DynLight = true, BrakeColor = "245 0 0", BlinkersColor = "255 0 0", NormalColor = "255 0 0"},
						
						{Pos = Vector(-23.9,-134, 41.6), Mat = "sprites/glow1.vmt", Alpha = 210, Size = 0.34, DynLight = true, BrakeColor = "255 0 0", BlinkersColor = "255 0 0", NormalColor = "230 0 0"},
						{Pos = Vector(-20.9,-134, 41.6), Mat = "sprites/glow1.vmt", Alpha = 210, Size = 0.34, DynLight = true, BrakeColor = "255 0 0", BlinkersColor = "255 0 0", NormalColor = "230 0 0"},
						{Pos = Vector(-26.0,-134, 41.6), Mat = "sprites/glow1.vmt", Alpha = 210, Size = 0.34, DynLight = true, BrakeColor = "255 0 0", BlinkersColor = "255 0 0", NormalColor = "230 0 0"},
						{Pos = Vector(-23.9,-134, 41.6), Mat = "sprites/glow1.vmt", Alpha = 210, Size = 0.37, DynLight = true, BrakeColor = "245 0 0", BlinkersColor = "255 0 0", NormalColor = "230 0 0"},
						
						{Pos = Vector(-11.8,-134, 41.6), Mat = "sprites/glow1.vmt", Alpha = 210, Size = 0.34, DynLight = true, NormalColor = "255 0 0"},
						{Pos = Vector(-8.8,-134, 41.6), Mat = "sprites/glow1.vmt", Alpha = 210, Size = 0.34, DynLight = true, NormalColor = "255 0 0"},
						{Pos = Vector(-14.8,-134, 41.6), Mat = "sprites/glow1.vmt", Alpha = 210, Size = 0.34, DynLight = true, NormalColor = "255 0 0"},
						{Pos = Vector(-11.8,-134, 41.6), Mat = "sprites/glow1.vmt", Alpha = 210, Size = 0.35, DynLight = true, NormalColor = "245 0 0"},
						
						{Pos = Vector(11.8,-134, 41.6), Mat = "sprites/glow1.vmt", Alpha = 210, Size = 0.34, DynLight = true, NormalColor = "255 0 0"},
						{Pos = Vector(8.8,-134, 41.6), Mat = "sprites/glow1.vmt", Alpha = 210, Size = 0.34, DynLight = true, NormalColor = "255 0 0"},
						{Pos = Vector(14.8,-134, 41.6), Mat = "sprites/glow1.vmt", Alpha = 210, Size = 0.34, DynLight = true, NormalColor = "255 0 0"},
						{Pos = Vector(11.8,-134, 41.6), Mat = "sprites/glow1.vmt", Alpha = 210, Size = 0.35, DynLight = true, NormalColor = "245 0 0"},
						
						{Pos = Vector(18.5,-140, 27.6), Mat = "sprites/glow1.vmt", Alpha = 240, Size = 0.37, DynLight = true, ReverseColor = "230 230 230"},
						{Pos = Vector(-18.5,-140, 27.6), Mat = "sprites/glow1.vmt", Alpha = 240, Size = 0.37, DynLight = true, ReverseColor = "230 230 230"},
						
						{Pos = Vector(42.7,-128.7, 31.5), Mat = "sprites/glow1.vmt", Alpha = 210, Size = 0.34, DynLight = true,BlinkersColor = "255 30 0"},
						{Pos = Vector(-42.7,-128.7, 31.5), Mat = "sprites/glow1.vmt", Alpha = 210, Size = 0.34, DynLight = true,BlinkersColor = "255 30 0"},
						
						{Pos = Vector(40.1,115.2, 24), Mat = "sprites/glow1.vmt", Alpha = 210, Size = 0.34, DynLight = true,BlinkersColor = "255 30 0"},
						{Pos = Vector(-40.1,115.2, 24), Mat = "sprites/glow1.vmt", Alpha = 210, Size = 0.34, DynLight = true,BlinkersColor = "255 30 0"},
						
						{Pos = Vector(12.7,138.2, 28.8), Mat = "sprites/glow1.vmt", Alpha = 210, Size = 0.34, DynLight = true,BlinkersColor = "255 30 0"},
						{Pos = Vector(-12.7,138.2, 28.8), Mat = "sprites/glow1.vmt", Alpha = 210, Size = 0.34, DynLight = true,BlinkersColor = "255 30 0"},
						},
			VC_Exhaust_Dissipate = true,
			VC_Exhaust = { //Exhaust effect, only active when engine is on, can be infinite amount.
						{Pos = Vector(19.3, -132.1, 20.7), Ang = Angle(0,0,90), EffectIdle = "Exhaust", EffectStress = "Exhaust"},
						{Pos = Vector(-19.3, -132.1, 20.7), Ang = Angle(0,0,90), EffectIdle = "Exhaust", EffectStress = "Exhaust"},

						},
			VC_ExtraSeats = { //Can be an infinite amount of seats, Pos and ExitPos can be a simple Vector() or an attachment name, other options are self explanatory.
						{Pos = Vector(19.6, -8.7, 27.7), Ang = Angle(0, 0, 8), EnterRange = 80, ExitAng = Angle(0, -90, 0), Model = "models/props_phx/carseat2.mdl", ModelOffset = Vector(0, 0, 0), Hide = true, DoorSounds = true, RadioControl = true},
						{Pos = Vector(19.6, -43.7, 27.7), Ang = Angle(0, 0, 8), EnterRange = 80, ExitAng = Angle(0, -90, 0), Model = "models/props_phx/carseat2.mdl", ModelOffset = Vector(0, 0, 0), Hide = true, DoorSounds = true, RadioControl = false},
						{Pos = Vector(-19.6, -43.7, 27.7), Ang = Angle(0, 0, 8), EnterRange = 80, ExitAng = Angle(0, -90, 0), Model = "models/props_phx/carseat2.mdl", ModelOffset = Vector(0, 0, 0), Hide = true, DoorSounds = true, RadioControl = false},
						{Pos = Vector(0, -43.7, 27.7), Ang = Angle(0, 0, 8), EnterRange = 80, ExitAng = Angle(0, -90, 0), Model = "models/props_phx/carseat2.mdl", ModelOffset = Vector(0, 0, 0), Hide = true, DoorSounds = true, RadioControl = false},

						},
			VC_Horn = {Sound = "vehicles/vc_horn_light.wav", Pitch = 110, Looping = false}, //Horn sound the car will use.
			
			KeyValues = {
							vehiclescript	=	"scripts/vehicles/LWCars/dod_daytona.txt"
							}
			}
list.Set("Vehicles", "dodge_daytona", V)

