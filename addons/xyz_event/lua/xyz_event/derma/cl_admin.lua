local baseActions = {
	-- Add Team
	{
		name = "Add Another Team",
		color = Color(0, 150, 0),
		action = function()
			net.Start("EventSystem:UI:Admin:SendAction")
				net.WriteString("add_team")
				net.WriteTable({refresh = true})
			net.SendToServer()
		end
	},
	-- Move Team
	{
		name = "Remove A Team",
		color = Color(150, 0, 0),
		action = function(teamID)
			net.Start("EventSystem:UI:Admin:SendAction")
				net.WriteString("remove_team")
				net.WriteTable({refresh = true, id = teamID})
			net.SendToServer()
		end,
		populate = function(data)
			local choices = {}
			for k, v in pairs(data.teamMembers) do
				if table.Count(data.teamMembers[k]) > 0 then continue end
				table.insert(choices, {name = "Team "..EventSystem.Config.TeamNames[k], value = k})
			end

			return choices
		end
	},
	-- Balance All Teams
	{
		name = "Auto Balance All Teams",
		action = function()
			XYZUI.Confirm("Balance All Teams?", nil, function()
				net.Start("EventSystem:UI:Admin:SendAction")
						net.WriteString("balance_team")
						net.WriteTable({refresh = true})
				net.SendToServer()
			end)
		end
	},
	-- Set Default Lives
	{
		name = "Set Default Lives",
		action = function()
			XYZUI.PromptInput("Default Lives", nil, "1 (0 = Infinite)", function(amount)
				amount = tonumber(amount)
				if not amount then return end
				if amount < 0 then return end

				net.Start("EventSystem:UI:Admin:SendAction")
					net.WriteString("default_lives")
					net.WriteTable({refresh = true, lives = amount})
				net.SendToServer()
			end)
		end
	},
	-- Toggle Points On Kills
	{
		name = "Toggle Points On Kills",
		action = function(data)
			XYZUI.Confirm(data.pointsOnKills and "Disable Points On Kills" or "Enable Points On Kills", data.pointsOnKills and Color(200, 0, 0) or Color(0, 200, 0), function()
				net.Start("EventSystem:UI:Admin:SendAction")
					net.WriteString("toggle_kill_points")
					net.WriteTable({refresh = true})
				net.SendToServer()
			end)
		end
	},
	-- Toggle Points On Kills
	{
		name = "Toggle Team Damage",
		action = function(data)
			XYZUI.Confirm(data.teamDamage and "Disable Team Damage" or "Enable Team Damage", nil, function()
				net.Start("EventSystem:UI:Admin:SendAction")
					net.WriteString("toggle_team_damage")
					net.WriteTable({refresh = true})
				net.SendToServer()
			end)
		end
	},
	-- Refresh Users
	{
		name = "Toggle Prop Spawning",
		action = function(data)
			XYZUI.Confirm(data.blockPropSpawning and "Enable Prop Spawning" or "Disable Prop Spawning", nil, function()
				net.Start("EventSystem:UI:Admin:SendAction")
					net.WriteString("toggle_prop_spawning")
					net.WriteTable({refresh = true})
				net.SendToServer()
			end)
		end
	},
	-- Toggle Points On Kills
	{
		name = "Release Invites",
		color = Color(0, 200, 0),
		action = function(data)
			XYZUI.Confirm("Allow People To Join The Event?", Color(0, 200, 0), function()
				net.Start("EventSystem:UI:Admin:SendAction")
					net.WriteString("release_invites")
					net.WriteTable({})
				net.SendToServer()
			end)
		end
	},
	-- Toggle Points On Kills
	{
		name = "Cancel Event",
		color = Color(200, 0, 0),
		action = function(data)
			XYZUI.Confirm("End Event!", Color(200, 0, 0), function()
				net.Start("EventSystem:UI:Admin:SendAction")
					net.WriteString("cancel_event")
					net.WriteTable({refresh = true})
				net.SendToServer()
			end)
		end
	},
	-- Set Loadout
	{
		name = "Loadout",
		action = function(data, frame)
			frame:Close()
			EventSystem.Core.EventLoadouts(data)
		end
	},
	-- Event Doors
	{
		name = "Toggle 1st Event Door",
		action = function(data, frame)
			net.Start("EventSystem:UI:Admin:SendAction")
				net.WriteString("toggle_doors")
				net.WriteTable({door = 1})
			net.SendToServer()
		end
	},
	{
		name = "Toggle 2nd Event Door",
		action = function(data, frame)
			net.Start("EventSystem:UI:Admin:SendAction")
				net.WriteString("toggle_doors")
				net.WriteTable({door = 2})
			net.SendToServer()
		end
	},
	-- End Event
	{
		name = "End Event",
		color = Color(0, 200, 200),
		action = function(data, frame)
			frame:Close()
			EventSystem.Core.EventWinnersUI()
		end
	},
	-- Refresh Users
	{
		name = "Refresh Users",
		action = function()
			net.Start("EventSystem:UI:Admin:RequestData")
			net.SendToServer()
		end
	} 
}
local actions = {
	-- Move Team
	{
		name = "Change Team",
		action = function(targets, selected)
			if not targets then return end

			XYZUI.Confirm("Move To Different Team?", nil, function()
				net.Start("EventSystem:UI:Admin:SendAction")
						net.WriteString("move_team")
						net.WriteTable({refresh = true, targets = targets, teamID = selected})
				net.SendToServer()
			end)
		end,
		populate = function(data)
			local choices = {}
			for k, v in pairs(data.teamMembers) do
				table.insert(choices, {name = "Team "..EventSystem.Config.TeamNames[k], value = k})
			end

			return choices
		end
	},
	-- Set Color
	{
		name = "Set Color",
		action = function(targets, selected)
			if not targets then return end

			net.Start("EventSystem:UI:Admin:SendAction")
					net.WriteString("set_color")
					net.WriteTable({refresh = true, targets = targets, color = selected})
			net.SendToServer()
		end,
		populate = function(data)
			return {
				{name = "Red", value = Color(255, 0, 0)},
				{name = "Green", value = Color(0, 255, 0)},
				{name = "Blue", value = Color(0, 0, 255)},
				{name = "Yellow", value = Color(255, 255, 0)},
				{name = "Purple", value = Color(155, 0, 255)},
				{name = "Cyan", value = Color(0, 255, 255)},
				{name = "Orange", value = Color(255, 155, 0)},
				{name = "Hot Pink", value = Color(255, 0, 155)},
				{name = "Pink", value = Color(255, 155, 155)},
				{name = "Lime", value = Color(155, 255, 0)}
			}
		end
	},
	-- Set Health
	{
		name = "Set Health",
		color = Color(100, 0, 0), -- Optional,
		action = function(targets)
			if not targets then return end

			XYZUI.PromptInput("Set Health", Color(100, 0, 0), 100, function(amount)
				amount = tonumber(amount)
				if not amount then return end
				if amount < 1 then return end

				net.Start("EventSystem:UI:Admin:SendAction")
					net.WriteString("set_health")
					net.WriteTable({targets = targets, amount = amount})
				net.SendToServer()
			end)
		end
	},
	-- Set Armour
	{
		name = "Set Armour",
		color = Color(0, 0, 155), -- Optional,
		action = function(targets)
			if not targets then return end

			XYZUI.PromptInput("Set Armour", Color(0, 0, 100), 100, function(amount)
				amount = tonumber(amount)
				if not amount then return end
				if amount < 1 then return end

				net.Start("EventSystem:UI:Admin:SendAction")
					net.WriteString("set_armour")
					net.WriteTable({targets = targets, amount = amount})
				net.SendToServer()
			end)
		end
	},
	-- Strip Weapons
	{
		name = "Strip Weapons",
		action = function(targets)
			if not targets then return end

			net.Start("EventSystem:UI:Admin:SendAction")
				net.WriteString("strip_weapons")
				net.WriteTable({targets = targets})
			net.SendToServer()
		end
	},
	-- Set Model
	{
		name = "Set Models",
		action = function(targets)
			if not targets then return end

			XYZUI.PromptInput("Set Model", Color(0, 0, 100), "models/props_borealis/borealis_door001a.mdl", function(model)
				net.Start("EventSystem:UI:Admin:SendAction")
						net.WriteString("set_model")
						net.WriteTable({targets = targets, model = model})
				net.SendToServer()
			end)
		end
	},
	-- Give Weapon
	{
		name = "Give Weapon",
		action = function(targets)
			if not targets then return end

			XYZUI.PromptInput("Give Weapon", Color(0, 0, 100), "cw_ak74", function(wep)
				net.Start("EventSystem:UI:Admin:SendAction")
						net.WriteString("give_weapon")
						net.WriteTable({targets = targets, weapon = wep})
				net.SendToServer()
			end)
		end
	},
	-- Set Lives
	{
		name = "Set Lives",
		action = function(targets)
			if not targets then return end

			XYZUI.PromptInput("Set Lives (0 = Unlimited)", nil, "5", function(amount)
				amount = tonumber(amount)
				if not amount then return end
				if amount < 0 then return end

				net.Start("EventSystem:UI:Admin:SendAction")
						net.WriteString("set_lives")
						net.WriteTable({refresh = true, targets = targets, lives = amount})
				net.SendToServer()
			end)
		end
	},
	-- Kick from event
	{
		name = "Kick From Event",
		color = Color(200, 0, 0),
		action = function(targets)
			if not targets then return end

			XYZUI.Confirm("Kick From Event?", nil, function()
				net.Start("EventSystem:UI:Admin:SendAction")
						net.WriteString("kick")
						net.WriteTable({refresh = true, targets = targets})
				net.SendToServer()
			end)
		end
	},
	-- Reset Points
	{
		name = "Reset Points",
		color = Color(100, 0, 0),
		action = function(targets)
			XYZUI.Confirm("Reset Points?", nil, function()
				net.Start("EventSystem:UI:Admin:SendAction")
						net.WriteString("reset_points")
						net.WriteTable({refresh = true, targets = targets})
				net.SendToServer()
			end)
		end
	},
	-- Add Points
	{
		name = "Add Points",
		color = Color(0, 120, 0),
		action = function(targets)
			XYZUI.PromptInput("Add Points", Color(0, 120, 0), 2, function(amount)
				amount = tonumber(amount)
				if not amount then return end
				if amount < 1 then return end

				net.Start("EventSystem:UI:Admin:SendAction")
						net.WriteString("add_points")
						net.WriteTable({refresh = true, targets = targets, points = amount})
				net.SendToServer()
			end)
		end
	},
	-- Remove Points
	{
		name = "Remove Points",
		color = Color(150, 0, 0),
		action = function(targets)
			XYZUI.PromptInput("Remove Points", Color(150, 0, 0), 2, function(amount)
				amount = tonumber(amount)
				if not amount then return end
				if amount < 1 then return end

				net.Start("EventSystem:UI:Admin:SendAction")
						net.WriteString("remove_points")
						net.WriteTable({refresh = true, targets = targets, points = amount})
				net.SendToServer()
			end)
		end
	},
	-- Build tools
	{
		name = "Give Build Tools",
		action = function(targets)
			if not targets then return end

			XYZUI.Confirm("Give Build Tools", nil, function()
				net.Start("EventSystem:UI:Admin:SendAction")
					net.WriteString("give_buildtools")
					net.WriteTable({targets = targets})
				net.SendToServer()
			end)
		end
	},
	-- Gag
	{
		name = "Gag",
		action = function(targets)
			if not targets then return end

			net.Start("EventSystem:UI:Admin:SendAction")
				net.WriteString("gag")
				net.WriteTable({targets = targets})
			net.SendToServer()
		end
	},
	-- Ungag
	{
		name = "Ungag",
		action = function(targets)
			if not targets then return end

			net.Start("EventSystem:UI:Admin:SendAction")
				net.WriteString("ungag")
				net.WriteTable({targets = targets})
			net.SendToServer()
		end
	},
	-- Mute
	{
		name = "Mute",
		action = function(targets)
			if not targets then return end

			net.Start("EventSystem:UI:Admin:SendAction")
				net.WriteString("mute")
				net.WriteTable({targets = targets})
			net.SendToServer()
		end
	},
	-- Unmute
	{
		name = "Unmute",
		action = function(targets)
			if not targets then return end

			net.Start("EventSystem:UI:Admin:SendAction")
				net.WriteString("unmute")
				net.WriteTable({targets = targets})
			net.SendToServer()
		end
	},
	-- Bring
	{
		name = "Bring to you",
		action = function(targets)
			if not targets then return end

			net.Start("EventSystem:UI:Admin:SendAction")
				net.WriteString("bring")
				net.WriteTable({targets = targets})
			net.SendToServer()
		end
	},
	-- Bring
	{
		name = "Broadcast Message",
		action = function(targets)
			XYZUI.PromptInput("Your Message", Color(150, 0, 0), 2, function(msg)
				if msg == "" then return end

				net.Start("EventSystem:UI:Admin:SendAction")
						net.WriteString("broadcast_message")
						net.WriteTable({targets = targets, message = msg})
				net.SendToServer()
			end)
		end
	}
}

