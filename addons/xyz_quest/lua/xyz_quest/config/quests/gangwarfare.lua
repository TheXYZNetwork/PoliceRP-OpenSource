Quest.Config.Storylines["gang_warfare"] ={
	name = "Gang Warfare",
	id = "gang_warfare",
	desc = "Everything is better experienced together",
	quests = {
		[1] = {
			name = "Join an Organisation",
			desc = "Find and join an Organisation",
			func = function(ply, data)
				return true
			end,
			check = function(ply)
				return not (XYZ_ORGS.Core.Members[ply:SteamID64()] == nil)
			end
		},
		[2] = {
			name = "Get promoted",
			desc = "Get promoted in your organisation",
			func = function(ply, data)
				return true
			end
		},
		[3] = {
			name = "Add funds",
			desc = "Put money into the Organisation funds",
			func = function(ply, data)
				return true
			end
		},
		[4] = {
			name = "Deposit an item",
			desc = "Add something to the Organisation bank",
			func = function(ply, data)
				return true
			end
		},
		[5] = {
			name = "Create your own Organisation",
			desc = "Create an Organisation of your own",
			func = function(ply, data)
				return true
			end,
			reward = function(ply)
				ply:addMoney(75000)
				XYZShit.Msg("Quests", Quest.Config.Color, "You have been given $75,000 as a grant to help you start your organisation!", ply)
			end
		},
	}
}