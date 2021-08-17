concommand.Add("xyz_thirdperson_toggle", function(ply, cmd, args)
    XYZSettings.SetSetting("cam_toggle", not XYZSettings.GetSetting("cam_toggle", false))
end)


hook.Add("CalcView", "XYZ3rdPersonCamera", function(ply, origin, angles, fov, znear, zfar)
    if not XYZSettings.GetSetting("cam_toggle", false) then return end
    if IsValid(CarDealer.UI.Menu) then return end
    
    -- Prevent 3rd person while having a weapon out
    local plyWep = ply:GetActiveWeapon()
    if not IsValid(plyWep) then return end -- They're probably dead
    if plyWep.Base == "cw_base" then return end -- They have a CW weapon out.

    -- 0 = Third Person    1 = Over the Shoulder.
    local view = {}
    local setting = XYZSettings.GetSetting("cam_type", "Third person")
    local dis

    if setting == "Third person" then
        dis = (angles:Forward() * math.Clamp(XYZSettings.GetSetting("cam_distance", 50), 0, 200))
        view.origin = origin - dis
    	view.angles = angles
    	view.fov = fov
    	view.drawviewer = true
    else
        dis = (angles:Forward() * math.Clamp(XYZSettings.GetSetting("cam_distance", 50), 0, 200)) - (angles:Right() * 25)
        view.origin = origin - dis
    	view.angles = angles
    	view.fov = fov
    	view.drawviewer = true
    end

    local traceData = {}
    traceData.start = origin
    traceData.endpos = view.origin
    traceData.filter = ply
    local trace = util.TraceLine(traceData)
    pos = trace.HitPos

    if (trace.Fraction < 1) or (not LocalPlayer():IsLineOfSightClear(view.origin)) then
        view.origin = origin - (dis * trace.Fraction)
    end

    return view
end)
