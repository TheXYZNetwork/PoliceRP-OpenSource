Quest.Config.Storylines["pocketaces"] ={
	name = "Pocket Aces",
	id = "pocketaces",
	desc = "Test your luck in the Casino",
	quests = {
		[1] = {
			name = "Win 5 rounds of Slots",
			desc = function(data) return string.format("Win 5 rounds on any Slot Machine. You have currently won %i/5", tonumber(data) or 0) end,
			func = function(ply, data)
				local wins = data or 0
				wins = wins + 1

				return (wins == 5), wins, true
			end
		},
		[2] = {
			name = "Win 2 hands on Blackjack",
			desc = function(data) return string.format("Win 2 hands on any Blackjack Table. You have currently won %i/2", tonumber(data) or 0) end,
			func = function(ply, data)
				local wins = data or 0
				wins = wins + 1

				return (wins == 2), wins, true
			end
		},
		[3] = {
			name = "Win $5,000 on Roulette",
			desc = function(data) return string.format("Win $5,000 on any Roulette Table. You have currently won %s/$5,000", DarkRP.formatMoney(tonumber(data) or 0)) end,
			func = function(ply, data, winnings)
				local wins = winnings or 0
				wins = wins + winnings

				return (wins >= 5000), wins, true
			end
		},
		[4] = {
			name = "Spin the Big Prize Wheel",
			desc = "Win a spin for the Big Prize Wheel and use it",
			func = function(ply, data, winnings)
				return true
			end
		},
	}
}

-- Win 5 rounds of slots
hook.Add("pCasinoOnWheelSlotMachinePayout", "Quest:Progress:pocketaces", function(ply, ent)
	Quest.Core.ProgressQuest(ply, "pocketaces", 1)
end)
hook.Add("pCasinoOnBasicSlotMachinePayout", "Quest:Progress:pocketaces", function(ply, ent)
	Quest.Core.ProgressQuest(ply, "pocketaces", 1)
end)
-- Win 2 blackjack hands
hook.Add("pCasinoOnBlackjackPayout", "Quest:Progress:pocketaces", function(ply, ent)
	Quest.Core.ProgressQuest(ply, "pocketaces", 2)
end)
-- Win 5,000 on roulette
hook.Add("pCasinoOnRoulettePayout", "Quest:Progress:pocketaces", function(ply, table, winnings)
	Quest.Core.ProgressQuest(ply, "pocketaces", 3, winnings)
end)
-- Spin the big price wheel
hook.Add("pCasinoCanMysteryWheelSpin", "Quest:Progress:pocketaces", function(ply)
	Quest.Core.ProgressQuest(ply, "pocketaces", 4)
end)
