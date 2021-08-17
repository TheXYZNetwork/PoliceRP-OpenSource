Quest.Config.Storylines["he_fix_it_falafel"] ={
	name = "He fix it Falafel",
	id = "he_fix_it_falafel",
	desc = "Oil and grease",
	quests = {
		[1] = {
			name = "Become a Mechanic",
			desc = "Become a Mechanic from the F4 menu",
			func = function(ply, data)
				return true
			end
		},
		[2] = {
			name = "Repair a vehicle part",
			desc = "Repair a vehicle part using your tools",
			func = function(ply, data)
				return true
			end
		},
		[3] = {
			name = "Clamp a vehicle",
			desc = "Clamp a vehicle using your clamp SWEP",
			func = function(ply, data)
				return true
			end,
			reward = function(ply)
				Quest.Core.GiveStoryline(ply, "money_guard")
			end
		},
	}
}

-- Become a bus driver
hook.Add("PlayerChangedTeam", "Quest:Progress:he_fix_it_falafel", function(ply, oldTeam, newTeam)
	if not (newTeam == TEAM_MECHANIC) then return end

	Quest.Core.ProgressQuest(ply, "he_fix_it_falafel", 1)
end)
-- Repair a vehicle
hook.Add("VC_playerRepairedPart", "Quest:Progress:he_fix_it_falafel", function(ply)
	Quest.Core.ProgressQuest(ply, "he_fix_it_falafel", 2)
end)
-- Clamp a vehicle
hook.Add("XYZImpoundClamp", "Quest:Progress:he_fix_it_falafel", function(ply, owner, vehicle)
	Quest.Core.ProgressQuest(ply, "he_fix_it_falafel", 3)
end)