function EventSystem.Core.GameMasterUI()
	local frame = XYZUI.Frame("GameMaster Interface", EventSystem.Config.Color)
	frame:SetSize(ScrW()*0.9, ScrH()*0.9)
	frame:Center()

	local shell = XYZUI.Container(frame)
	shell.Paint = nil

	net.Start("EventSystem:UI:Admin:RequestData")
	net.SendToServer()

	net.Receive("EventSystem:UI:Admin:RequestData", function()
		if not IsValid(frame) then return end

		shell:Clear()
		local data = net.ReadTable()

		local teamsShell = vgui.Create("DPanel", shell)
		teamsShell:Dock(TOP)
		teamsShell:SetHeight(shell:GetTall()*0.5)
		teamsShell.Paint = nil

		local teamTables = {}
		for i, v in pairs(data.teamMembers) do
			local teams = vgui.Create( "DListView", teamsShell)
			teams:Dock(LEFT)
			teams:SetWide(shell:GetWide()/data.teams)
			teams:SetMultiSelect(true)
			teams:AddColumn("Team "..EventSystem.Config.TeamNames[i])
			teams:AddColumn("Points")
	
			teamTables[i] = teams
	
			if data.teamMembers[i] then
				for k, v in pairs(data.teamMembers[i]) do
					local line = teams:AddLine(v:Name(), data.points[v])
					line.ply = v
				end
			end

			teams.OnRowRightClick = function(line, lineID)
				local ply = teams:GetLine(lineID).ply
				local popup = DermaMenu() 

				-- Information
				popup:AddOption(ply:Name())
				popup:AddOption("Remaining Lives: "..data.remainingLives[ply])
				popup:AddOption("Points: "..data.points[ply])
				local teamsPoints = 0
				for k, v in pairs(data.teamMembers[i]) do
					teamsPoints = teamsPoints + data.points[v]
				end
				popup:AddOption("Team Points: "..teamsPoints)
				popup:AddSpacer()

				for k, a in ipairs(actions) do
					if a.populate then
						local subMenu = popup:AddSubMenu(a.name)

						local choices = a.populate(data)
						for k, c in pairs(choices) do
							subMenu:AddOption(c.name, function()
								a.action({ply}, c.value)
							end)
						end
					else
						popup:AddOption(a.name, function()
							a.action({teams:GetLine(lineID).ply})
						end)
					end

				end

				popup:AddSpacer()

				popup:AddOption("Clear Selected In This Team", function()
					teams:ClearSelection()
				end)
				popup:AddOption("Close")
				popup:Open()
			end
		end

		local actionsShell = vgui.Create("DPanel", shell)
		actionsShell:Dock(TOP)
		actionsShell:SetHeight(shell:GetTall()*0.5)
		actionsShell.Paint = nil

		local generalActionsShell = vgui.Create("DPanel", actionsShell)
		generalActionsShell:Dock(LEFT)
		generalActionsShell:SetWide(shell:GetWide()*0.5)
		generalActionsShell.Paint = nil

		-- General Action shit
			local _, generalActionsShellList = XYZUI.Lists(generalActionsShell, 1)
			generalActionsShellList:DockMargin(0, 5, 5, 0)

			for k, v in ipairs(baseActions) do
				local btn
				if v.populate then
					btn = XYZUI.DropDownList(generalActionsShellList, v.name, function(name, dropData)
						v.action(dropData)
					end)

					local choices = v.populate(data)
					for k, v in pairs(choices) do
						XYZUI.AddDropDownOption(btn, v.name, v.value)
					end
				else
					btn = XYZUI.ButtonInput(generalActionsShellList, v.name, function()
						v.action(data, frame)
					end)
				end

				
				if v.color then
					btn.headerColor = v.color
				end
				btn:DockMargin(0, 0, 0, 5)
			end

		local teamActionsShell = vgui.Create("DPanel", actionsShell)
		teamActionsShell:Dock(RIGHT)
		teamActionsShell:SetWide(shell:GetWide()*0.5)
		teamActionsShell.Paint = nil

		-- General Action shit
			local function getTargets(targetType)
				local targets = {}
				if targetType == "everyone" then
					for k, v in pairs(data.teamMembers) do
						for i, p in pairs(v) do
							table.insert(targets, p)
						end
					end
				elseif targetType == "selected" then
					for k, v in pairs(teamTables) do
						local selected = v:GetSelected()

						for n, m in pairs(selected) do
							table.insert(targets, m.ply)
						end
					end
				elseif string.find(targetType, "team_") then
					local teamID = tonumber(string.Explode("_", targetType, false)[2])

					targets = data.teamMembers[teamID]
				end

				return targets
			end

			local _, teamActionsShellList = XYZUI.Lists(teamActionsShell, 1)
			teamActionsShellList:DockMargin(5, 5, 0, 0)

			-- Target Users
			local targets = nil
			local teamTarget = XYZUI.DropDownList(teamActionsShellList, "Choose Targets", function(name, targetType)
				targets = targetType
			end)
			teamTarget.headerColor = Color(100, 100, 100)
			XYZUI.AddDropDownOption(teamTarget, "Everyone", "everyone")
			XYZUI.AddDropDownOption(teamTarget, "Selected", "selected")
			for k, v in pairs(teamTables) do
				XYZUI.AddDropDownOption(teamTarget, "Team "..EventSystem.Config.TeamNames[k], "team_"..k)
			end

			for k, v in ipairs(actions) do
				local btn
				if v.populate then
					btn = XYZUI.DropDownList(teamActionsShellList, v.name, function(name, dropData)
						if not targets then return end
	
						v.action(getTargets(targets), dropData)
					end)

					local choices = v.populate(data)
					for k, v in pairs(choices) do
						XYZUI.AddDropDownOption(btn, v.name, v.value)
					end
				else
					btn = XYZUI.ButtonInput(teamActionsShellList, v.name, function()
						if not targets then return end
	
						v.action(getTargets(targets))
					end)
				end

				
				if v.color then
					btn.headerColor = v.color
				end
				btn:DockMargin(0, 5, 0, 0)
			end
	end)
