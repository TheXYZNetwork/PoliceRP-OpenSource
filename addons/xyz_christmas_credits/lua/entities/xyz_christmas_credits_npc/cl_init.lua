include("shared.lua")

function ENT:Draw()
	self:DrawModel()
  	if self:GetPos():DistToSqr(LocalPlayer():GetPos()) > 400000 then return end

	local ang = self:GetAngles()

	ang:RotateAroundAxis(ang:Forward(), 90)
	ang:RotateAroundAxis(ang:Right(), -90)

	cam.Start3D2D(self:GetPos()+self:GetUp()*80, Angle(0, self:GetAngles().y+90, 90), 0.07);
		draw.SimpleTextOutlined("Christmas Credit Store", "xyz_font_120_static", 0, 0, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(0,0,0,255))
	cam.End3D2D()
	cam.Start3D2D(self:GetPos()+self:GetUp()*80, Angle(180, self:GetAngles().y+90, -90), 0.07);
		draw.SimpleTextOutlined("Christmas Credit Store", "xyz_font_120_static", 0, 0, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(0,0,0,255))
	cam.End3D2D()
end
