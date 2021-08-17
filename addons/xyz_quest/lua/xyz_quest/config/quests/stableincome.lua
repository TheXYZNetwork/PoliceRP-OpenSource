Quest.Config.Storylines["stable_income"] ={
	name = "Stable Income",
	id = "stable_income",
	desc = "Start your own business, the legal way",
	quests = {
		[1] = {
			name = "Become a Gun Dealer",
			desc = "Become the Gun Dealer job from the F4 menu",
			func = function(ply, data)
				return true
			end
		},
		[2] = {
			name = "Purchase a Cash Register",
			desc = "Purchase a Cash Register from the F4 menu",
			func = function(ply, data)
				return true
			end
		},
		[3] = {
			name = "Add 5 weapons to your Cash Register",
			desc = function(data) return string.format("Add 5 items to your cash register. You have currently added %i/5", tonumber(data) or 0) end,
			func = function(ply, data)
				local complete = data or 0
				complete = complete + 1

				return (complete == 5), complete, true
			end
		},
		[4] = {
			name = "Sell 5 weapons from your Cash Register",
			desc = function(data) return string.format("Sell 5 items from your cash register. You have currently sold %i/5", tonumber(data) or 0) end,
			func = function(ply, data)
				local complete = data or 0
				complete = complete + 1

				return (complete == 5), complete, true
			end
		},
	}
}

-- Beomce a Gun Dealer
hook.Add("PlayerChangedTeam", "Quest:Progress:stable_income", function(ply, oldTeam, newTeam)
	if not (newTeam == TEAM_GUND) then return end

	Quest.Core.ProgressQuest(ply, "stable_income", 1)
end)
-- Purchase a Cash Register
hook.Add("playerBoughtCustomEntity", "Quest:Progress:stable_income", function(ply, entTable, ent)
	if not (ent:GetClass() == "xyz_cash_register") then return end

	Quest.Core.ProgressQuest(ply, "stable_income", 2)
end)