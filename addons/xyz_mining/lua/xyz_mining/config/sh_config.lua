-- The chat and UI colors
Mining.Config.Color = Color(150, 75, 0)

-- The min and max for the amount of health for 1 chunk of ore to be mined
Mining.Config.ChunkMin = 2
Mining.Config.ChunkMax = 4

-- Time between each mine (seconds)
Mining.Config.PickaxeCooldown = 2
Mining.Config.DrillCooldown = 1

-- Rock ore regeneration min and max (seconds)
Mining.Config.NodeRegenMin = 45
Mining.Config.NodeRegenMax = 120

-- Options with min and max values are used to randomly get a number between them.
Mining.Config.Ores = {
	["stone"] = {
		name = "Stone", -- The display name
		color = Color(100, 100, 100), -- The color of the ore
		value = {min = 160, max = 400}, -- The min and max sell values
		life = {min = 10, max = 20}, -- The min and max ores to be extracted before the node dies.
		rarity = 55 -- The chance of it being chosen. The lower the rarer
	},
	["coal"] = {
		name = "Coal",
		color = Color(0, 0, 0),
		value = {min = 400, max = 750},
		life = {min = 8, max = 18},
		rarity = 43
	},
	["copper"] = {
		name = "Copper",
		color = Color(205, 145, 6),
		value = {min = 750, max = 900},
		life = {min = 8, max = 16},
		rarity = 32
	},
	["iron"] = {
		name = "Iron",
		color = Color(200, 200, 200),
		value = {min = 900, max = 1200},
		life = {min = 7, max = 14},
		rarity = 25
	},
	["gold"] = {
		name = "Gold",
		color = Color(235, 225, 94),
		value = {min = 1200, max = 1500},
		life = {min = 7, max = 12},
		rarity = 20
	},
	["emerald"] = {
		name = "Emerald",
		color = Color(108, 235, 94),
		value = {min = 1500, max = 2000},
		life = {min = 6, max = 10},
		rarity = 12
	},
	["ruby"] = {
		name = "Ruby",
		color = Color(235, 94, 94),
		value = {min = 2000, max = 2400},
		life = {min = 6, max = 9},
		rarity = 8
	},
	["diamond"] = {
		name = "Diamond",
		color = Color(94, 221, 235),
		value = {min = 2400, max = 2800},
		life = {min = 6, max = 9},
		rarity = 4
	},
	["amethyst"] = {
		name = "Amethyst",
		color = Color(207, 94, 235),
		value = {min = 2800, max = 3100},
		life = {min = 4, max = 6},
		rarity = 2
	}
}


-- Gear
Mining.Config.Gear = {
	{
		name = "Pickaxe",
		model = "models/freeman/w_exhibition_pickaxe.mdl",
		price = 1000,
		canBuy = function(ply)
			return true
		end,
		action = function(ply)
			ply:Give("xyz_mining_axe")
		end
	},
	{
		name = "Drill",
		model = "models/freeman/w_exhibition_jackhammer.mdl",
		price = 10000,
		canBuy = function(ply)
			return ply:IsVIP()
		end,
		action = function(ply)
			ply:Give("xyz_mining_drill")
		end
	},
}