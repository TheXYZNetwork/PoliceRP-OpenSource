hook.Add("PlayerSay", "xyz_tag_chat_command", function(ply, msg)
	if string.lower(msg) == "!tag" then
		if XYZ_TAG[ply:SteamID64()] then
			net.Start("xyz_tag_open")
			net.Send(ply)
		else
			XYZShit.Msg("Tags", Color(160, 130, 40), "It seems you do not have access to use the custom tags...", ply)
			return ""
		end
	end
end)

net.Receive("xyz_tag_set", function(_, ply)
	local title = net.ReadString()
	local color = net.ReadColor()

	if not XYZ_TAG[ply:SteamID64()] then return end

    if XYZShit.CoolDown.Check("xyz_tag_set", 3, ply) then return end

	if string.len(title) > 15 then return end

	XYZShit.Msg("Tags", Color(160, 130, 40), "You have updated your tag!", ply)

	XYZShit.DataBase.Query(string.format("SELECT * FROM user_tags WHERE userid='%s'", ply:SteamID64()), function(data)
		if data[1] then
			XYZShit.DataBase.Query(string.format("UPDATE user_tags SET tag='%s', color='%s' WHERE userid='%s'", XYZShit.DataBase.Escape(title), util.TableToJSON(color), ply:SteamID64()))
		else
			XYZShit.DataBase.Query(string.format("INSERT INTO user_tags VALUES('%s', '%s', '%s')", ply:SteamID64(), XYZShit.DataBase.Escape(title), util.TableToJSON(color)))
		end
	end)

	ply:SetNWString("xyz_tag_string", title)
	ply:SetNWVector("xyz_tag_Color", Vector(color.r, color.g, color.b))
end)