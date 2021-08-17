include("shared.lua")

function ENT:Draw()
	if self:GetPos():DistToSqr(LocalPlayer():GetPos()) > 9000 then return end
	local Pos = self:GetPos()
	local Ang = self:GetAngles()
	Ang:RotateAroundAxis(Ang:Up(), 270)
	cam.Start3D2D(Pos + Ang:Up()*15, Ang, 0.07)
		XYZUI.DrawScaleText("Press E", "30", 0, 0, color_white, 1)
	cam.End3D2D()
end