DMV.Config.Color = Color(22, 170, 120)
DMV.Config.MaxPoints = 10
hook.Add("loadCustomDarkRPItems", "xyzDMVSetupConfig", function()
	DMV.Config.PointManager = {
        [TEAM_SHERIFFLIEUTENANT] = true,
        [TEAM_SHERIFFCAPTAIN] = true,
        [TEAM_SHERIFFMAJOR] = true,
        [TEAM_CHIEFDEPUTY] = true,
        [TEAM_UNDERSHERIFF] = true,
        [TEAM_SHERIFF] = true,
    
        [TEAM_PLIUTENANT] = true,
        [TEAM_PCAPTAIN] = true,
        [TEAM_PSUP] = true,
        [TEAM_PMAJ] = true,
        [TEAM_PLTC] = true,
        [TEAM_PCOL] = true,
        [TEAM_PASSCOM] = true,
        [TEAM_PDCOM] = true,
        [TEAM_PCOM] = true,
    }
end)