function xWhitelist.Core.UI()
	local jobsFound = {}
	for k, v in pairs(RPExtraTeams) do
		if (not xWhitelist.Config.WhitelistedJobs[v.command]) and (not xWhitelist.Config.BlacklistedJobs[v.command]) then continue end
		if (not xWhitelist.Core.CanWhitelist(LocalPlayer(), v.command)) and (not xWhitelist.Core.CanBlacklist(LocalPlayer(), v.command)) then continue end

		if not jobsFound[v.category] then
			jobsFound[v.category] = {}
		end
		table.insert(jobsFound[v.category], v)
	end


	local frame = XYZUI.Frame("xWhitelist", Color(155, 155, 155))
	frame:SetSize(ScrH()*0.9, ScrH()*0.9)
	frame:Center()

    local navBar = XYZUI.NavBar(frame)
	local shell = XYZUI.Container(frame)
	shell.Paint = function() end

    XYZUI.AddNavBarPage(navBar, shell, "Whitelists", function(shell)
    	XYZUI.Title(shell, "Whitelists", "", 50, 30)

    	local listTable, plysList = XYZUI.Lists(shell, 1)
    	local listTable, whitelistList = XYZUI.Lists(shell, 1)
    	plysList:SetWidth(shell:GetWide()/3)
    	plysList:Dock(LEFT)
    	plysList:DockPadding(2, 2, 2, 2)
    	whitelistList:Dock(FILL)
    	whitelistList:DockPadding(2, 2, 2, 2)

    	local activeUser = nil

    	-- Search SteamID64
    		local searhUserDock = vgui.Create("DPanel", plysList)
    		searhUserDock:SetText("")
    		searhUserDock:Dock(TOP)
    		searhUserDock:DockMargin(4, 4, 4, 2)
    		searhUserDock:SetTall(40)
    		searhUserDock.Paint = function() end

    		local entry

			local btn = XYZUI.ButtonInput(searhUserDock, "Search ID", function()
				net.Start("xWhitelistRequestUserData")
					net.WriteString(entry:GetText())
				net.SendToServer()
				activeUser = entry:GetText()
			end)
			btn:Dock(RIGHT)
			btn:SetWide(120)

    		entry = XYZUI.TextInput(searhUserDock)
    		entry:Dock(FILL)

    	for k, v in pairs(player.GetAll()) do
    		local plyButton = vgui.Create("DPanel", plysList)
    		plyButton:SetText("")
    		plyButton:Dock(TOP)
    		plyButton:DockMargin(4, 4, 4, 2)
    		plyButton:SetTall(40)
    		plyButton.Paint = function() end
    		plyButton.headerColor = plysList.headerColor

    		plyButton.icon = vgui.Create("AvatarImage", plyButton)
			plyButton.icon:SetSize(plyButton:GetTall(), plyButton:GetTall())
			plyButton.icon:Dock(LEFT)
			plyButton.icon:SetPlayer(v, 64)

			XYZUI.ButtonInput(plyButton, v:Name(), function()
				net.Start("xWhitelistRequestUserData")
					net.WriteString(v:SteamID64())
				net.SendToServer()
				activeUser = v
			end)
    	end

		net.Receive("xWhitelistRequestedUserData", function()
			if not shell then return end
			whitelistList:Clear()
    		XYZUI.PanelText(whitelistList, (isstring(activeUser) and xWhitelist.Core.ValidateToID64(activeUser)) or activeUser:Name(), 30, TEXT_ALIGN_LEFT)
			local usersJobs = net.ReadTable()

			local jobCats = {}
			for k, v in pairs(jobsFound) do
				for n, m in pairs(v) do
					if (not xWhitelist.Config.WhitelistedJobs[m.command]) then continue end
					if not jobCats[m.category] then
						local body, card, mainContainer = XYZUI.ExpandableCard(whitelistList, m.category, 40)
						jobCats[m.category] = mainContainer
						jobCats[m.category]:DockMargin(4, 4, 4, 0)
					end
					
					local card = XYZUI.Card(jobCats[m.category], 50)
					local jobName = XYZUI.PanelText(card, m.name, 30, TEXT_ALIGN_LEFT)
					jobName:Dock(FILL)

					local toggleWhitelist = XYZUI.ButtonInput(card, "Void", function(self)
						if self.disText == "Done" then return end
						net.Start("xWhitelistToggleWhitelistID")
							net.WriteString((isstring(activeUser) and activeUser) or activeUser:SteamID64())
							net.WriteString(m.command)
							net.WriteBool(self.whitelisted)
						net.SendToServer()
    					self.headerColor = Color(155, 155, 155)
    					self.disText = "Done"
					end)
					if usersJobs.whitelist[m.command] then
    					toggleWhitelist.headerColor = Color(175, 10, 30)
    					toggleWhitelist.disText = "Unwhitelist"
    					toggleWhitelist.whitelisted = true
						toggleWhitelist:Dock(RIGHT)
						toggleWhitelist:SetWide(100)
						toggleWhitelist:DockMargin(4, 4, 4, 4)
					else
    					toggleWhitelist.headerColor = Color(10, 175, 30)
    					toggleWhitelist.disText = "Whitelist"
    					toggleWhitelist.whitelisted = false
						toggleWhitelist:Dock(RIGHT)
						toggleWhitelist:SetWide(100)
						toggleWhitelist:DockMargin(4, 4, 4, 4)
					end

					XYZUI.AddToExpandableCardBody(jobCats[m.category], card)
				end
			end
		end)
    end)
    XYZUI.AddNavBarPage(navBar, shell, "Blacklists", function(shell)
    	XYZUI.Title(shell, "Blacklists", "", 50, 30)

    	local listTable, plysList = XYZUI.Lists(shell, 1)
    	local listTable, whitelistList = XYZUI.Lists(shell, 1)
    	plysList:SetWidth(shell:GetWide()/3)
    	plysList:Dock(LEFT)
    	plysList:DockPadding(2, 2, 2, 2)
    	whitelistList:Dock(FILL)

    	local activeUser = nil

    	-- Search SteamID64
    		local searhUserDock = vgui.Create("DPanel", plysList)
    		searhUserDock:SetText("")
    		searhUserDock:Dock(TOP)
    		searhUserDock:DockMargin(4, 4, 4, 2)
    		searhUserDock:SetTall(40)
    		searhUserDock.Paint = function() end

    		local entry

			local btn = XYZUI.ButtonInput(searhUserDock, "Search ID", function()
				net.Start("xWhitelistRequestUserData")
					net.WriteString(entry:GetText())
				net.SendToServer()
				activeUser = entry:GetText()
			end)
			btn:Dock(RIGHT)
			btn:SetWide(120)

    		entry = XYZUI.TextInput(searhUserDock)
    		entry:Dock(FILL)
    		
    	for k, v in pairs(player.GetAll()) do
    		local plyButton = vgui.Create("DPanel", plysList)
    		plyButton:SetText("")
    		plyButton:Dock(TOP)
    		plyButton:DockMargin(4, 4, 4, 2)
    		plyButton:SetTall(40)
    		plyButton.Paint = function() end
    		plyButton.headerColor = plysList.headerColor

    		plyButton.icon = vgui.Create("AvatarImage", plyButton)
			plyButton.icon:SetSize(plyButton:GetTall(), plyButton:GetTall())
			plyButton.icon:Dock(LEFT)
			plyButton.icon:SetPlayer(v, 64)

			XYZUI.ButtonInput(plyButton, v:Name(), function()
				net.Start("xWhitelistRequestUserData")
					net.WriteString(v:SteamID64())
				net.SendToServer()
				activeUser = v
			end)
    	end

		net.Receive("xWhitelistRequestedUserData", function()
			if not shell then return end
			whitelistList:Clear()
    		XYZUI.PanelText(whitelistList, (isstring(activeUser) and xWhitelist.Core.ValidateToID64(activeUser)) or activeUser:Name(), 30, TEXT_ALIGN_LEFT)
			local usersJobs = net.ReadTable()

			local jobCats = {}
			for k, v in pairs(jobsFound) do
				for n, m in pairs(v) do
					if (not xWhitelist.Config.BlacklistedJobs[m.command]) then continue end
					if not jobCats[m.category] then
						local body, card, mainContainer = XYZUI.ExpandableCard(whitelistList, m.category, 40)
						jobCats[m.category] = mainContainer
						jobCats[m.category]:DockMargin(4, 4, 4, 0)
					end
					
					local card = XYZUI.Card(jobCats[m.category], 50)
					local jobName = XYZUI.PanelText(card, m.name, 30, TEXT_ALIGN_LEFT)
					jobName:Dock(FILL)

					local toggleWhitelist = XYZUI.ButtonInput(card, "Void", function(self)
						if self.disText == "Done" then return end
						net.Start("xWhitelistToggleBlacklistID")
							net.WriteString((isstring(activeUser) and activeUser) or activeUser:SteamID64())
							net.WriteString(m.command)
							net.WriteBool(self.whitelisted)
						net.SendToServer()
    					self.headerColor = Color(155, 155, 155)
    					self.disText = "Done"
					end)
					if usersJobs.blacklist[m.command] then
    					toggleWhitelist.headerColor = Color(175, 10, 30)
    					toggleWhitelist.disText = "Unblacklist"
    					toggleWhitelist.whitelisted = true
						toggleWhitelist:Dock(RIGHT)
						toggleWhitelist:SetWide(100)
						toggleWhitelist:DockMargin(4, 4, 4, 4)
					else
    					toggleWhitelist.headerColor = Color(10, 175, 30)
    					toggleWhitelist.disText = "Blacklist"
    					toggleWhitelist.whitelisted = false
						toggleWhitelist:Dock(RIGHT)
						toggleWhitelist:SetWide(100)
						toggleWhitelist:DockMargin(4, 4, 4, 4)
					end

					XYZUI.AddToExpandableCardBody(jobCats[m.category], card)
				end
			end
		end)
    end)
end


concommand.Add("xwhitelist_menu", function()
	xWhitelist.Core.UI()
end)

hook.Add("XYZOnPlayerChat", "xWhitelistOpenMenu", function(ply, msg)
	if not (ply == LocalPlayer()) then return end
	if not (string.lower(msg) == "!xwhitelist") then return end
	
	xWhitelist.Core.UI()
end)