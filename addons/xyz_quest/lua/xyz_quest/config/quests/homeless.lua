Quest.Config.Storylines["homeless"] ={
	name = "Homeless",
	id = "homeless",
	desc = "You had it all, now it's time to lose it all",
	quests = {
		[1] = {
			name = "Become a Hobo",
			desc = "Become the Hobo job from the F4 menu",
			func = function(ply, data)
				return true
			end
		},
		[2] = {
			name = "Build a Hobo Hut",
			desc = function(data) return string.format("Place 5 props to build a Hobo Hut. You have currently placed %i/5 props", tonumber(data) or 0) end,
			func = function(ply, data)
				local complete = data or 0
				complete = complete + 1

				return (complete == 5), complete, true
			end
		},
		[3] = {
			name = "Purchase a Donation Box",
			desc = "Purchase a Donation Box from the F4 menu",
			func = function(ply, data)
				return true
			end
		},
		[4] = {
			name = "Earn $5,000 from your Donation Box",
			desc = function(data) return string.format("Earn $5,000 from your Donation Box. You have currently earned %s/$5,000", DarkRP.formatMoney(tonumber(data) or 0)) end,
			func = function(ply, data, donation)
				local earned = tonumber(data) or 0
				earned = earned + donation

				return (earned >= 5000), earned, true
			end
		},
	}
}

-- Become a Hobo
hook.Add("PlayerChangedTeam", "Quest:Progress:homeless", function(ply, oldTeam, newTeam)
	if not (newTeam == TEAM_HOBO) then return end

	Quest.Core.ProgressQuest(ply, "homeless", 1)
end)
-- Spawned a prop
hook.Add("PlayerSpawnedProp", "Quest:Progress:homeless", function(ply)
	Quest.Core.ProgressQuest(ply, "homeless", 2)
end)
-- Purchase a Donation Box
hook.Add("playerBoughtCustomEntity", "Quest:Progress:homeless", function(ply, entTable, ent)
	if not (ent:GetClass() == "vs_donationbox") then return end

	Quest.Core.ProgressQuest(ply, "homeless", 3)
end)