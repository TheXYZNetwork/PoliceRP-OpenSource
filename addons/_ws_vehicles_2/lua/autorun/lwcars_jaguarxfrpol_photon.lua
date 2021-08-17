AddCSLuaFile()
local name = "Jaguar XFR Police Photon"
local A = "AMBER"
local R = "RED"
local B = "BLUE"
local W = "WHITE"
local CW = "C_WHITE"
local SW = "S_WHITE"

local EMV = {}

EMV.Siren = 5
EMV.Color = nil
EMV.Skin = 0

EMV.Positions = {
--FR
	{ Vector(3.02,-6.797,74.45), Angle(0,0,0), "led_lightbar" }, -- 1 
	{ Vector(9.37,-6.797,74.45), Angle(0,0,0), "led_lightbar" }, -- 2
	{ Vector(15.704,-6.797,74.45), Angle(0,0,0), "bulb_lightbar" }, -- 3 This is the bulb
	{ Vector(22.4,-8.9,74.45), Angle(0,-32.3,0), "led_lightbar_side" }, -- 4

--FL
	{ Vector(-3.02,-6.797,74.45), Angle(0,0,0), "led_lightbar" }, -- 5
	{ Vector(-9.37,-6.797,74.45), Angle(0,0,0), "led_lightbar" }, -- 6
	{ Vector(-15.704,-6.797,74.45), Angle(0,0,0), "bulb_lightbar" }, -- 7 This is the bulb
	{ Vector(-22.4,-8.9,74.45), Angle(0,32.3,0), "led_lightbar_side" }, -- 8

--RL
	{ Vector(-3.02,-18.35,74.45), Angle(0,180,0), "led_lightbar" }, -- 9
	{ Vector(-9.37,-18.35,74.45), Angle(0,180,0), "led_lightbar" }, -- 10
	{ Vector(-15.704,-18.35,74.45), Angle(0,180,0), "led_lightbar" }, -- 11
	{ Vector(-22.4,-16.35,74.45), Angle(0,147.7,0), "led_lightbar_side" }, -- 12

--RR
	{ Vector(3.02,-18.35,74.45), Angle(0,180,0), "led_lightbar" }, -- 13
	{ Vector(9.37,-18.35,74.45), Angle(0,180,0), "led_lightbar" }, -- 14
	{ Vector(15.704,-18.35,74.45), Angle(0,180,0), "led_lightbar" }, -- 15
	{ Vector(22.4,-16.1,74.45), Angle(0,-146.7,0), "led_lightbar_side" }, -- 16
--Scene Illumination Lights
	{ Vector(-25.94,-12.805,74.467), Angle(0,90,0), "led_triple" }, -- 17
	{ Vector(25.94,-12.805,74.467), Angle(0,-90,0), "led_triple" }, -- 18
	{ Vector(15.704,-6.797,74.45), Angle(0,0,0), "bulb_lightbar_illu" }, -- 19
	{ Vector(-15.704,-6.797,74.45), Angle(0,0,0), "bulb_lightbar_illu" }, -- 20
--Rearlights
	{ Vector(-25.63, -109.46, 45.06), Angle(0,-20.6, 180), "rear_circle" }, -- 21 
	{ Vector(-28.405, -108.376, 45.06), Angle(0,-26.433, 180), "rear_circle" }, -- 22
	{ Vector(-31.746, -105.26, 48.269), Angle(0,-37.656, 180), "rear_circle" }, -- 23
	{ Vector(-34.548, -104.151, 45.036), Angle(0,-44.624, 180), "rear_circle" }, -- 24
	{ Vector(-30.904, -106.871, 45.04), Angle(0,-31.944, 180), "rear_circle" }, -- 25
	{ Vector(-27.038, -108.944, 45.061), Angle(0,-20.6, 180), "rear_circle" }, -- 26
	{ Vector(-32.905, -104.26, 48.064), Angle(0,-42.256, 180), "rear_circle" }, -- 27
	{ Vector(-28.041, -107.545, 48.655), Angle(0,-23.771, 180), "rear_circle" }, -- 28
	{ Vector(-32.164, -106.086, 45.138), Angle(0,-31.944, 180), "rear_circle" }, -- 29
	{ Vector(-30.5, -106.104, 48.45), Angle(0,-28.656, 180), "rear_circle" }, -- 30
	{ Vector(-29.566, -107.6, 45.049), Angle(0,-31.9, 180), "rear_circle" }, -- 31
	{ Vector(-33.432, -105.177, 45.038), Angle(0,-40.4, 180), "rear_circle" }, -- 32
	{ Vector(-26.745, -108.207, 48.763), Angle(0,-20.6, 180), "rear_circle" }, -- 33
	{ Vector(-29.269, -106.85, 48.552), Angle(0,-27.3, 180), "rear_circle" }, -- 34

	{ Vector(25.63, -109.46, 45.06), Angle(0,20.6, 180), "rear_circle" }, -- 35 
	{ Vector(28.405, -108.376, 45.06), Angle(0,26.433, 180), "rear_circle" }, -- 36
	{ Vector(31.746, -105.26, 48.269), Angle(0,37.656, 180), "rear_circle" }, -- 37
	{ Vector(34.548, -104.151, 45.036), Angle(0,44.624, 180), "rear_circle" }, -- 38
	{ Vector(30.904, -106.871, 45.04), Angle(0,31.944, 180), "rear_circle" }, -- 39
	{ Vector(27.038, -108.944, 45.061), Angle(0,20.6, 180), "rear_circle" }, -- 40
	{ Vector(32.905, -104.26, 48.064), Angle(0,42.256, 180), "rear_circle" }, -- 41
	{ Vector(28.041, -107.545, 48.655), Angle(0,23.771, 180), "rear_circle" }, -- 42
	{ Vector(32.164, -106.086, 45.138), Angle(0,31.944, 180), "rear_circle" }, -- 43
	{ Vector(30.5, -106.104, 48.45), Angle(0,28.656, 180), "rear_circle" }, -- 44
	{ Vector(29.566, -107.6, 45.049), Angle(0,31.9, 180), "rear_circle" }, -- 45
	{ Vector(33.432, -105.177, 45.038), Angle(0,40.4, 180), "rear_circle" }, -- 46
	{ Vector(26.745, -108.207, 48.763), Angle(0,20.6, 180), "rear_circle" }, -- 47
	{ Vector(29.269, -106.85, 48.552), Angle(0,27.3, 180), "rear_circle" }, -- 48
--Frontlights	
	{ Vector(24.402, 108, 33.676), Angle(0,0,0), "headlight" }, -- 49
	{ Vector(-24.402, 108, 33.676), Angle(0,0,0), "headlight" }, -- 50
--Grill
	{ Vector(-6.696, 114.86, 29.083), Angle(0,0,23.7), "led_grill" }, -- 51
	{ Vector(6.696, 114.86, 29.083), Angle(0,0,23.7), "led_grill" }, -- 52
--Bumperlights
	{ Vector(42.014, 95.506, 30.188), Angle(0,-66.8,0), "led_bumper" }, -- 53
	{ Vector(-42.014, 95.506, 30.188), Angle(0,66.8,0), "led_bumper" }, -- 54
}

