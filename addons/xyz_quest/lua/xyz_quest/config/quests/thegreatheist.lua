Quest.Config.Storylines["the_great_heist"] ={
	name = "The Great Heist",
	id = "the_great_heist",
	desc = "Take on the biggest robbery and hit the bank vault",
	quests = {
		[1] = {
			name = "Purchase a Mask",
			desc = "Purchase a mask from the F4 menu",
			func = function(ply, data, partyCount)
				return true
			end
		},
		[2] = {
			name = "Rob the Big Bank Vault",
			desc = "Break into the bank vault and rob it",
			func = function(ply, data, partyCount)
				return true
			end
		},
		[3] = {
			name = "Sell the Money Bags",
			desc = "Find a Corrupt Banker and sell him your Money Bags",
			func = function(ply, data, partyCount)
				return true
			end,
			reward = function(ply)
				ply:GiveBadge("quest")
			end
		},
	}
}

-- Purchase a mask
hook.Add("playerBoughtCustomEntity", "Quest:Progress:the_great_heist", function(ply, entTable, ent)
	if not (ent:GetClass() == "pvault_mask") then return end
	Quest.Core.ProgressQuest(ply, "the_great_heist", 1)
end)
-- The big vault was robbed
hook.Add("pVaultVaultCracked", "Quest:Progress:the_great_heist", function(ent, ply)
	if not (ent:GetClass() == "pvault_door") then return end
	Quest.Core.ProgressPartyQuest(ply, "the_great_heist", 2)
end)
-- Sell the money
hook.Add("pVaultMoneyCleaned", "Quest:Progress:the_great_heist", function(ply)
	Quest.Core.ProgressPartyQuest(ply, "the_great_heist", 3)
end)
