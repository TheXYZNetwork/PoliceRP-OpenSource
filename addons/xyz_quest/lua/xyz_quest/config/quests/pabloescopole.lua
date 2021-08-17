Quest.Config.Storylines["pablo_escopole"] ={
	name = "Pablo Escopole",
	id = "pablo_escopole",
	desc = "Process Cocaine and become a true drug empire kingpin",
	quests = {
		[1] = {
			name = "Access your Drugs Tablet",
			desc = "Open your drugs tablet. It can be located on your weapon hotbar",
			clientProgress = true,
			func = function(ply, data)
				return true
			end
		},
		[2] = {
			name = "Purchase a Cocaine Stove",
			desc = "Purchase a Cocaine Stove from your Drugs Tablet",
			func = function(ply, data)
				return true
			end
		},
		[3] = {
			name = "Purchase a Cocaine Extractor",
			desc = "Purchase a Cocaine Extractor from your Drugs Tablet",
			func = function(ply, data)
				return true
			end
		},
		[4] = {
			name = "Purchase a Cocaine Drying Rack",
			desc = "Purchase a Cocaine Extractor from your Drugs Tablet",
			func = function(ply, data)
				return true
			end
		},
		[5] = {
			name = "Process a brick of Cocaine",
			desc = "Follow the Cocaine guide inside your Drugs Tablet and fully Process a brick of cocaine",
			func = function(ply, data)
				return true
			end
		},
		[6] = {
			name = "Sell the brick of Cocaine",
			desc = "Find a Drug Hustler and sell him your brick of Cocaine",
			func = function(ply, data)
				return true
			end
		},
		[7] = {
			name = "Process 5 bricks of Cocaine",
			desc = function(data) return string.format("Process 5 bricks of Cocaine. You have currently processed %i/5", tonumber(data) or 0) end,
			func = function(ply, data)
				local complete = data or 0
				complete = complete + 1

				return (complete == 5), complete, true
			end
		},
		[8] = {
			name = "Sell 5 bricks of Cocaine",
			desc = function(data) return string.format("Sell 5 bricks of Cocaine. You have currently sold %i/5", tonumber(data) or 0) end,
			func = function(ply, data)
				local complete = data or 0
				complete = complete + 1

				return (complete == 5), complete, true
			end,
			reward = function(ply)
				ply:addMoney(50000)
				XYZShit.Msg("Quests", Quest.Config.Color, "That final batch was super high quality, your buyer was willing to pay a little extra. You received $50,000!", ply)
			end
		},
	}
}

-- Purchase all the stuff
hook.Add("DrugsTabletPurchase", "Quest:Progress:pablo_escopole", function(ply, itemClass)
	if itemClass == "xyz_cocaine_stove" then
		Quest.Core.ProgressQuest(ply, "pablo_escopole", 2)
	elseif itemClass == "xyz_cocaine_extractor" then
		Quest.Core.ProgressQuest(ply, "pablo_escopole", 3)
	elseif itemClass == "xyz_cocaine_rack" then
		Quest.Core.ProgressQuest(ply, "pablo_escopole", 4)
	end
end)
-- Process a brick of cocaine
hook.Add("CocaineRackComplete", "Quest:Progress:pablo_escopole", function(ply, rack, brick)
	Quest.Core.ProgressQuest(ply, "pablo_escopole", 5)
	Quest.Core.ProgressQuest(ply, "pablo_escopole", 7)
end)
-- Sell a brick of cocaine
hook.Add("DrugTabletDrugHustlerAdd", "Quest:Progress:pablo_escopole", function(ent, value)
	if not (ent:GetClass() == "xyz_cocaine_brick") then return end
	if not ent.invOwner then return end
	Quest.Core.ProgressQuest(ent.invOwner, "pablo_escopole", 6)
	Quest.Core.ProgressQuest(ent.invOwner, "pablo_escopole", 8)
end)
