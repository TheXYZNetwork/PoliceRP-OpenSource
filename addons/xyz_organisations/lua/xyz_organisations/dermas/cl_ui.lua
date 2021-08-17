local function manageMember(ply, plyName, plyID, role)
	net.Start("xyz_orgs_info")
	net.WriteString("roles")
	net.SendToServer()
	net.Receive("xyz_orgs_info", function()
		local roles = net.ReadTable()
		local frame = XYZUI.Frame("Manage "..plyName, XYZ_ORGS.Config.Color)
		frame:SetSize(ScrW()*0.3, ScrH()*0.3)
		frame:Center()

		local shell = XYZUI.Container(frame)

		local dropdown = XYZUI.DropDownList(shell, roles[role].name, function(name, value)
	        net.Start("xyz_orgs_updatemember")
			net.WriteString(plyID)
			net.WriteUInt(value, 16)
			net.SendToServer()
	    end)

		for k, v in pairs(roles) do
			XYZUI.AddDropDownOption(dropdown, v.name, k)
		end

		local btnCnt = vgui.Create("DPanel", shell)
		btnCnt.Paint = function() end
		btnCnt:Dock(BOTTOM)
		btnCnt:DockMargin(0, 0, 0, 0)
		btnCnt:SetTall(50)
		btnCnt.headerColor = XYZ_ORGS.Config.Color

		local kick = XYZUI.ButtonInput(btnCnt, "Kick", function()
			net.Start("xyz_orgs_discipline")
			net.WriteString("kick")
			net.WriteString(plyID)
			net.SendToServer()
			frame:Close()
		end)
		kick:SetWide(75)
		kick:Dock(LEFT)
		kick:DockMargin(10, 10, 10, 10)

		local transfer = XYZUI.ButtonInput(btnCnt, "Transfer", function()
			net.Start("xyz_orgs_transfer")
			net.WriteString(plyID)
			net.SendToServer()
			frame:Close()
		end)
		transfer:SetWide(75)
		transfer:Dock(LEFT)
		transfer:DockMargin(10, 10, 10, 10)
	end)
end

local function manageRole(role, roleID)
	local stateCache = {}
	local frame = XYZUI.Frame("Manage "..role.name, XYZ_ORGS.Config.Color)
	frame:SetSize(ScrW()*0.4, ScrH()*0.4)
	frame:Center()

	local shell = XYZUI.Container(frame)
	shell.Paint = function() end
	local _, permList = XYZUI.Lists(shell, 1)
	permList:DockPadding(0, 0, 0, 0)
	permList:Dock(FILL)

	for k, v in pairs(XYZ_ORGS.Config.Permissions) do
		if k == "NONE" then continue end
		local t = XYZUI.Card(permList, 40)
		t:DockMargin(0, 0, 0, 5)
		t:Dock(TOP)

		local a = XYZUI.PanelText(t, k, 35, TEXT_ALIGN_LEFT)
		a:Dock(FILL)

		local s, container = XYZUI.ToggleInput(t)
		container:Dock(RIGHT)
		container:SetSize(31, 31)
		container:DockMargin(5, 6, 1, 0)
		s.state = XYZ_ORGS.Core.HasPerms(role.perms, k)

		s.key = k
		table.insert(stateCache, s)
	end

	local save = XYZUI.ButtonInput(frame, "Save", function()
		local perms = 0
		for k, v in pairs(stateCache) do
			if v.state then perms = perms + XYZ_ORGS.Config.Permissions[v.key] end
		end
		net.Start("xyz_orgs_managerole")
		net.WriteUInt(roleID, 32)
		net.WriteUInt(perms, 32)
		net.SendToServer()
		frame:Close()
	end)
	save:Dock(BOTTOM)
end

local function createRole()
	local stateCache = {}
	local frame = XYZUI.Frame("Create Role", XYZ_ORGS.Config.Color)
	frame:SetSize(ScrW()*0.4, ScrH()*0.4)
	frame:Center()

	local shell = XYZUI.Container(frame)
	shell.Paint = function() end
	local entry, cont = XYZUI.TextInput(frame)
	entry.placeholder = "Role Name"
	local _, permList = XYZUI.Lists(shell, 1)
	permList:DockPadding(0, 0, 0, 0)
	permList:Dock(FILL)

	for k, v in pairs(XYZ_ORGS.Config.Permissions) do
		if k == "NONE" then continue end
		local t = XYZUI.Card(permList, 40)
		t:DockMargin(0, 0, 0, 5)
		t:Dock(TOP)

		local a = XYZUI.PanelText(t, k, 35, TEXT_ALIGN_LEFT)
		a:Dock(FILL)

		local s, container = XYZUI.ToggleInput(t)
		container:Dock(RIGHT)
		container:SetSize(31, 31)
		container:DockMargin(5, 6, 1, 0)

		s.key = k
		table.insert(stateCache, s)
	end

	local save = XYZUI.ButtonInput(frame, "Save", function()
		local perms = 0
		for k, v in pairs(stateCache) do
			if v.state then perms = perms + XYZ_ORGS.Config.Permissions[v.key] end
		end
		net.Start("xyz_orgs_createrole")
		net.WriteString(entry:GetValue())
		net.WriteUInt(perms, 32)
		net.SendToServer()
		frame:Close()
	end)
	save:Dock(BOTTOM)
