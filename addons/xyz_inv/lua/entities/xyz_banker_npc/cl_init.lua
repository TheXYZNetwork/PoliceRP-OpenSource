include("shared.lua")

local width = 220
local offset = 90
local shader = Color(0, 0, 0, 55)
local addonColor = Color(2, 108, 254)
function ENT:Draw()
	self:DrawModel()
	if not XYZSettings.GetSetting("overhead_toggle", true) then return end
  	if self:GetPos():DistToSqr(LocalPlayer():GetPos()) > tonumber(XYZSettings.GetSetting("overhead_distance", 400000)) then return end

	local ang = LocalPlayer():EyeAngles();
	ang:RotateAroundAxis(ang:Forward(), 90)
	ang:RotateAroundAxis(ang:Right(), 90)

	cam.Start3D2D(self:GetPos() + (self:GetUp()*50) + (self:GetForward()*4.3), ang, 0.1)
		offset = -width*0.5
		-- Base background
		XYZUI.DrawShadowedBox(offset, 0, width, 65)
		draw.RoundedBox(0, offset+5, 5, width-10, 10, addonColor)
		draw.RoundedBox(0, offset+5, 10, width-10, 5, shader)

		XYZUI.DrawText("Bank Locker", 45, offset + (width*0.5), 37, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	cam.End3D2D()
end