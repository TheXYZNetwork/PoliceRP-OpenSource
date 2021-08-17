AddCSLuaFile()
local name = "Ford F350 Ambulance Photon"

local A = "AMBER"
local R = "RED"
local B = "BLUE"
local W = "WHITE"
local CW = "C_WHITE"
local SW = "S_WHITE"

local EMV = {}

EMV.Siren = 6
EMV.Color = nil
EMV.Skin = 0

EMV.Positions = {
--Front Squares
	{ Vector(-45.6,21.75,108.65), Angle(0,0,0), "led_rec" }, -- 1 
	{ Vector(43.5,21.75,108.65), Angle(0,0,0), "led_rec" }, -- 2 

	{ Vector(-45.6,21.75,105), Angle(0,0,0), "led_rec" }, -- 3
	{ Vector(43.5,21.75,105), Angle(0,0,0), "led_rec" }, -- 4 
--Rear Squares
	{ Vector(-45.638,-171.3,120.311), Angle(0,180,0), "led_rec" }, -- 5
	{ Vector(43.5,-171.3,120.311), Angle(0,180,0), "led_rec" }, -- 6
	
	{ Vector(43.5,-171.3,116.465), Angle(0,180,0), "led_rec" }, -- 7
	{ Vector(-45.638,-171.3,116.465), Angle(0,180,0), "led_rec" }, -- 8
--Rear Square Single
	{ Vector(-45.55,-171.3,102.9), Angle(0,180,0), "led_sqr" }, -- 9
	{ Vector(43.5,-171.3,102.804), Angle(0,180,0), "led_sqr" }, -- 10
--Grill Lights
	{ Vector(-14.55,156.1,50.94), Angle(0,0,0), "led_grill" }, -- 11
	{ Vector(14.55,156.1,50.94), Angle(0,0,0), "led_grill" }, -- 12
--Sidesquares
	{ Vector(57,2.42,113.127), Angle(0,-90,0), "led_sqr" }, -- 13 Right	
	{ Vector(-59.1,2.42,113.127), Angle(0,90,0), "led_sqr" }, -- 14 Left

	{ Vector(57.455,-58.272,113.120), Angle(0,-90,0), "led_sqr" }, -- 15 Right	
	{ Vector(-59.1,-19.74,113.120), Angle(0,90,0), "led_sqr" }, -- 16 Left

	{ Vector(56.952,-133.363,113.126), Angle(0,-90,0), "led_sqr" }, -- 17 Right	
	{ Vector(-59.1,-133.363,113.126), Angle(0,90,0), "led_sqr" }, -- 18 Left
	
	{ Vector(56.952,-155.461,113.126), Angle(0,-90,0), "led_sqr" }, -- 19 Right	
	{ Vector(-59.1,-155.461,113.126), Angle(0,90,0), "led_sqr" }, -- 20 Left	
--Lightbar Front
	{ Vector(37.708,26.9,117.13), Angle(0,0,0), "led_lightbar" }, -- 21 Right	
	{ Vector(-38.6,26.9,117.13), Angle(0,0,0), "led_lightbar" }, -- 22 Left	
	
	{ Vector(17.219,26.9,117.13), Angle(0,0,0), "led_lightbar_wider" }, -- 23 Right	
	{ Vector(-18.2,26.9,117.13), Angle(0,0,0), "led_lightbar_wider" }, -- 24 Left	
	
	{ Vector(27.961,26.9,117.13), Angle(0,0,0), "bulb_lightbar" }, -- 25 Right	
	{ Vector(-28.961,26.9,117.13), Angle(0,0,0), "bulb_lightbar" }, -- 26 Left	
	
	{ Vector(7.832,26.632,116.62), Angle(0,0,0), "rotator" }, -- 27 Right	
	{ Vector(-8.832,26.632,116.62), Angle(0,0,0), "rotator" }, -- 28 Left	
	
	{ Vector(47.368,26.632,116.62), Angle(0,0,0), "rotator_opp" }, -- 29 Right	
	{ Vector(-48.368,26.632,116.62), Angle(0,0,0), "rotator_opp" }, -- 30 Left	
--Lightbar Rear
	{ Vector(3,-172.9,118.808), Angle(0,180,0), "led_lightbar_rear" }, -- 31 Left	
	{ Vector(-2.5,-172.9,118.808), Angle(0,180,0), "led_lightbar_rear" }, -- 32 Left	

	{ Vector(9.1,-172.9,118.808), Angle(0,180,0), "led_lightbar_rear" }, -- 33 Left	
	{ Vector(-8.6,-172.9,118.808), Angle(0,180,0), "led_lightbar_rear" }, -- 34 Left	

	{ Vector(15.2,-172.9,118.808), Angle(0,180,0), "led_lightbar_rear" }, -- 35 Left	
	{ Vector(-14.7,-172.9,118.808), Angle(0,180,0), "led_lightbar_rear" }, -- 36 Left	
	
	{ Vector(21.3,-172.9,118.808), Angle(0,180,0), "led_lightbar_rear" }, -- 37 Left	
	{ Vector(-20.8,-172.9,118.808), Angle(0,180,0), "led_lightbar_rear" }, -- 38 Left	
--Rearsquare Single Code 4
	{ Vector(-45.55,-171.3,102.9), Angle(0,180,0), "led_sqr" }, -- 39
	{ Vector(43.5,-171.3,102.804), Angle(0,180,0), "led_sqr" }, -- 40
--Grill Lights Code 4
	{ Vector(-14.55,156.1,50.94), Angle(0,0,0), "led_grill" }, -- 41
	{ Vector(14.55,156.1,50.94), Angle(0,0,0), "led_grill" }, -- 42
}

