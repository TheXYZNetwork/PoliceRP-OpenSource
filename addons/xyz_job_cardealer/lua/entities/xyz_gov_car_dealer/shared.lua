ENT.Type = "ai"
ENT.Base = "base_ai"
ENT.PrintName = "Government Cars"
ENT.Author = "Owain Owjo"
ENT.Category = "The XYZ Network Custom Stuff"
ENT.Spawnable = true
ENT.AdminSpawnable = true

ENT.CarSpawner = true
ENT.Config = {}
ENT.Config.Vehicles = {
	// Police Department
	{
		class = "forcrownvicpoltdm",
		canAccess = function(ply)
			return table.HasValue(XYZShit.Jobs.Government.Police, ply:Team())
		end,
		postSpawn = function(car)
			car:SetSkin(8)

		end,
		editable = true
	},
	{
		class = "chargersrt8poltdm",
		canAccess = function(ply)
			return table.HasValue({TEAM_SERGEANT, TEAM_MASSERGEANT, TEAM_PSERGEANTMAJOR, TEAM_PLIUTENANT, TEAM_PCAPTAIN, TEAM_PSUP, TEAM_PMAJ, TEAM_PLTC, TEAM_PCOL, TEAM_PASSCOM, TEAM_PDCOM, TEAM_PCOM}, ply:Team())
		end,
		postSpawn = function(car)
			car:SetSkin(8)
		end,
		editable = true
	},
	{
		class = "charger12poltdm",
		canAccess = function(ply)
			return table.HasValue({TEAM_SERGEANT, TEAM_MASSERGEANT, TEAM_PSERGEANTMAJOR, TEAM_PLIUTENANT, TEAM_PCAPTAIN, TEAM_PSUP, TEAM_PMAJ, TEAM_PLTC, TEAM_PCOL, TEAM_PASSCOM, TEAM_PDCOM, TEAM_PCOM}, ply:Team())
		end,
		postSpawn = function(car)
			car:SetSkin(8)
		end,
		editable = true
	},
	{
		class = "jag_xfr_pol",
		canAccess = function(ply)
			return table.HasValue({TEAM_PLIUTENANT, TEAM_PCAPTAIN, TEAM_PSUP, TEAM_PMAJ, TEAM_PLTC, TEAM_PCOL, TEAM_PASSCOM, TEAM_PDCOM, TEAM_PCOM}, ply:Team())
		end,
		postSpawn = function(car)
			car:SetSkin(2)
		end,
		editable = true
	},
	{
		class = "mitsuevoxpoltdm",
		canAccess = function(ply)
			return table.HasValue({TEAM_PCAPTAIN, TEAM_PSUP, TEAM_PMAJ, TEAM_PLTC, TEAM_PCOL, TEAM_PASSCOM, TEAM_PDCOM, TEAM_PCOM}, ply:Team())
		end,
		postSpawn = function(car)
			car:SetSkin(8)
		end,
		editable = true
	},
	{
		class = "chev_suburban_pol",
		canAccess = function(ply)
			return table.HasValue({TEAM_PSUP, TEAM_PMAJ, TEAM_PLTC, TEAM_PCOL, TEAM_PASSCOM, TEAM_PDCOM, TEAM_PCOM}, ply:Team())
		end,
		postSpawn = function(car)
			car:SetSkin(7)
		end,
		editable = true
	},
	{
		class = "smc_mustang_lapd",
		canAccess = function(ply)
			return table.HasValue({TEAM_PLTC, TEAM_PCOL, TEAM_PASSCOM, TEAM_PDCOM, TEAM_PCOM}, ply:Team())
		end,
		postSpawn = function(car)
		end,
		editable = true
	},
	{
		class = "lam_huracan_lw_lapd",
		canAccess = function(ply)
			return table.HasValue({TEAM_PCOL, TEAM_PASSCOM, TEAM_PDCOM, TEAM_PCOM}, ply:Team())
		end,
		postSpawn = function(car)
		end,
		editable = true
	},
	{
		class = "police_crsk_wmotors_fenyr_police",
		canAccess = function(ply)
			return table.HasValue({TEAM_PASSCOM, TEAM_PDCOM, TEAM_PCOM}, ply:Team())
		end,
		postSpawn = function(car)
			car:SetSkin(5)
		end,
		editable = true
	},

	// Sheriff's Department

	{
		class = "forcrownvicpoltdm",
		canAccess = function(ply)
			return table.HasValue(XYZShit.Jobs.Government.SD, ply:Team())
		end,
		postSpawn = function(car)
			car:SetSkin(6)
		end,
		editable = true
	},
	{
		class = "chargersrt8poltdm",
		canAccess = function(ply)
			return table.HasValue({TEAM_SHERIFFFIRSTCLASS, TEAM_SHERIFFMASTER, TEAM_SHERIFFCORPORAL, TEAM_SHERIFFSERGEANT, TEAM_SHERIFFLIEUTENANT, TEAM_SHERIFFCAPTAIN, TEAM_SHERIFFMAJOR, TEAM_CHIEFDEPUTY, TEAM_UNDERSHERIFF, TEAM_SHERIFF}, ply:Team())
		end,
		postSpawn = function(car)
			car:SetSkin(6)
		end,
		editable = true
	},
	{
		class = "charger12poltdm",
		canAccess = function(ply)
			return table.HasValue({TEAM_SHERIFFMASTER, TEAM_SHERIFFCORPORAL, TEAM_SHERIFFSERGEANT, TEAM_SHERIFFLIEUTENANT, TEAM_SHERIFFCAPTAIN, TEAM_SHERIFFMAJOR, TEAM_CHIEFDEPUTY, TEAM_UNDERSHERIFF, TEAM_SHERIFF}, ply:Team())
		end,
		postSpawn = function(car)
			car:SetSkin(6)
		end,
		editable = true
	},
	{
		class = "polbike_sgm",
		canAccess = function(ply)
			return table.HasValue({TEAM_SHERIFFCORPORAL, TEAM_SHERIFFSERGEANT, TEAM_SHERIFFLIEUTENANT, TEAM_SHERIFFCAPTAIN, TEAM_SHERIFFMAJOR, TEAM_CHIEFDEPUTY, TEAM_UNDERSHERIFF, TEAM_SHERIFF}, ply:Team())
		end,
		postSpawn = function(car)
		end,
		editable = true
	},
	{
		class = "chev_suburban_pol",
		canAccess = function(ply)
			return table.HasValue({TEAM_SHERIFFLIEUTENANT, TEAM_SHERIFFCAPTAIN, TEAM_SHERIFFMAJOR, TEAM_CHIEFDEPUTY, TEAM_UNDERSHERIFF, TEAM_SHERIFF}, ply:Team())
		end,
		postSpawn = function(car)
			car:SetSkin(9)
		end,
		editable = true
	},
	{
		class = "smc_mustang_gp_15",
		canAccess = function(ply)
			return table.HasValue({TEAM_SHERIFFMAJOR, TEAM_CHIEFDEPUTY, TEAM_UNDERSHERIFF, TEAM_SHERIFF}, ply:Team())
		end,
		postSpawn = function(car)
		end,
		editable = true
	},
	{
		class = "pbus",
		canAccess = function(ply)
			return table.HasValue({TEAM_SHERIFFMAJOR, TEAM_CHIEFDEPUTY, TEAM_UNDERSHERIFF, TEAM_SHERIFF}, ply:Team())
		end,
		postSpawn = function(car)
			car:SetSkin(1)
		end,
		editable = true,
		max = 1
	},
	{
		class = "crsk_ford_bronco_1982_police",
		canAccess = function(ply)
			return table.HasValue({TEAM_CHIEFDEPUTY, TEAM_UNDERSHERIFF, TEAM_SHERIFF}, ply:Team())
		end,
		postSpawn = function(car)
		end,
		editable = true
	},
	// FBI
	{
		class = "mereclasspoltdm",
		canAccess = function(ply)
			return table.HasValue(XYZShit.Jobs.Government.FBI, ply:Team())
		end,
		postSpawn = function(car)
			car:SetSkin(1)
			car:SetColor(Color(0, 0, 0, 255))
		end,
		editable = true
	},
	{
		class = "chargersrt8poltdm",
		canAccess = function(ply)
			return table.HasValue({TEAM_FBISA, TEAM_FBISSA, TEAM_FBIASAIC, TEAM_FBISAIC, TEAM_FBISSAIC, TEAM_FBIDAD, TEAM_FBIEAD, TEAM_FBIADD, TEAM_FBICOS, TEAM_FBIDD, TEAM_FBID}, ply:Team())
		end,
		postSpawn = function(car)
			car:SetSkin(0)
			car:SetColor(Color(0, 0, 0, 255))
			car:SetBodygroup(0, 2)
			car:SetBodygroup(4, 4)
		end,
		editable = true
	},
	{
		class = "perryn_2009_bmw_750li",
		canAccess = function(ply)
			return table.HasValue({TEAM_FBISSA, TEAM_FBIASAIC, TEAM_FBISAIC, TEAM_FBISSAIC, TEAM_FBIDAD, TEAM_FBIEAD, TEAM_FBIADD, TEAM_FBICOS, TEAM_FBIDD, TEAM_FBID}, ply:Team())
		end,
		postSpawn = function(car)
			car:SetColor(Color(0, 0, 0, 255))
		end,
		editable = true
	},
	{
		class = "mitsuevoxpoltdm",
		canAccess = function(ply)
			return table.HasValue({TEAM_FBIASAIC, TEAM_FBISAIC, TEAM_FBISSAIC, TEAM_FBIDAD, TEAM_FBIEAD, TEAM_FBIADD, TEAM_FBICOS, TEAM_FBIDD, TEAM_FBID}, ply:Team())
		end,
		postSpawn = function(car)
			car:SetSkin(1)
			car:SetColor(Color(0, 0, 0, 255))
		end,
		editable = true
	},
	{
		class = "jag_xfr_pol_und",
		canAccess = function(ply)
			return table.HasValue({TEAM_FBISAIC, TEAM_FBISSAIC, TEAM_FBIDAD, TEAM_FBIEAD, TEAM_FBIADD, TEAM_FBICOS, TEAM_FBIDD, TEAM_FBID}, ply:Team())
		end,
		postSpawn = function(car)
		end,
		editable = true
	},
	{
		class = "perryn_sprinter_armed_transport",
		canAccess = function(ply)
			return table.HasValue({TEAM_FBISSAIC, TEAM_FBIDAD, TEAM_FBIEAD, TEAM_FBIADD, TEAM_FBICOS, TEAM_FBIDD, TEAM_FBID}, ply:Team())
		end,
		postSpawn = function(car)
			car:SetSkin(3)
		end,
		editable = true,
		max = 2
	},
	{
		class = "perryn_cadillac_dts_limousine",
		canAccess = function(ply)
			return table.HasValue({TEAM_FBISAIC, TEAM_FBISSAIC, TEAM_FBIDAD, TEAM_FBIEAD, TEAM_FBIADD, TEAM_FBICOS, TEAM_FBIDD, TEAM_FBID}, ply:Team())
		end,
		postSpawn = function(car)
		end,
		editable = true,
		max = 1
	},
	{
		class = "chev_suburban_pol_und",
		canAccess = function(ply)
			return table.HasValue({TEAM_FBIEAD, TEAM_FBIADD, TEAM_FBICOS, TEAM_FBIDD, TEAM_FBID}, ply:Team())
		end,
		postSpawn = function(car)
			car:SetColor(Color(0, 0, 0, 255))
		end,
		editable = true
	},
	{
		class = "mcc",
		canAccess = function(ply)
			return table.HasValue({TEAM_FBIADD, TEAM_FBICOS, TEAM_FBIDD, TEAM_FBID}, ply:Team())
		end,
		postSpawn = function(car)
			car:SetSkin(4)
		end,
		editable = true,
		max = 1
	},
	{
		class = "15camaro_cop_sgm",
		canAccess = function(ply)
			return table.HasValue({TEAM_FBICOS, TEAM_FBIDD, TEAM_FBID}, ply:Team())
		end,
		postSpawn = function(car)
			car:SetColor(Color(0, 0, 0, 255))
		end,
		editable = true
	},
	// SWAT
	{
		class = "charger12poltdm",
		canAccess = function(ply)
			return table.HasValue(XYZShit.Jobs.Government.SWAT, ply:Team())
		end,
		postSpawn = function(car)
			car:SetSkin(2)
		end,
		editable = true
	},
	{
		class = "perryn_bearcat_g3",
		canAccess = function(ply)
			return table.HasValue(XYZShit.Jobs.Government.SWAT, ply:Team())
		end,
		postSpawn = function(car)
			car:SetSkin(2)
		end,
		editable = true,
		max = 2
	},
	{
		class = "chev_tahoe_police_lw",
		canAccess = function(ply)
			return table.HasValue({TEAM_SWATCOL, TEAM_SWATLTCOL, TEAM_SWATMAJOR, TEAM_SWATLEADER, TEAM_SWATSUP, TEAM_SWATCTU}, ply:Team())
		end,
		postSpawn = function(car)
		end,
		editable = true
	},
	{
		class = "17raptor_cop_sgm",
		canAccess = function(ply)
			return table.HasValue({TEAM_SWATCOL, TEAM_SWATLTCOL, TEAM_SWATMAJOR, TEAM_SWATLEADER, TEAM_SWATSUP}, ply:Team())
		end,
		postSpawn = function(car)
		end,
		editable = false,
		max = 2
	},
	{
		class = "chev_suburban_pol_und",
		canAccess = function(ply)
			return table.HasValue({TEAM_SWATCOL, TEAM_SWATLTCOL, TEAM_SWATMAJOR}, ply:Team())
		end,
		postSpawn = function(car)
			car:SetColor(Color(0, 0, 0, 255))
		end,
		editable = true
	},
	{
		class = "15camaro_cop_sgm",
		canAccess = function(ply)
			return table.HasValue({TEAM_SWATLEADER, TEAM_SWATMAJOR, TEAM_SWATLTCOL, TEAM_SWATCOL}, ply:Team())
		end,
		postSpawn = function(car)
			car:SetColor(Color(0, 0, 0, 255))
		end,
		editable = true
	},
	{
		class = "mcc",
		canAccess = function(ply)
			return table.HasValue({TEAM_SWATCOL, TEAM_SWATLTCOL, TEAM_SWATMAJOR, TEAM_SWATLEADER, TEAM_SWATSUP}, ply:Team())
		end,
		postSpawn = function(car)
			car:SetSkin(3)
		end,
		editable = true,
		max = 1
	},
	// Fire & Rescue
	{
		class = "forcrownvicpoltdm",
		canAccess = function(ply)
			return table.HasValue(XYZShit.Jobs.Government.FR, ply:Team())
		end,
		postSpawn = function(car)
			car:SetSkin(2)
		end,
		editable = true
	},
	{
		class = "ford_f350_ambu_lw",
		canAccess = function(ply)
			return table.HasValue({TEAM_FR_F, TEAM_FR_SF, TEAM_FR_E, TEAM_FR_SE, TEAM_FR_SUP, TEAM_FR_LT, TEAM_FR_CPT, TEAM_FR_BC, TEAM_FR_DC, TEAM_FR_AC, TEAM_FR_FC}, ply:Team())
		end,
		postSpawn = function(car)
			car:SetSkin(5)
		end,
		editable = true
	},
	{
		class = "perryn_pierce_pumper",
		canAccess = function(ply)
			return table.HasValue({TEAM_FR_E, TEAM_FR_SE, TEAM_FR_SUP, TEAM_FR_LT, TEAM_FR_CPT, TEAM_FR_BC, TEAM_FR_DC, TEAM_FR_AC, TEAM_FR_FC}, ply:Team())
		end,
		postSpawn = function(car)
		end,
		editable = true,
		max = 2
	},
	{
		class = "chev_suburban_pol",
		canAccess = function(ply)
			return table.HasValue({TEAM_FR_BC, TEAM_FR_DC, TEAM_FR_AC, TEAM_FR_FC}, ply:Team())
		end,
		postSpawn = function(car)
			car:SetSkin(8)
		end,
		editable = true
	},
}