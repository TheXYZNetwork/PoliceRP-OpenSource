RobbableNPC.Config.Color = Color(42, 172, 53)

RobbableNPC.Config.Stores = {
	["supermarket"] = {
		name = "Rockford Foods", -- The display names
		model = "models/Humans/Group02/male_08.mdl", -- The model
		neededPolice = 5, -- How many police are needed
		neededPlayers = 10, -- How many players are needed
		robTime = 60, -- How many seconds it takes to rob
		cooldownTime = 60*5, -- How many seconds before it can be robbed again
		minEarn = 10000, -- The minimum amount it drops
		maxEarn = 75000 -- The max amount it drops
	},
	["shell"] = {
		name = "Shell Gas Station",
		model = "models/Humans/Group02/male_08.mdl",
		neededPolice = 5,
		neededPlayers = 10,
		robTime = 90,
		cooldownTime = 60*10,
		minEarn = 30000,
		maxEarn = 100000
	},
	["taco"] = {
		name = "Taco Bell",
		model = "models/Humans/Group02/male_08.mdl",
		neededPolice = 5,
		neededPlayers = 10,
		robTime = 60,
		cooldownTime = 60*5,
		minEarn = 10000,
		maxEarn = 75000
	},
}
RobbableNPC.Core.Load()

RobbableNPC.Config.AllowedBases = {
	["cw_base"] = true,
	["zekeou_gun_base"] = true,
	["zekeou_scoped_base"] = true
}