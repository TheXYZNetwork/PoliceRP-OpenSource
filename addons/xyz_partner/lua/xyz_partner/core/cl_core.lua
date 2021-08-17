net.Receive("xyz_partner_data", function()
	XYZPartner.CurrentPartner = net.ReadEntity()
	XYZPartner.CurrentPartnerVehicle = net.ReadEntity()
end)

net.Receive("xyz_partner_data_remove", function()
	Minimap.RemoveWaypoint("pd_partner")
	Minimap.RemoveWaypoint("pd_partner_car")
	XYZPartner.CurrentPartner = nil
	XYZPartner.CurrentPartnerVehicle = nil
end)

-- Cache
local scrw = ScrW
local scrh = ScrH
local color = Color
local draw_box = draw.RoundedBox
local math_clamp = math.Clamp

-- Colors
local white = color(255, 255, 255)
local headerDefault = color(100, 40, 160)
local headerShader = color(0, 0, 0, 55)
local healthRed = color(200, 0, 55)
local ArmorRed = color(0, 100, 200)
local healthSegments = color(31, 31, 31, 155)

local startY = 200
local hudW, hudH =  math_clamp(scrw()*0.21, 330, 380), math_clamp(scrh()*0.046+22, 60, 120)

local actualHUDH = math_clamp(scrh()*0.045+15+(scrw() > 1920 and ScreenScale(5) or 0), 60, 120)
hook.Add("HUDPaint", "xyz_partner_display", function()
	if IsValid(XYZPartner.CurrentPartner) and XYZSettings.GetSetting("partner_show_hud", true) then
		local w, h = scrw(), scrh()
		local hudStart = h-actualHUDH-25

		XYZUI.DrawShadowedBox(5, hudStart-hudH-10, hudW, hudH)
		draw_box(0, 10, hudStart-hudH-5, hudW-10, 16, headerDefault)
		draw_box(0, 10, hudStart-hudH-5, hudW-10, 8, headerShader)

		local partner = XYZPartner.CurrentPartner
		-- Display name
		XYZUI.DrawScaleText(XYZUI.CharLimit(partner:Nick(), 22), 8, 10, hudStart-hudH+10, white, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)

		draw_box(0, 10, hudStart-10-20, (hudW-10) * math_clamp(partner:Health(), 0, 100)/100, 15, healthRed)
		draw_box(0, 10, hudStart-10-25, (hudW-10) * math_clamp(partner:Armor(), 0, 100)/100, 5, ArmorRed)
	
		for i=1, 3 do
			draw_box(0, 5+(i*((hudW-10)*0.25))-1, hudStart-10-20, 2, 15, healthSegments)
		end

	end
end)

hook.Add("PreDrawOutlines", "xyz_partner_halo", function()
	if IsValid(XYZPartner.CurrentPartner) and XYZSettings.GetSetting("partner_show_halo", true)  then
		if LocalPlayer():GetPos():DistToSqr(XYZPartner.CurrentPartner:GetPos()) < tonumber(XYZSettings.GetSetting("partner_distance_halo", 800000)) then
			outline.Add({XYZPartner.CurrentPartner}, Color(55, 255, 255), 0)
		end
	end
end)

hook.Add("MinimapThink", "PDPartner", function()
	if not IsValid(XYZPartner.CurrentPartner) then return end
	Minimap.AddWaypoint("pd_partner", "minimap_partner", XYZUI.CharLimit(XYZPartner.CurrentPartner:Name(), 20), color_white, 1, XYZPartner.CurrentPartner:GetPos(), XYZPartner.CurrentPartner:EyeAngles())

	if not IsValid(XYZPartner.CurrentPartnerVehicle) then return end
	Minimap.AddWaypoint("pd_partner_car", "minimap_mycar", XYZUI.CharLimit(XYZPartner.CurrentPartner:Name(), 20), color_white, 1, XYZPartner.CurrentPartnerVehicle:GetPos(), XYZPartner.CurrentPartnerVehicle:GetAngles())
end)