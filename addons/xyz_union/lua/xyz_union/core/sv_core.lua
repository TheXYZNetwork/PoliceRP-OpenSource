net.Receive("PoliceUnion:Submit", function(_, ply)
    if XYZShit.CoolDown.Check("PoliceUnion:Submit", 10, ply) then return end

	local reportType = net.ReadString()
	local userID = net.ReadString()
	local discordTag = net.ReadString()
	local reason = net.ReadString()

	-- Validate type
	if (not (reportType == "ia")) and (not (reportType == "comp")) then return end
	-- Validate ID
	if (not isnumber(tonumber(userID))) or (tonumber(userID) < 7656119820896462) or (tonumber(userID) > 765611982089646201) then return end
	-- Validate Discord tag
	if not string.find(discordTag, "#", 1, true) then
		discordTag = ""
	end
	if (reportType == "comp") then
		discordTag = ""
	end
	-- Validate reason
	reason = string.Trim(reason, " ")
	if (reason == "") or (string.len(reason) <= 10) then return end
	-- If online, check against blacklist

	-- Validation complete!

	local department = "pd"
	local target = player.GetBySteamID64(userID)
	if target then
		if PoliceUnion.Config.Blacklist[target:Team()] then return end
		department = PoliceUnion.Config.DepartmentToLog[RPExtraTeams[target:Team()].category] or "pd"
	end

	if reportType == "comp" then
		XYZShit.Msg("Police Union", PoliceUnion.Config.Color, "Your compliment has been submitted! Thanks for letting us know about this amazing member.", ply)
	else
		XYZShit.Msg("Police Union", PoliceUnion.Config.Color, "Your report has been submitted! You may be contacted by an IA representative at a later date for more information.", ply)
	end

	local embed = {
		author = {
		    name =  ply:Name(),
		    url = "https://thexyznetwork.xyz/lookup/"..ply:SteamID64(),
		    icon_url = "https://extra.thexyznetwork.xyz/steamProfileByID?id="..ply:SteamID64()
		},
		title = ((reportType == "comp") and "Compliment for " or "IA Report on ")..((target and target:Name().." ("..userID..")") or userID),
		color = "368575",
		description = "**Reason:** "..reason..((discordTag == "") and "" or ("\n**Provided Discord Tag:** "..discordTag))
	}


	XYZShit.Webhook.PostEmbed("union_"..reportType.."_"..department, embed)
end)

local apikey = "Yl8yzDnzXy9fdbjPakVNqQWMRDj4GGmfBQGIhGHF" 

net.Receive("PoliceUnion:RequestDiscordInfo", function(_, ply)
	http.Fetch("https://api.thexyznetwork.xyz/xsuitelink/steam/"..ply:SteamID64(), 
		function(body)
			local json = util.JSONToTable(body)
			if not json then return end -- If the API returns a non json response (for whatever reason)
			if json['error'] then return end
			local discordinfo = json.result.username.."#"..string.format("%04d", json.result.tag)
			net.Start("PoliceUnion:RequestDiscordInfo")
			net.WriteString(discordinfo)
			net.Send(ply)
		end, 
		function(err)
			print("Error attempting to get Discord info "..err)
		end,
		{ 
			["apikey"] = apikey
		}
	)
end)