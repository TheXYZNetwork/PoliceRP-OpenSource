include("shared.lua")


function ENT:Initialize()
	self.hasInitialized = true

	Minimap.AddWaypoint("sign"..self:EntIndex(), "minimap_sign1", "Sign", color_white, 1.5, self:GetPos())
	table.insert(Minimap.Signs, self)
end

function ENT:OnRemove()
	Minimap.RemoveWaypoint("sign"..self:EntIndex())
	table.RemoveByValue(Minimap.Signs, self)
end

function ENT:Think()
	if not self.hasInitialized then
		self:Initialize()
	end

	function self:Think() -- Reset it
	end
end


function ENT:Draw()
	self:DrawModel()
  	if self:GetPos():DistToSqr(LocalPlayer():GetPos()) > 1000000 then return end

  	-- Image stuff
	local pos = self:GetPos()
	local ang = self:GetAngles()
	ang:RotateAroundAxis(ang:Up(), 90)
	ang:RotateAroundAxis(ang:Forward(), 74)
	cam.Start3D2D(pos + (ang:Up()*8.1), ang, 0.2)
		XYZUI.DrawShadowedBox(-50, -50, 100, 100)
		surface.SetDrawColor(color_white)
		surface.SetMaterial(XYZShit.Image.GetMat("minimap_sign"..self:GetDisplayImage()))
		surface.DrawTexturedRectRotated(0, 0, 75, 75, 0)
	cam.End3D2D()

	ang:RotateAroundAxis(ang:Forward(), -74)
	ang:RotateAroundAxis(ang:Up(), 180)
	ang:RotateAroundAxis(ang:Forward(), 73)

	cam.Start3D2D(pos + (ang:Up()*7.1), ang, 0.2)
		XYZUI.DrawShadowedBox(-50, -50, 100, 100)
		surface.SetDrawColor(color_white)
		surface.SetMaterial(XYZShit.Image.GetMat("minimap_sign"..self:GetDisplayImage()))
		surface.DrawTexturedRectRotated(0, 0, 75, 75, 0)
	cam.End3D2D()


	-- Text stuff
	local pos = self:GetPos()
	local ang = self:GetAngles()
	ang:RotateAroundAxis(ang:Up(), (CurTime()*20)%360)
	ang:RotateAroundAxis(ang:Forward(), 90)

	pos = pos + -(ang:Right() * math.sin((CurTime()*0.2)*10))

	-- Header
	cam.Start3D2D(pos + (ang:Right() * -25), ang, 0.2)
		XYZUI.DrawTextOutlined(self:GetDisplayName(), 30, 0, 0, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, color_black)
	cam.End3D2D()
	ang:RotateAroundAxis(ang:Right(), 180)
	cam.Start3D2D(pos + (ang:Right() * -25), ang, 0.2)
		XYZUI.DrawTextOutlined(self:GetDisplayName(), 30, 0, 0, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, color_black)
	cam.End3D2D()
end