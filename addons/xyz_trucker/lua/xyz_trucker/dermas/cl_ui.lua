net.Receive("xyz_trucker_menu", function()
	local npc = net.ReadEntity()

	local frame = XYZUI.Frame("Trucking Agency", Color(100, 100, 160))
	frame:SetSize(ScrW()*0.3, ScrH()*0.5)
	frame:Center()

	local _, shell = XYZUI.Lists(frame, 1)

	XYZUI.PanelText(frame, "Start a delivery job?", 35)
	:DockMargin(0, 0, 0, 5)

	for k, v in pairs(XYZTrucker.Core.Loads) do
		local c = XYZUI.Card(shell, 60)
		c:DockMargin(0, 0, 0, 5)

		local a = XYZUI.Title(c, v.name, DarkRP.formatMoney(v.price), 30)
		a:DockMargin(5, 0, 5, 0)
		a:Dock(FILL)

		local b = XYZUI.ButtonInput(c, "Start", function()
			net.Start("xyz_trucker_request_job")
				net.WriteEntity(npc)
				net.WriteInt(k, 32)
			net.SendToServer()
			frame:Close()
		end)
		b:DockMargin(10, 10, 10, 10)
		b:Dock(RIGHT)
	end
end)