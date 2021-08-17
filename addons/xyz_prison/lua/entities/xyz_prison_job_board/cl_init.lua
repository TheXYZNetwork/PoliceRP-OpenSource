include("shared.lua")

local width = 560
local offset = -width*0.5
local shader = Color(0, 0, 0, 55)
local background = Color(201, 171, 127)
function ENT:Draw()
	--self:DrawModel()
  	if self:GetPos():DistToSqr(LocalPlayer():GetPos()) > tonumber(XYZSettings.GetSetting("overhead_distance", 400000)) then return end

	local ang = self:GetAngles()
	ang:RotateAroundAxis(ang:Forward(), 90)
	ang:RotateAroundAxis(ang:Right(), -90)

	cam.Start3D2D(self:GetPos() + (self:GetUp()*30) + (self:GetForward()*0.55), ang, 0.07)
		-- Background
		draw.RoundedBox(0, offset+5, 60, width-10, 820, background)

		-- Title
		XYZUI.DrawShadowedBox(offset, 0, width, 65)
		draw.RoundedBox(0, offset+25, 5, width-50, 10, PrisonSystem.Config.Color)
		XYZUI.DrawText("Prison Jobs", 45, offset + (width*0.5), 37, color_white)


		-- Job options
		local count = 0
		for k, v in pairs(PrisonSystem.Config.Jobs) do
			count = count + 1 -- Used to get how far down it should go
			XYZUI.DrawShadowedBox(offset+5, 25 + (count*65), width-10, 60)
			XYZUI.DrawText(v, 50, (offset+5) + (width*0.5), 53 + (count*65), color_white)
		end
	cam.End3D2D()
end