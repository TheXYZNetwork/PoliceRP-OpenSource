Quest.Config.Storylines["snoop_puppy"] ={
	name = "Snoop Puppy",
	id = "snoop_puppy",
	desc = "Grow the green stuff for 'Medical usage'",
	quests = {
		[1] = {
			name = "Purchase a Plant Pot",
			desc = "Purchase a Weed Plant Pot from your Drugs Tablet",
			func = function(ply, data)
				return true
			end
		},
		[2] = {
			name = "Purchase a Light",
			desc = "Purchase a Weed Light from your Drugs Tablet",
			func = function(ply, data)
				return true
			end
		},
		[3] = {
			name = "Purchase a Seed Box",
			desc = "Purchase a Weed Seed Box from your Drugs Tablet",
			func = function(ply, data)
				return true
			end
		},
		[4] = {
			name = "Cultivate a Weed Plant",
			desc = "Following the Weed guide inside the Drug Tablet, grow a Weed Plant",
			func = function(ply, data)
				return true
			end
		},
		[5] = {
			name = "Sell the Bag of Weed",
			desc = "Find a Drug Hustler and sell him your Bag of Weed",
			func = function(ply, data)
				return true
			end
		},
		[6] = {
			name = "Cultivate 5 Weed Buds",
			desc = function(data) return string.format("Cultivate 5 Weeed Buds. You have currently cultivated %i/5", tonumber(data) or 0) end,
			func = function(ply, data)
				local complete = data or 0
				complete = complete + 1

				return (complete == 5), complete, true
			end
		},
		[7] = {
			name = "Sell 5 Bags of Weed",
			desc = function(data) return string.format("Sell 5 Bags of Weed. You have currently sold %i/5", tonumber(data) or 0) end,
			func = function(ply, data)
				local complete = data or 0
				complete = complete + 1

				return (complete == 5), complete, true
			end,
			reward = function(ply)
				Quest.Core.GiveStoryline(ply, "pablo_escopole")
			end
		},
	}
}

-- Purchase all the stuff
hook.Add("DrugsTabletPurchase", "Quest:Progress:snoop_puppy", function(ply, itemClass)
	if itemClass == "uweed_plant" then
		Quest.Core.ProgressQuest(ply, "snoop_puppy", 1)
	elseif (itemClass == "uweed_light") or (itemClass == "uweed_light_big") then
		Quest.Core.ProgressQuest(ply, "snoop_puppy", 2)
	elseif itemClass == "uweed_seed_box" then
		Quest.Core.ProgressQuest(ply, "snoop_puppy", 3)
	end
end)
-- Sell a bag of weed
hook.Add("DrugTabletDrugHustlerAdd", "Quest:Progress:snoop_puppy", function(ent, value)
	if not (ent:GetClass() == "uweed_bag") then return end
	if not ent.invOwner then return end
	Quest.Core.ProgressQuest(ent.invOwner, "snoop_puppy", 5)
	Quest.Core.ProgressQuest(ent.invOwner, "snoop_puppy", 7)
end)
