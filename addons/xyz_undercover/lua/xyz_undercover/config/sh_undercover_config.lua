xUndercover.Config = xUndercover.Config or {}

hook.Add("loadCustomDarkRPItems", "xUndercoverSetupConfig", function()
	-- The jobs that are allowed to use the NPC.
	-- TODO: Dynamically add all FBI jobs
	xUndercover.Config.AllowedJobs = {
		[TEAM_FBIPA]	= true,
		[TEAM_FBISA] 	= true,
		[TEAM_FBISSA] 	= true,
		[TEAM_FBIASAIC] = true,
		[TEAM_FBISAIC]	= true,
		[TEAM_FBISSAIC] = true,
		[TEAM_FBIDAD] 	= true,
		[TEAM_FBIEAD] 	= true,
		[TEAM_FBIADD] 	= true,
		[TEAM_FBICOS] 	= true,
		[TEAM_FBIDD]	= true,
		[TEAM_FBID]		= true,
	}
	-- The jobs that can be used to go undercover as.
	-- Dont worry about VIP/Elite jobs, I check if the customCheck passes
	xUndercover.Config.UndercoverJobs = { 
		[TEAM_CITIZEN] 			= true,
		[TEAM_HOBO]				= true,
		[TEAM_GUND] 			= true,
		[TEAM_GUARD]			= true,
		[TEAM_PD_KER]			= true,
		
		[TEAM_BLOODzL]			= true,
		[TEAM_BLOODz]			= true,
		[TEAM_CRIPSL]			= true,
		[TEAM_CRIPS]			= true,
		[TEAM_THIEF] 			= true,
		[TEAM_DRUGDEALER]		= true,
		[TEAM_HITMAN]			= true,

		[TEAM_PTHIEF]			= true,
		[TEAM_ELITEHITMAN]		= true,
		[TEAM_KINGBLOODZ]		= true,
		[TEAM_KINGCRIPS]		= true,
		[TEAM_BTHIEF]			= true,
		[TEAM_TAXI]				= true,
		[TEAM_HACKER]			= true,

		[TEAM_BOUNTYHUNTER]		= true,
		[TEAM_ELITETHIEF]		= true,
		[TEAM_OVERLORDBLOODZ]	= true,
		[TEAM_OVERLORDCRIPS]	= true,
		[TEAM_DRUGLORD]			= true,
		[TEAM_BUS]				= true,
		[TEAM_NEWSR]			= true,
		[TEAM_NEWSC]			= true,
		[TEAM_MECHANIC]			= true,

	}
end)