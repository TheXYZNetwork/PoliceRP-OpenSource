Quest.Config.Storylines["jail_break"] ={
	name = "Jail Break",
	id = "jail_break",
	desc = "Use your high IQ to plan the perfect escape",
	quests = {
		[1] = {
			name = "Get Arrested",
			desc = "Get Arrested and put in prison",
			func = function(ply, data)
				return true
			end
		},
		[2] = {
			name = "Find a Prison Spoon",
			desc = "Search the lockers to find a Prison Spoon",
			func = function(ply, data)
				return true
			end
		},
		[3] = {
			name = "Dig a Tunnel",
			desc = "Use the Prison Spoon to dig a tunnel",
			func = function(ply, data)
				return true
			end
		},
		[4] = {
			name = "Escape Prison",
			desc = "Climb through the hole to escape the prison walls",
			func = function(ply, data)
				return true
			end
		},
		[5] = {
			name = "Purchase a New Identity",
			desc = "Go to the Black Market dealer and purchase a new identity",
			func = function(ply, data)
				return true
			end,
			reward = function(ply)
				Quest.Core.GiveStoryline(ply, "hostile_takeover")
			end
		},
	}
}