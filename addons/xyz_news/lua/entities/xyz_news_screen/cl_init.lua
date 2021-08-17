include("shared.lua")
function ENT:Initialize()
	NewsSystem.ScreenCache[self:EntIndex()] = self

	self.hasInitialized = true
end

function ENT:Draw()
	self:DrawModel()

	if LocalPlayer():GetPos():DistToSqr(self:GetPos()) > NewsSystem.Config.StartDistance then return end

	if not self.hasInitialized then
		self:Initialize()
	end

	local ang = self:GetAngles()
	local pos = self:GetPos() + (self:GetUp()*35.1) + (self:GetForward()*6.2)


	ang:RotateAroundAxis(ang:Forward(), 90)
	ang:RotateAroundAxis(ang:Right(), -90)

	cam.Start3D2D(pos, ang, 0.07)

		if (not NewsSystem.Data.IsLive) or (not IsValid(NewsSystem.Data.CameraMan)) then
			XYZUI.DrawText("NO LIVE FEED", 100, 0, 215, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		else
			surface.SetMaterial(NewsSystem.Core.GetView())
			surface.SetDrawColor(255, 255, 255, 255)
			surface.DrawTexturedRect(-400, 0, 800, 463)

			if NewsSystem.Data.Title then
				draw.RoundedBox(0, -400, 360, 800, 80, NewsSystem.Config.Color)
				XYZUI.DrawText(XYZUI.CharLimit(NewsSystem.Data.Title, 20), 60, -380, 353, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
				XYZUI.DrawText(XYZUI.CharLimit(NewsSystem.Data.Desc, 30), 40, -380, 402, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
			end
		end
	cam.End3D2D()
end


function ENT:OnRemove()
	NewsSystem.ScreenCache[self:EntIndex()] = nil
end