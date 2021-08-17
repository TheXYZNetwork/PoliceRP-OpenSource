net.Receive("xyz_meeting_open", function()
	local frame = XYZUI.Frame("Create a Meeting", Color(0, 100, 155))
	frame:SetSize(ScrH()*0.85, ScrH()*0.85)
	frame:Center()

	local shell = XYZUI.Container(frame)
	shell:DockPadding(10, 10, 10, 10)

	-- Title settings
		local settingTitle = XYZUI.Title(shell, "The meeting type", nil, 40)
		local settingTitleDropdown = XYZUI.DropDownList(shell, "Type")
		for k, _ in pairs(XYZMeeting.Config.MeetingTypes) do
			XYZUI.AddDropDownOption(settingTitleDropdown, k)
		end

	-- Department settings
		local settingDepartments = XYZUI.Title(shell, "Which department is the meeting for?", nil, 40)
		settingDepartments:DockMargin(0, 5, 0, 0)
		local settingDepartmentsDropdown = XYZUI.DropDownList(shell, "Departments")
		XYZUI.AddDropDownOption(settingDepartmentsDropdown, "All Departments")
		for k, v in pairs(XYZShit.Departments.Government) do
			XYZUI.AddDropDownOption(settingDepartmentsDropdown, v)
		end

	-- Department settings
		local settingTime = XYZUI.Title(shell, "How long will the meeting last in minutes?", nil, 40)
		settingTime:DockMargin(0, 5, 0, 0)
		local settingTimeEntry = XYZUI.TextInput(shell)
		settingTimeEntry:SetNumeric(true)
		settingTimeEntry:SetText(5)
		settingTimeEntry.OnChange = function(self)
			if self:GetText() == "" then
				self:SetText(1)
			elseif self:GetText() == "-" then
				self:SetText(1)
			elseif tonumber(self:GetText()) > 20 then
				self:SetText(20)
			elseif tonumber(self:GetText()) < 1 then
				self:SetText(1)
			end
		end

		local settingAnnouncement = XYZUI.Title(shell, "Announcement?", nil, 40)
		settingAnnouncement:DockMargin(0, 5, 0, 0)
		local settingAnnouncementEntry = XYZUI.TextInput(shell)

	-- Department settings
		local settingMajorCrime = XYZUI.Title(shell, "Stop major crimes? (Only PD & SWAT can stop major crime)", nil, 40)
		settingMajorCrime:DockMargin(0, 5, 0, 0)
		local settingMajorCrimeEntry = XYZUI.ToggleInput(shell)


	local submitAnswer = XYZUI.ButtonInput(shell, "Start Meeting", function()
		local TABLE = {}
		TABLE.name = settingTitleDropdown.selected and settingTitleDropdown.selected.name or "Meeting"
		if TABLE.name == "Announcement" then
			TABLE.announcement = settingAnnouncementEntry:GetText()
		end
		TABLE.dep = settingDepartmentsDropdown.selected and settingDepartmentsDropdown.selected.name or "Police Department"
		TABLE.time = tonumber(settingTimeEntry:GetText()) or 5
		TABLE.stopCrime = settingMajorCrimeEntry.state or false


		net.Start("xyz_meeting_start")
			net.WriteTable(TABLE)
		net.SendToServer()

		frame:Close()
	end)
	submitAnswer:Dock(BOTTOM)
end)