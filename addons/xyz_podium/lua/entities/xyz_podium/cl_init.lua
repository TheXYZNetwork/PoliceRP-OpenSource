include("shared.lua")

local status = {}
status[0] = "Off"
status[1] = "PTS Inactive"
status[2] = "PTS Active"
status[3] = "PTS Questions"
status[4] = "Be seated"
status[5] = "Meeting over"

function ENT:Draw()
	self:DrawModel()
  	if self:GetPos():DistToSqr(LocalPlayer():GetPos()) > 340000 then return end

	local Pos = self:GetPos()
	local Ang = self:GetAngles()
	Ang:RotateAroundAxis(Ang:Up(), 90)
	Ang:RotateAroundAxis(Ang:Forward(), 90)

	-- Header
	cam.Start3D2D(Pos + Ang:Up()*11.2, Ang, 0.07)

		if self:GetBackground() then
			surface.SetDrawColor(255, 255, 255, 255)
			if not self.Background then
				self.Background = Material("data/xyzcommunity/bg_pd.jpg")
			end
			if self.Background then
				surface.SetMaterial(self.Background)
				surface.DrawTexturedRect(-185, -317, 365, 225, 1175)
			end
		end
		if self:GetState() == 1 then
			draw.SimpleText("PTS is", "xyz_font_120_static", 0, -260, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			draw.SimpleText("Inactive", "xyz_font_120_static", 0, -170, Color(0, 255, 0), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		elseif self:GetState() == 2 then
			draw.SimpleText("PTS is", "xyz_font_120_static", 0, -260, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			draw.SimpleText("Active", "xyz_font_120_static", 0, -170, Color(255, 0, 0), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		elseif self:GetState() == 3 then
			draw.SimpleText("PTS for", "xyz_font_120_static", 0, -260, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			draw.SimpleText("questions", "xyz_font_90_static", 0, -175, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		elseif self:GetState() == 4 then
			draw.SimpleText("Please be", "xyz_font_90_static", 0, -255, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			draw.SimpleText("seated", "xyz_font_120_static", 0, -170, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		elseif self:GetState() == 5 then
			draw.SimpleText("Meeting", "xyz_font_120_static", 0, -260, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			draw.SimpleText("Over", "xyz_font_120_static", 0, -170, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end
	cam.End3D2D()

	if not table.HasValue(XYZShit.Jobs.Government.PoliceMeetings, ply:Team()) and not XYZShit.Staff.All[LocalPlayer():GetUserGroup()] then return end

	-- Setting up the interactive 3D2D
	local tr = LocalPlayer():GetEyeTrace().HitPos
	local pos = self:WorldToLocal(tr)


	Ang:RotateAroundAxis(Ang:Right(), 180)
	Ang:RotateAroundAxis(Ang:Forward(), -90)
	cam.Start3D2D(Pos + Ang:Up()*15.9, Ang, 0.07)

		draw.RoundedBox(0, -155, -33, 123, (23+(23*(#status+1)))-7, Color(0, 0, 0, 155))
		draw.SimpleText("Status", "xyz_font_20_static", -150, -22, Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
		for k, v in pairs(status) do
			if self:GetState() == k then
				draw.RoundedBox(0, -155, (k*22)-11, 123, 22, Color(0, 0, 0, 155))
			elseif pos.x < 0.82 + (-1.48*k) and pos.x > -0.68 + (-1.48*k) and pos.y < 10.87 and pos.y > 2.24 then
				draw.RoundedBox(0, -155, (k*22)-11, 123, 22, Color(0, 0, 0, 155))
			end
			draw.SimpleText(k.." - "..v, "xyz_font_20_static", -150, (k*22), Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
		end

		draw.RoundedBox(0, 75, -33, 80, 66, Color(0, 0, 0, 155))
		draw.SimpleText("Backgound", "xyz_font_20_static", 150, -22, Color(255, 255, 255), TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
		if self:GetBackground() then
			draw.RoundedBox(0, 75, -11, 80, 22, Color(0, 0, 0, 155))
		elseif pos.x < 0.82 and pos.x > -0.69 and pos.y < -5.26 and pos.y > -10.86 then
			draw.RoundedBox(0, 75, -11, 80, 22, Color(0, 0, 0, 155))
		end
		if not self:GetBackground() then
			draw.RoundedBox(0, 75, 11, 80, 22, Color(0, 0, 0, 155))
		elseif pos.x < -0.65 and pos.x > -2.23 and pos.y < -5.27 and pos.y > -10.87 then
			draw.RoundedBox(0, 75, 11, 80, 22, Color(0, 0, 0, 155))
		end
		draw.SimpleText("On", "xyz_font_20_static", 150, 0, Color(255, 255, 255), TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
		draw.SimpleText("Off", "xyz_font_20_static", 150, 22, Color(255, 255, 255), TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
	cam.End3D2D()
end

/*
0.822226 -5.267386 15.845877

-0.699246 -10.862628 15.845855