EMV.Sections = {
	["frontsquares"] = {
		{ {1,R}, {2,R} },
		{ {3,CW}, {4,CW} },
		{ {1,R}, {4,CW} },
		{ {3,CW}, {2,R} },		
		{ {1,R}, {2,R}, {3,CW}, {4,CW} },
		{ {42,R}, {41,CW} },
	},
	["rearsquares"] = {
		{ {5,R}, {6,R} },
		{ {7,CW}, {8,CW} },		
		{ {5,R}, {6,R}, {7,CW}, {8,CW} },		
		{ {5,R}, {7,CW} },
		{ {8,CW}, {6,R} },		
		{ {39,CW}, {40,CW} },
	},
	["rearsquare_single"] = {
		{ {9,CW}, {10,CW} },
		{ {10,CW} },
		{ {9,CW} },
	},
	["grill_lights"] = {
		{ {11,CW} },
		{ {12,R} },
		{ {11,CW}, {12,R} },
	},
	["sidesquares"] = {
		{ {13,R}, {14,R}, {19,R}, {20,R} },
		{ {15,CW}, {16,CW}, {17,CW}, {18,CW} },
		{ {13,R}, {15,CW}, {17,CW}, {19,R} },
		{ {14,R}, {16,CW}, {18,CW}, {20,R} },
		{ {13,R}, {14,R} },
		{ {15,CW}, {16,CW}, {13,R}, {14,R}  },
		{ {17,CW}, {18,CW}, {15,CW}, {16,CW} },
		{ {19,R}, {20,R}, {17,CW}, {18,CW} },
		{ {19,R}, {20,R} },
	},
	["lightbar_front"] = {
		{ {21,R}, {23,R}, {22,R}, {24,R}},
		{ {25,CW},  {26,CW} },		
		{ {21,R}, {23,R}, {26,CW} },
		{ {22,R}, {24,R}, {25,CW} },
		{ {21,R}, {22,R} },
		{ {25,CW}, {26,CW} },
		{ {23,R}, {24,R} },
	},
	["lightbar_rotators"] = {
		{ {27,W}, {28,W}, {29,W}, {30,W} },
	},
	["lightbar_rear"] = {
		{ {31,R}, {32,R}, {33,CW}, {34,CW}, {35,R}, {36,R}, {37,R}, {38,R} },
		{ {31,R}, {32,R}, {35,R}, {36,R}, {37,R}, {38,R} },
		{ {33,CW}, {34,CW} },
		{ {37,R}, {38,R}, {33,CW}, {34,CW} },
		{ {35,R}, {36,R}, {32,R}, {31,R} },
		{ {37,R}, {38,R} },
		{ {35,R}, {36,R} },
		{ {33,CW}, {34,CW} },
		{ {31,R}, {32,R} },
	},
}

