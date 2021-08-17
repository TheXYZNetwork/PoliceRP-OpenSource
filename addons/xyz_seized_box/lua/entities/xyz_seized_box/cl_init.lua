include("shared.lua")

-- Draws all the 3D2D
function ENT:Draw()
	self:DrawModel()
  	if self:GetPos():DistToSqr(LocalPlayer():GetPos()) > 400000 then return end

	local ang = LocalPlayer():EyeAngles()

	ang:RotateAroundAxis(ang:Forward(), 90)
	ang:RotateAroundAxis(ang:Right(), 90)

	cam.Start3D2D(self:GetPos()+self:GetUp()*25, ang, 0.07);
		draw.SimpleTextOutlined("Seized Items Box", "xyz_font_120_static", 0, 0, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(0,0,0,255))
	cam.End3D2D()
end