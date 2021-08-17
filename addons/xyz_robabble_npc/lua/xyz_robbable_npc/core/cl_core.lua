local cacheLocations = {}
net.Receive("RobbableNPC:UI", function()
	if not XYZSettings.GetSetting("rs_show_marker", true) then return end
	local pos = net.ReadVector()
	local id = table.insert(cacheLocations, pos)

	timer.Simple(60, function()
		cacheLocations[id] = nil
	end)
end)

local red = Color(200, 0, 0)
hook.Add("HUDPaint", "RobableStoresAlerts", function()
	for k, v in pairs(cacheLocations) do
		if not isvector(v) then continue end
		local pos = v:ToScreen()

		XYZUI.DrawText("The store is being robbed!", 40, pos.x, pos.y+6, color_white)
		XYZUI.DrawText(math.Round(v:Distance(LocalPlayer():GetPos())).."m", 25, pos.x, pos.y+25, red)
	end
end)