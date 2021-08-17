include("shared.lua")

function ENT:Initialize()
	self.hole = ClientsideModel("models/freeman/owain_prisonhole_bottom.mdl")
	self.hole:SetPos(self:GetPos())
	self.hole:SetAngles(self:GetAngles())
	
	self.hole:SetNoDraw(true)

	self.hole:SetRenderMode(RENDERMODE_TRANSCOLOR)
end

function ENT:Draw()
end

function ENT:DrawTranslucent()
	self:DrawModel()
	local screenpos = self:GetPos():ToScreen()
	if !screenpos.visible then
		return
	end

	render.ClearStencil()
	render.SetStencilEnable(true)
		render.SetStencilReferenceValue(44)
		render.SetStencilWriteMask(252)
		render.SetStencilTestMask(252)
		render.SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_ALWAYS)
		render.SetStencilPassOperation(STENCILOPERATION_REPLACE)
		render.SetStencilFailOperation(STENCIL_ZERO)
		render.SetStencilZFailOperation(STENCIL_ZERO)

		local angle = self:GetAngles()
		angle:RotateAroundAxis(angle:Right(), -180)
		angle:RotateAroundAxis(angle:Forward(), 180)
	
		cam.Start3D2D(self:GetPos()-(self:GetForward()*-1.5), angle, 0.5)
			surface.SetDrawColor(255, 255, 255, 1)
			draw.NoTexture()
			XYZUI.DrawCircle(1.6, 3, 27.3, 1)
		cam.End3D2D()
		
		render.SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_EQUAL)
		render.DepthRange(0, 0.9)
		if not IsValid(self.hole) then
			self:Initialize()
		end
		self.hole:DrawModel()

	render.SetStencilEnable(false)
	render.DepthRange(0, 1)
	render.ClearStencil()
end

function ENT:Think()
	if not IsValid(self.hole) then return end
	self.hole:SetPos(self:GetPos())
	self.hole:SetAngles(self:GetAngles())
	self.hole:SetColor(self:GetColor())
end

function ENT:OnRemove()
	if IsValid(self.hole) then self.hole:Remove() end
end