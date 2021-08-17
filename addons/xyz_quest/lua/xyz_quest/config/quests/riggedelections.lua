Quest.Config.Storylines["rigged_elections"] ={
	name = "Rigged Elections",
	id = "rigged_elections",
	desc = "Do whatever it takes to become President",
	quests = {
		[1] = {
			name = "Enter the Election for President",
			desc = "Enter the running for President",
			func = function(ply, data)
				return true
			end
		},
		[2] = {
			name = "Win the Election",
			desc = "Win the Election for President",
			func = function(ply, data)
				return true
			end
		},
		[3] = {
			name = "Assign a Vice President",
			desc = "Assign someone to be your Vice President",
			func = function(ply, data)
				return true
			end
		},
		[4] = {
			name = "Change the Tax Rate",
			desc = "Change the Tax Rate at the President's Computer",
			func = function(ply, data)
				return true
			end
		},
		[5] = {
			name = "Run a Lottery",
			desc = "Start a Lottery at the President's Computer",
			func = function(ply, data)
				return true
			end
		},
		[6] = {
			name = "Payout the President's Funds",
			desc = "Do a payout of the President's Funds at the President's Computer",
			func = function(ply, data)
				return true
			end,
			reward = function(ply)
				Quest.Core.GiveStoryline(ply, "homeless")
			end
		},
	}
}

-- Start a lottery
hook.Add("lotteryStarted", "Quest:Progress:rigged_elections", function(ply)
	Quest.Core.ProgressQuest(ply, "rigged_elections", 5)
end)