include("shared.lua")

local cachedVaults = {}

function ENT:Initialize()
	self.room = ClientsideModel("models/freeman/vault/floor_safe_interior.mdl")
	self.room:SetPos(self:GetPos())
	self.room:SetAngles(self:GetAngles())
	
	self.room:SetNoDraw(true)
	self.room:SetBodygroup(1, 1)

	cachedVaults[self:EntIndex()] = self

	self.RenderGroup = 7
	self.room.RenderGroup = 7
end

function ENT:Draw()
	self:DrawModel()
end

function ENT:Think()
	if not IsValid(self.room) then return end
	self.room:SetPos(self:GetPos())
	local ang = self:GetAngles()
	ang:RotateAroundAxis(ang:Up(), 45)

	self.room:SetAngles(ang)

end
function ENT:OnRemove()
	if IsValid(self.room) then self.room:Remove() end
	table.remove(cachedVaults, self:EntIndex())
end


-- huge credit to CodeBlue for helping me out with this, he's a true good guy
hook.Add("PreDrawTranslucentRenderables", "pres_stencil_floor", function(depth, skybox)
	if skybox or depth then return end
	for k, v in pairs(cachedVaults) do
		if not IsValid(v) then continue end

		local screenpos = v:GetPos():ToScreen()
		if !screenpos.visible then
			continue
		end

		render.ClearStencil()
		render.SetStencilEnable(true)
			render.SetStencilReferenceValue(44)
			render.SetStencilWriteMask(255)
			render.SetStencilTestMask(255)
			render.SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_ALWAYS)
			render.SetStencilPassOperation(STENCILOPERATION_REPLACE)
			render.SetStencilFailOperation(STENCIL_ZERO)
			render.SetStencilZFailOperation(STENCIL_ZERO)

			local angle = v:GetAngles()

			cam.Start3D2D(v:GetPos() + (v:GetUp()*0.85), angle, 0.3)
				--draw.RoundedBox(0, -75, -60, 160, 120, Color(255,255,255,255))
				draw.RoundedBox(0, -60, -60, 120, 120, Color(255,255,255,1))
			cam.End3D2D()
			
			render.SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_EQUAL)
			render.DepthRange(0, 0.9)
			if not IsValid(v.room) then
				v:Initialize()
			end
			v.room:DrawModel()

		render.SetStencilEnable(false)
		render.DepthRange(0, 1)
		render.ClearStencil()
	end
end)
