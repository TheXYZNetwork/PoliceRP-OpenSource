-- The chat and UI colors
PoliceUnion.Config.Color = Color(170, 120, 22)

PoliceUnion.Config.DepartmentToLog = {
    ["Police Force"] = "pd",
    ["Sheriff's Department"] = "sd",
    ["Swat"] = "swat",
    ["FBI"] = "fbi"
}

hook.Add("loadCustomDarkRPItems", "PoliceUnion:Blacklist", function()
	PoliceUnion.Config.Blacklist = {
		[TEAM_PRESIDENT] = true
	}
end)