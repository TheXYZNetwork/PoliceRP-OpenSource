include("shared.lua")


function ENT:Draw()
	self:DrawModel()
  	if self:GetPos():DistToSqr(LocalPlayer():GetPos()) > tonumber(XYZSettings.GetSetting("overhead_distance", 400000)) then return end
 	if not (LocalPlayer():Team() == PrisonSystem.Config.Prisoner) then return end

 	if self:GetNextUse() > CurTime() then return end

	local ang = LocalPlayer():EyeAngles();
	ang:RotateAroundAxis(ang:Forward(), 90)
	ang:RotateAroundAxis(ang:Right(), 90)
	
	cam.Start3D2D(self:GetPos() + (self:GetUp()*40), ang, 0.07)
		XYZUI.DrawText("Press E to search me!", 60, 0, 0, color_white)
	cam.End3D2D()
end