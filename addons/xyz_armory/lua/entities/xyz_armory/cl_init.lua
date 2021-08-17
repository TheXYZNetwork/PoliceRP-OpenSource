include("shared.lua")

armoryRooms = armoryRooms or {}
 
function ENT:Initialize()
	self.room = ClientsideModel("models/freeman/owain_locker_interior.mdl")
	self.room:SetPos(self:GetPos())
	self.room:SetAngles(self:GetAngles())
	
	self.room:SetNoDraw(true)

	armoryRooms[self:EntIndex()] = self
	self.RenderGroup = 7
	self.room.RenderGroup = 7
end

function ENT:Think()
	if not IsValid(self.room) then return end
	self.room:SetPos(self:GetPos())
	self.room:SetAngles(self:GetAngles())
end


function ENT:OnRemove()
	if IsValid(self.room) then self.room:Remove() end
	table.remove(armoryRooms, self:EntIndex())
end


local centerx, centery = 80, -300
function ENT:Draw()
	self:DrawModel()
  	if self:GetPos():DistToSqr(LocalPlayer():GetPos()) > 400000 then return end
	-- Basic setups
	local Pos = self:GetPos()
	local Ang = self:GetAngles()
	
	Ang:RotateAroundAxis(Ang:Up(), 90+30)
	Ang:RotateAroundAxis(Ang:Forward(), 90)

	cam.Start3D2D(Pos + Ang:Up()*-5 + Ang:Forward()*-40, Ang, 0.07)
		draw.RoundedBox(0, centerx-300, centery, 600, 265, Color(0, 0, 0, 150))
		draw.RoundedBox(0, centerx-300, centery, 600, 20, Color(0, 0, 0, 200))
		draw.SimpleText("Police Armory", "xyz_font_120_static", centerx, centery+5, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)

		-- Money Bag Icon
		surface.SetDrawColor(255, 255, 255, 255)
		surface.SetMaterial(perfectVault.Icons[1].mat)
		surface.DrawTexturedRect(centerx-290, centery+130, 55, 55)
		-- Bag Count
		draw.SimpleText("Holding: "..DarkRP.formatMoney(self:GetHolding()), "_pvault70", centerx-220, centery+120, Color(255,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)

		-- Police Icon
		surface.SetDrawColor(255, 255, 255, 255)
		surface.SetMaterial(perfectVault.Icons[3].mat)
		surface.DrawTexturedRect(centerx-290, centery+200, 55, 55)
		-- Police
		local cops = 0
		for k, v in pairs(player.GetAll()) do
			if v:isCP() then cops = cops + 1 continue end
			if perfectVault.Config.Government[v:Team()] then cops = cops + 1 continue end
		end
		if player.GetCount()*0.2 <= cops then
			draw.SimpleText("Police: Enough", "_pvault70", centerx-220, centery+190, Color(255,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
		else
			draw.SimpleText("Police: Not enough", "_pvault70", centerx-220, centery+190, Color(255,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
		end
	cam.End3D2D()
end

-- huge credit to CodeBlue for helping me out with this, he's a true good guy
hook.Add("PreDrawTranslucentRenderables", "xyz_armory_stencil", function(depth, skybox)
	if skybox or depth then return end
	for k, v in pairs(armoryRooms) do
		if not IsValid(v) then continue end

		local screenpos = v:GetPos():ToScreen()
		if not screenpos.visible then
			continue
		end

		if v:GetPos():DistToSqr(LocalPlayer():GetPos()) > 400000 then continue end

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
			angle:RotateAroundAxis(angle:Right(), -90)
			angle:RotateAroundAxis(angle:Up(), 90)

			cam.Start3D2D(v:GetPos(), angle, 0.5)
				draw.RoundedBox(0, -20, -45, 40, 90, Color(0,0,0,255))
			cam.End3D2D()
			
			render.SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_EQUAL)
			render.DepthRange(0, 0.9)
			if not IsValid(v.room) then
				v:Initialize()
			end
			v:DrawModel()
			v.room:DrawModel()

		render.SetStencilEnable(false)
		render.DepthRange(0, 1)
		render.ClearStencil()
	end
end)
