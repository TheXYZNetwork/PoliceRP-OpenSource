local att = {}
att.name = "bg_skspuscope"
att.displayName = "PU Scope"
att.displayNameShort = "PU"
att.FOVModifier = 15
att.isBG = true
att.isSight = true
att.aimPos = {"PUPos", "PUAng"}
att.withoutRail = true

att.statModifiers = {OverallMouseSensMult = -0.2}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/bg_skspuscope")
	att.description = {[1] = {t = "Provides 3.5x magnification.", c = CustomizableWeaponry.textColors.POSITIVE},
	[2] = {t = "May decreases awareness.", c = CustomizableWeaponry.textColors.NEGATIVE}}
	
	local old, x, y, ang
	local reticle = surface.GetTextureID("cw20_extras/ber_svt_40")
	
	att.zoomTextures = {[1] = {tex = reticle, offset = {0, 1}}}
	
	local lens = surface.GetTextureID("cw2/gui/lense")
	local lensMat = Material("cw2/gui/lense")
	local cd, alpha = {}, 0.5
	local Ini = true
	
	-- render target var setup
	cd.x = 0
	cd.y = 0
	cd.w = 512
	cd.h = 512
	cd.fov = 3.5
	cd.drawviewmodel = false
	cd.drawhud = false
	cd.dopostprocess = false
	
	function att:drawRenderTarget()
		local complexTelescopics = self:canUseComplexTelescopics()
		
		-- if we don't have complex telescopics enabled, don't do anything complex, and just set the texture of the lens to a fallback 'lens' texture
		if not complexTelescopics then
			self.TSGlass:SetTexture("$basetexture", lensMat:GetTexture("$basetexture"))
			return
		end
		
		if self:canSeeThroughTelescopics(att.aimPos[1]) then
			alpha = math.Approach(alpha, 0, FrameTime() * 5)
		else
			alpha = math.Approach(alpha, 1, FrameTime() * 5)
		end
		
		x, y = ScrW(), ScrH()
		old = render.GetRenderTarget()
	
		ang = self:getTelescopeAngles()
		
		if not self.freeAimOn then
			ang.r = self.BlendAng.z
			ang:RotateAroundAxis(ang:Right(), self.PUAxisAlign.right)
			ang:RotateAroundAxis(ang:Up(), self.PUAxisAlign.up)
			ang:RotateAroundAxis(ang:Forward(), self.PUAxisAlign.forward)
		end
		
		local size = self:getRenderTargetSize()

		cd.w = size
		cd.h = size
		cd.angles = ang
		cd.origin = self.Owner:GetShootPos()
		render.SetRenderTarget(self.ScopeRT)
		render.SetViewPort(0, 0, size, size)
			if alpha < 1 or Ini then
				render.RenderView(cd)
				Ini = false
			end
			
			ang = self.Owner:EyeAngles()
			ang.p = ang.p + self.BlendAng.x
			ang.y = ang.y + self.BlendAng.y
			ang.r = ang.r + self.BlendAng.z
			ang = -ang:Forward()
			
			local light = render.ComputeLighting(self.Owner:GetShootPos(), ang)
			
			cam.Start2D()
				surface.SetDrawColor(255, 255, 255, 255)
				surface.SetTexture(reticle)
				surface.DrawTexturedRect(0, 0, size, size)

				surface.SetDrawColor(150 * light[1], 150 * light[2], 150 * light[3], 255 * alpha)
				surface.SetTexture(lens)
				surface.DrawTexturedRectRotated(size * 0.5, size * 0.5, size, size, 90)
			cam.End2D()
		render.SetViewPort(0, 0, x, y)
		render.SetRenderTarget(old)
		
		if self.TSGlass then
			self.TSGlass:SetTexture("$basetexture", self.ScopeRT)
		end
	end
end

function att:attachFunc()
	self:setBodygroup(self.SightBGs.main, self.SightBGs.scope)
					if self.WMEnt then
		self.WMEnt:SetBodygroup(self.SightBGs.main, self.SightBGs.scope)
	end
    self.OverrideAimMouseSens = 0.25
	self.SimpleTelescopicsFOV = 70
	self.AimViewModelFOV = 50
	self.BlurOnAim = true
	self.ZoomTextures = att.zoomTextures
end

function att:detachFunc()
if self.WMEnt then
		self.WMEnt:SetBodygroup(self.SightBGs.main, self.SightBGs.none)
	end
	self.OverrideAimMouseSens = nil
	self.SimpleTelescopicsFOV = nil
	self.BlurOnAim = false
end

CustomizableWeaponry:registerAttachment(att)