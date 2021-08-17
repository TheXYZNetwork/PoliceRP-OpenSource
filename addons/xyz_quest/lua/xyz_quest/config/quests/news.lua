Quest.Config.Storylines["news"] ={
	name = "News",
	id = "news",
	desc = "Broadcast the latest and greates",
	quests = {
		[1] = {
			name = "Become a News Crew operator",
			desc = "Become a News Crew operator from the F4 menu",
			func = function(ply, data)
				return true
			end
		},
		[2] = {
			name = "Start a News Broadcast",
			desc = "Start a News Broadcast",
			func = function(ply, data)
				return true
			end
		},
		[3] = {
			name = "Finish a News Broadcast",
			desc = "Finish a News Broadcast",
			func = function(ply, data)
				return true
			end
		},
		[4] = {
			name = "Become a News Reporter",
			desc = "Become a News Reporter from the F4 menu",
			func = function(ply, data)
				return true
			end
		},
		[5] = {
			name = "Be present during a News Broadcast",
			desc = "Be present during a News Broadcast",
			func = function(ply, data)
				return true
			end
		},
	}
}

-- Become a News Crew
hook.Add("PlayerChangedTeam", "Quest:Progress:news", function(ply, oldTeam, newTeam)
	if newTeam == TEAM_NEWSC then
		Quest.Core.ProgressQuest(ply, "news", 1)
	elseif newTeam == TEAM_NEWSR then
		Quest.Core.ProgressQuest(ply, "news", 4)
	end
end)