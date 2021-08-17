local cachedReports = {}
local iconSize = 80
local redish = Color(200, 0, 0)

net.Receive("XYZ911:Marker", function()
	local callID = net.ReadUInt(32)
	local pos = net.ReadVector()
	cachedReports[callID] = pos
	if XYZSettings.GetSetting("911_show_minimap", true) then
		Minimap.AddWaypoint("911_"..callID, "911_marker", "911 Call", color_white, 1.3, pos)
	end

	timer.Simple(XYZ911.Config.WaypointTime, function()
		Minimap.RemoveWaypoint("911_"..callID)
		cachedReports[callID] = nil
	end)
end)

hook.Add("HUDPaint", "xyz_911_reports", function()
	if not XYZSettings.GetSetting("911_show_marker", true) then return end
	if not XYZShit.IsGovernment(LocalPlayer():Team(), true) then return end
	for k, v in pairs(cachedReports) do
		local pos = v:ToScreen()

		surface.SetDrawColor(255, 255, 255, 255)
		surface.SetMaterial(XYZShit.Image.GetMat("911_marker"))
		surface.DrawTexturedRect(pos.x -(iconSize*0.5), pos.y -(iconSize*0.5), iconSize, iconSize)
	end
end)
