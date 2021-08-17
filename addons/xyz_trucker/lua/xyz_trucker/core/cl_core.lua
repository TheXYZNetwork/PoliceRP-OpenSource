local trailer, location
net.Receive("xyz_trucker_send_active_data", function()
	trailer = net.ReadEntity()
	location = net.ReadVector()

	Minimap.AddWaypoint("trucker", "waypoint_pin", "Delivery Location", color_white, 1.5, location)
end)
net.Receive("xyz_trucker_send_end", function()
	trailer, location = nil, nil
	Minimap.RemoveWaypoint("trucker")
end)

hook.Add("PreDrawOutlines", "xyz_truck_halo", function()
	if not IsValid(trailer) then return end

	outline.Add({trailer}, Color(0, 255, 0), 2 )
end)

hook.Add("HUDPaint", "xyz_truck_waypoint", function()
	if not IsValid(trailer) then return end

	local pos = location:ToScreen()

	surface.SetDrawColor(255, 255, 255)
	surface.SetMaterial(XYZShit.Image.GetMat("waypoint_pin"))
	surface.DrawTexturedRect(pos.x-20, pos.y-30, 40, 40)

	XYZUI.DrawText("Delivery Location", 30, pos.x, pos.y+10, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
end)