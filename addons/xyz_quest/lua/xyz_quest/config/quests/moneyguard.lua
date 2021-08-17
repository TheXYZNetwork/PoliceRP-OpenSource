Quest.Config.Storylines["money_guard"] ={
	name = "Money Guard",
	id = "money_guard",
	desc = "Protect the money at all costs",
	quests = {
		[1] = {
			name = "Become a Gruppe 6 Driver",
			desc = "Become a Gruppe 6 Driver from the F4 menu",
			func = function(ply, data)
				return true
			end
		},
		[2] = {
			name = "Spawn your Armoured Truck",
			desc = "Spawn your Armoured Truck",
			func = function(ply, data)
				return true
			end
		},
		[3] = {
			name = "Collect a Money Bag",
			desc = "Collect a Money Bag from a store",
			func = function(ply, data)
				return true
			end
		},
		[4] = {
			name = "Collect 2 more Money Bags",
			desc = function(data) return string.format("Collect 2 more Money Bags from stores. You have currently collected %i/2", data) end,
			func = function(ply, data)
				local collected = data or 0
				collected = collected + 1

				return (collected == 2), collected, true
			end
		},
		[5] = {
			name = "Deposit the Money Bags",
			desc = "Deposit the Money Bags in the Bank Vault and collect your reward",
			func = function(ply, data)
				return true
			end
		},
	}
}

-- Become a bus driver
hook.Add("PlayerChangedTeam", "Quest:Progress:money_guard", function(ply, oldTeam, newTeam)
	if not (newTeam == TEAM_G4SDRIVER) then return end

	Quest.Core.ProgressQuest(ply, "money_guard", 1)
end)