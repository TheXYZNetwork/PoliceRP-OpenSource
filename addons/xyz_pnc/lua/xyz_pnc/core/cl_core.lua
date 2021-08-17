PNC.Core.ActivePatrol = PNC.Core.ActivePatrol or nil

net.Receive("xyz_pnc_patrol_send", function()
	PNC.Core.ActivePatrol = {}
	PNC.Core.ActivePatrol.current = 1
	PNC.Core.ActivePatrol.pads = net.ReadTable()

end)

net.Receive("xyz_pnc_patrol_end", function()
	PNC.Core.ActivePatrol = nil
end)

net.Receive("xyz_pnc_patrol_next", function()
	if not PNC.Core.ActivePatrol then return end

	PNC.Core.ActivePatrol.current = PNC.Core.ActivePatrol.current + 1
	XYZShit.Msg("PNC", PNC.Config.Color, "Good job, now to your next waypoint: "..PNC.Core.ActivePatrol.pads[PNC.Core.ActivePatrol.current].name)
end)

hook.Add("HUDPaint", "xyz_pnc_patrol_hud", function()
	if not PNC.Core.ActivePatrol then return end

	local curPad = PNC.Core.ActivePatrol.pads[PNC.Core.ActivePatrol.current]
	local pos = curPad.pos:ToScreen()

	surface.SetDrawColor(255, 255, 255)
	surface.SetMaterial(XYZShit.Image.GetMat("waypoint_pin"))
	surface.DrawTexturedRect(pos.x-20, pos.y-30, 40, 40)

	XYZUI.DrawText(curPad.name, 30, pos.x, pos.y+10, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
end)

hook.Add("HUDPaint", "PrisonerTransportRequests", function()
    if not XYZSettings.GetSetting("pnc_pt_show_marker", true) then return end
    
    for k, v in pairs(PNC.Core.PrisonerTransportRequests) do
        if IsValid(v[2]) then
            local pos = v[1]:ToScreen()
            draw.DrawText(v[2]:Nick() .. " has requested prisoner transport", "xyz_font_20_static", pos.x, pos.y-30, Color(255, 255, 255), TEXT_ALIGN_CENTER)
            draw.DrawText("They are "..string.Comma(math.Round(v[1]:Distance(LocalPlayer():GetPos()))).."m away", "xyz_font_20_static", pos.x, pos.y, Color(255, 255, 255), TEXT_ALIGN_CENTER)
            draw.NoTexture()
            surface.SetDrawColor(0, 0, 0, 255)
            XYZUI.DrawCircle(pos.x, pos.y-45, 20, 2)
            surface.SetDrawColor(169, 169, 169, 255)
            XYZUI.DrawCircle(pos.x, pos.y-45, 18, 2)
        end
    end
end)