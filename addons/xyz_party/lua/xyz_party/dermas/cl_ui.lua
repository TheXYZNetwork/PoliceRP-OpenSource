local function createParty()
	local frame = XYZUI.Frame("Start a Party", Color(100, 160, 40))
	frame:SetSize(ScrH()*0.7, ScrH()*0.7)
	frame:Center()
	
	local shell = XYZUI.Container(frame)
	shell:DockPadding(10, 5, 10, 10)

		-- Name
		local settingName = XYZUI.Title(shell, "Party Name", nil, 40)
		local settingNameEntry = XYZUI.TextInput(shell)

		-- Password
		local settingPassword = XYZUI.Title(shell, "Password (Leave blank to make an open party)", nil, 40)
		settingPassword:DockMargin(0, 5, 0, 0)
		local settingPasswordEntry = XYZUI.TextInput(shell)

		local settingOrgOnlyEntry
		if XYZShit.InOrg then
			local settingOrgOnly = XYZUI.Title(shell, "Organization Only", nil, 40)
			settingOrgOnly:DockMargin(0, 5, 0, 0)
			settingOrgOnlyEntry = XYZUI.ToggleInput(shell)
		end

		-- Color
		local settingColor = XYZUI.Title(shell, "Party Color", nil, 40)
		settingColor:DockMargin(0, 5, 0, 0)
		local settingColorPallet = vgui.Create("DColorMixer", shell)
		settingColorPallet:SetTall(120)
		settingColorPallet:Dock(TOP)
		settingColorPallet:SetAlphaBar(false)
		settingColorPallet:SetPalette(true)
		settingColorPallet:SetWangs(false)
		settingColorPallet:SetColor(Color(30, 100, 160))

		local submitParty = XYZUI.ButtonInput(shell, "Start Party", function()
			local data = {}
			data.name = (not (settingNameEntry:GetText() == "") and settingNameEntry:GetText()) or "My party"
			data.password = (not (settingPasswordEntry:GetText() == "") and settingPasswordEntry:GetText()) or false
			if XYZShit.InOrg then 
				if settingOrgOnlyEntry.state then
					data.password = false
					data.orgOnly = true
				end
			end
			data.color = settingColorPallet:GetColor()

			net.Start("xyz_party_create")
			net.WriteTable(data)
			net.SendToServer()
			frame:Close()
		end)
		submitParty:Dock(BOTTOM)
	end

local function editParty()
	local frame = XYZUI.Frame("Edit "..XYZParty.Core.MyParty.name, Color(100, 160, 40)) --vgui.Create("xyz_frame")
	frame.Think = function()
		if gui.MouseX() < 10 then frame:Remove() end
	end
	frame:SetSize(ScrH()*0.7, ScrH()*0.7)
	frame:Center()
	frame:ShowCloseButton(false)
	
	local shell = XYZUI.Container(frame)
	shell:DockPadding(10, 5, 10, 10)

		-- Name
		local settingName = XYZUI.Title(shell, "Party Name", nil, 40)
		local settingNameEntry = XYZUI.TextInput(shell)
		settingNameEntry:SetText(XYZParty.Core.MyParty.name)

		-- Password
		local settingPassword = XYZUI.Title(shell, "Password (Leave blank to make an open party)", nil, 40)
		settingPassword:DockMargin(0, 5, 0, 0)
		local settingPasswordEntry = XYZUI.TextInput(shell)

		-- Color
		local settingColor = XYZUI.Title(shell, "Party Color", nil, 40)
		settingColor:DockMargin(0, 5, 0, 0)
		local settingColorPallet = vgui.Create("DColorMixer", shell)
		settingColorPallet:SetTall(120)
		settingColorPallet:Dock(TOP)
		settingColorPallet:SetAlphaBar(false)
		settingColorPallet:SetPalette(true)
		settingColorPallet:SetWangs(false)
		settingColorPallet:SetColor(Color(30, 100, 160))
		settingColorPallet:SetColor(XYZParty.Core.MyParty.color)

	local submitParty = XYZUI.ButtonInput(shell, "Edit Party", function()
		local data = {}
		data.name = (not (settingNameEntry:GetText() == "") and settingNameEntry:GetText()) or "My party"
		data.password = (not (settingPasswordEntry:GetText() == "") and settingPasswordEntry:GetText()) or false
		data.color = settingColorPallet:GetColor()

		net.Start("xyz_party_edit")
			net.WriteTable(data)
		net.SendToServer()
		frame:Close()
	end)
	submitParty:Dock(BOTTOM)
end