end



function EventSystem.Core.CreateEventUI()
	local frame = XYZUI.Frame("Create Event", EventSystem.Config.Color)
	frame:SetSize(ScrH()*0.7, ScrH()*0.5)
	frame:Center()

    local shell = XYZUI.Container(frame)
    shell:DockPadding(10, 10, 10, 10)

    -- Title
	local title = XYZUI.Title(shell, "Create a new event", nil, 50, 0, TEXT_ALIGN_CENTER)
	title:SetTall(50)

	-- Event Name
    XYZUI.PanelText(shell, "Event Name:", 35, TEXT_ALIGN_LEFT)
    local nameEntry, cont = XYZUI.TextInput(shell)

	-- Event Description
    XYZUI.PanelText(shell, "Event Description:", 35, TEXT_ALIGN_LEFT)
    local descEntry, cont = XYZUI.TextInput(shell, true)

	-- Event Reward
    XYZUI.PanelText(shell, "Event Prize (Credit Amount):", 35, TEXT_ALIGN_LEFT)
    local rewardEntry, cont = XYZUI.TextInput(shell)
    rewardEntry:SetNumeric(true)


    local submit = XYZUI.ButtonInput(shell, "Start Event Preparation", function()
    	local name = nameEntry:GetText()
    	local desc = descEntry:GetText()
    	local prize = rewardEntry:GetText()
    	prize = tonumber(prize)

    	if name == "" then return end
    	if desc == "" then return end
    	if prize < 100 then return end
    	if prize > 15000 then return end

    	net.Start("EventSystem:UI:Admin:CreateEvent:Start")
    		net.WriteString(name)
    		net.WriteString(desc)
    		net.WriteUInt(prize, 14)
    	net.SendToServer()

    	frame:Close()
    	timer.Simple(0, function()
    		EventSystem.Core.GameMasterUI()
    	end)
    end)
    submit:Dock(BOTTOM)
