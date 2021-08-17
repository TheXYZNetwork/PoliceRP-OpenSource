local function openArrestMenu(npc, prisoner)
	local frame = XYZUI.Frame("Arrest Someone", Color(200, 100, 40))
	frame:SetSize(ScrH()*0.4, ScrH()*0.6)
	frame:Center()

	local shell = XYZUI.Container(frame)
	--shell:DockPadding(5, 5, 5, 5)
	shell.Paint = nil

	local stateCache = {}
	local _, punishmentList = XYZUI.Lists(shell, 1)
	punishmentList.Paint = nil

	local categories = {}
	for k, v in ipairs(handcuffs.Config.Punishments) do
		if not categories[v.category] then
			categories[v.category] = {}
		end

		categories[v.category][k] = v
	end

	for categoryName, categoryPunishments in pairs(categories) do
		local body, card, mainContainer = XYZUI.ExpandableCard(punishmentList, categoryName)
		mainContainer:DockMargin(0, 0, 0, 10)
		local _, itemList = XYZUI.Lists(body, 1)

		for k, v in pairs(categoryPunishments) do
			local t = XYZUI.Card(itemList, 30)
			t:DockMargin(0, 0, 0, 5)
			t:Dock(TOP)
			t:InvalidateParent(true)
	
			local a = XYZUI.PanelText(t, v.name, 20, TEXT_ALIGN_LEFT)
			a:Dock(FILL)
	
			local s, container = XYZUI.ToggleInput(t)
			container:Dock(RIGHT)
			container:SetSize(30, 30)
			container:DockMargin(5, 6, 0, 0)
			s:SetSize(20, 20)
			s.key = k
			stateCache[k] = s
		end

		XYZUI.AddToExpandableCardBody(mainContainer, itemList)
		itemList:InvalidateParent(true)
		itemList:SizeToContents()
	end

	local custom = XYZUI.Card(punishmentList, 30)
	custom:DockMargin(0, 0, 0, 5)

	local cpanel = vgui.Create("DPanel", custom)
	cpanel:Dock(FILL)
	cpanel.Paint = function() end
	cpanel.headerColor = custom.headerColor

	local customname, cn = XYZUI.TextInput(cpanel, false, 20)
	customname.placeholder = "Custom Reason"
	cn:Dock(FILL)

	local customtime, ct = XYZUI.TextInput(cpanel, false, 20)
	customtime.placeholder = "Custom Time"
	customtime:SetNumeric(true)
	ct:DockMargin(5, 0, 0, 0)
	ct:Dock(RIGHT)
	timer.Simple(0.1, function()
		ct:SetWide(cpanel:GetWide()*0.3)
	end)

	local j = XYZUI.ButtonInput(shell, "Jail", function(container)
		local reasons = {}
		for k, v in ipairs(stateCache) do
			if v.state then
				reasons[k] = true
			end
		end

		if customname:GetValue() ~= "" and customtime:GetValue() ~= "" then
			-- next line will error if customtime is text due to user error, not a bug, just how gmod handles the nil.
			reasons["custom"] = {name = customname:GetValue(), time = customtime:GetInt()}
		end

		net.Start("hc_front_desk_jail")
			net.WriteEntity(npc)
			net.WriteEntity(prisoner)
			net.WriteTable(reasons)
		net.SendToServer()
		frame:Close()

	end)
	j:DockMargin(0, 5, 0, 0)
	j:Dock(BOTTOM)
	j.Think = function()
		local jailTime = 0
		for k, v in pairs(stateCache) do
			if v.state then
				jailTime = jailTime + handcuffs.Config.Punishments[k].time
			end
		end
		if tonumber(customtime:GetText()) then
			jailTime = jailTime + tonumber(customtime:GetText())
		end
		jailTime = math.Clamp(jailTime, 0, 10)

		j.disText = "Jail ("..jailTime.." Years)"
	end
end

-- Function name is outdated, also includes compliment/report
local function openBailMenu(npc)
	local arrestable = false
	for k, v in pairs(player.GetAll()) do
		if PrisonSystem.IsArrested(v) then arrestable = true break end
	end
	--if not arrestable then XYZShit.Msg("Front Desk", Color(200, 100, 40), "It seems there is currently no one in jail...", ply) return end


	local frame = XYZUI.Frame("Front Desk", Color(200, 100, 40))
	frame:SetSize(ScrH()*0.4, ScrH()*0.6)
	frame:Center()
	local navBar = XYZUI.NavBar(frame)
	local shell = XYZUI.Container(frame)

	if arrestable and not LocalPlayer():isCP() then
		XYZUI.AddNavBarPage(navBar, shell, "Bail", function(shell)
			local _, membersList = XYZUI.Lists(shell, 1)
			for k, v in pairs(player.GetAll()) do
				local isArrested, time = PrisonSystem.IsArrested(v)
				if not isArrested then continue end

				local t = XYZUI.Card(membersList, 56)
				t:DockMargin(0, 0, 0, 5)
				t:Dock(TOP)
				t.Think = function()
					if not IsValid(v) then
						t:Remove()
					end
				end

				local a = XYZUI.PanelText(t, v:Name(), 35, TEXT_ALIGN_LEFT)
				a:Dock(FILL)
				a:DockMargin(5, 0, 0, 0)

				local j = XYZUI.ButtonInput(t, "Bail", function(container)
					net.Start("hc_front_desk_bail")
					net.WriteEntity(npc)
					net.WriteEntity(v)
					net.SendToServer()
					frame:Close()
				end)
				j:DockMargin(10, 10, 10, 10)
				j:Dock(RIGHT)
			end
		end)
	end

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
end


net.Receive("hc_front_desk", function()
	local npc = net.ReadEntity()
	local prisoner = net.ReadEntity()

	if IsValid(prisoner) and prisoner:IsPlayer() then
		openArrestMenu(npc, prisoner)
	else
		openBailMenu(npc)
	end
end)