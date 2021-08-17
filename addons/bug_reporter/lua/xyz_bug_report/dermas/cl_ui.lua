net.Receive("bug_report_menu", function()
	local frame = XYZUI.Frame("Bug Report", Color(40, 40, 40))
	local shell = XYZUI.Container(frame)
	shell.Paint = nil

	local title = XYZUI.PanelText(shell, "Report a bug", 40, TEXT_ALIGN_CENTER)

	local entry, cont = XYZUI.TextInput(shell, true)
	entry.placeholder = "Clearly describe how to reproduce the bug. Abuse will result in punishment."
	cont:DockMargin(0, 15, 0, 15)
	cont:Dock(FILL)

	local submit = XYZUI.ButtonInput(frame, "Submit bug report", function(self)
		net.Start("bug_report_bug")
			net.WriteString(entry:GetText())
			net.WriteTable({
				OS = (system.IsWindows() and "Windows") or (system.IsOSX() and "Mac") or (system.IsLinux() and "Linux"),
				CC = system.GetCountry(),
				SR = {w = ScrW(), h = ScrH()}
			})
		net.SendToServer()
		frame:Close()
	end)

	submit:Dock(BOTTOM)
	submit.headerColor = Color(40, 70, 40)
end)