Quest.Config.Storylines["hostile_takeover"] ={
	name = "Hostile Takeover",
	id = "hostile_takeover",
	desc = "It's about time you got a turn running the Police Station",
	quests = {
		[1] = {
			name = "Purchase a Mask",
			desc = "Purchase a Mask from the F4 menu",
			func = function(ply, data)
				return true
			end
		},
		[2] = {
			name = "Rob the Police Armory",
			desc = "Break into the PD and rob the Police Armory",
			func = function(ply, data)
				return true
			end
		},
		[3] = {
			name = "Sell the Money Bag",
			desc = "Find the corrupt banker and sell your Money Bag to him",
			func = function(ply, data)
				return true
			end,
			reward = function(ply)
				Quest.Core.GiveStoryline(ply, "the_great_heist")
			end
		},
	}
}
-- Purchase a mask
hook.Add("playerBoughtCustomEntity", "Quest:Progress:hostile_takeover", function(ply, entTable, ent)
	if not (ent:GetClass() == "pvault_mask") then return end

	Quest.Core.ProgressQuest(ply, "hostile_takeover", 1)
end)
-- Purchase a mask
hook.Add("XYZArmoryRobbed", "Quest:Progress:hostile_takeover", function(ply)
	Quest.Core.ProgressPartyQuest(ply, "hostile_takeover", 2)
end)
-- Cleaned some money
hook.Add("pVaultMoneyCleaned", "Quest:Progress:hostile_takeover", function(ply)
	Quest.Core.ProgressPartyQuest(ply, "hostile_takeover", 3)
end)