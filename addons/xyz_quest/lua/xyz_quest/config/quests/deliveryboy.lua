Quest.Config.Storylines["delivery_boy"] ={
	name = "Delivery Boy",
	id = "delivery_boy",
	desc = "Delivering small loads could be so fun",
	quests = {
		[1] = {
			name = "Become a UPS Driver",
			desc = "Become a UPS Driver from the F4 menu",
			func = function(ply, data)
				return true
			end
		},
		[2] = {
			name = "Spawn your truck",
			desc = "Spawn your delivery truck",
			func = function(ply, data)
				return true
			end
		},
		[3] = {
			name = "Deliver 5 packages",
			desc = function(data) return string.format("Deliver 5 packages. You have currently delivered %i/5", tonumber(data) or 0) end,
			func = function(ply, data)
				local delivered = data or 0
				delivered = delivered + 1

				return (delivered == 5), delivered, true
			end,
			reward = function(ply)
				Quest.Core.GiveStoryline(ply, "honk_honk")

				ply:addMoney(10000)
				XYZShit.Msg("Quests", Quest.Config.Color, "You have been given $10,000 as a bonus!", ply)
			end
		},
	}
}

-- Become a UPS driver
hook.Add("PlayerChangedTeam", "Quest:Progress:delivery_boy", function(ply, oldTeam, newTeam)
	if not (newTeam == TEAM_UPSDRIVER) then return end

	Quest.Core.ProgressQuest(ply, "delivery_boy", 1)
end)