end

net.Receive("xyz_orgs_menu", function()
	local InOrg = net.ReadBool()
	XYZShit.InOrg = InOrg
	local w, h = ScrW()*0.3, ScrH()*0.15
	local frameTitle = "Join or Create Organization"

	if InOrg then
		w, h = ScrW()*0.5, ScrH()*0.5
		frameTitle = "Manage Organization"
	end
	
	local frame = XYZUI.Frame(frameTitle, XYZ_ORGS.Config.Color)
	frame:SetSize(w, h)
	frame:Center()

	local navBar = XYZUI.NavBar(frame, true)
	local shell = XYZUI.Container(frame)

	if not InOrg then 
		XYZUI.AddNavBarPage(navBar, shell, "Join Organization", function(shell)
			local entry, cont = XYZUI.TextInput(shell)
			entry.placeholder = "Invite Code e.g. xyz"

			local btn = XYZUI.ButtonInput(shell, "Join Organization", function(self)
				XYZUI.Confirm("This will cost "..DarkRP.formatMoney(XYZ_ORGS.Config.JoinPrice).."! Are you sure?", XYZ_ORGS.Config.Color, function()
					net.Start("xyz_orgs_join")
					net.WriteString(entry:GetValue())
					net.SendToServer()
					frame:Close()
				end)
			end)
			btn:Dock(BOTTOM)
		end)
		XYZUI.AddNavBarPage(navBar, shell, "Create Organization", function(shell)
			local entry, cont = XYZUI.TextInput(shell)
			entry.placeholder = "Crew Name"

			local btn = XYZUI.ButtonInput(shell, "Create Organization", function(self)
				XYZUI.Confirm("This will cost "..DarkRP.formatMoney(XYZ_ORGS.Config.CreatePrice).."! Are you sure?", XYZ_ORGS.Config.Color, function()
					net.Start("xyz_orgs_create")
					net.WriteString(entry:GetValue())
					net.SendToServer()
					frame:Close()
				end)
			end)
			btn:Dock(BOTTOM)
		end)
	else 
		XYZUI.AddNavBarPage(navBar, shell, "Dashboard", function(shell)
			net.Start("xyz_orgs_info")
			net.WriteString("dashboard")
			net.SendToServer()
			net.Receive("xyz_orgs_info", function()
				local info = net.ReadTable()
				frame.header = string.upper("Manage Organization \""..info.name.."\"")

				local orgStats = XYZUI.Card(shell, 75)
				shell.Paint = nil
				orgStats:InvalidateParent(true)
				orgStats:DockMargin(0, 0, 0, 10)
				orgStats:InvalidateLayout(true)

				local membCount = XYZUI.Title(orgStats, "Members", info.mCount, 40, 30, true)
				membCount:Dock(LEFT)
				membCount:SetWide(orgStats:GetWide()/3)

				local balance = XYZUI.Title(orgStats, "Balance", DarkRP.formatMoney(info.bal), 40, 30, true)
				balance:Dock(LEFT)
				balance:SetWide(orgStats:GetWide()/3)

				local level = XYZUI.Title(orgStats, "Level", info.xp / 1000, 40, 30, true)
				level:Dock(LEFT)
				level:SetWide(orgStats:GetWide()/3)

				XYZUI.Divider(shell)

				local deposit = XYZUI.ButtonInput(shell, "Deposit Money", function(self)
					XYZUI.PromptInput("How much to deposit?", XYZ_ORGS.Config.Color, DarkRP.formatMoney(50000), function(input)
						net.Start("xyz_orgs_deposit")
						net.WriteUInt(input or 50000, 32)
						net.SendToServer()
						frame:Close()
					end)
				end)

				local withdraw = XYZUI.ButtonInput(shell, "Withdraw Money", function(self)
					XYZUI.PromptInput("How much to withdraw?", XYZ_ORGS.Config.Color, DarkRP.formatMoney(50000), function(input)
						net.Start("xyz_orgs_withdraw")
						net.WriteUInt(input or 50000, 32)
						net.SendToServer()
						frame:Close()
					end)
				end)
				withdraw:DockMargin(0, 7.5, 0, 0)

				local copyinv = XYZUI.ButtonInput(shell, "Copy Invite Code", function(self)
					if info.invite then SetClipboardText(info.invite) end
				end)
				copyinv:DockMargin(0, 7.5, 0, 0)

				local leave = XYZUI.ButtonInput(shell, "Leave Organization", function(self)
					XYZUI.Confirm("Are you sure?", XYZ_ORGS.Config.Color, function()
						net.Start("xyz_orgs_leave")
						net.SendToServer()
						frame:Close()
					end)
				end)
				leave:DockMargin(0, 7.5, 0, 0)

				local disband = XYZUI.ButtonInput(shell, "Disband Organization", function(self)
					XYZUI.Confirm("You won't be refunded. Are you sure?", XYZ_ORGS.Config.Color, function()
						net.Start("xyz_orgs_disband")
						net.SendToServer()
						frame:Close()
					end)
				end)
				disband:DockMargin(0, 7.5, 0, 0)

			end)
		end)

		XYZUI.AddNavBarPage(navBar, shell, "Members", function(shell)
			net.Start("xyz_orgs_info")
			net.WriteString("members")
			net.SendToServer()
			net.Receive("xyz_orgs_info", function()
				local members = net.ReadTable()
				local roles = net.ReadTable()
				local rankFilter
				
				local _, plysList = XYZUI.Lists(shell, 1)
		        plysList:DockPadding(0, 0, 0, 0)
		        plysList:Dock(FILL)

		        local function fillMembers(filterOffline, filterRank)
		        	plysList:Clear()
		        	for k, v in pairs(members) do
		        		if filterRank and v ~= filterRank then continue end
		        		local ply = player.GetBySteamID64(k)
		        		if ply == false and filterOffline then continue end
		        		local plyButton = vgui.Create("DPanel", plysList)
		        		plyButton:SetText("")
		        		plyButton:Dock(TOP)
		        		plyButton:DockMargin(0, 0, 0, 5)
		        		plyButton:SetTall(40)
		        		plyButton.Paint = function() end
		        		plyButton.headerColor = Color(35, 35, 35)

		        		plyButton.icon = vgui.Create("AvatarImage", plyButton)
		        		plyButton.icon:SetSize(plyButton:GetTall(), plyButton:GetTall())
		        		plyButton.icon:Dock(LEFT)

		        		local nick
		        		if ply then
		        			plyButton.icon:SetPlayer(ply, 64)
		        		else
		        			steamworks.RequestPlayerInfo(k, function(sN)
		        				nick = sN
		        			end)
		        		end

		        		local btn = XYZUI.ButtonInput(plyButton, ply and ply:Nick() or nick, function()
		        			manageMember(ply or nil, ply and ply:Nick() or nick, k, v)
		        		end)
		        		print(k, v)
		        		btn.role = v
		        		local white = Color(255, 255, 255)
		        		btn.PaintOver = function(self, w, h)
		        			XYZUI.DrawText(roles[self.role].name, 20, w*0.93, h/2, white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		        		end
		        	end
		        end
		        fillMembers()

		        local card = XYZUI.Card(shell, 37.5)
		        card:Dock(TOP)
				local filterOffline, cont = XYZUI.ToggleInput(card, function(self)
					fillMembers(self.state, rankFilter)
				end)
				cont:Dock(LEFT)
				cont:SetSize(31, 31)
				local showOnline = XYZUI.PanelText(card, "Only show online", 30, TEXT_ALIGN_LEFT)
				showOnline:SetWide(190)
				showOnline:Dock(LEFT)

				local rankDropdown = XYZUI.DropDownList(card, "Filter by Rank", function(_, value)
					rankFilter = value
					fillMembers(filterOffline.state, rankFilter)
				end)
				rankDropdown:Dock(RIGHT)
				rankDropdown:SetWide(175)

				for k, v in pairs(roles) do
					XYZUI.AddDropDownOption(rankDropdown, v.name, k)
				end

			end)
		end)
		XYZUI.AddNavBarPage(navBar, shell, "Upgrades", function(shell)
			net.Start("xyz_orgs_info")
			net.WriteString("upgrades")
			net.SendToServer()
			net.Receive("xyz_orgs_info", function()
				local upgrades = net.ReadTable()
				local upgv = XYZ_ORGS.Config.UpgradeValues

				local _, list1 = XYZUI.Lists(shell, 1)
		        list1:DockPadding(0, 0, 0, 0)
		        list1:Dock(FILL)

				for k, v in pairs(upgrades) do
					local card = XYZUI.Card(list1, 70)
					card:InvalidateParent(true)
					card:DockPadding(7, 5, 2, 2)

					local itemTag = XYZUI.Title(card, upgv[k][1], (upgv[k][4] and "Enable" or "Increase of "..upgv[k][3] ).." for "..DarkRP.formatMoney(upgv[k][2])..". Current value: "..upgrades[k], 35)
					itemTag:Dock(FILL)
					itemTag:DockMargin(5, 0, 5, 0)


		
					local tagPurchase = XYZUI.ButtonInput(card, "Purchase", function()
						if upgv[k][5] then
							upgv[k][5](k, frame)
						else
							net.Start("xyz_orgs_upgrade")
							net.WriteString(k)
							net.SendToServer()
							frame:Close()
						end
					end)
					tagPurchase:SetWide(120)
					tagPurchase:Dock(RIGHT)
					tagPurchase:DockMargin(10, 10, 10, 10)

				end


			end)
		end)
		XYZUI.AddNavBarPage(navBar, shell, "Achievements", function(shell)
			net.Start("xyz_orgs_info")
			net.WriteString("achievements")
			net.SendToServer()
			net.Receive("xyz_orgs_info", function()
				local achievements = net.ReadTable()
				
				local _, list1 = XYZUI.Lists(shell, 1)
		        list1:DockPadding(0, 0, 0, 0)
		        list1:Dock(FILL)

				for k, v in pairs(achievements) do
					local card = XYZUI.Card(list1, 70)
					card:InvalidateParent(true)
					card:DockPadding(7, 5, 2, 2)

					local itemTag = XYZUI.Title(card, XYZ_ORGS.Config.Achievements[k].name, "XP: "..XYZ_ORGS.Config.Achievements[k].xp, 35)
					itemTag:Dock(FILL)
					itemTag:DockMargin(5, 0, 5, 0)

					local text = "Locked"
					if v then text = "Unlocked" end
					local tagLock = XYZUI.PanelText(card, text, 30, TEXT_ALIGN_RIGHT)
					tagLock:SetWide(120)
					tagLock:Dock(RIGHT)
					tagLock:DockMargin(10, 10, 10, 10)

				end

			end)
		end)
		XYZUI.AddNavBarPage(navBar, shell, "Inventory", function(shell)
			net.Start("xyz_orgs_info")
			net.WriteString("inventory")
			net.SendToServer()
			net.Receive("xyz_orgs_info", function()
				local inventory = net.ReadTable()
				local stacks = {}
				for k, v in pairs(inventory) do
					if not stacks[v.class] then
						stacks[v.class] = {}
						stacks[v.class].count = 0
						stacks[v.class].sample = v
					end
					stacks[v.class].count = stacks[v.class].count + 1
				end
				local upgv = XYZ_ORGS.Config.UpgradeValues

				local _, list1 = XYZUI.Lists(shell, 1)
		        list1:DockPadding(0, 0, 0, 0)
		        list1:Dock(FILL)

				for k, v in pairs(stacks) do
					local card = XYZUI.Card(list1, 70)
					card:InvalidateParent(true)
					card:DockPadding(7, 5, 2, 2)

					local title = v.sample.data.info.displayName
					if v.sample.data.type.isWeapon then
							title = weapons.Get(v.sample.data.info.displayName).PrintName
					end

					local itemTag = XYZUI.Title(card, title, "Count: x"..v.count, 35)
					itemTag:Dock(FILL)
					itemTag:DockMargin(5, 0, 5, 0)
		
					local withdraw = XYZUI.ButtonInput(card, "Withdraw", function()
						net.Start("xyz_orgs_withdraw_inv")
						net.WriteString(v.sample.class)
						net.SendToServer()
						frame:Close()
					end)
					withdraw:SetWide(120)
					withdraw:Dock(RIGHT)
					withdraw:DockMargin(10, 10, 10, 10)

				end


			end)
		end)
		XYZUI.AddNavBarPage(navBar, shell, "Roles", function(shell)
			net.Start("xyz_orgs_info")
			net.WriteString("roles")
			net.SendToServer()
			net.Receive("xyz_orgs_info", function()
				local roles = net.ReadTable()
				local _, list1 = XYZUI.Lists(shell, 1)
				list1:DockPadding(0, 0, 0, 0)
		        list1:Dock(FILL)

				for k, v in pairs(roles) do
					print(v.name)
					local btn = XYZUI.ButtonInput(list1, v.name, function()
						manageRole(v, k)
					end)
					btn:DockMargin(0, 0, 0, 5)
				end
				local createRole = XYZUI.ButtonInput(shell, "Create role", function()
					createRole()
				end)
				createRole:Dock(BOTTOM)
			end)
		end)
	end

end)