EMV.Patterns = { -- 0 = blank
	["frontsquares"] = {
		["code1"] = {
			1,0,1,0,2,0,2
		},
		["code2"] = {
			5,5,5,0,0,0,0,0
		},
		["code3"] = {
			3,0,3,0,4,0,4,0
		},
		["code4"] = {
			1,2,6,2
		}
	},
	["rearsquares"] = {
		["code1"] = {
			1,0,1,0,2,0,2
		},
		["code2"] = {
			3,3,3,3,0,0,0,0
		},
		["code3"] = {
			4,0,4,0,5,0,5,0,4,0,4,0,5,0,5,0,4,0,4,0,5,0,5,0,1,0,1,0,2,0,2,1,0,1,0,2,0,2,1,0,1,0,2,0,2
		},		
		["code4"] = {
			1,2,6,2
		}		
	},
	["rearsquare_single"] = {
		["code1"] = {
			1,0,1,0,0,0,0
		},
		["code2"] = {
			0,0,0,0,1,1,1,1
		},
		["code3"] = {
			2,0,2,0,3,0,3,0
		}
	},
	["grill_lights"] = {
		["code1"] = {
			1,0,1,0,2,0,2
		},
		["code2"] = {
		    0,0,0,0,3,0,3,0
		},
		["code3"] = {
			1,0,1,0,2,0,2,0,1,0,1,0,2,0,2,0,1,0,1,0,2,0,2,0,1,1,1,2,2,2,1,1,1,2,2,2,1,1,1,2,2,2
		}
	},
	["sidesquares"] = {
		["code1"] = {
		    3,3,3,3,4,4,4,4
		},
		["code2"] = {
			1,0,1,0,2,0,2
		},
		["code3"] = {
			5,6,7,8,9,8,7,6,5,6,7,8,9,8,7,6,5,6,7,8,9,8,7,6,5,6,7,8,9,8,7,6,1,0,1,0,2,0,2,1,0,1,0,2,0,2,1,0,1,0,2,0,2
		},
		["code4"] = {
			5,6,7,8,9,8,7,6
		}
	},
	["lightbar_front"] = {
		["code2"] = {
			3,0,3,0,4,0,4,0
		},
		["code3"] = {
			1,0,1,0,2,0,2,0
		},
		["code4"] = {
			5,6,7,6
		}			
	},
	["lightbar_rotators"] = {
		["code3"] = {
			1
		}
	},
	["lightbar_rear"] = {
		["code1"] = {
			6,6,7,7,9,9,7,7
		},
		["code2"] = {
			4,0,4,0,5,0,5,0
		},
		["code3"] = {
			2,0,2,0,3,0,3,0
		},
		["code4"] = {
			6,7,8,9,8,7
		}
	}			
}

EMV.Sequences = {
		Sequences = {
		{
			Name = "CODE 1",
			Components = {
			["frontsquares"] = "code2",
			["grill_lights"] = "code2",
			["sidesquares"] = "code1",
			["rearsquares"] = "code2",
			["rearsquare_single"] = "code2",
			["lightbar_rear"] = "code1"
			},
			Disconnect = {}
		},
		{
			Name = "CODE 2",
			Components = {
			["frontsquares"] = "code1",
			["rearsquares"] = "code1",
			["rearsquare_single"] = "code1",
			["grill_lights"] = "code1",
			["sidesquares"] = "code2",
			["lightbar_front"] = "code2",
			["lightbar_rear"] = "code2"
			},
			Disconnect = {}
		},
		{
			Name = "CODE 3",
			Components = {
			["frontsquares"] = "code3",
			["rearsquares"] = "code1",
			["rearsquare_single"] = "code1",
			["grill_lights"] = "code3",
			["sidesquares"] = "code2",
			["lightbar_front"] = "code3",
			["lightbar_rotators"] = "code3",
			["lightbar_rear"] = "code4"
			},
			Disconnect = {}
		},
		{
			Name = "SWIPE",
			Components = {
			["lightbar_rear"] = "code4",
			["sidesquares"] = "code4",
			["lightbar_front"] = "code4",
			["rearsquares"] = "code4",
			["frontsquares"] = "code4"
			},
			Disconnect = {}
		},
	}
}

EMV.Meta = {
	led_rec = {
		AngleOffset = -90,
		W = 10,
		H = 14,
		Sprite = "sprites/emv/led_lightbar"
	},
	led_sqr = {
		AngleOffset = -90,
		W = 8.8,
		H = 7.5,
		Sprite = "sprites/emv/led_square"
	},
	led_grill = {
		AngleOffset = -90,
		W = 7.5,
		H = 9,
		Sprite = "sprites/emv/emv_whelen_rectangle"
	},
	led_lightbar = {
		AngleOffset = -90,
		W = 9,
		H = 15,
		Sprite = "sprites/emv/led_lightbar"
	},
	led_lightbar_wider = {
		AngleOffset = -90,
		W = 12,
		H = 15,
		Sprite = "sprites/emv/led_lightbar"
	},
	bulb_lightbar = {
		AngleOffset = -90,
		Scale = 2,
		W = 16,
		H = 15,
		Sprite = "sprites/emv/lightbar"
	},
	rotator = {
		AngleOffset = "R",
		Scale = 4,
		W = 12,
		H = 12,
		Sprite = "sprites/emv/circular_src",
		Speed = 5,
		VisRadius = 1
	},
	rotator_opp = {
		AngleOffset = "R",
		Scale = 4,
		W = 12,
		H = 12,
		Sprite = "sprites/emv/circular_src",
		Speed = -5,
		VisRadius = 1
	},
	led_lightbar_rear = {
		AngleOffset = -90,
		W = 6.5,
		H = 7,
		Sprite = "sprites/emv/led_lightbar"
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
				Model =	"models/LoneWolfie/ford_f350_ambu.mdl",

			
				KeyValues = {				
						vehiclescript =	"scripts/vehicles/LWCars/ford_f350_ambu.txt"
					    },
				IsEMV = true,
				EMV = EMV,
				HasPhoton = true,
				Photon = PI
}

list.Set( "Vehicles", V.Name, V )

if EMVU then EMVU:OverwriteIndex( name, EMV ) end
if Photon then Photon:OverwriteIndex( name, PI ) end