local att = {}
att.name = "md_insight_x2"
att.displayName = "Insight X2 LAM"
att.displayNameShort = "X2 LAM"
att.laserRange = 4096
att.laserBeamRange = 75
att.colorType = CustomizableWeaponry.colorableParts.COLOR_TYPE_BEAM

att.statModifiers = {VelocitySensitivityMult = -0.2,
OverallMouseSensMult = -0.05,
HipSpreadMult = -0.2,
DrawSpeedMult = -0.05,
MaxSpreadIncMult = -0.25}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/insight_x2")
	local beam = Material("cw2/reticles/aim_reticule")
	local laserDot = Material("cw2/reticles/aim_reticule")
	
	att.reticle = "cw2/reticles/aim_reticule"
	local td = {}
	
	function att:elementRender()
		local model = self.AttachmentModelsVM.md_insight_x2.ent
		local pos = model:GetPos()
		local ang = self:getLaserAngles(model)
		local angs = nil
		
		if not self.freeAimOn then
			if self.dt.State == CW_AIMING then
				angs = self.LaserAngAdjustAim
			end
		end
		
		angs = angs or self.LaserAngAdjust
		
		-- rotate and prepare the position
		ang:RotateAroundAxis(ang:Right(), angs.p)
		ang:RotateAroundAxis(ang:Up(), angs.y)
		ang:RotateAroundAxis(ang:Forward(), angs.r)
		
		local dir = ang * 1
		
		if not self.freeAimOn then
			if self.dt.State == CW_AIMING then
				dir.p = self.Owner:EyeAngles().p
			end
		end
		
		local fw = dir:Forward()
		local laserPos = pos + ang:Right() * self.LaserPosAdjust.x + ang:Forward() * self.LaserPosAdjust.y + ang:Up() * self.LaserPosAdjust.z
		
		td.start = laserPos
		td.endpos = td.start + fw * att.laserRange
		td.filter = self.Owner
		
		local tr = util.TraceLine(td)
		
		if not self.lastLaserPos then
			self.lastLaserPos = tr.HitPos
		end
		
		local dist = math.Clamp(att.laserRange * tr.Fraction, 0, att.laserBeamRange)
		
		if util.PointContents(tr.HitPos) != CONTENTS_SOLID and not self.NearWall then
			local renderColor = self:getSightColor(att.name)
			local laserHQ = GetConVarNumber("cw_laser_quality") > 1
			
			-- draw the beam
			renderColor.a = 100
			render.SetMaterial(beam)
			
			render.DrawBeam(laserPos + fw, laserPos + fw * dist, 0.1, 0, 0.99, renderColor)
			
			if laserHQ then
				renderColor.a = 50
				render.DrawBeam(laserPos + fw, laserPos + fw * dist, 0.6, 0, 0.99, renderColor)
				
				renderColor.a = 25
				render.DrawBeam(laserPos + fw, laserPos + fw * dist, 1, 0, 0.99, renderColor)
			end
			
			-- draw the dot if the model is not out of world bounds
			renderColor.a = 255
			
			render.SetMaterial(laserDot)
			
			if GetConVarNumber("cw_laser_blur") >= 1 then
				render.DrawBeam(self.lastLaserPos, tr.HitPos, 1.5, 0, 0.99, renderColor)
				
				local dist = math.Clamp(self.lastLaserPos:Distance(tr.HitPos), 0, 2)

				dist = 1 - (dist / 2)
				
				if dist < 2 then
					renderColor.a = 255 * dist
					render.DrawSprite(tr.HitPos, 1.5, 1.5, renderColor)
					
					if laserHQ then
						renderColor.a = 33 * dist
						render.DrawSprite(tr.HitPos, 3, 3, renderColor)
					end
				end
			else
				render.DrawSprite(tr.HitPos, 1.5, 1.5, renderColor)
				
				if laserHQ then
					renderColor.a = 33
					render.DrawSprite(tr.HitPos, 3, 3, renderColor)
				end
			end
			
			self.lastLaserPos = tr.HitPos
		end
	end
end

CustomizableWeaponry:registerAttachment(att)