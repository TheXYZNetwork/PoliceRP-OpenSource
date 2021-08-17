Alcohol.Config.AlcoholTypes = {
	["am_beer"] = {
		name = "A.M. Beer", -- The display names
		units = 1, -- The alcohol content
		model = "models/mark2580/gtav/barstuff/beer_am.mdl" -- Model
	},
	["patriot_beer"] = {
		name = "Patriot Beer",
		units = 1,
		model = "models/mark2580/gtav/barstuff/beer_jakey.mdl"
	},
	["pisswasser_beer"] = {
		name = "Pißwasser",
		units = 1,
		model = "models/mark2580/gtav/barstuff/beer_pissh.mdl"
	},
	["red_wine"] = {
		name = "Red Wine",
		units = 2,
		model = "models/mark2580/gtav/barstuff/wine_red.mdl"
	},
	["rose_wine"] = {
		name = "Rose Wine",
		units = 2,
		model = "models/mark2580/gtav/barstuff/wine_rose.mdl"
	},
	["white_wine"] = {
		name = "White Wine",
		units = 2,
		model = "models/mark2580/gtav/barstuff/wine_white.mdl"
	},
	["cava_champagne"] = {
		name = "Champagne",
		units = 2,
		model = "models/mark2580/gtav/barstuff/cava.mdl"
	},
	["bleuter_champagne"] = {
		name = "Blêuter'd",
		units = 3,
		model = "models/mark2580/gtav/barstuff/champ_jer_01a.mdl"
	},
	["vodka"] = {
		name = "Cherenkov Vodka",
		units = 2,
		model = "models/mark2580/gtav/barstuff/cherenkov_01.mdl"
	},
	["rum"] = {
		name = "Ragga Rum",
		units = 2,
		model = "models/mark2580/gtav/barstuff/rum_bottle.mdl"
	},
	["tequila"] = {
		name = "Tequila",
		units = 2,
		model = "models/mark2580/gtav/barstuff/tequila_bottle.mdl"
	},
	["whiskey"] = {
		name = "Whiskey",
		units = 2,
		model = "models/mark2580/gtav/barstuff/whiskey_bottle.mdl"
	},
	["water"] = {
		name = "Water",
		units = 0,
		model = "models/props/cs_office/water_bottle.mdl"
	},
	["coke"] = {
		name = "Coca Cola",
		units = 0,
		model = "models/griim/foodpack/sodacan_cocacola.mdl"
	},
	["pepsi"] = {
		name = "Pepsi",
		units = 0,
		model = "models/griim/foodpack/sodacan_pepsi.mdl"
	}
	
}
-- Ignore this line, we just use it to actually load the alcohol as an entity 
Alcohol.Core.Load()

-- Amount of units to enter the drunken state
Alcohol.Config.DrunkAmount = 6

-- How long before a player's units wear off (Seconds)
Alcohol.Config.ReduceTimer = 40
-- How many units to reduce per wear off
Alcohol.Config.ReduceAmount = 1

-- Amount of units to die
Alcohol.Config.Death = 20

-- Sounds to play when drinking
Alcohol.Config.DrinkSounds = {
	"npc/barnacle/barnacle_gulp1.wav",
	"npc/barnacle/barnacle_gulp2.wav"
}

-- The different kind of inputs to apply to the player
Alcohol.Config.ForceInputs = {"left", "right", "forward", "back"}