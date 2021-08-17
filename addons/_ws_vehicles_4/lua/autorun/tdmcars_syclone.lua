local V = {
			Name = "GMC Syclone", 
			Class = "prop_vehicle_jeep",
			Category = "TDM Cars",
			Author = "TheDanishMaster, freemmaann, Turn 10",
			Information = "A drivable GMC Syclone by TheDanishMaster",
			Model = "models/tdmcars/gmc_syclone.mdl",
			//Vehicle Controller
			VC_Lights = { //Pos can be a simple Vector() relative to the vehicle or an attachment name, else is self explanatory, can be an infinite amount of these.
						{Pos = Vector(-36.8, -110.7, 42), Mat = "sprites/glow1.vmt", Alpha = 180, Size = 0.5, DynLight = true, BlinkersColor = "255 0 0", NormalColor = "255 0 0", BrakeColor = "255 0 0"},
						{Pos = Vector(36.8, -110.7, 42), Mat = "sprites/glow1.vmt", Alpha = 180, Size = 0.5, DynLight = true, BlinkersColor = "255 0 0", NormalColor = "255 0 0", BrakeColor = "255 0 0"},
						{Pos = Vector(-36.8, -110.7, 37.5), Mat = "sprites/glow1.vmt", Alpha = 180, Size = 0.5, DynLight = true, BlinkersColor = "255 0 0", NormalColor = "255 0 0", BrakeColor = "255 0 0"},
						{Pos = Vector(36.8, -110.7, 37.5), Mat = "sprites/glow1.vmt", Alpha = 180, Size = 0.5, DynLight = true, BlinkersColor = "255 0 0", NormalColor = "255 0 0", BrakeColor = "255 0 0"},

						{Pos = Vector(-36.9, -110.7, 33.3), Mat = "sprites/glow1.vmt", Alpha = 180, Size = 0.4, DynLight = true, ReverseColor = "255 255 255"},
						{Pos = Vector(36.9, -110.7, 33.3), Mat = "sprites/glow1.vmt", Alpha = 180, Size = 0.4, DynLight = true, ReverseColor = "255 255 255"},
						{Pos = Vector(-29.4, 111.7, 22.3), Mat = "sprites/glow1.vmt", Alpha = 220, Size = 0.5, DynLight = true, NormalColor = "255 130 0", BlinkersColor = "255 130 0"},
						{Pos = Vector(29.4, 111.7, 22.3), Mat = "sprites/glow1.vmt", Alpha = 220, Size = 0.5, DynLight = true, NormalColor = "255 130 0", BlinkersColor = "255 130 0"},
						{Pos = Vector(-36.3, 105.7, 35.7), Mat = "sprites/glow1.vmt", Alpha = 220, Size = 0.6, DynLight = true, NormalColor = "255 130 0", BlinkersColor = "255 130 0"},
						{Pos = Vector(36.3, 105.7, 35.7), Mat = "sprites/glow1.vmt", Alpha = 220, Size = 0.6, DynLight = true, NormalColor = "255 130 0", BlinkersColor = "255 130 0"},

						{Pos = Vector(-32, 108, 18), Mat = "sprites/glow1.vmt", Alpha = 180, Size = 0.6, DynLight = true, NormalColor = "255 255 255"},
						{Pos = Vector(32, 108, 18), Mat = "sprites/glow1.vmt", Alpha = 180, Size = 0.6, DynLight = true, NormalColor = "255 255 255"},

						{Pos = Vector(-30.5, 97, 36), Size = 1, GlowSize = 1, HeadLightAngle = Angle(-5, 95, 0)},
						{Pos = Vector(30.5, 97, 36), Size = 1, GlowSize = 1, HeadLightAngle = Angle(-5, 85, 0)}
						},
			VC_Exhaust_Dissipate = true,
			VC_Exhaust = { //Exhaust effect, only active when engine is on, can be infinite amount.
						{Pos = Vector(18.5, -107, 14.5), Ang = Angle(0,0,90), EffectIdle = "Exhaust", EffectStress = "Exhaust"},
						{Pos = Vector(15.5, -107, 14.5), Ang = Angle(0,0,90), EffectIdle = "Exhaust", EffectStress = "Exhaust"}
						},
			VC_ExtraSeats = { //Can be an infinite amount of seats, Pos and ExitPos can be a simple Vector() or an attachment name, other options are self explanatory.
						{Pos = Vector(17, 0, 25.3), Ang = Angle(0, 0, 8), EnterRange = 80, ExitAng = Angle(0, -90, 0), Model = "models/props_phx/carseat2.mdl", ModelOffset = Vector(12, 0, 4), Hide = true, DoorSounds = true, RadioControl = true}
						},
			VC_Horn = {Sound = "vehicles/vc_horn_light.wav", Pitch = 100, Looping = false}, //Horn sound the car will use.
						
			KeyValues = {
							vehiclescript	=	"scripts/vehicles/TDMCars/syclone.txt"
							}
			}
list.Set("Vehicles", "syclonetdm", V)
sound.Add( 
{
    name = "tdmsyclone_idle",
    channel = CHAN_STATIC,
    volume = 1.0,
    soundlevel = 90,
    sound = "vehicles/tdmcars/syclone/idle.wav"
} )
sound.Add( 
{
    name = "tdmsyclone_reverse",
    channel = CHAN_STATIC,
    volume = 0.9,
    soundlevel = 90,
    pitchstart = 98,
	pitchend = 105,
    sound = "vehicles/tdmcars/syclone/rev.wav"
} )

sound.Add( 
{
    name = "tdmsyclone_firstgear",
    channel = CHAN_STATIC,
    volume = 1.0,
    soundlevel = 90,
    pitchstart = 95,
	pitchend = 104,
    sound = "vehicles/tdmcars/syclone/first.mp3"
} )

sound.Add( 
{
    name = "tdmsyclone_secondgear",
    channel = CHAN_STATIC,
    volume = 1.0,
    soundlevel = 90,
    pitchstart = 90,
    pitchend = 105,
    sound = "vehicles/tdmcars/syclone/second.mp3"
} )

sound.Add( 
{
    name = "tdmsyclone_thirdgear",
    channel = CHAN_STATIC,
    volume = 1.0,
    soundlevel = 90,
    pitchstart = 90,
    pitchend = 105,
    sound = "vehicles/tdmcars/syclone/third.mp3"
} )

sound.Add( 
{
    name = "tdmsyclone_fourthgear",
    channel = CHAN_STATIC,
    volume = 1.0,
    soundlevel = 90,
    pitchstart = 90,
    pitchend = 105,
    sound = "vehicles/tdmcars/syclone/fourth_cruise.wav"
} )

sound.Add( 
{
    name = "tdmsyclone_noshift",
    channel = CHAN_STATIC,
    volume = 1.0,
    soundlevel = 90,
    pitchstart = 85,
    pitchend = 110,
    sound = "vehicles/tdmcars/syclone/second.mp3"
} )

sound.Add( 
{
    name = "tdmsyclone_slowdown",
    channel = CHAN_STATIC,
    volume = 1.0,
    soundlevel = 90,
    pitchstart = 85,
    pitchend = 110,
    sound = "vehicles/tdmcars/syclone/throttle_off.mp3"
} )
