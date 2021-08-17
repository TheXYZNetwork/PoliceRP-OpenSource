hook.Add("PlayerSay", "bug_report_command", function(ply, msg)
	if (string.lower(msg) == "!bug") then
		net.Start("bug_report_menu")
		net.Send(ply)
	end
end)


net.Receive("bug_report_bug", function(_, ply)
    if XYZShit.CoolDown.Check("bug_report_bug", 60, ply) then
        XYZShit.Msg("Bug Report", Color(100, 0, 155), "Hey now, you only just reported a bug to us. Take a moment before reporting another!", ply)
        return
    end

    local bug = net.ReadString()
    local info = net.ReadTable()

	XYZShit.Webhook.PostEmbed("bug_reports", {
        author = {
            name = ply:SteamName().." ("..ply:SteamID64()..")",
            url = "https://steamcommunity.com/profiles/"..ply:SteamID64().."/",
            icon_url = "http://extra.thexyznetwork.xyz/steamProfileByID?id="..ply:SteamID64()
        },
        fields = {
            {
                name = "Server",
                value = "PoliceRP",
                inline = false,
            },
            {
                name = "Information",
                value = string.gsub(bug, "%@", ""),
                inline = false,
            },
            {
                name = "Operating System",
                value = string.gsub(info.OS or "Unknown", "%@", ""),
                inline = true,
            },
            {
                name = "Country Code",
                value = string.gsub(info.CC or "Unknown", "%@", ""),
                inline = true,
            },
            {
                name = "Screen Resolution",
                value = string.gsub((info.SR.w or "Unknown").."x"..(info.SR.h or "Unknown"), "%@", ""),
                inline = true,
            },
            {
                name = "Usergroup",
                value = ply:GetUserGroup(),
                inline = true,
            },
            {
                name = "Secondary Usergroup",
                value = ply:GetSecondaryUserGroup() or "None",
                inline = true,
            },
            {
                name = "Job",
                value = RPExtraTeams[ply:Team()].name,
                inline = true,
            },
        },
        color = 6729778
    })
    
    XYZShit.Msg("Bug Report", Color(100, 0, 155), "Thanks for trying to make the server a better place. Your report has been logged and will be reviewed.", ply)
end)