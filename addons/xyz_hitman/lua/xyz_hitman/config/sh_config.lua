XYZ_HITMAN.Config.Color = Color(162, 117, 76)
XYZ_HITMAN.Config.MinPrice = 25000
XYZ_HITMAN.Config.HitmanJobs = XYZ_HITMAN.Config.HitmanJobs or {}
XYZ_HITMAN.Config.BlacklistedJobs = XYZ_HITMAN.Config.BlacklistedJobs or {}

hook.Add("loadCustomDarkRPItems", "HitmanConfig", function()

	XYZ_HITMAN.Config.HitmanJobs = {
		[TEAM_HITMAN] = true,
		[TEAM_ELITEHITMAN] = true,
		[TEAM_BOUNTYHUNTER] = true,
	}

	XYZ_HITMAN.Config.BlacklistedJobs = {
	}

	for k, v in pairs(RPExtraTeams) do
		if v.category == "Fire & Rescue" then
			XYZ_HITMAN.Config.BlacklistedJobs[v.team] = true
		end
	end

end)