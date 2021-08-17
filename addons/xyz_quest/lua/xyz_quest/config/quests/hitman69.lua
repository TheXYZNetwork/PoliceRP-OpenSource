Quest.Config.Storylines["hitman69"] ={
	name = "Hitman 69",
	id = "hitman69",
	desc = "Take contracts and kill your targets",
	quests = {
		[1] = {
			name = "Take a hit from the Payphone",
			desc = "Find a Payphone and take a hit contract",
			func = function(ply, data)
				return true
			end
		},
		[2] = {
			name = "Complete the hit",
			desc = "Complete your newly claimed contact",
			func = function(ply, data)
				return true
			end
		},
		[3] = {
			name = "Complete 5 hits",
			desc = function(data) return string.format("Complete 5 different hits. You have completed %i/5", tonumber(data) or 0) end,
			func = function(ply, data)
				local complete = data or 0
				complete = complete + 1

				return (complete == 5), complete, true
			end,
			reward = function(ply)
				ply:addMoney(30000)
				XYZShit.Msg("Quests", Quest.Config.Color, "Your last client was very happy with your work, you've been given $30,000!", ply)
			end
		},
	}
}