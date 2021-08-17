hook.Add("HUDPaint", "Developer:Info", function()
    if not GetConVar("developer"):GetBool() then return end
    if not ply:HasPower(90) then return end

    local startX = ScrW()-260
    local startY = ScrH()*0.5

    XYZUI.DrawShadowedBox(startX, startY, 250, 100, 3)
    XYZUI.DrawText("Players: "..player.GetCount().."/"..game.MaxPlayers(), "20", startX + 10, startY+5, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
    XYZUI.DrawText("Entities: "..ents.GetCount(), "20", startX + 10, startY + 20, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
    XYZUI.DrawText("Vehicles: "..#ents.FindByClass("prop_vehicle_jeep"), "20", startX + 10, startY+35, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
    XYZUI.DrawText("Uptime: "..string.NiceTime(CurTime()).." ("..math.Round(CurTime())..")", "20", startX + 10, startY+50, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
    XYZUI.DrawText("Tickrate: "..math.Round(1/engine.ServerFrameTime(), 1), "20", startX + 10, startY+65, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
end)

concommand.Add("xyz_perma_info", function()
    if not LocalPlayer():IsSuperAdmin() then return end
    local target = LocalPlayer():GetEyeTrace().Entity
    local data = string.format("{ent = '%s', pos = %s, ang = %s},", target:GetClass(), "Vector("..target:GetPos().x..", "..target:GetPos().y..", "..target:GetPos().z..")", "Angle("..target:GetAngles().p..", "..target:GetAngles().y..", "..target:GetAngles().r..")")

    print(data)
    SetClipboardText(data)
end)