EMV.Sections = {
	["lightbar"] = {
	{ {2,B}, {4,B}, {6,B},{8,B}, {16,B}, {12,B} },
	{ {1,B}, {5,B}, {11,B}, {15,B}, {7,W}, {3,W} },
--Left Right
	{ {1,B}, {2,B}, {4,B}, {15,B}, {16,B}, {3,W}  },
	{ {5,B}, {6,B}, {8,B}, {11,B}, {12,B}, {7,W}  },
--High Priority
	{ {1,B}, {2,B}, {4,B}, {15,B}, {16,B}, {7,W} },	
	{ {5,B}, {6,B}, {8,B}, {11,B}, {12,B}, {3,W} },
--Whole thing no bulbs
	{ {1,B}, {2,B}, {4,B}, {15,B}, {16,B}, {5,B}, {6,B}, {8,B}, {11,B}, {12,B} },
	},	
	["lightbar_reds"] = {
	{ {9,R}, {10,R}, {13,R}, {14,R} },
	{ {9,R}, {14,R} },
	{ {13,R}, {10,R} },
--Swipe
	{ {10,R} },
	{ {9,R} },
	{ {13,R} },
	{ {14,R} },
--Caution
	{ {10,R}, {14,R} },
	{ {9,R}, {13,R} },
	},
	["sceneillu"] = {
	 { {17,W},{18,W},{19,W},{20,W} },
	},	
	["rearlights"] = {
	{ {21,R}, {22,R}, {23,R}, {24,R}, {25,R}, {26,R}, {27,R}, {28,R}, {29,R}, {30,R}, {31,R}, {32,R}, {33,R}, {34,R} },
	{ {35,R}, {36,R}, {37,R}, {38,R}, {39,R}, {40,R}, {41,R}, {42,R}, {43,R}, {44,R}, {45,R}, {46,R}, {47,R}, {48,R} },
	{ {21,R}, {22,R}, {23,R}, {24,R}, {25,R}, {26,R}, {27,R}, {28,R}, {29,R}, {30,R}, {31,R}, {32,R}, {33,R}, {34,R}, {35,R}, {36,R}, {37,R}, {38,R}, {39,R}, {40,R}, {41,R}, {42,R}, {43,R}, {44,R}, {45,R}, {46,R}, {47,R}, {48,R} },
	{ {35,R}, {36,R}, {38,R}, {39,R}, {40,R}, {43,R}, {45,R}, {46,R},   {21,R}, {22,R}, {24,R}, {25,R}, {26,R}, {29,R}, {31,R}, {32,R} },
	{ {37,R}, {41,R}, {42,R}, {44,R}, {47,R}, {48,R},   {23,R}, {27,R}, {28,R}, {30,R}, {33,R}, {34,R} },
	},	
	["headlights"] = {
	{ {49,W} },
	{ {50,W} },
	{ {49,W}, {50,W} },
	},
	["grill"] = {
	{ {51,B}, {52,B} },
	{ {51,B} },
	{ {52,B} },
	},
	["bumper"] = {
	{ {53,B}, {54,B} },
	{ {53,B} },
	{ {54,B} },
	}
}
EMV.Patterns = { -- 0 = blank
	["lightbar"] = {
		["code1"] = {
			3,3,3,4,4,4
		},
		["code2"] = {
			3,0,3,0,4,0,4,0,3,0,3,0,4,0,4,0,3,0,3,0,4,0,4,0,1,1,1,2,2,2,1,1,1,2,2,2,1,1,1,2,2,2
		},
		["highpri"] = {
			5,0,5,0,5,0,6,0,6,0,6,0
		},
		["caution"] = {
			7,0,7,0,7,0,0,0,0
		},
		["stop"] = {
			1,1,1,2,2,2
		}
	},
	["lightbar_reds"] = {
		["code1"] = {
			1,0,1,0,1,0,0,0
		},
		["code2"] = {
			3,0,3,0,2,0,2,0,3,0,3,0,2,0,2,0,3,0,3,0,2,0,2,0,8,8,8,9,9,9,8,8,8,9,9,9,8,8,8,9,9,9
		},
		["highpri"] = {
			3,0,3,0,3,0,2,0,2,0,2,0
		},
		["caution"] = {
			8,8,8,9,9,9
		},
		["stop"] = {
			8,0,8,0,8,0,9,0,9,0,9,0
		}
	},
	["sceneillu"] = {
		["on"] = {
			1
		}
	},
	["rearlights"] = {
		["code2"] = {
			1,1,1,2,2,2
		},
		["highpri"] = {
			1,0,1,0,1,0,2,0,2,0,2,0
		},
		["caution"] = {
			5,0,5,0,4,0,4,0
		},
		["stop"] = {
			5,5,5,4,4,4
		}			
	},
	["headlights"] = {
		["code2"] = {
			1,1,1,2,2,2
		},
		["highpri"] = {
			1,0,1,0,1,0,2,0,2,0,2,0
		},
		["caution"] = {
			3,0,3,0,3,0,0,0
		},
		["stop"] = {
			3,3,3,0,0,0
		}
	},
	["grill"] = {
		["code1"] = {
			2,2,2,3,3,3
		},
		["code2"] = {
			2,0,2,0,3,0,3,0
		},
		["highpri"] = {
			2,0,2,0,2,0,3,0,3,0,3,0
		},
		["stop"] = {
			0,0,0,1,1,1
		}
	},
	["bumper"] = {
		["code2"] = {
			3,3,3,2,2,2
		},
		["highpri"] = {
			3,0,3,0,3,0,2,0,2,0,2,0
		}
	}
}
EMV.Sequences = {
		Sequences = {
		{
			Name = "CODE1",
			Components = {
				["lightbar"] = "code1",
				["lightbar_reds"] = "code1",
				["grill"] = "code1"
			},
			Disconnect = {}
		},
		{
			Name = "CODE2",
			Components = {
				["lightbar"] = "code2",
				["lightbar_reds"] = "code2",
				["rearlights"] = "code2",
			--	["headlights"] = "code2",
				["grill"] = "code2",
				["bumper"] = "code2"
			},
			Disconnect = {}
		},
		{
			Name = "HIGH PRIORITY",
			Components = {
				["lightbar"] = "highpri",
				["lightbar_reds"] = "highpri",
				["rearlights"] = "highpri",
				["headlights"] = "highpri",
				["grill"] = "highpri",
				["bumper"] = "highpri"
			},
			Disconnect = {}
		},
		{
			Name = "CAUTION",
			Components = {
				["lightbar_reds"] = "caution",
				["lightbar"] = "caution",
				["rearlights"] = "caution",
				["headlights"] = "caution",
				["grill"] = "stop"
			},
			Disconnect = {}
		},
		{
			Name = "STOP",
			Components = {
				["lightbar_reds"] = "stop",
				["lightbar"] = "stop",
				["rearlights"] = "stop",
				["headlights"] = "stop",
				["grill"] = "stop"
			},
			Disconnect = {}
		},
		{
			Name = "SCENE ILLU",
			Components = {
				["sceneillu"] = "on"
			},
			Disconnect = {}
		},
	}
}

