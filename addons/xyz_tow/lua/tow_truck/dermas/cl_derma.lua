net.Receive("towtruck_menu", function()
	local npc = net.ReadEntity()

	local frame = XYZUI.Frame("Tow Truck Agency", Color(153, 125, 30))
	frame:SetSize(384, 162)
	frame:Center()

	XYZUI.PanelText(frame, "Spawn your tow truck?", 35)
	:DockMargin(0, 0, 0, 5)

	XYZUI.ButtonInput(frame, "Spawn", function()
		net.Start("towtruck_spawn")
			net.WriteEntity(npc)
		net.SendToServer()
		frame:Close()
	end)
	:Dock(FILL)
end)