hook.Add("HUDPaint", "xyz_speedometer", function()
	if LocalPlayer():InVehicle() and XYZSettings.GetSetting("speedometer_toggle_show", true) then
		local w, h = ScrW(), ScrH()
		local car = LocalPlayer():GetVehicle()
		if not IsValid(car) then return end
		if not car:IsVehicle() then return end
		local speed = car:VC_getSpeedKmH() or 0
		speed = math.Round(speed*0.6)
		if speed <= 0 then return end

		XYZUI.DrawShadowedBox(w*0.5-115, h-66, 230, 61)
		XYZUI.DrawText(speed.." mph", 40, w*0.5,  h-35, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end
end)