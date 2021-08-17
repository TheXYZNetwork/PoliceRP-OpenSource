AddCSLuaFile()
local name = "Jaguar XFR SEG Photon"

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
--Front Grill
	{ Vector(-7.25,114.075,32.6), Angle(0,0,25.2), "led_sqr" }, -- 1 
	{ Vector(7.25,114.075,32.6), Angle(0,0,25.2), "led_sqr" }, -- 2 

	{ Vector(41.6,96.15,30.165), Angle(0,-60,0), "led_single" }, -- 3 
	{ Vector(-41.6,96.15,30.165), Angle(0,60,0), "led_single" }, -- 4
	
	{ Vector(39.897,-94.9,29.867), Angle(0,-120,0), "led_single" }, -- 5
	{ Vector(-39.897,-94.9,29.867), Angle(0,120,0), "led_single" }, -- 6
}

EMV.Sections = {
	["grill"] = {
	{ {1,B} },
	{ {2,B} },
	{ {2,B}, {1,B} },
	{ {2,B,.6}, {1,B,.6} },
	
	},
	["sidelights"] = {
	{ {3,B} },
	{ {4,B} },
	{ {3,B}, {4,B} },
	{ {5,B}, {6,B} },
	{ {3,B,.6}, {4,B,.6}, {5,B,.6}, {6,B,.6} },
	{ {3,B}, {4,B}, {5,B}, {6,B} },
	}

}

EMV.Patterns = { -- 0 = blank
	["grill"] = {
		["code1"] = {
			1,1,1,2,2,2
		},
		["code2"] = {
			1,0,1,0,2,0,2,0
		},
		["steady"] = {
			3,4
		}
	},
	["sidelights"] = {
		["code1"] = {
			3,0,3,0,3,0,4,0,4,0,4,0
		},
		["code2"] = {
			3,0,3,0,4,0,4,0
		},
		["steady"] = {
			6,5
		}
	}
}

EMV.Sequences = {
		Sequences = {
		{
			Name = "ESCORT",
			Components = {
				["grill"] = "code1",
				["sidelights"] = "code1"
			},
			Disconnect = {}
		},
		{
			Name = "HIGH PRIORITY",
			Components = {
				["grill"] = "code2",
				["sidelights"] = "code2"	
			},
			Disconnect = {}
		},
		{
			Name = "STEADY",
			Components = {
				["grill"] = "steady",
				["sidelights"] = "steady"	
			},
			Disconnect = {}
		},
	}
}

EMV.Meta = {
	led_sqr = {
		AngleOffset = -90,
		W = 1.6,
		H = 4.8,
		Sprite = "sprites/emv/led_square"
	},
	led_single = {
		AngleOffset = -90,
		Scale = 0.45,
		W = 1.2,
		H = 1.2,
		Sprite = "sprites/emv/led_single"
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
				Model =	"models/LoneWolfie/jaguar_xfr_pol_und.mdl",

			
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