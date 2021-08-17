function NewsSystem.Core.Menu()
	local frame = XYZUI.Frame("New Reporter", NewsSystem.Config.Color)
	frame:SetSize(ScrH()*0.4, ScrH()*0.4)
	frame:Center()

	local shell = XYZUI.Container(frame)
	shell:DockPadding(10, 10, 10, 10)

	local title = XYZUI.Title(shell, "Set the current news", nil, 38, 0, true)

	-- News title
    XYZUI.PanelText(shell, "Title:", 35, TEXT_ALIGN_LEFT)
    local titleEntry, cont = XYZUI.TextInput(shell)

	-- News desc
    XYZUI.PanelText(shell, "Description:", 35, TEXT_ALIGN_LEFT)
    local descEntry, cont = XYZUI.TextInput(shell, true)

    -- Set news
	local btn = XYZUI.ButtonInput(shell, "Set News", function(self)
		local title = string.Trim(titleEntry:GetText(), " ")
		local desc = string.Trim(descEntry:GetText(), " ")

		if title == "" then return end
		if desc == "" then return end

		net.Start("NewsSystem:News:Set")
			net.WriteString(title)
			net.WriteString(desc)
		net.SendToServer()

		frame:Close()
	end)
	btn:Dock(BOTTOM)
end