local att = {}
att.name = "md_microt1"
att.displayName = "Micro T1"
att.displayNameShort = "M-T1"
att.aimPos = {"MicroT1Pos", "MicroT1Ang"}
att.FOVModifier = 15
att.isSight = true
att.colorType = CustomizableWeaponry.colorableParts.COLOR_TYPE_SIGHT

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/microt1")
	att.description = {[1] = {t = "Provides a bright reticle to ease aiming.", c = CustomizableWeaponry.textColors.POSITIVE},
	[3] = {t = "Narrow scope may decrease awareness.", c = CustomizableWeaponry.textColors.NEGATIVE}}
	
	att.reticle = "cw2/reticles/aim_reticule"
	att._reticleSize = 0.2
	
	function att:drawReticle()
		if not self:isAiming() or not self:isReticleActive() then
			return
		end
		
		diff = self:getDifferenceToAimPos(self.MicroT1Pos, self.MicroT1Ang, 1)
		
		-- draw the reticle only when it's close to center of the aiming position
		if diff > 0.9 and diff < 1.1 then
			cam.IgnoreZ(true)
				render.SetMaterial(att._reticle)
				dist = math.Clamp(math.Distance(1, 1, diff, diff), 0, 0.13)
				
				local EA = self:getReticleAngles()
				
				local renderColor = self:getSightColor(att.name)
				renderColor.a = (0.13 - dist) / 0.13 * 255
				
				local pos = EyePos() + EA:Forward() * 100
				
				for i = 1, 2 do
					render.DrawSprite(pos, att._reticleSize, att._reticleSize, renderColor)
				end
			cam.IgnoreZ(false)
		end
	end
	
	function att:attachFunc()
		self.AimViewModelFOV = 35
	end
	
	function att:detachFunc()
		self.AimViewModelFOV = self.AimViewModelFOV_Orig
	end
end

CustomizableWeaponry:registerAttachment(att)