end


function EventSystem.Core.AddSpawnPointUI()
	local frame = XYZUI.Frame("Place/Delete Spawn Point", EventSystem.Config.Color)
	frame:SetSize(ScrH()*0.6, 335)
	frame:Center()

    local shell = XYZUI.Container(frame)
    shell:DockPadding(10, 10, 10, 10)

    local shellBottom = XYZUI.Container(frame)
    shellBottom:Dock(BOTTOM)
    shellBottom:SetTall(110)
    shellBottom:DockPadding(10, 10, 10, 10)
    shellBottom:DockMargin(0, 5, 0, 0)


	net.Start("EventSystem:UI:Admin:RequestData")
	net.SendToServer()

	net.Receive("EventSystem:UI:Admin:RequestData", function()
		if not IsValid(shell) then return end
		local data = net.ReadTable()

		-- Top panel
			-- Title
			local title = XYZUI.Title(shell, "Add a spawn point!", nil, 50, 0, TEXT_ALIGN_CENTER)
			title:SetTall(50)
	
			-- Team
			local targetTeam
			teamDropdown = XYZUI.DropDownList(shell, "Event Team", function(name, dropData)
				targetTeam = dropData
			end)
			XYZUI.AddDropDownOption(teamDropdown, "Everyone", "everyone")
	
			for k, v in pairs(data.teamMembers) do
				XYZUI.AddDropDownOption(teamDropdown, "Team "..EventSystem.Config.TeamNames[k], "team_"..k)
			end
	
    		local submit = XYZUI.ButtonInput(shell, "Place Spawn Point", function()
    			if not targetTeam then return end
	
    			net.Start("EventSystem:UI:Admin:AddSpawnPoint")
    				net.WriteString(targetTeam)
    				net.WriteVector(LocalPlayer():GetEyeTrace().HitPos)
    			net.SendToServer()
	
    			frame:Close()
    		end)
    		submit:Dock(BOTTOM)

		-- Bottom panel
			-- Title
			local title = XYZUI.Title(shellBottom, "Remove closest spawn point!", nil, 50, 0, TEXT_ALIGN_CENTER)
			title:SetTall(50)
	
    		local submit = XYZUI.ButtonInput(shellBottom, "Remove Spawn Point", function()
    			local teamID, spawnID
    			local plyPos = LocalPlayer():GetPos()
				for k, v in pairs(data.spawns) do
					for n, m in pairs(v) do
						if not teamID then 
							teamID = k
							spawnID = n

							continue
						end

						local curHighest = data.spawns[teamID][spawnID]

						if plyPos:Distance(m) < plyPos:Distance(curHighest) then
							teamID = k
							spawnID = n
						end
					end
				end

				if (not teamID) or (not spawnID) then return end

    			net.Start("EventSystem:UI:Admin:RemoveSpawnPoint")
    				net.WriteString(teamID)
    				net.WriteUInt(spawnID, 32)
    			net.SendToServer()
	
    			frame:Close()
    		end)
			submit.headerColor = Color(200, 0, 0)
    		submit:Dock(BOTTOM)
	end)
