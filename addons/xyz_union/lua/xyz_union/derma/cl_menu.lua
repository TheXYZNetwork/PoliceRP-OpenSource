net.Receive("PoliceUnion:UI", function()
	local ent = net.ReadEntity()

	local frame = XYZUI.Frame("Police Union", PoliceUnion.Config.Color)
	frame:SetSize(ScrH()*0.6, ScrH()*0.7)
	frame:Center()

	local navBar = XYZUI.NavBar(frame)
	local shell = XYZUI.Container(frame)
    shell:DockPadding(10, 5, 10, 10)

    XYZUI.AddNavBarPage(navBar, shell, "Internal Affairs", function(shell)
        local t = XYZUI.Title(shell, "Internal Affairs", nil, 50, 0, TEXT_ALIGN_CENTER)
        t:SetTall(50)

    	-- Get the user
    	XYZUI.PanelText(shell, "User to submit report on", 35, TEXT_ALIGN_LEFT)
    	local target 
    	local dropdown = XYZUI.DropDownList(shell, "Select a Player", function(name, value)
    		target = value
    	end)
    	XYZUI.AddDropDownOption(dropdown, "None")
    	for k, v in ipairs(player.GetAll()) do
            if not XYZShit.IsGovernment(v:Team(), true) then continue end
    		if v == LocalPlayer() then continue end
    		XYZUI.AddDropDownOption(dropdown, v:Name(), v:SteamID64())
    	end
    	XYZUI.PanelText(shell, "or", 30, TEXT_ALIGN_CENTER)
    	local steamIDEntry, cont = XYZUI.TextInput(shell)
    	steamIDEntry.placeholder = LocalPlayer():SteamID64().." | steamid64"
    	steamIDEntry:SetNumeric(true)

    	-- Divider
    	local div = XYZUI.Divider(shell)
    	div:DockMargin(0, 15, 0, 10)

    	-- Discord name
    	XYZUI.PanelText(shell, "Your Discord Tag (Optional)", 35, TEXT_ALIGN_LEFT)
    	local discordTagEntry, cont = XYZUI.TextInput(shell)
    	discordTagEntry.placeholder = "Owain#0001 | discordtag"
        if XYZDiscordInfo == nil then
            net.Start("PoliceUnion:RequestDiscordInfo")
            net.SendToServer()
            XYZDiscordInfo = 0 -- A bit of a hacky way to prevent spamming of net msgs when the server doesn't respond (in time)

            net.Receive("PoliceUnion:RequestDiscordInfo", function()
                if not IsValid(frame) then return end
                
                XYZDiscordInfo = net.ReadString()
                discordTagEntry:SetValue(XYZDiscordInfo)
            end)
        elseif XYZDiscordInfo ~= 0 then
            discordTagEntry:SetValue(XYZDiscordInfo)
        end

    	-- Divider
    	local div = XYZUI.Divider(shell)
    	div:DockMargin(0, 15, 0, 10)

    	-- Reason
    	XYZUI.PanelText(shell, "The reason for the report", 35, TEXT_ALIGN_LEFT)
    	local reasonEntry, cont = XYZUI.TextInput(shell, true)

    	-- Submit
		local btn = XYZUI.ButtonInput(shell, "Submit Report!", function(self)
		    local userID64 = target or steamIDEntry:GetText()
		    if (not isnumber(tonumber(userID64))) or (tonumber(userID64) < 7656119820896462) or (tonumber(userID64) > 765611982089646201) then
				XYZShit.Msg("Police Union", PoliceUnion.Config.Color, "The SteamID64 you have provided is invalid")
				return
			end

			local discordTag = discordTagEntry:GetText()

			local reason = reasonEntry:GetText()
			reason = string.Trim(reason, " ")
			if (reason == "") or (string.len(reason) <= 10) then
				XYZShit.Msg("Police Union", PoliceUnion.Config.Color, "Your reason must be longer!")
				return
			end

			net.Start("PoliceUnion:Submit")
				net.WriteString("ia")
				net.WriteString(userID64) -- 64 bit, gotta pass it as a string
				net.WriteString(discordTag or "")
				net.WriteString(reason)
			net.SendToServer()

            frame:Close()
		end)
		btn:Dock(BOTTOM)
    end)
    XYZUI.AddNavBarPage(navBar, shell, "Compliments", function(shell)
        local t = XYZUI.Title(shell, "Compliments", nil, 50, 0, TEXT_ALIGN_CENTER)
        t:SetTall(50)

        -- Get the user
        XYZUI.PanelText(shell, "User to compliment", 35, TEXT_ALIGN_LEFT)
        local target 
        local dropdown = XYZUI.DropDownList(shell, "Select a Player", function(name, value)
            target = value
        end)
        XYZUI.AddDropDownOption(dropdown, "None")
        for k, v in ipairs(player.GetAll()) do
            if not XYZShit.IsGovernment(v:Team(), true) then continue end
            if v == LocalPlayer() then continue end
            XYZUI.AddDropDownOption(dropdown, v:Name(), v:SteamID64())
        end
        XYZUI.PanelText(shell, "or", 30, TEXT_ALIGN_CENTER)
        local steamIDEntry, cont = XYZUI.TextInput(shell)
        steamIDEntry.placeholder = LocalPlayer():SteamID64().." | steamid64"
        steamIDEntry:SetNumeric(true)

        -- Divider
        local div = XYZUI.Divider(shell)
        div:DockMargin(0, 15, 0, 10)

        -- Reason
        XYZUI.PanelText(shell, "The reason for their compliment", 35, TEXT_ALIGN_LEFT)
        local reasonEntry, cont = XYZUI.TextInput(shell, true)

        -- Submit
        local btn = XYZUI.ButtonInput(shell, "Submit Compliment!", function(self)
            local userID64 = target or steamIDEntry:GetText()
            if (not isnumber(tonumber(userID64))) or (tonumber(userID64) < 7656119820896462) or (tonumber(userID64) > 765611982089646201) then
                XYZShit.Msg("Police Union", PoliceUnion.Config.Color, "The SteamID64 you have provided is invalid")
                return
            end

            local reason = reasonEntry:GetText()
            reason = string.Trim(reason, " ")
            if (reason == "") or (string.len(reason) <= 10) then
                XYZShit.Msg("Police Union", PoliceUnion.Config.Color, "Your reason must be longer!")
                return
            end

            net.Start("PoliceUnion:Submit")
                net.WriteString("comp")
                net.WriteString(userID64) -- 64 bit, gotta pass it as a string
                net.WriteString("")
                net.WriteString(reason)
            net.SendToServer()

            frame:Close()
        end)
        btn:Dock(BOTTOM)
    end)

end)