hook.Add("loadCustomDarkRPItems", "xWhitelistLoadConfig", function()
	xWhitelist.Config.WhitelistedJobs = {}
	
	for k, v in pairs(RPExtraTeams) do
		local category = v.category
		if category == "Police Force" then
			xWhitelist.Config.WhitelistedJobs[v.command] = true
		end
		if category == "FBI" then
			xWhitelist.Config.WhitelistedJobs[v.command] = true
		end
		if category == "Swat" then
			xWhitelist.Config.WhitelistedJobs[v.command] = true
		end
		if category == "Fire & Rescue" then
			xWhitelist.Config.WhitelistedJobs[v.command] = true
		end
		if category == "Sheriff's Department" then
			xWhitelist.Config.WhitelistedJobs[v.command] = true
		end
		-- Criminal Jobs
		if category == "Terrorist" then
			xWhitelist.Config.WhitelistedJobs[v.command] = true
		end
		if category == "The Mafia" then
			xWhitelist.Config.WhitelistedJobs[v.command] = true
		end
		if category == "Custom Job" then
			xWhitelist.Config.WhitelistedJobs[v.command] = true
		end
	end

	xWhitelist.Config.BlacklistedJobs = {
		["policeofficer"] 				= true,
		["policeleutenant"]				= true,
		["sheriffdeputy"] 				= true,
		["fbipa"] 						= true,
		["swatrifle"] 					= true,
		["frcf"] 						= true,
		["terroristrecruit"] 			= true,
		["scjrassociate"] 				= true,
		["mechanic"] 					= true,
		["trucker"] 					= true,
		["upsdriver"]					= true,
		["taxidriver"]					= true,
		["busdriver"]					= true
	}




	xWhitelist.Config.WhitelistPermissions = {
		[TEAM_PLIUTENANT] = {
			["policeofficer"] 			= true,
			["policeseniorofficer"] 	= true,
			["policelancecorporal"] 	= true,
			["policecorporal"] 			= true,
			["policesergeant"] 			= true
		},
		[TEAM_PCAPTAIN] = {
			["policeofficer"] 			= true,
			["policeseniorofficer"] 	= true,
			["policelancecorporal"] 	= true,
			["policecorporal"] 			= true,
			["policesergeant"] 			= true,
			["policemastersergeant"]	= true
		},
		[TEAM_PSUP] = {
			["policeofficer"] 			= true,
			["policeseniorofficer"] 	= true,
			["policelancecorporal"] 	= true,
			["policecorporal"] 			= true,
			["policesergeant"] 			= true,
			["policemastersergeant"] 	= true,
			["policesergeantmajor"]		= true
		},
		[TEAM_PMAJ] = {
			["policeofficer"] 			= true,
			["policeseniorofficer"] 	= true,
			["policelancecorporal"] 	= true,
			["policecorporal"] 			= true,
			["policesergeant"] 			= true,
			["policemastersergeant"] 	= true,
			["policesergeantmajor"]		= true,
			["policeleutenant"]			= true,
			["policecaptain"] 			= true
		},
		[TEAM_PLTC] = {
			["policeofficer"] 			= true,
			["policeseniorofficer"] 	= true,
			["policelancecorporal"] 	= true,
			["policecorporal"] 			= true,
			["policesergeant"] 			= true,
			["policemastersergeant"] 	= true,
			["policesergeantmajor"]		= true,
			["policeleutenant"]			= true,
			["policecaptain"] 			= true,
			["policesuperindentent"] 	= true
		},
		[TEAM_PCOL] = {
			["policeofficer"] 			= true,
			["policeseniorofficer"] 	= true,
			["policelancecorporal"] 	= true,
			["policecorporal"] 			= true,
			["policesergeant"] 			= true,
			["policemastersergeant"] 	= true,
			["policesergeantmajor"]		= true,
			["policeleutenant"]			= true,
			["policecaptain"] 			= true,
			["policesuperindentent"] 	= true,
			["policeMajor"] 			= true,
			["policelieucorporal"] 		= true
		},
		[TEAM_PASSCOM] = {
			["policeofficer"] 			= true,
			["policeseniorofficer"] 	= true,
			["policelancecorporal"] 	= true,
			["policecorporal"] 			= true,
			["policesergeant"] 			= true,
			["policemastersergeant"] 	= true,
			["policesergeantmajor"]		= true,
			["policeleutenant"]			= true,
			["policecaptain"] 			= true,
			["policesuperindentent"] 	= true,
			["policeMajor"] 			= true,
			["policelieucorporal"] 		= true
		},
		[TEAM_PDCOM] = {
			["policeofficer"]			= true,
			["policeseniorofficer"] 	= true,
			["policelancecorporal"] 	= true,
			["policecorporal"] 			= true,
			["policesergeant"] 			= true,
			["policemastersergeant"] 	= true,
			["policesergeantmajor"]		= true,
			["policeleutenant"]			= true,
			["policecaptain"] 			= true,
			["policesuperindentent"] 	= true,
			["policeMajor"] 			= true,
			["policelieucorporal"] 		= true,
			["policecolonel"] 			= true,
			["policeass"] 				= true
		},
		[TEAM_PCOM] = {
			["policeofficer"] 			= true,
			["policeseniorofficer"] 	= true,
			["policelancecorporal"] 	= true,
			["policecorporal"] 			= true,
			["policesergeant"] 			= true,
			["policemastersergeant"] 	= true,
			["policesergeantmajor"]		= true,
			["policeleutenant"]			= true,
			["policecaptain"] 			= true,
			["policesuperindentent"] 	= true,
			["policeMajor"] 			= true,
			["policelieucorporal"] 		= true,
			["policecolonel"] 			= true,
			["policeass"] 				= true,
			["policedeputycomissioner"] = true
		},
	
		[TEAM_SHERIFFLIEUTENANT] = {
			["sheriffdeputy"] 			= true,
			["sherifffirstclass"] 		= true,
			["sheriffmaster"] 			= true,
			["k9dogsh"] 				= true
		},
		[TEAM_SHERIFFCAPTAIN] = {
			["sheriffdeputy"] 			= true,
			["sherifffirstclass"] 		= true,
			["sheriffmaster"] 			= true,
			["sheriffcorporal"] 		= true,
			["k9dogsh"] 				= true
		},
		[TEAM_SHERIFFMAJOR] = {
			["sheriffdeputy"] 			= true,
			["sherifffirstclass"] 		= true,
			["sheriffmaster"] 			= true,
			["sheriffcorporal"] 		= true,
			["sheriffsergeant"] 		= true,
			["k9dogsh"] 				= true
		},
		[TEAM_CHIEFDEPUTY] = {
			["sheriffdeputy"] 			= true,
			["sherifffirstclass"] 		= true,
			["sheriffmaster"] 			= true,
			["sheriffcorporal"] 		= true,
			["sheriffsergeant"] 		= true,
			["sherifflieutenant"] 		= true,
			["sheriffrcaptain"] 		= true,
			["sheriffmajor"] 			= true,
			["k9dogsh"] 				= true
		},
		[TEAM_UNDERSHERIFF] = {
			["sheriffdeputy"] 			= true,
			["sherifffirstclass"] 		= true,
			["sheriffmaster"] 			= true,
			["sheriffcorporal"] 		= true,
			["sheriffsergeant"] 		= true,
			["sherifflieutenant"] 		= true,
			["sheriffrcaptain"] 		= true,
			["sheriffmajor"] 			= true,
			["k9dogsh"] 				= true
		},
		[TEAM_SHERIFF] = {
			["sheriffdeputy"] 			= true,
			["sherifffirstclass"] 		= true,
			["sheriffmaster"] 			= true,
			["sheriffcorporal"] 		= true,
			["sheriffsergeant"] 		= true,
			["sherifflieutenant"]		= true,
			["sheriffrcaptain"] 		= true,
			["sheriffmajor"] 			= true,
			["chiefdeputy"] 			= true,
			["Undersheriff"] 			= true,
			["k9dogsh"] 				= true
		},
	
		[TEAM_SWATSUP] = {
			["swatrifle"] 				= true,
			["swatqcq"]					= true,
			["swatmedic"] 				= true,
			["swatbre"] 				= true,
			["swatmrk"] 				= true,
			["swatsnp"] 				= true
		},
		[TEAM_SWATLEADER] = {
			["swatrifle"] 				= true,
			["swatqcq"]					= true,
			["swatmedic"] 				= true,
			["swatbre"] 				= true,
			["swatmrk"] 				= true,
			["swatsnp"] 				= true,
			["swatctu"]					= true,
			["swatsup"] 				= true
		},
		[TEAM_SWATMAJOR] = {
			["swatrifle"] 				= true,
			["swatqcq"]					= true,
			["swatmedic"] 				= true,
			["swatbre"] 				= true,
			["swatmrk"] 				= true,
			["swatsnp"] 				= true,
			["swatctu"]					= true,
			["swatsup"] 				= true
		},
		[TEAM_SWATLTCOL] = {
			["swatrifle"] 				= true,
			["swatqcq"]					= true,
			["swatmedic"] 				= true,
			["swatbre"] 				= true,
			["swatmrk"] 				= true,
			["swatsnp"] 				= true,
			["swatctu"]					= true,
			["swatsup"] 				= true,
			["swatleader"]				= true,
			["swatmajor"]				= true
		},
		[TEAM_SWATCOL] = {
			["swatrifle"] 				= true,
			["swatqcq"]					= true,
			["swatmedic"] 				= true,
			["swatbre"] 				= true,
			["swatmrk"] 				= true,
			["swatsnp"] 				= true,
			["swatctu"]					= true,
			["swatsup"] 				= true,
			["swatleader"]				= true,
			["swatmajor"]				= true,
			["swatltcol"] 				= true
		},

		[TEAM_FBIDAD] = {
			["fbipa"] 					= true,
			["fbisa"] 					= true,
			["fbissa"] 					= true,
			["fbiasaic"] 				= true
		},
		[TEAM_FBIEAD] = {
			["fbipa"] 					= true,
			["fbisa"] 					= true,
			["fbissa"] 					= true,
			["fbiasaic"] 				= true,
			["fbisaic"] 				= true
		},
		[TEAM_FBIADD] = {
			["fbipa"] 					= true,
			["fbisa"] 					= true,
			["fbissa"] 					= true,
			["fbiasaic"] 				= true,
			["fbisaic"] 				= true,
			["fbissaic"]				= true
		},
		[TEAM_FBICOS] = {
			["fbipa"] 					= true,
			["fbisa"] 					= true,
			["fbissa"] 					= true,
			["fbiasaic"] 				= true,
			["fbisaic"] 				= true,
			["fbissaic"]				= true,
			["fbidad"] 					= true,
			["fbiead"] 					= true,
			["fbiadd"] 					= true
		},
		[TEAM_FBIDD] = {
			["fbipa"] 					= true,
			["fbisa"] 					= true,
			["fbissa"] 					= true,
			["fbiasaic"] 				= true,
			["fbisaic"] 				= true,
			["fbissaic"]				= true,
			["fbidad"] 					= true,
			["fbiead"] 					= true,
			["fbiadd"] 					= true,
			["fbicos"] 					= true
		},
		[TEAM_FBID] = {
			["fbipa"] 					= true,
			["fbisa"] 					= true,
			["fbissa"] 					= true,
			["fbiasaic"] 				= true,
			["fbisaic"] 				= true,
			["fbissaic"]				= true,
			["fbidad"] 					= true,
			["fbiead"] 					= true,
			["fbiadd"] 					= true,
			["fbicos"] 					= true,
			["fbidd"] 					= true
		},

		[TEAM_SCCAPOREGIME] = {
			["scjrassociate"] 			= true,
			["scassociate"] 			= true,
			["scsassociate"] 			= true,
			["schassociate"] 			= true,
			["jrsicario"] 				= true
		},
		[TEAM_LTBOSS] = {
			["scjrassociate"] 			= true,
			["scassociate"] 			= true,
			["scsassociate"] 			= true,
			["schassociate"] 			= true,
			["jrsicario"] 				= true,
			["sporegime"]				= true,
			["ssporegime"] 				= true
		},
		[TEAM_SCUNDERBOSS] = {
			["scjrassociate"] 			= true,
			["scassociate"] 			= true,
			["scsassociate"] 			= true,
			["schassociate"] 			= true,
			["jrsicario"] 				= true,
			["sporegime"]				= true,
			["ssporegime"] 				= true,
			["schsaporegime"] 			= true
		},
		[TEAM_SCBOSS] = {
			["scjrassociate"] 			= true,
			["scassociate"] 			= true,
			["scsassociate"] 			= true,
			["schassociate"] 			= true,
			["jrsicario"] 				= true,
			["sporegime"]				= true,
			["ssporegime"] 				= true,
			["schsaporegime"] 			= true,
			["sccaporegime"] 			= true,
			["ltboss"] 					= true
		},
		[TEAM_SCCONSIGLIERE] = {
			["scjrassociate"] 			= true,
			["scassociate"] 			= true,
			["scsassociate"] 			= true,
			["schassociate"] 			= true,
			["jrsicario"] 				= true,
			["sporegime"]				= true,
			["ssporegime"] 				= true,
			["schsaporegime"] 			= true,
			["sccaporegime"] 			= true,
			["ltboss"] 					= true,
			["scunderboss"] 			= true,
			["scboss"] 					= true
		},
		[TEAM_SCGODFATHER] = {
			["scjrassociate"] 			= true,
			["scassociate"] 			= true,
			["scsassociate"] 			= true,
			["schassociate"] 			= true,
			["jrsicario"] 				= true,
			["sporegime"]				= true,
			["ssporegime"] 				= true,
			["schsaporegime"] 			= true,
			["sccaporegime"] 			= true,
			["ltboss"] 					= true,
			["scunderboss"] 			= true,
			["scboss"] 					= true,
			["sccon"] 					= true
		},

		[TEAM_TERRORIST_GOVNR] = {
			["terroristrecruit"] 		= true,
			["terroristagitator"] 		= true,
			["terroristfanatic"] 		= true
		},
		[TEAM_TERRORIST_CMDR] = {
			["terroristrecruit"] 		= true,
			["terroristagitator"] 		= true,
			["terroristfanatic"] 		= true,
			["terroristins"] 			= true
		},
		[TEAM_TERRORIST_SNRCMDR] = {
			["terroristrecruit"] 		= true,
			["terroristagitator"] 		= true,
			["terroristfanatic"] 		= true,
			["terroristins"] 			= true,
			["terroristexe"] 			= true
		},
		[TEAM_TERRORIST_CHIEF] = {
			["terroristrecruit"] 		= true,
			["terroristagitator"] 		= true,
			["terroristfanatic"] 		= true,
			["terroristins"] 			= true,
			["terroristexe"] 			= true,
			["terroristgovnr"]			= true,
			["terroristcmd"] 			= true
		},
		[TEAM_TERRORIST_COLEAD] = {
			["terroristrecruit"] 		= true,
			["terroristagitator"] 		= true,
			["terroristfanatic"] 		= true,
			["terroristins"] 			= true,
			["terroristexe"] 			= true,
			["terroristgovnr"]			= true,
			["terroristcmd"] 			= true,
			["terroristsnrcmd"] 		= true,
			["terroristchief"]			= true
		},
		[TEAM_TERRORIST_LEAD] = {
			["terroristrecruit"] 		= true,
			["terroristagitator"] 		= true,
			["terroristfanatic"] 		= true,
			["terroristins"] 			= true,
			["terroristexe"] 			= true,
			["terroristgovnr"]			= true,
			["terroristcmd"] 			= true,
			["terroristsnrcmd"] 		= true,
			["terroristchief"]			= true,
			["terroristcolead"]			= true
		},


		[TEAM_FR_FC] = {
			["frac"] = true,
			["frdc"] = true,
			["frbc"] = true,
			["frcpt"] = true,
			["frlt"] = true,
			["frsup"] = true,
			["frse"] = true,
			["fre"] = true,
			["frsf"] = true,
			["frf"] = true,
			["frjf"] = true,
			["frcf"] = true
		},
		[TEAM_FR_AC] = {
			["frbc"] = true,
			["frcpt"] = true,
			["frlt"] = true,
			["frsup"] = true,
			["frse"] = true,
			["fre"] = true,
			["frsf"] = true,
			["frf"] = true,
			["frjf"] = true,
			["frcf"] = true
		},
		[TEAM_FR_DC] = {
			["frcpt"] = true,
			["frlt"] = true,
			["frsup"] = true,
			["frse"] = true,
			["fre"] = true,
			["frsf"] = true,
			["frf"] = true,
			["frjf"] = true,
			["frcf"] = true
		},
		[TEAM_FR_BC] = {
			["frsup"] = true,
			["frse"] = true,
			["fre"] = true,
			["frsf"] = true,
			["frf"] = true,
			["frjf"] = true,
			["frcf"] = true
		},
		[TEAM_FR_CPT] = {
			["frse"] = true,
			["fre"] = true,
			["frsf"] = true,
			["frf"] = true,
			["frjf"] = true,
			["frcf"] = true
		},
		[TEAM_FR_LT] = {
			["fre"] = true,
			["frsf"] = true,
			["frf"] = true,
			["frjf"] = true,
			["frcf"] = true
		},
		[TEAM_FR_SUP] = {
			["frsf"] = true,
			["frf"] = true,
			["frjf"] = true,
			["frcf"] = true
		}
	}
	
	
	xWhitelist.Config.BlacklistedPermissions = {
		[TEAM_PCOM] = {
			["policeofficer"] = true,
			["policeleutenant"] = true
		},
		[TEAM_PDCOM] = {
			["policeofficer"] = true,
			["policeleutenant"] = true
		},
		[TEAM_SHERIFF] = {
			["sheriffdeputy"] = true
		},
		[TEAM_FBID] = {
			["fbipa"] = true
		},
		[TEAM_SWATCOL] = {
			["swatrifle"] = true
		},
		[TEAM_TERRORIST_LEAD] = {
			["terroristrecruit"] = true
		},
		[TEAM_SCGODFATHER] = {
			["scjrassociate"] = true
		},
		[TEAM_FR_FC] = {
			["frcf"] = true
		}
	}
end)