end

function EventSystem.Core.WipeSpawnPointUI()
	local frame = XYZUI.Frame("Wipe Spawn Point", EventSystem.Config.Color)
	frame:SetSize(ScrH()*0.5, 180)
	frame:Center()

    local shell = XYZUI.Container(frame)
    shell:DockPadding(10, 10, 10, 10)

	-- Title
	local title = XYZUI.Title(shell, "Remove all spawn points!", nil, 50, 0, TEXT_ALIGN_CENTER)
	title:SetTall(50)

    local submit = XYZUI.ButtonInput(shell, "Remove Spawn Point", function()
    	net.Start("EventSystem:UI:Admin:WipeSpawnPoint")
    	net.SendToServer()

    	frame:Close()
    end)
	submit.headerColor = Color(200, 0, 0)
    submit:Dock(BOTTOM)
end

function EventSystem.Core.SpawnEntity()
	local frame = XYZUI.Frame("Spawn Entity", EventSystem.Config.Color)
	frame:SetSize(ScrH()*0.5, 220)
	frame:Center()

    local shell = XYZUI.Container(frame)
    shell:DockPadding(10, 10, 10, 10)

	-- Title
	local title = XYZUI.Title(shell, "Spawn an entity!", nil, 50, 0, TEXT_ALIGN_CENTER)
	title:SetTall(50)

	local entEntry, entCont = XYZUI.TextInput(shell)
	entEntry.placeholder = "entity class"

    local submit = XYZUI.ButtonInput(shell, "Spawn Entity", function()
    	local class = entEntry:GetText()
    	if not class then return end
    	if class == "" then return end
    	
    	net.Start("EventSystem:UI:Admin:SpawnEntity")
    		net.WriteString(class)
    	net.SendToServer()

    	frame:Close()
    end)
    submit:Dock(BOTTOM)
