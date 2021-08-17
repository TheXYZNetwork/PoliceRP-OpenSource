XYZChat.AddChat = XYZChat.AddChat or chat.AddText

-- [Done] Talking in team chat triggers advert display
-- Text overlaps scroll bar

function chat.AddText(...)
    XYZChat.AddChat(...)
	if not IsValid(XYZChat.ChatBox) then
		XYZChat.CreateChat()
	end
    XYZChat.AddMessage({...})
end

hook.Add("playerWeaponsChecked", "xyz_weaponchecker", function(ply, ent, wep)
    if not (ply == LocalPlayer()) then return end
    local weps = ""
    for k, v in pairs(wep) do
        weps = weps.."\n"..v:GetPrintName()
       --chat.AddText(v:GetPrintName())
    end
    chat.AddText(ent, " has the following weapons:", weps)
end)

hook.Add("HUDShouldDraw", "xyz_hide_chat", function(v)
    if v == "CHudChat" then return false end
end)

hook.Add("PlayerBindPress", "xyz_toggle_chat", function(ply, bind, pressed)
    if ply == LocalPlayer() then
        if bind == "messagemode" and pressed then
			if not IsValid(XYZChat.ChatBox) then
				XYZChat.CreateChat()
			end
			XYZChat.ChatBox:ChatShow() 
            XYZChat.ChatBox.Team = false
            timer.Remove("xyz_chat_show")
            return true
        elseif bind == "messagemode2" and pressed then
			if not IsValid(XYZChat.ChatBox) then
				XYZChat.CreateChat()
			end
            XYZChat.ChatBox:ChatShow() 
            XYZChat.ChatBox.Team = true
            timer.Remove("xyz_chat_show")
            return true
        end
    end
end)

hook.Add("OnPlayerChat", "xyz_chat_ply", function(ply, msg, team, dead, prefixText, col1, col2)
    if not IsValid(XYZChat.ChatBox) then
        XYZChat.CreateChat()
    end

    if prefixText then
        local deadText = ""
        if dead then
            deadText = "*DEAD* "
        end
        prefixText = string.Replace(prefixText, ply:Name(), "")

        local teamPref = ""
        if string.find(prefixText, "group") then
            teamPref = "(TEAM) "
        end
        local advertPref = ""
        if string.find(prefixText, "Advert") then
            advertPref = "(Advert) "
        end
        local oocPref = ""
        if string.find(prefixText, "OOC") then
            oocPref = "(OOC) "
        end
        local yellPref = ""
        if string.find(prefixText, "yell") then
            yellPref = "(Yell) "
        end
        local whisperPref = ""
        if string.find(prefixText, "whisper") then
            yellPref = "(Whisper) "
        end
        local pmPref = ""
        if string.find(prefixText, "PM") then
           pmPref = "(PM) "
        end
        chat.AddText(Color(30, 160, 40), teamPref, Color(255, 55, 55), deadText, col2, advertPref, oocPref, pmPref, yellPref, whisperPref, ply, ": ", col2, msg)     
    else
        chat.AddText(Color(143, 218, 230), msg)
    end

    hook.Run("XYZOnPlayerChat", ply, msg, team, dead, prefixText, col1, col2)
    return true
end)

net.Receive("xyz_chat_connection", function()
    local ply = net.ReadString()
    local state = net.ReadBool()

    if state then
        chat.AddText(string.format("%s has connected to the server!", ply, player.GetCount(), game.MaxPlayers()))
    else
        local plyID = net.ReadString()
        local plyColor = net.ReadColor()
        chat.AddText(plyColor, ply, Color(255, 255, 255), string.format(" (%s) is disconnecting from the server!", plyID, player.GetCount(), game.MaxPlayers()))
    end
end)


hook.Add("XYZOnPlayerChat", "xyz_chat_commands", function(ply, text)
    if not (ply == LocalPlayer()) then return end

    if (text == "/clear") or (text == "!clear") then
        for k, v in pairs(XYZChat.ChatBox.Messages) do
            v:Remove()
        end
        XYZChat.ChatBox.Messages = {}
    end
end )