net.Receive("EventSystem:UI:Admin", function()
	EventSystem.Core.GameMasterUI()
end)

net.Receive("EventSystem:UI:Admin:CreateEvent", function()
	EventSystem.Core.CreateEventUI()
end)

net.Receive("EventSystem:Message", function()
	local msg = net.ReadString()
	EventSystem.Core.MessageUI(msg)
	XYZShit.Msg("Game Master", EventSystem.Config.Color, "From the Gamemasters: "..msg)

end)

EventSystem.Spawnpoints = {}
net.Receive("EventSystem:SendSpawnPoints", function()
	EventSystem.Spawnpoints = net.ReadTable()
end)

EventSystem.ShowOutlines = false
net.Receive("EventSystem:TeamMembers", function()
	EventSystem.ShowOutlines = not net.ReadBool()
end)

hook.Add("PreDrawOutlines", "EventSystem:TeamOutlines", function()
	if not (LocalPlayer():Team() == TEAM_EVENT) then return end
	if not EventSystem.ShowOutlines then return end

	local myJob = LocalPlayer():getDarkRPVar("job")

	local teamMembers = {}
	for k, v in pairs(player.GetAll()) do
		local theirTeam = v:getDarkRPVar("job")
		if not (myJob == theirTeam) then continue end

		table.insert(teamMembers, v)
	end

	outline.Add(teamMembers, EventSystem.Config.Color, OUTLINE_MODE_BOTH)
end)