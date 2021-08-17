include("shared.lua")

function ENT:Draw()
	self:DrawModel()
  	--if self:GetPos():DistToSqr(LocalPlayer():GetPos()) > 400000 then return end

	--local ang = LocalPlayer():EyeAngles()

	--ang:RotateAroundAxis(ang:Forward(), 90) ang:RotateAroundAxis(ang:Right(), 90)

	--cam.Start3D2D(self:GetPos()+self:GetUp()*25, ang, 0.07);
		--XYZUI.DrawText(self:GetWeight(), 120, 0, 0, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	--cam.End3D2D()
end