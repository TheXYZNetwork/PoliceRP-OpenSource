-- The chat and UI colors
GovBadgeID.Config.Color = Color(22, 120, 170)

-- Use this hook to load the addon post DarkRP
hook.Add("loadCustomDarkRPItems","GovBadgeID:LoadTags", function()
	-- The job Prefixes
	GovBadgeID.Config.JobPrefix = {
		-- Police
		[TEAM_POFFICER]			= "OFC",
		[TEAM_PSENOFFICER]		= "SNR",
		[TEAM_PLANCORP]			= "LCPL",
		[TEAM_PCORP]			= "CPL",
		[TEAM_SERGEANT]			= "SGT",
		[TEAM_MASSERGEANT]		= "MSGT",
		[TEAM_PSERGEANTMAJOR]	= "SGTMAJ",
		[TEAM_PLIUTENANT]		= "LT",
		[TEAM_PCAPTAIN]			= "CPT",
		[TEAM_PSUP]				= "SUPT",
		[TEAM_PMAJ]				= "MAJ",
		[TEAM_PLTC]				= "DEPTCHIEF",
		[TEAM_PCOL]				= "D.CHIEF",
		[TEAM_PASSCOM]			= "A.COMM",
		[TEAM_PDCOM]			= "DEPTCOMM",
		[TEAM_PCOM]				= "COMM",

		-- HP
		[TEAM_SHERIFFTROOPER]		= "DEP",
		[TEAM_SHERIFFFIRSTCLASS]	= "DFC",
		[TEAM_SHERIFFMASTER]		= "MST",
		[TEAM_SHERIFFCORPORAL]		= "CPL",
		[TEAM_SHERIFFSERGEANT]		= "SGT",
		[TEAM_SHERIFFLIEUTENANT]	= "LT",
		[TEAM_SHERIFFCAPTAIN]		= "CPT",
		[TEAM_SHERIFFMAJOR]			= "MAJ",
		[TEAM_CHIEFDEPUTY]			= "CHIEF",
		[TEAM_UNDERSHERIFF]			= "U.SHERIFF",
		[TEAM_SHERIFF]				= "SHERIFF",

		-- FBI
		[TEAM_FBIPA]			= "PA",
		[TEAM_FBISA] 			= "SA",
		[TEAM_FBISSA] 			= "SSA",
		[TEAM_FBIASAIC] 		= "ASAIC",
		[TEAM_FBISAIC]			= "SAIC",
		[TEAM_FBISSAIC] 		= "SSAIC",
		[TEAM_FBIDAD] 			= "DAD",
		[TEAM_FBIEAD] 			= "EAD",
		[TEAM_FBIADD] 			= "ADD",
		[TEAM_FBICOS] 			= "COS",
		[TEAM_FBIDD]			= "DDIR",
		[TEAM_FBID]				= "DIR",

		-- SWAT
		[TEAM_SWATRIFLE]		= "RIFLEMAN",
		[TEAM_SWATCQC]			= "CQC",
		[TEAM_SWATMED]			= "MEDIC",
		[TEAM_SWATBRE]			= "BREACHER",
		[TEAM_SWATMRK]			= "MKM",
		[TEAM_SWATSNP]			= "SNIPER",
		[TEAM_SWATCTU]			= "CTU",
		[TEAM_SWATSUP]			= "LT",
		[TEAM_SWATLEADER] 		= "CPT",
		[TEAM_SWATMAJOR]		= "MAJ",
		[TEAM_SWATLTCOL]		= "LTCOL",
		[TEAM_SWATCOL] 			= "COL",

		-- Fire & Rescue
		[TEAM_FR_CF]				= "CAND",
		[TEAM_FR_JF]				= "JNR",
		[TEAM_FR_F]					= "FF",
		[TEAM_FR_SF]				= "SNR",
		[TEAM_FR_E]					= "ENG",
		[TEAM_FR_SE]				= "SNRENG",
		[TEAM_FR_SUP]				= "SUP",
		[TEAM_FR_LT]				= "LT",
		[TEAM_FR_CPT]				= "CPT",
		[TEAM_FR_BC]				= "B.CHIEF",
		[TEAM_FR_DC]				= "D.CHIEF",
		[TEAM_FR_AC]				= "A.CHIEF",
		[TEAM_FR_FC]				= "F.CHIEF",
	}
end)