local function myParty()
	local frame = XYZUI.Frame(XYZParty.Core.MyParty.name, Color(100, 160, 40)) --vgui.Create("xyz_frame")
	frame:SetSize(ScrH()*0.7, ScrH()*0.7)
	frame:Center()
	
	local shell = XYZUI.Container(frame)
	shell:DockPadding(5, 5, 5, 5)

	local _, membersList = XYZUI.Lists(shell, 1)

		local function populate()
			membersList:Clear()
			for k, v in pairs(XYZParty.Core.MyParty.members) do
				local t = XYZUI.Card(membersList, 56)
				t:DockMargin(0, 0, 0, 5)
				t:Dock(TOP)

				local n = XYZUI.PanelText(t, v:Name(), 30, TEXT_ALIGN_LEFT)
				n:Dock(FILL)
				t.Think = function()
					if not IsValid(v) then
						XYZParty.Core.MyParty.members[k] = nil
						populate()
					end
				end

				if XYZParty.Core.MyParty.leader == LocalPlayer() then
					if v == LocalPlayer() then continue end


					local j = XYZUI.ButtonInput(t, "Kick", function(container)
						net.Start("xyz_party_kick")
							net.WriteEntity(v)
						net.SendToServer()
						table.remove(XYZParty.Core.MyParty.members, k)
						populate()
					end)
					j:DockMargin(10, 10, 10, 10)
					j:Dock(RIGHT)
				end
			end
		end
		populate()

	-- Buttons

	local leaveParty = XYZUI.ButtonInput(shell, "Leave Party", function()
		net.Start("xyz_party_leave")
		net.SendToServer()
		frame:Close()
	end)
	leaveParty:DockMargin(0, 5, 0, 0)
	leaveParty:Dock(BOTTOM)

	if XYZParty.Core.MyParty.leader == LocalPlayer() then
		local editPartyBtn = XYZUI.ButtonInput(shell, "Edit Party", function()
			editParty()
			frame:Close()
		end)
		editPartyBtn:DockMargin(0, 5, 0, 0)
		editPartyBtn:Dock(BOTTOM)
	end
end

local function partyHUB()
	local allParties = net.ReadTable()

	local frame = XYZUI.Frame("Join/Create a Party", Color(100, 160, 40)) --vgui.Create("xyz_frame")
	frame:SetSize(ScrH()*0.7, ScrH()*0.7)
	frame:Center()
	
	local shell = XYZUI.Container(frame)
	shell:DockPadding(5, 5, 5, 5)
	-- Title settings

		local _, partiesList = XYZUI.Lists(shell, 1)

		local function populate()
			partiesList:Clear()
			for k, v in pairs(allParties) do
				local t = XYZUI.Card(partiesList, 56)
				t:DockMargin(0, 0, 0, 5)
				t:Dock(TOP)

				local a = XYZUI.Title(t, v.name, "Leader: "..(IsValid(v.leader) and v.leader:Name() or "Unknown").." | ".."Members: "..#v.members, 30)
				a:Dock(FILL)
				t.Think = function()
					if not IsValid(v.leader) then
						allParties[k] = nil
						populate()
					end
				end

				local j = XYZUI.ButtonInput(t, "Join", function(container)
					if v.password then
						local passwordFrame = vgui.Create("DFrame")
						passwordFrame:SetSize(ScrW(), ScrH())
						passwordFrame:SetDraggable(false)
						passwordFrame:MakePopup()
						passwordFrame:ShowCloseButton(false)
						passwordFrame:SetBackgroundBlur(true)
						passwordFrame.Paint = function(self, w, h)
							XYZUI.DrawShadowedBox(w/2-105, h/2-30, 210, 80)
							draw.SimpleText("Password:", "xyz_font_12", w/2, h/2+4, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM)
						end

						local passwordInput = vgui.Create("DTextEntry", passwordFrame)
						passwordInput:SetPos(passwordFrame:GetWide()/2-100, passwordFrame:GetTall()/2)
						passwordInput:SetSize(200, 20)

						local passwordSubmit = vgui.Create("DButton", passwordFrame)
						passwordSubmit:SetPos(passwordFrame:GetWide()/2-100, passwordFrame:GetTall()/2+25)
						passwordSubmit:SetSize(200, 20)
						passwordSubmit:SetText("")
						passwordSubmit.Paint = function(self, w, h)
							draw.RoundedBox( 0, 0, 0, w, h, Color(0, 100, 0, 155))
							draw.SimpleText("Submit", "xyz_font_20_static", w/2, h/2, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
						end
						passwordSubmit.DoClick = function()
							net.Start("xyz_party_request")
								net.WriteInt(k, 32)
								net.WriteString(passwordInput:GetText())
							net.SendToServer()
							frame:Close()
							passwordFrame:Close()
						end
					else
						net.Start("xyz_party_request")
							net.WriteInt(k, 32)
						net.SendToServer()
						frame:Close()
					end
				end)
				j:DockMargin(10, 10, 10, 10)
				j:Dock(RIGHT)
			end
		end
		populate()

	-- Buttons
	local startParty = XYZUI.ButtonInput(shell, "Start Party", function()
		createParty()
		frame:Close()
	end)
	startParty:DockMargin(0, 5, 0, 0)
	startParty:Dock(BOTTOM)
end

net.Receive("xyz_party_open", function()
	if istable(XYZParty.Core.MyParty) then
		myParty()
	else
	    partyHUB()
	end
end)