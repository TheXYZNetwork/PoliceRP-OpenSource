hook.Add("loadCustomDarkRPItems", "XYZJobTrackerConfig", function()
	timer.Simple(0, function()
		XYZTracker.Config.Filter = {
			pd = {
				perms = {TEAM_PLIUTENANT, TEAM_PCAPTAIN, TEAM_PSUP, TEAM_PMAJ, TEAM_PLTC, TEAM_PCOL, TEAM_PASSCOM, TEAM_PDCOM, TEAM_PCOM},
				jobs = XYZShit.Jobs.Government.Police
			},
			sd = {
				perms = {TEAM_SHERIFFLIEUTENANT, TEAM_SHERIFFCAPTAIN, TEAM_SHERIFFMAJOR, TEAM_CHIEFDEPUTY, TEAM_UNDERSHERIFF, TEAM_SHERIFF},
				jobs = XYZShit.Jobs.Government.SD
			},
			fbi = {
				perms = {TEAM_FBIDAD, TEAM_FBIEAD, TEAM_FBIADD, TEAM_FBICOS, TEAM_FBIDD, TEAM_FBID},
				jobs = XYZShit.Jobs.Government.FBI
			},
			swat = {
				perms = {TEAM_SWATSUP, TEAM_SWATLEADER, TEAM_SWATCOL, TEAM_SWATLTCOL, TEAM_SWATMAJOR},
				jobs = XYZShit.Jobs.Government.SWAT
			},
			firerescue = {
				perms = {TEAM_FR_SUP, TEAM_FR_LT, TEAM_FR_CPT, TEAM_FR_BC, TEAM_FR_DC, TEAM_FR_AC, TEAM_FR_FC},
				jobs = XYZShit.Jobs.Government.FR
			},
			terrorist = {
				perms = {TEAM_TERRORIST_LEAD, TEAM_TERRORIST_COLEAD, TEAM_TERRORIST_CHIEF, TEAM_TERRORIST_SNRCMDR, TEAM_TERRORIST_CMDR, TEAM_TERRORIST_GOVNR},
				jobs = XYZShit.Jobs.Criminals.Terrorists
			},
			mafia = {
				perms = {TEAM_SCCAPOREGIME, TEAM_LTBOSS, TEAM_SCUNDERBOSS, TEAM_SCBOSS, TEAM_SCCONSIGLIERE, TEAM_SCGODFATHER},
				jobs = XYZShit.Jobs.Criminals.SinaloaCartel
			}
		}
	end)
end)