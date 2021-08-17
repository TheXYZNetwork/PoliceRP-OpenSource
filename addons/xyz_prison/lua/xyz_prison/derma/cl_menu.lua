net.Receive("PrisonSystem:UI", function()
	local ent = net.ReadEntity()

	local frame = XYZUI.Frame("Prison Jobs", PrisonSystem.Config.Color)
	frame:SetSize(ScrH()*0.4, ScrH()*0.7)
	frame:Center()

	local _, shell = XYZUI.Lists(frame, 1)
	shell.Paint = nil

    for k, v in pairs(PrisonSystem.Config.Jobs) do
		local job = XYZUI.Container(shell)
		job:Dock(TOP)
		job:DockMargin(0, 0, 0, 5)
		job:SetTall(70)

		local btn = XYZUI.ButtonInput(job, "Take Job", function(self)
			net.Start("PrisonSystem:StartJob")
				net.WriteEntity(ent)
				net.WriteString(k)
			net.SendToServer()

			frame:Close()
		end)
		btn:Dock(RIGHT)
		btn:DockMargin(0, 5, 5, 5)
		btn:SetWide(100)

		XYZUI.PanelText(job, v, 40, TEXT_ALIGN_CENTER):Dock(FILL)
	end
end)