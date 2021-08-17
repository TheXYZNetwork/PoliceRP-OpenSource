XYZShit = XYZShit or {}
XYZShit.Jobs = XYZShit.Jobs or {}
XYZShit.Jobs.Criminals = XYZShit.Jobs.Criminals or {}
XYZShit.Jobs.Government = XYZShit.Jobs.Government or {}
XYZShit.Departments = XYZShit.Departments or {}

XYZShit.Departments.Government = XYZShit.Departments.Government or {}

XYZShit.Departments.Government.Police = "Police Department"
XYZShit.Departments.Government.Sheriff = "Sheriff's Department"
XYZShit.Departments.Government.FBI = "Federal Bureau of Investigation"
XYZShit.Departments.Government.SWAT = "Special Weapons and Tactics"
XYZShit.Departments.Government.FR = "Fire & Rescue"

hook.Add("loadCustomDarkRPItems", "XYZ_LOAD_CONTENT", function()

	XYZShit.Jobs.Government.PoliceTrainers = {TEAM_PASSCOM, TEAM_PLIUTENANT, TEAM_PCAPTAIN, TEAM_PSUP, TEAM_PMAJ, TEAM_PLTC, TEAM_PCOL, TEAM_PDCOM, TEAM_PCOM}

	XYZShit.Jobs.Government.PoliceMeetings = {TEAM_PASSCOM, TEAM_PLIUTENANT, TEAM_PCAPTAIN, TEAM_PSUP, TEAM_PMAJ, TEAM_PLTC, TEAM_PCOL, TEAM_PDCOM, TEAM_PCOM, TEAM_SWATMAJOR, TEAM_SWATLEADER, TEAM_SWATLTCOL, TEAM_SWATCOL, TEAM_HEADEMT, TEAM_SHERIFFLIEUTENANT, TEAM_SHERIFFCAPTAIN, TEAM_SHERIFFMAJOR, TEAM_CHIEFDEPUTY, TEAM_UNDERSHERIFF, TEAM_SHERIFF, TEAM_FBID, TEAM_FBIDD, TEAM_FBICOS, TEAM_FBIADD, TEAM_FBIEAD, TEAM_FBIDAD, TEAM_FR_FC, TEAM_FR_AC, TEAM_FR_DC, TEAM_FR_BC, TEAM_FR_CPT}

	-- Police
	XYZShit.Jobs.Government.Police = {}

	XYZShit.Jobs.Government.FBI = {}

	XYZShit.Jobs.Government.SWAT = {}

	XYZShit.Jobs.Government.FR = {}

	XYZShit.Jobs.Government.SD = {}

	XYZShit.Jobs.Government.President = {}

	-- Criminals
	XYZShit.Jobs.Criminals.Raiders = {TEAM_PTHIEF, TEAM_KINGBLOODZ, TEAM_KINGCRIPS, TEAM_BTHIEF, TEAM_ELITETHIEF, TEAM_OVERLORDBLOODZ, TEAM_OVERLORDCRIPS, TEAM_HACKER}

	XYZShit.Jobs.Criminals.Terrorists = {}

	XYZShit.Jobs.Criminals.SinaloaCartel = {}

	XYZShit.Jobs.Criminals.CustomJobs = {}

	for k, v in pairs(RPExtraTeams) do
		local category = v.category

		if category == "Police Force" then
			table.insert(XYZShit.Jobs.Government.Police, v.team)
		end
		
		if category == "FBI" then
			table.insert(XYZShit.Jobs.Government.FBI, v.team)
		end

		if category == "Swat" then
			table.insert(XYZShit.Jobs.Government.SWAT, v.team)
		end

		if category == "Sheriff's Department" then
			if k == TEAM_SHERIFFK9 then continue end
			
			table.insert(XYZShit.Jobs.Government.SD, v.team)
		end

		if category == "Fire & Rescue" then
			table.insert(XYZShit.Jobs.Government.FR, v.team)
		end

		-- Criminal Jobs
		if category == "Criminals" then
			table.insert(XYZShit.Jobs.Criminals.Raiders, v.team)
		end

		if category == "Terrorist" then
			table.insert(XYZShit.Jobs.Criminals.Terrorists, v.team)
		end

		if category == "The Mafia" then
			table.insert(XYZShit.Jobs.Criminals.SinaloaCartel, v.team)
		end

		if category == "Custom Job" then
			table.insert(XYZShit.Jobs.Criminals.CustomJobs, v.team)
		end
	end

	-- Add PRES and VP to USMS (they're in the civ category)
	table.insert(XYZShit.Jobs.Government.President, TEAM_VICE_PRESIDENT)
	table.insert(XYZShit.Jobs.Government.President, TEAM_PRESIDENT)

	-- Government
	XYZShit.Jobs.Government.All = {}
	XYZShit.Jobs.Government.All = table.Add(XYZShit.Jobs.Government.All, XYZShit.Jobs.Government.Police)
	XYZShit.Jobs.Government.All = table.Add(XYZShit.Jobs.Government.All, XYZShit.Jobs.Government.FBI)
	XYZShit.Jobs.Government.All = table.Add(XYZShit.Jobs.Government.All, XYZShit.Jobs.Government.SWAT)
	XYZShit.Jobs.Government.All = table.Add(XYZShit.Jobs.Government.All, XYZShit.Jobs.Government.SD)
	--XYZShit.Jobs.Government.All = table.Add(XYZShit.Jobs.Government.All, XYZShit.Jobs.Government.President)
	
	-- List form
	XYZShit.Jobs.Government.List = {}
	for k, v in pairs(XYZShit.Jobs.Government.All) do
		XYZShit.Jobs.Government.List[v] = true
	end

	-- Criminals 
	XYZShit.Jobs.Criminals.All = {}
	XYZShit.Jobs.Criminals.All = table.Add(XYZShit.Jobs.Criminals.All, XYZShit.Jobs.Criminals.Raiders)
	XYZShit.Jobs.Criminals.All = table.Add(XYZShit.Jobs.Criminals.All, XYZShit.Jobs.Criminals.Terrorists)
	XYZShit.Jobs.Criminals.All = table.Add(XYZShit.Jobs.Criminals.All, XYZShit.Jobs.Criminals.SinaloaCartel)
	XYZShit.Jobs.Criminals.All = table.Add(XYZShit.Jobs.Criminals.All, XYZShit.Jobs.Criminals.CustomJobs)
	table.insert(XYZShit.Jobs.Criminals.All, TEAM_CUSTOMCLASS)
end)

function XYZShit.IsGovernment(jobEnum, includeEMS)
	 -- They're in the gov list
	if XYZShit.Jobs.Government.List[jobEnum] then return true end
	-- They're in the EMS table
	if includeEMS and table.HasValue(XYZShit.Jobs.Government.FR, jobEnum) then return true end

	-- They failed the checks
	return false
end