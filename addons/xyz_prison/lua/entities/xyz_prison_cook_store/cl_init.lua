include("shared.lua")

local width = 250
local offset = -width*0.5
local shader = Color(0, 0, 0, 55)
function ENT:Draw()
	self:DrawModel()
	if not XYZSettings.GetSetting("overhead_toggle", true) then return end
	if self:GetPos():DistToSqr(LocalPlayer():GetPos()) > tonumber(XYZSettings.GetSetting("overhead_distance", 400000)) then return end

	local ang = LocalPlayer():EyeAngles();
	ang:RotateAroundAxis(ang:Forward(), 90)
	ang:RotateAroundAxis(ang:Right(), 90)

	cam.Start3D2D(self:GetPos() + (self:GetUp()*20), ang, 0.07)
	
		-- Base background
		XYZUI.DrawShadowedBox(offset, 0, width, 130)
		draw.RoundedBox(0, offset+5, 5, width-10, 10, PrisonSystem.Config.Color)
		draw.RoundedBox(0, offset+5, 10, width-10, 5, shader)

		XYZUI.DrawText("Storage", 45, offset + (width*0.5), 37, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		XYZUI.DrawText("Holding: "..self:GetHoldingFood(), 35, offset + (width*0.5), 55, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
		XYZUI.DrawText("Press E to Sell", 35, offset + (width*0.5), 85, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
	cam.End3D2D()
end