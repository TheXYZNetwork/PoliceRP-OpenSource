ENT.Type = "ai"
ENT.Base = "base_ai"
ENT.PrintName = "Weapon Armory"
ENT.Author = "Owain Owjo"
ENT.Category = "The XYZ Network Custom Stuff"
ENT.Spawnable = true
ENT.AdminSpawnable = true

-- XYZArmoryItems = {
-- 	[1] = {
-- 		class = "cw_ak74",
-- 		check = function(ply)
-- 			return table.HasValue(XYZShit.Jobs.USMC.Jobs, ply:Team())
-- 		end
-- 	},
-- 	[2] = {
-- 		class = "cw_ar15",
-- 		check = function(ply)
--   			return table.HasValue({TEAM_BLAH1, BLAH2}, ply:Team())
-- 		end
-- 	},
-- }

XYZArmoryItems = {
	-- Police Department
	{
		class = "cw_ump45",
		check = function(ply)
			return table.HasValue({TEAM_PCORP, TEAM_SERGEANT, TEAM_MASSERGEANT, TEAM_PSERGEANTMAJOR, TEAM_PLIUTENANT, TEAM_PCAPTAIN, TEAM_PSUP, TEAM_PMAJ, TEAM_PLTC, TEAM_PCOL, TEAM_PASSCOM, TEAM_PDCOM, TEAM_PCOM}, ply:Team())
		end
	},
	{
		class = "cw_m3super90",
		check = function(ply)
			return table.HasValue({TEAM_SERGEANT, TEAM_MASSERGEANT, TEAM_PSERGEANTMAJOR, TEAM_PLIUTENANT, TEAM_PCAPTAIN, TEAM_PSUP, TEAM_PMAJ, TEAM_PLTC, TEAM_PCOL, TEAM_PASSCOM,TEAM_PDCOM,TEAM_PCOM}, ply:Team())
		end
	},
	{
		class = "cw_mp5",
		check = function(ply)
			return table.HasValue({TEAM_PLIUTENANT, TEAM_PCAPTAIN, TEAM_PSUP, TEAM_PMAJ, TEAM_PLTC, TEAM_PCOL, TEAM_PASSCOM, TEAM_PDCOM, TEAM_PCOM}, ply:Team())
		end
	},
	{
		class = "cw_ar15",
		check = function(ply)
			return table.HasValue({TEAM_PASSCOM, TEAM_PDCOM, TEAM_PCOM}, ply:Team())
		end
	},
	-- Sheriff Department
	{
		class = "cw_g3a3",
		check = function(ply)
			return table.HasValue({TEAM_SHERIFFLIEUTENANT, TEAM_SHERIFFCAPTAIN, TEAM_SHERIFFMAJOR, TEAM_CHIEFDEPUTY, TEAM_UNDERSHERIFF, TEAM_SHERIFF}, ply:Team())
		end
	},
	-- FBI
	{
		class = "cw_mp5",
		check = function(ply)
			return table.HasValue({TEAM_FBISSA, TEAM_FBIASAIC, TEAM_FBISAIC, TEAM_FBISSAIC, TEAM_FBIDAD, TEAM_FBIEAD, TEAM_FBIADD, TEAM_FBICOS, TEAM_FBIDD, TEAM_FBID}, ply:Team())
		end
	},
	{
		class = "cw_ump45",
		check = function(ply)
			return table.HasValue({TEAM_FBIDAD, TEAM_FBIEAD, TEAM_FBIADD, TEAM_FBICOS, TEAM_FBIDD, TEAM_FBID}, ply:Team())
		end
	},
	-- SWAT
	{
		class = "heavy_shield",
		check = function(ply)
			return table.HasValue({TEAM_SWATCTU, TEAM_SWATSUP, TEAM_SWATLEADER, TEAM_SWATMAJOR, TEAM_SWATLTCOL, TEAM_SWATCOL}, ply:Team())
		end
	},
	{
		class = "deployable_shield",
		check = function(ply)
			return table.HasValue({TEAM_SWATSUP, TEAM_SWATLEADER, TEAM_SWATMAJOR, TEAM_SWATLTCOL, TEAM_SWATCOL}, ply:Team())
		end
	},
	{
		class = "riot_shield",
		check = function(ply)
			return table.HasValue(XYZShit.Jobs.Government.SWAT, ply:Team())
		end
	},
	{
		class = "cw_ar15",
		check = function(ply)
			return table.HasValue({TEAM_SWATLTCOL, TEAM_SWATCOL}, ply:Team())
		end
	},
	{
		class = "khr_m82a3",
		check = function(ply)
			return table.HasValue({TEAM_SWATLEADER, TEAM_SWATMAJOR, TEAM_SWATLTCOL, TEAM_SWATCOL}, ply:Team())
		end
	},
	{
		class = "cw_m3super90_beanbag",
		check = function(ply)
			return table.HasValue({TEAM_SHERIFFLIEUTENANT, TEAM_SHERIFFCAPTAIN, TEAM_SHERIFFMAJOR, TEAM_CHIEFDEPUTY, TEAM_UNDERSHERIFF, TEAM_SHERIFF, TEAM_SWATCTU, TEAM_SWATSUP, TEAM_SWATLEADER, TEAM_SWATMAJOR, TEAM_SWATLTCOL, TEAM_SWATCOL}, ply:Team())
		end
	}
}

XYZArmoryCap = {
	[TEAM_PLTC] 		= 2,
	[TEAM_PCOL] 		= 2,
	[TEAM_PDCOM] 		= 3,
	[TEAM_PCOM] 		= 3,
  	[TEAM_PASSCOM] 		= 3,

	[TEAM_SWATMAJOR]	= 2,
	[TEAM_SWATLTCOL] 	= 2,
	[TEAM_SWATCOL] 		= 3
}