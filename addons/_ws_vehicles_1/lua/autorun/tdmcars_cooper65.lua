local V = {
			Name = "Mini Cooper 1965", 
			Class = "prop_vehicle_jeep",
			Category = "TDM Cars",
			Author = "TheDanishMaster, freemmaann, Turn 10",
			Information = "A drivable Mini Cooper 1965 by TheDanishMaster",
			Model = "models/tdmcars/cooper65.mdl",
			//Vehicle Controller
			VC_Lights = { //Pos can be a simple Vector() relative to the vehicle or an attachment name, else is self explanatory, can be an infinite amount of these.
						{Pos = Vector(-28.7, -74.2, 28), Mat = "sprites/glow1.vmt", Alpha = 180, Size = 0.7, DynLight = true, NormalColor = "255 0 0", BrakeColor = "255 0 0", BlinkersColor = "255 0 0"},
						{Pos = Vector(28.7, -74.2, 28), Mat = "sprites/glow1.vmt", Alpha = 180, Size = 0.7, DynLight = true, NormalColor = "255 0 0", BrakeColor = "255 0 0", BlinkersColor = "255 0 0"},

						{Pos = Vector(-26.3, 76, 22.5), Mat = "sprites/glow1.vmt", Alpha = 220, Size = 0.4, DynLight = true, BlinkersColor = "255 130 0"},
						{Pos = Vector(26.3, 76, 22.5), Mat = "sprites/glow1.vmt", Alpha = 220, Size = 0.3, DynLight = true, BlinkersColor = "255 130 0"},

						{Pos = Vector(-26, 76, 32.5), Size = 1, GlowSize = 1, HeadLightAngle = Angle(-5, 95, 0)},
						{Pos = Vector(26, 76, 32.5), Size = 1, GlowSize = 1, HeadLightAngle = Angle(-5, 85, 0)}
						},
			VC_Exhaust_Dissipate = true,
			VC_Exhaust = { //Exhaust effect, only active when engine is on, can be infinite amount.
						{Pos = Vector(-18.6, -70, 11), Ang = Angle(0,0,90), EffectIdle = "Exhaust", EffectStress = "Exhaust"}
						},
			VC_Horn = {Sound = "vehicles/vc_horn_light.wav", Pitch = 120, Looping = false}, //Horn sound the car will use.
						
			KeyValues = {
							vehiclescript	=	"scripts/vehicles/TDMCars/cooper65.txt"
							}
			}
list.Set("Vehicles", "cooper65tdm", V)
sound.Add( 
{
    name = "tdmbeetle_idle",
    channel = CHAN_STATIC,
    volume = 1.0,
    soundlevel = 90,
    sound = "vehicles/tdmcars/beetle/idle.wav"
} )
sound.Add( 
{
    name = "tdmbeetle_reverse",
    channel = CHAN_STATIC,
    volume = 0.9,
    soundlevel = 90,
    pitchstart = 98,
	pitchend = 105,
    sound = "vehicles/tdmcars/beetle/rev.wav"
} )

sound.Add( 
{
    name = "tdmbeetle_firstgear",
    channel = CHAN_STATIC,
    volume = 1.0,
    soundlevel = 90,
    pitchstart = 95,
	pitchend = 104,
    sound = "vehicles/tdmcars/beetle/first.mp3"
} )

sound.Add( 
{
    name = "tdmbeetle_secondgear",
    channel = CHAN_STATIC,
    volume = 1.0,
    soundlevel = 90,
    pitchstart = 90,
    pitchend = 105,
    sound = "vehicles/tdmcars/beetle/second.mp3"
} )

sound.Add( 
{
    name = "tdmbeetle_thirdgear",
    channel = CHAN_STATIC,
    volume = 1.0,
    soundlevel = 90,
    pitchstart = 90,
    pitchend = 105,
    sound = "vehicles/tdmcars/beetle/third.mp3"
} )

sound.Add( 
{
    name = "tdmbeetle_fourthgear",
    channel = CHAN_STATIC,
    volume = 1.0,
    soundlevel = 90,
    pitchstart = 90,
    pitchend = 105,
    sound = "vehicles/tdmcars/beetle/fourth_cruise.wav"
} )

sound.Add( 
{
    name = "tdmbeetle_noshift",
    channel = CHAN_STATIC,
    volume = 1.0,
    soundlevel = 90,
    pitchstart = 85,
    pitchend = 110,
    sound = "vehicles/tdmcars/beetle/second.mp3"
} )

sound.Add( 
{
    name = "tdmbeetle_slowdown",
    channel = CHAN_STATIC,
    volume = 1.0,
    soundlevel = 90,
    pitchstart = 85,
    pitchend = 110,
    sound = "vehicles/tdmcars/beetle/throttle_off.mp3"
} )