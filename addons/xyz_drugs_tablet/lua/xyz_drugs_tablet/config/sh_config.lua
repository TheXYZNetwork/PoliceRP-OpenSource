XYZDrugsTable.Config.Color = Color(0, 140, 90)
-- The buffer zone to prevent spawning on
XYZDrugsTable.Config.SpawnBuffer = Vector(30, 30, 30)
XYZDrugsTable.Config.SpawnWhitelist = {"prop_dynamic", "prop_physics_multiplayer", "keyframe_rope", "move_rope"}

XYZDrugsTable.Config.Drugs = {
	{ -- Weed
		name = "Weed",
		ents = {
			["uweed_battery"] = {ent = "uweed_battery", price = 50, limit = 2, check = function(ply) return table.HasValue({TEAM_DRUGDEALER, TEAM_DRUGLORD, TEAM_SCSASSOCIATE, TEAM_SCHASSOCIATE, TEAM_SJRSICARIO, TEAM_SPOREGIME, TEAM_SSPOREGIME, TEAM_SCHSPOREGIME, TEAM_SCCAPOREGIME, TEAM_LTBOSS, TEAM_SCUNDERBOSS, TEAM_SCBOSS, TEAM_SCCONSIGLIERE, TEAM_SCGODFATHER}, ply:Team()) end},
			["uweed_light_big"] = {ent = "uweed_light_big", price = 200, limit = 1, check = function(ply) return table.HasValue({TEAM_DRUGDEALER, TEAM_DRUGLORD, TEAM_SCSASSOCIATE, TEAM_SCHASSOCIATE, TEAM_SJRSICARIO, TEAM_SPOREGIME, TEAM_SSPOREGIME, TEAM_SCHSPOREGIME, TEAM_SCCAPOREGIME, TEAM_LTBOSS, TEAM_SCUNDERBOSS, TEAM_SCBOSS, TEAM_SCCONSIGLIERE, TEAM_SCGODFATHER}, ply:Team()) end},
			["uweed_light"] = {ent = "uweed_light", price = 100, limit = 1, check = function(ply) return table.HasValue({TEAM_DRUGDEALER, TEAM_DRUGLORD, TEAM_SCSASSOCIATE, TEAM_SCHASSOCIATE, TEAM_SJRSICARIO, TEAM_SPOREGIME, TEAM_SSPOREGIME, TEAM_SCHSPOREGIME, TEAM_SCCAPOREGIME, TEAM_LTBOSS, TEAM_SCUNDERBOSS, TEAM_SCBOSS, TEAM_SCCONSIGLIERE, TEAM_SCGODFATHER}, ply:Team()) end},
			["uweed_plant"] = {ent = "uweed_plant", price = 150, limit = 1, check = function(ply) return table.HasValue({TEAM_DRUGDEALER, TEAM_DRUGLORD, TEAM_SCSASSOCIATE, TEAM_SCHASSOCIATE, TEAM_SJRSICARIO, TEAM_SPOREGIME, TEAM_SSPOREGIME, TEAM_SCHSPOREGIME, TEAM_SCCAPOREGIME, TEAM_LTBOSS, TEAM_SCUNDERBOSS, TEAM_SCBOSS, TEAM_SCCONSIGLIERE, TEAM_SCGODFATHER}, ply:Team()) end},
			["uweed_skin"] = {ent = "uweed_skin", price = 75, limit = 1, check = function(ply) return table.HasValue({TEAM_DRUGDEALER, TEAM_DRUGLORD, TEAM_SCSASSOCIATE, TEAM_SCHASSOCIATE, TEAM_SJRSICARIO, TEAM_SPOREGIME, TEAM_SSPOREGIME, TEAM_SCHSPOREGIME, TEAM_SCCAPOREGIME, TEAM_LTBOSS, TEAM_SCUNDERBOSS, TEAM_SCBOSS, TEAM_SCCONSIGLIERE, TEAM_SCGODFATHER}, ply:Team()) end},
			["uweed_scale"] = {ent = "uweed_scale", price = 50, limit = 1, check = function(ply) return table.HasValue({TEAM_DRUGDEALER, TEAM_DRUGLORD, TEAM_SCSASSOCIATE, TEAM_SCHASSOCIATE, TEAM_SJRSICARIO, TEAM_SPOREGIME, TEAM_SSPOREGIME, TEAM_SCHSPOREGIME, TEAM_SCCAPOREGIME, TEAM_LTBOSS, TEAM_SCUNDERBOSS, TEAM_SCBOSS, TEAM_SCCONSIGLIERE, TEAM_SCGODFATHER}, ply:Team()) end},
			["uweed_seed_box"] = {ent = "uweed_seed_box", price = 80, limit = 1, check = function(ply) return table.HasValue({TEAM_DRUGDEALER, TEAM_DRUGLORD, TEAM_SCSASSOCIATE, TEAM_SCHASSOCIATE, TEAM_SJRSICARIO, TEAM_SPOREGIME, TEAM_SSPOREGIME, TEAM_SCHSPOREGIME, TEAM_SCCAPOREGIME, TEAM_LTBOSS, TEAM_SCUNDERBOSS, TEAM_SCBOSS, TEAM_SCCONSIGLIERE, TEAM_SCGODFATHER}, ply:Team()) end},
			["uweed_bag"] = {ent = "uweed_bag", price = 100, limit = 2, check = function(ply) return table.HasValue({TEAM_DRUGDEALER, TEAM_DRUGLORD, TEAM_SCSASSOCIATE, TEAM_SCHASSOCIATE, TEAM_SJRSICARIO, TEAM_SPOREGIME, TEAM_SSPOREGIME, TEAM_SCHSPOREGIME, TEAM_SCCAPOREGIME, TEAM_LTBOSS, TEAM_SCUNDERBOSS, TEAM_SCBOSS, TEAM_SCCONSIGLIERE, TEAM_SCGODFATHER}, ply:Team()) end}
		},
		check = function(ply) return true end
	},
	{ -- Weed Edibles
		name = "Weed Edibles",
		ents = {
			["uweed_cookbowl"] = {ent = "uweed_cookbowl", price = 175, limit = 1, check = function(ply) return table.HasValue({TEAM_DRUGDEALER, TEAM_DRUGLORD, TEAM_SCSASSOCIATE, TEAM_SCHASSOCIATE, TEAM_SJRSICARIO, TEAM_SPOREGIME, TEAM_SSPOREGIME, TEAM_SCHSPOREGIME, TEAM_SCCAPOREGIME, TEAM_LTBOSS, TEAM_SCUNDERBOSS, TEAM_SCBOSS, TEAM_SCCONSIGLIERE, TEAM_SCGODFATHER}, ply:Team()) end},
			["uweed_cocoapowder"] = {ent = "uweed_cocoapowder", price = 60, limit = 2, check = function(ply) return table.HasValue({TEAM_DRUGDEALER, TEAM_DRUGLORD, TEAM_SCSASSOCIATE, TEAM_SCHASSOCIATE, TEAM_SJRSICARIO, TEAM_SPOREGIME, TEAM_SSPOREGIME, TEAM_SCHSPOREGIME, TEAM_SCCAPOREGIME, TEAM_LTBOSS, TEAM_SCUNDERBOSS, TEAM_SCBOSS, TEAM_SCCONSIGLIERE, TEAM_SCGODFATHER}, ply:Team()) end},
			["uweed_eggcarton"] = {ent = "uweed_eggcarton", price = 50, limit = 1, check = function(ply) return table.HasValue({TEAM_DRUGDEALER, TEAM_DRUGLORD, TEAM_SCSASSOCIATE, TEAM_SCHASSOCIATE, TEAM_SJRSICARIO, TEAM_SPOREGIME, TEAM_SSPOREGIME, TEAM_SCHSPOREGIME, TEAM_SCCAPOREGIME, TEAM_LTBOSS, TEAM_SCUNDERBOSS, TEAM_SCBOSS, TEAM_SCCONSIGLIERE, TEAM_SCGODFATHER}, ply:Team()) end},
			["uweed_flour"] = {ent = "uweed_flour", price = 65, limit = 2, check = function(ply) return table.HasValue({TEAM_DRUGDEALER, TEAM_DRUGLORD, TEAM_SCSASSOCIATE, TEAM_SCHASSOCIATE, TEAM_SJRSICARIO, TEAM_SPOREGIME, TEAM_SSPOREGIME, TEAM_SCHSPOREGIME, TEAM_SCCAPOREGIME, TEAM_LTBOSS, TEAM_SCUNDERBOSS, TEAM_SCBOSS, TEAM_SCCONSIGLIERE, TEAM_SCGODFATHER}, ply:Team()) end},
			["uweed_gas"] = {ent = "uweed_gas", price = 50, limit = 2, check = function(ply) return table.HasValue({TEAM_DRUGDEALER, TEAM_DRUGLORD, TEAM_SCSASSOCIATE, TEAM_SCHASSOCIATE, TEAM_SJRSICARIO, TEAM_SPOREGIME, TEAM_SSPOREGIME, TEAM_SCHSPOREGIME, TEAM_SCCAPOREGIME, TEAM_LTBOSS, TEAM_SCUNDERBOSS, TEAM_SCBOSS, TEAM_SCCONSIGLIERE, TEAM_SCGODFATHER}, ply:Team()) end},
			["uweed_milk"] = {ent = "uweed_milk", price = 99, limit = 2, check = function(ply) return table.HasValue({TEAM_DRUGDEALER, TEAM_DRUGLORD, TEAM_SCSASSOCIATE, TEAM_SCHASSOCIATE, TEAM_SJRSICARIO, TEAM_SPOREGIME, TEAM_SSPOREGIME, TEAM_SCHSPOREGIME, TEAM_SCCAPOREGIME, TEAM_LTBOSS, TEAM_SCUNDERBOSS, TEAM_SCBOSS, TEAM_SCCONSIGLIERE, TEAM_SCGODFATHER}, ply:Team()) end},
			["uweed_oven"] = {ent = "uweed_oven", price = 200, limit = 1, check = function(ply) return table.HasValue({TEAM_DRUGDEALER, TEAM_DRUGLORD, TEAM_SCSASSOCIATE, TEAM_SCHASSOCIATE, TEAM_SJRSICARIO, TEAM_SPOREGIME, TEAM_SSPOREGIME, TEAM_SCHSPOREGIME, TEAM_SCCAPOREGIME, TEAM_LTBOSS, TEAM_SCUNDERBOSS, TEAM_SCBOSS, TEAM_SCCONSIGLIERE, TEAM_SCGODFATHER}, ply:Team()) end},
			["uweed_sugar"] = {ent = "uweed_sugar", price = 45, limit = 2, check = function(ply) return table.HasValue({TEAM_DRUGDEALER, TEAM_DRUGLORD, TEAM_SCSASSOCIATE, TEAM_SCHASSOCIATE, TEAM_SJRSICARIO, TEAM_SPOREGIME, TEAM_SSPOREGIME, TEAM_SCHSPOREGIME, TEAM_SCCAPOREGIME, TEAM_LTBOSS, TEAM_SCUNDERBOSS, TEAM_SCBOSS, TEAM_SCCONSIGLIERE, TEAM_SCGODFATHER}, ply:Team()) end},
			["uweed_oilext"] = {ent = "uweed_oilext", price = 250, limit = 1, check = function(ply) return table.HasValue({TEAM_DRUGDEALER, TEAM_DRUGLORD, TEAM_SCSASSOCIATE, TEAM_SCHASSOCIATE, TEAM_SJRSICARIO, TEAM_SPOREGIME, TEAM_SSPOREGIME, TEAM_SCHSPOREGIME, TEAM_SCCAPOREGIME, TEAM_LTBOSS, TEAM_SCUNDERBOSS, TEAM_SCBOSS, TEAM_SCCONSIGLIERE, TEAM_SCGODFATHER}, ply:Team()) end}
		},
		check = function(ply) return true end
	},
	{ -- Cocaine
		name = "Cocaine",
		ents = {
			["xyz_cocaine_baking_soda"] = {ent = "xyz_cocaine_baking_soda", price = 75, limit = 2, check = function(ply) return table.HasValue({TEAM_DRUGDEALER, TEAM_DRUGLORD, TEAM_SCSASSOCIATE, TEAM_SCHASSOCIATE, TEAM_SJRSICARIO, TEAM_SPOREGIME, TEAM_SSPOREGIME, TEAM_SCHSPOREGIME, TEAM_SCCAPOREGIME, TEAM_LTBOSS, TEAM_SCUNDERBOSS, TEAM_SCBOSS, TEAM_SCCONSIGLIERE, TEAM_SCGODFATHER}, ply:Team()) end},
			["xyz_cocaine_battery"] = {ent = "xyz_cocaine_battery", price = 60, limit = 2, check = function(ply) return table.HasValue({TEAM_DRUGDEALER, TEAM_DRUGLORD, TEAM_SCSASSOCIATE, TEAM_SCHASSOCIATE, TEAM_SJRSICARIO, TEAM_SPOREGIME, TEAM_SSPOREGIME, TEAM_SCHSPOREGIME, TEAM_SCCAPOREGIME, TEAM_LTBOSS, TEAM_SCUNDERBOSS, TEAM_SCBOSS, TEAM_SCCONSIGLIERE, TEAM_SCGODFATHER}, ply:Team()) end},
			["xyz_cocaine_bucket"] = {ent = "xyz_cocaine_bucket", price = 120, limit = 1, check = function(ply) return table.HasValue({TEAM_DRUGDEALER, TEAM_DRUGLORD, TEAM_SCSASSOCIATE, TEAM_SCHASSOCIATE, TEAM_SJRSICARIO, TEAM_SPOREGIME, TEAM_SSPOREGIME, TEAM_SCHSPOREGIME, TEAM_SCCAPOREGIME, TEAM_LTBOSS, TEAM_SCUNDERBOSS, TEAM_SCBOSS, TEAM_SCCONSIGLIERE, TEAM_SCGODFATHER}, ply:Team()) end},
			["xyz_cocaine_rack"] = {ent = "xyz_cocaine_rack", price = 320, limit = 1, check = function(ply) return table.HasValue({TEAM_DRUGDEALER, TEAM_DRUGLORD, TEAM_SCSASSOCIATE, TEAM_SCHASSOCIATE, TEAM_SJRSICARIO, TEAM_SPOREGIME, TEAM_SSPOREGIME, TEAM_SCHSPOREGIME, TEAM_SCCAPOREGIME, TEAM_LTBOSS, TEAM_SCUNDERBOSS, TEAM_SCBOSS, TEAM_SCCONSIGLIERE, TEAM_SCGODFATHER}, ply:Team()) end},
			["xyz_cocaine_extractor"] = {ent = "xyz_cocaine_extractor", price = 300, limit = 1, check = function(ply) return table.HasValue({TEAM_DRUGDEALER, TEAM_DRUGLORD, TEAM_SCSASSOCIATE, TEAM_SCHASSOCIATE, TEAM_SJRSICARIO, TEAM_SPOREGIME, TEAM_SSPOREGIME, TEAM_SCHSPOREGIME, TEAM_SCCAPOREGIME, TEAM_LTBOSS, TEAM_SCUNDERBOSS, TEAM_SCBOSS, TEAM_SCCONSIGLIERE, TEAM_SCGODFATHER}, ply:Team()) end},
			["xyz_cocaine_gas"] = {ent = "xyz_cocaine_gas", price = 100, limit = 2, check = function(ply) return table.HasValue({TEAM_DRUGDEALER, TEAM_DRUGLORD, TEAM_SCSASSOCIATE, TEAM_SCHASSOCIATE, TEAM_SJRSICARIO, TEAM_SPOREGIME, TEAM_SSPOREGIME, TEAM_SCHSPOREGIME, TEAM_SCCAPOREGIME, TEAM_LTBOSS, TEAM_SCUNDERBOSS, TEAM_SCBOSS, TEAM_SCCONSIGLIERE, TEAM_SCGODFATHER}, ply:Team()) end},
			["xyz_cocaine_leaves"] = {ent = "xyz_cocaine_leaves", price = 190, limit = 2, check = function(ply) return table.HasValue({TEAM_DRUGDEALER, TEAM_DRUGLORD, TEAM_SCSASSOCIATE, TEAM_SCHASSOCIATE, TEAM_SJRSICARIO, TEAM_SPOREGIME, TEAM_SSPOREGIME, TEAM_SCHSPOREGIME, TEAM_SCCAPOREGIME, TEAM_LTBOSS, TEAM_SCUNDERBOSS, TEAM_SCBOSS, TEAM_SCCONSIGLIERE, TEAM_SCGODFATHER}, ply:Team()) end},
			["xyz_cocaine_pot"] = {ent = "xyz_cocaine_pot", price = 145, limit = 2, check = function(ply) return table.HasValue({TEAM_DRUGDEALER, TEAM_DRUGLORD, TEAM_SCSASSOCIATE, TEAM_SCHASSOCIATE, TEAM_SJRSICARIO, TEAM_SPOREGIME, TEAM_SSPOREGIME, TEAM_SCHSPOREGIME, TEAM_SCCAPOREGIME, TEAM_LTBOSS, TEAM_SCUNDERBOSS, TEAM_SCBOSS, TEAM_SCCONSIGLIERE, TEAM_SCGODFATHER}, ply:Team()) end},
			["xyz_cocaine_stove"] = {ent = "xyz_cocaine_stove", price = 390, limit = 2, check = function(ply) return table.HasValue({TEAM_DRUGDEALER, TEAM_DRUGLORD, TEAM_SCSASSOCIATE, TEAM_SCHASSOCIATE, TEAM_SJRSICARIO, TEAM_SPOREGIME, TEAM_SSPOREGIME, TEAM_SCHSPOREGIME, TEAM_SCCAPOREGIME, TEAM_LTBOSS, TEAM_SCUNDERBOSS, TEAM_SCBOSS, TEAM_SCCONSIGLIERE, TEAM_SCGODFATHER}, ply:Team()) end},
			["xyz_cocaine_water"] = {ent = "xyz_cocaine_water", price = 20, limit = 2, check = function(ply) return table.HasValue({TEAM_DRUGDEALER, TEAM_DRUGLORD, TEAM_SCSASSOCIATE, TEAM_SCHASSOCIATE, TEAM_SJRSICARIO, TEAM_SPOREGIME, TEAM_SSPOREGIME, TEAM_SCHSPOREGIME, TEAM_SCCAPOREGIME, TEAM_LTBOSS, TEAM_SCUNDERBOSS, TEAM_SCBOSS, TEAM_SCCONSIGLIERE, TEAM_SCGODFATHER}, ply:Team()) end}
		},
		check = function(ply) return true end
	},
	{ -- Alcohol
		name = "Alcohol",
		ents = {
			["xyz_alcohol_am_beer"] = {ent = "xyz_alcohol_am_beer", price = 100, limit = 2, check = function(ply) return table.HasValue(XYZShit.Jobs.Criminals.SinaloaCartel, ply:Team()) end},
			["xyz_alcohol_bleuter_champagne"] = {ent = "xyz_alcohol_bleuter_champagne", price = 100, limit = 2, check = function(ply) return table.HasValue(XYZShit.Jobs.Criminals.SinaloaCartel, ply:Team()) end},
			["xyz_alcohol_cava_champagne"] = {ent = "xyz_alcohol_cava_champagne", price = 100, limit = 2, check = function(ply) return table.HasValue(XYZShit.Jobs.Criminals.SinaloaCartel, ply:Team()) end},
			["xyz_alcohol_vodka"] = {ent = "xyz_alcohol_vodka", price = 100, limit = 2, check = function(ply) return table.HasValue(XYZShit.Jobs.Criminals.SinaloaCartel, ply:Team()) end},
			["xyz_alcohol_coke"] = {ent = "xyz_alcohol_coke", price = 100, limit = 2, check = function(ply) return table.HasValue(XYZShit.Jobs.Criminals.SinaloaCartel, ply:Team()) end},
			["xyz_alcohol_patriot_beer"] = {ent = "xyz_alcohol_patriot_beer", price = 100, limit = 2, check = function(ply) return table.HasValue(XYZShit.Jobs.Criminals.SinaloaCartel, ply:Team()) end},
			["xyz_alcohol_pepsi"] = {ent = "xyz_alcohol_pepsi", price = 100, limit = 2, check = function(ply) return table.HasValue(XYZShit.Jobs.Criminals.SinaloaCartel, ply:Team()) end},
			["xyz_alcohol_pisswasser_beer"] = {ent = "xyz_alcohol_pisswasser_beer", price = 100, limit = 2, check = function(ply) return table.HasValue(XYZShit.Jobs.Criminals.SinaloaCartel, ply:Team()) end},
			["xyz_alcohol_rum"] = {ent = "xyz_alcohol_rum", price = 100, limit = 2, check = function(ply) return table.HasValue(XYZShit.Jobs.Criminals.SinaloaCartel, ply:Team()) end},
			["xyz_alcohol_red_wine"] = {ent = "xyz_alcohol_red_wine", price = 100, limit = 2, check = function(ply) return table.HasValue(XYZShit.Jobs.Criminals.SinaloaCartel, ply:Team()) end},
			["xyz_alcohol_rose_wine"] = {ent = "xyz_alcohol_rose_wine", price = 100, limit = 2, check = function(ply) return table.HasValue(XYZShit.Jobs.Criminals.SinaloaCartel, ply:Team()) end},
			["xyz_alcohol_tequila"] = {ent = "xyz_alcohol_tequila", price = 100, limit = 2, check = function(ply) return table.HasValue(XYZShit.Jobs.Criminals.SinaloaCartel, ply:Team()) end},
			["xyz_alcohol_water"] = {ent = "xyz_alcohol_water", price = 100, limit = 2, check = function(ply) return table.HasValue(XYZShit.Jobs.Criminals.SinaloaCartel, ply:Team()) end},
			["xyz_alcohol_whiskey"] = {ent = "xyz_alcohol_whiskey", price = 100, limit = 2, check = function(ply) return table.HasValue(XYZShit.Jobs.Criminals.SinaloaCartel, ply:Team()) end},
			["xyz_alcohol_white_wine"] = {ent = "xyz_alcohol_white_wine", price = 100, limit = 2, check = function(ply) return table.HasValue(XYZShit.Jobs.Criminals.SinaloaCartel, ply:Team()) end},
		},
		check = function(ply) return true end
	}
}

