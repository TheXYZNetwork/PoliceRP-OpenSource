Quest.Config.Storylines["front_of_the_bus"] ={
	name = "Front of the Bus",
	id = "front_of_the_bus",
	desc = "Nothing is more rewarding than helping people reach their destination",
	quests = {
		[1] = {
			name = "Become a Bus Driver",
			desc = "Become a Bus Driver from the F4 menu",
			func = function(ply, data)
				return true
			end
		},
		[2] = {
			name = "Pick up 3 passengers",
			desc = function(data) return string.format("Pick up 3 passengers. You have currently picked up %i/3", tonumber(data) or 0) end,
			func = function(ply, data)
				local passangers = data or 0
				passangers = passangers + 1

				return (passangers == 3), passangers, true
			end
		},
		[3] = {
			name = "Earn $1,000 from passengers",
			desc = function(data) return string.format("Earn $1,000 from passengers. You have currently earned %s/$1,000", DarkRP.formatMoney(tonumber(data) or 0)) end,
			func = function(ply, data, amount)
				local earned = data or 0
				earned = earned + amount

				return (earned >= 1000), earned, true
			end,
			reward = function(ply)
				ply:addMoney(10000)
				XYZShit.Msg("Quests", Quest.Config.Color, "You have been given $10,000 as a bonus!", ply)
			end
		},
	}
}

-- Become a bus driver
hook.Add("PlayerChangedTeam", "Quest:Progress:front_of_the_bus", function(ply, oldTeam, newTeam)
	if not (newTeam == TEAM_BUS) then return end

	Quest.Core.ProgressQuest(ply, "front_of_the_bus", 1)
end)