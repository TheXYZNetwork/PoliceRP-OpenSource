include("shared.lua")

local hsvToColor = HSVToColor
local curTime = CurTime

function ENT:Draw()
	self:DrawModel()

	local ang = LocalPlayer():EyeAngles()
	ang:RotateAroundAxis( ang:Forward(), 90 )
	ang:RotateAroundAxis( ang:Right(), 90 )

	local centerx, centery = 0, -150

	cam.Start3D2D(self:GetPos(), Angle( 0, ang.y, ang.z ), 0.07)
		draw.SimpleText("Candy Cane", "xyz_font_60_static", centerx, centery, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		draw.SimpleText("One time use", "xyz_font_40_static", centerx, centery+35, hsvToColor((curTime()*50)%360, 1, 1), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	cam.End3D2D()
end