end

function EventSystem.Core.EventWinnersUI()
	local frame = XYZUI.Frame("End Event", EventSystem.Config.Color)
	frame:SetSize(ScrH()*0.5, ScrH()*0.5)
	frame:Center()

    local shell = XYZUI.Container(frame)
    shell:DockPadding(10, 10, 10, 10)

	-- Title
	local title = XYZUI.Title(shell, "End the event!", nil, 50, 0, TEXT_ALIGN_CENTER)
	title:SetTall(50)


	local _, winnersShellList = XYZUI.Lists(shell, 1)
	winnersShellList:DockMargin(0, 5, 5, 0)
	winnersShellList:Dock(FILL)
	winnersShellList.Paint = nil

	-- Players
	local winners = {}
	local winnersDropDown = XYZUI.DropDownList(shell, "Winners", function(name, ply)
		if winners[ply] then return end
		winners[ply] = true

		local card = XYZUI.Card(winnersShellList, 70)
		card:DockMargin(0, 0, 0, 5)
		card:DockPadding(5, 5, 5, 5)

		local title = XYZUI.Title(card, ply:Name(), ply:SteamID64(), 35, 20)
		title:Dock(FILL)

		local avatar = vgui.Create("AvatarImage", card)
		avatar:Dock(LEFT)
		avatar:SetPlayer(ply, 64)

    	local remove = XYZUI.ButtonInput(card, "X", function()
    		card:Remove()
    		winners[ply] = nil
    	end)
    	remove.headerColor = Color(255, 0, 0)
    	remove:Dock(RIGHT)
	end)
	
	for k, v in pairs(player.GetAll()) do
		XYZUI.AddDropDownOption(winnersDropDown, v:Name(), v)
	end

	-- Event Winners
    XYZUI.PanelText(shell, "Event Winners:", 35, TEXT_ALIGN_LEFT)

	-- Submit
    local submit = XYZUI.ButtonInput(shell, "End Event", function()
    	net.Start("EventSystem:UI:Admin:EndEvent")
    		net.WriteTable(winners)
    	net.SendToServer()

    	frame:Close()
    end)
    submit:Dock(BOTTOM)
    submit:DockMargin(0, 5, 0, 0)
