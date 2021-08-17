hook.Add("HUDPaint", "xyz_ups_hud", function()
	if not UPS.Core.ActiveDelivery then return end

	local pos = UPS.Core.ActiveDelivery.pos:ToScreen()

	surface.SetFont("xyz_ui_main_font_"..30)
	local width, height = surface.GetTextSize(UPS.Core.ActiveDelivery.name)
	width = math.Clamp(width + 15, 110, 1000)

	surface.SetDrawColor(255, 255, 255)

	surface.SetMaterial(XYZShit.Image.GetMat("waypoint_pin"))
	surface.DrawTexturedRect(pos.x-20, pos.y-30, 40, 40)

	XYZUI.DrawText(UPS.Core.ActiveDelivery.name, 30, pos.x, pos.y+10, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
end)

net.Receive("xyz_ups_select", function(_, ply)
	local selected = net.ReadTable()
	UPS.Core.ActiveDelivery = selected
	Minimap.AddWaypoint("ups", "waypoint_pin", UPS.Core.ActiveDelivery.name, color_white, 1.5, UPS.Core.ActiveDelivery.pos)
end)

net.Receive("xyz_ups_end", function(_, ply)
	UPS.Core.ActiveDelivery = nil
	Minimap.RemoveWaypoint("ups")
end)