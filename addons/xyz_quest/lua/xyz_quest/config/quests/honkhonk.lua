Quest.Config.Storylines["honk_honk"] ={
	name = "Honk Honk",
	id = "honk_honk",
	desc = "Delivering big loads has never been so fun",
	quests = {
		[1] = {
			name = "Become a Trucker",
			desc = "Become a Truck Driver from the F4 menu",
			func = function(ply, data)
				return true
			end
		},
		[2] = {
			name = "Collect a payload",
			desc = "Collect a payload to deliver",
			func = function(ply, data)
				return true
			end
		},
		[3] = {
			name = "Deliver the payload",
			desc = "Deliver the payload to the prompted location",
			func = function(ply, data)
				return true
			end
		},
		[4] = {
			name = "Deliver 3 payloads",
			desc = function(data) return string.format("Deliver 3 payloads. You have currently delivered %i/3", tonumber(data) or 0) end,
			func = function(ply, data)
				local delivered = data or 0
				delivered = delivered + 1

				return (delivered == 3), delivered, true
			end,
			reward = function(ply)
				Quest.Core.GiveStoryline(ply, "front_of_the_bus")
			end
		},
	}
}

-- Become a bus driver
hook.Add("PlayerChangedTeam", "Quest:Progress:honk_honk", function(ply, oldTeam, newTeam)
	if not (newTeam == TEAM_TRUCKER) then return end

	Quest.Core.ProgressQuest(ply, "honk_honk", 1)
end)