end

function EventSystem.Core.EventLoadouts(data)
	local frame = XYZUI.Frame("Loadouts", EventSystem.Config.Color)
	frame:SetSize(ScrH()*0.5, ScrH()*0.5)
	frame:Center()

    local shell = XYZUI.Container(frame)
    shell:DockPadding(10, 10, 10, 10)

	-- Title
	local title = XYZUI.Title(shell, "Edit Loadout!", nil, 50, 0, TEXT_ALIGN_CENTER)
	title:SetTall(50)


	local _, wepShellList = XYZUI.Lists(shell, 1)
	wepShellList:DockMargin(0, 5, 5, 0)
	wepShellList:Dock(FILL)
	wepShellList.Paint = nil

	-- Weapons
	local weps = {}
	for k, v in pairs(data.loadout) do
    	local wepData = weapons.Get(k)
		weps[k] = true

		local card = XYZUI.Card(wepShellList, 45)
		card:DockMargin(0, 0, 0, 5)
		card:DockPadding(5, 5, 5, 5)

		local title = XYZUI.Title(card, wepData.PrintName, nil, 35, 0)
		title:Dock(FILL)

    	local remove = XYZUI.ButtonInput(card, "X", function()
    		card:Remove()
    		weps[k] = nil
    	end)
    	remove.headerColor = Color(255, 0, 0)
    	remove:Dock(RIGHT)
    	remove:SetWide(35)
	end

	-- Input
	local wepInput, wepInputCont = XYZUI.TextInput(shell)
	wepInputCont:DockMargin(0, 0, 0, 5)

    local wepAdd = XYZUI.ButtonInput(shell, "Add Weapon", function()
    	local wep = wepInput:GetText()
    	local wepData = weapons.Get(wep)

    	if not wepData then return end

		if weps[wep] then return end
		weps[wep] = true

		local card = XYZUI.Card(wepShellList, 45)
		card:DockMargin(0, 0, 0, 5)
		card:DockPadding(5, 5, 5, 5)

		local title = XYZUI.Title(card, wepData.PrintName, nil, 35, 0)
		title:Dock(FILL)

    	local remove = XYZUI.ButtonInput(card, "X", function()
    		card:Remove()
    		weps[wep] = nil
    	end)	
    	remove.headerColor = Color(255, 0, 0)
    	remove:Dock(RIGHT)
    	remove:SetWide(35)
    end)
	wepAdd.headerColor = Color(0, 200, 0)

	-- Loadout Title
    XYZUI.PanelText(shell, "Loadout:", 35, TEXT_ALIGN_LEFT)

	-- Submit
    local submit = XYZUI.ButtonInput(shell, "Save Loadout", function()
		net.Start("EventSystem:UI:Admin:SendAction")
			net.WriteString("loadout")
			net.WriteTable({refresh = true, loadout = weps})
		net.SendToServer()

    	frame:Close()
    end)
    submit:Dock(BOTTOM)
    submit:DockMargin(0, 5, 0, 0)
end