XYZDrugsTable.Config.Addition = {}
hook.Add("loadCustomDarkRPItems", "DrugsTable:ExtraLimits", function()
	XYZDrugsTable.Config.Addition[TEAM_DRUGLORD] = 2
end)


XYZDrugsTable.Config.SellValues = {
	["uweed_bag"] = {
		valuePer = function() return math.random(UWeed.Config.MinSell, UWeed.Config.MaxSell) end,
		calcPer = function(ent) return ent:GetBudCounter() end
	},
	["xyz_cocaine_brick"]  = {
		valuePer = function() return 1 end,
		calcPer = function(ent) return ent:GetSellValue() end
	}
}

XYZDrugsTable.Config.Guides = {
	{ -- Weed
		name = "Weed",
		desc = [[
		Requirements:
		1x Light
		1x Plant Pot
		1x Seed

		Instructions:
		1.) Plant the seed inside the plant pot.
		2.) Wait for it to grow. Ensure you do not give it too little or too much light.
		3.) Once grown, harvest.
		]]
	},
	{ -- Cocaine
		name = "Cocaine",
		desc = [[
		Requirements:
		1x Stove
		1x Extractor
		1x Drying Rack
		1x Pot
		3x Water
		3x Baking Soda
		3x Leaves

		Instructions:
		1.) Place water and baking soda inside pot.
		2.) Place pot on stove and wait to boil. Do not let over boil. (May require gas.)
		2.5) Repeat step 1 and 2 three times.
		3.) Place boiled pot contents inside extractor.
		4.) Place 3x leaves and bucket inside extractor. Turn on and wait to finish.
		5.) Place full bucket on drying rack and wait to dry. (May require a battery.)
		6.) Once dry, harvest and package.
		]]
	},
}