EMV.Meta = {
	led_lightbar = {
		AngleOffset = -90,
		W = 7.4,
		H = 7.9,
		Sprite = "sprites/emv/emv_whelen_src"
	},
	led_lightbar_side = {
		AngleOffset = -90,
		W = 9,
		H = 9.9,
		Sprite = "sprites/emv/emv_whelen_src_side"
	},
	bulb_lightbar = {
		AngleOffset = -90,
		Scale = 1,
		W = 12,
		H = 9,
		Sprite = "sprites/emv/lightbar"
	},
	bulb_lightbar_illu = {
		AngleOffset = -90,
		Scale = 3,
		W = 12,
		H = 9,
		Sprite = "sprites/emv/lightbar"
	},
	led_triple = {
		AngleOffset = -90,
		Scale = 4,
		W = 4,
		H = 4,
		Sprite = "sprites/emv/emv_whelen_tri"
	},
	rear_circle = {
		AngleOffset = 90,
		Scale = 0.6,
		W = 1.6,
		H = 1.6,
		Sprite = "sprites/emv/led_single"
	},
	headlight = {
		AngleOffset = -90,
		Scale = 1.4,
		W = 12,
		H = 12,
		Sprite = "sprites/emv/circular_src"
	},
	led_grill = {
		AngleOffset = -90,
		Scale = 0.4,
		W = 5,
		H = 1.8,
		Sprite = "sprites/emv/led_square"
	},
	led_bumper = {
		AngleOffset = -90,
		Scale = 0.3,
		W = 3.4,
		H = 1.3,
		Sprite = "sprites/emv/led_square"
	},
}

local PI = {}
PI.Meta = {
}
PI.Positions = {
}
PI.States = {}
PI.States.Headlights = {}
PI.States.Brakes = {}
PI.States.Blink_Left = {}
PI.States.Blink_Right = {}
PI.States.Reverse = {}
PI.States.Running = {}

local V = {
				// Required information
				Name =	name,
				Class = "prop_vehicle_jeep",
				Category = "Emergency Vehicles",

				// Optional information
				Author = "LoneWolfie, Schmal",
				Information = "vroom vroom",
				Model =	"models/LoneWolfie/jaguar_xfr_pol.mdl",

			
				KeyValues = {				
						vehiclescript =	"scripts/vehicles/LWCars/jag_xfr_pol.txt"
					    },
				IsEMV = true,
				EMV = EMV,
				HasPhoton = true,
				Photon = PI
}

list.Set( "Vehicles", V.Name, V )

if EMVU then EMVU:OverwriteIndex( name, EMV ) end
if Photon then Photon:OverwriteIndex( name, PI ) end