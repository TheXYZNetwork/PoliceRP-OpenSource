include("shared.lua")

local width = 300
local offset = 90
local shader = Color(0, 0, 0, 55)
local addonColor = Color(40, 40, 40)
function ENT:Draw()
	self:DrawModel()
	if not XYZSettings.GetSetting("overhead_toggle", true) then return end
  	if self:GetPos():DistToSqr(LocalPlayer():GetPos()) > tonumber(XYZSettings.GetSetting("overhead_distance", 400000)) then return end

	local ang = LocalPlayer():EyeAngles();
	ang:RotateAroundAxis(ang:Forward(), 90)
	ang:RotateAroundAxis(ang:Right(), 90)

	if XYZSettings.GetSetting("overhead_position", "Side") == "Top" then
		cam.Start3D2D(self:GetPos() + (self:GetUp()*77), ang, 0.07)
		offset = -width*0.6
	else
		cam.Start3D2D(self:GetPos() + (self:GetUp()*69), ang, 0.07)
		offset = 60
	end
		-- Base background
		XYZUI.DrawShadowedBox(offset, 0, width, 65)
		draw.RoundedBox(0, offset+5, 5, width-10, 10, self.StoreColor)
		draw.RoundedBox(0, offset+5, 10, width-10, 5, shader)

		XYZUI.DrawText(self.StoreNameDisplay, 45, offset + (width*0.5), 37, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	cam.End3D2D()
end