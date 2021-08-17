local att = {}
att.name = "md_fas2_aimpoint"
att.displayName = "Aimpoint® CompM4s"
att.displayNameShort = "Aimpoint"
att.aimPos = {"FAS2AimpointPos", "FAS2AimpointAng"}
att.FOVModifier = 25
att.isSight = true
att.colorType = CustomizableWeaponry.colorableParts.COLOR_TYPE_SIGHT
att.statModifiers = {OverallMouseSensMult = -0.08}

if CLIENT then
	att.displayIcon = surface.GetTextureID("entities/md_fas2_aimpoint")
	att.description = {
		[1] = {t = "Provides a bright reticle to ease aiming.", c = CustomizableWeaponry.textColors.POSITIVE},
		[2] = {t = "Slightly increases aim zoom.", c = CustomizableWeaponry.textColors.POSITIVE},
		[3] = {t = "Narrow scope may decrease awareness.", c = CustomizableWeaponry.textColors.NEGATIVE}
	}
	
	att.reticle = "qq_sprites/bigdot"
	att._reticleSize = 2
	
	local RTRSize = 96
	local RDSLense = Material("models/qq_rec/cod4_2014/weapon_red_dot_reflexsight")
	local Ini = true
	local reticleTime = 0
	local lulz = 0
	
	-- function att:elementRender()
	function att:drawRenderTarget()
		if not self.ActiveAttachments[att.name] then return end
		
		-- local aimEnt = self.AttachmentModelsVM[att.name] ? self.AttachmentModelsVM[att.name].ent : nil
		local rc = self:getSightColor(att.name)
		
		local isAiming = self:isAiming()
		local freeze = GetConVarNumber("cw_kk_freeze_reticles") != 0
		local isScopePos = (self.AimPos == self[att.aimPos[1]] and self.AimAng == self[att.aimPos[2]])
		local correctMDL = self.AttachmentModelsVM[att.name] and self.AttachmentModelsVM[att.name].model == "models/c_fas2_aimpoint.mdl" or self.AttachmentModelsVM[att.name].model == "models/c_fas2_aimpoint_rigged.mdl"
		
		if correctMDL then 
			local aimEnt = self.AttachmentModelsVM[att.name].ent
			if isAiming and isScopePos then
				aimEnt:SetBodygroup(1, 2)
			else
				aimEnt:SetBodygroup(1, 0)
			end
			
			local rigged = self.AttachmentModelsVM[att.name].model:find("rigged")
			if rigged then
				aimEnt:SetSequence(aimEnt:LookupSequence("idle"))
				aimEnt:ResetSequenceInfo()
				if self.CompM4SBoneMod and table.Count(self.CompM4SBoneMod)>0 then
					for key,value in pairs(self.CompM4SBoneMod) do
						aimEnt:ManipulateBoneScale(aimEnt:LookupBone(key), value.scale)
						aimEnt:ManipulateBonePosition(aimEnt:LookupBone(key), value.pos)
						aimEnt:ManipulateBoneAngles(aimEnt:LookupBone(key), value.angle)
					end
				else
					lulz = (lulz + FrameTime() * 15) % 360
					aimEnt:ManipulateBoneAngles(aimEnt:LookupBone("ard"), Angle(lulz - 180, 0, 0))
				end
			end
		end
		
		-- if not self:isAiming() then 
			-- RDSLense:SetTexture("$basetexture", "models/qq_rec/cod4_2014/512")
			-- return
		-- end
		
		-- if self:canSeeThroughTelescopics(att.aimPos[1]) and self:isReticleActive() then
		if isAiming and self:isReticleActive() and isScopePos then
			reticleTime = math.Approach(reticleTime, 1, FrameTime() * 1.8)
		else
			-- reticleTime = math.Approach(reticleTime, 0, FrameTime() * 20)
			reticleTime = 0
			if not freeze then
				RDSLense:SetTexture("$basetexture", "models/qq_rec/cod4_2014/512")
				return
			end
		end
		
		local old, x, y
		x, y = ScrW(), ScrH()
		old = render.GetRenderTarget()
		
		render.SetRenderTarget(CustomizableWeaponry_KK_ReflexSightRT)
		render.SetViewPort(0, 0, 512, 512)
			render.Clear(0,0,0,0,false,false)
			
			if CustomizableWeaponry_KK_ReflexSightRT_Ini then
				render.RenderView()
				render.Clear(0,0,0,0,false,false)
				CustomizableWeaponry_KK_ReflexSightRT_Ini = false
			end
			
			-- if self:isReticleActive() then
			-- if self:isReticleActive() then
				cam.Start2D()
					-- surface.SetDrawColor(255 - rc.r, 255 - rc.g, 255 - rc.b, 255)
					-- surface.SetTexture(surface.GetTextureID("qq_sprites/circlecross"))
					-- surface.DrawTexturedRect(192, 192, 128, 128)	
					
					-- local sightAng = self.AttachmentModelsVM[att.name].ent:GetAngles()
					-- // local sightAng = self.AimAng
					-- local aimAng = LocalPlayer():EyeAngles() + LocalPlayer():GetPunchAngle()
					
					-- print("=============")
					-- print(sightAng)
					-- print(aimAng)
					-- print(sightAng.p - aimAng.p .. ", " .. sightAng.y - aimAng.y .. ", " .. sightAng.r - aimAng.r)
					
					
					-- // 14.734 -151.618 -0.009
					-- // 14.503 -151.575 0.000
					-- local tw = self.FAS2AimpointTweak or Angle(0,0,0)
					
					-- local con = 0.1
					-- local dh = (sightAng.y - aimAng.y - tw.y) * con
					-- local dv = (sightAng.p - aimAng.p - tw.p) * con
					-- local center = (512 - RTRSize) / 2
					-- local rx = center * (dh + 1)
					-- local ry = center * (dv + 1)
					
					-- surface.SetDrawColor(255, 255, 255, 255)
					-- surface.SetTexture(surface.GetTextureID("qq_sprites/circledot"))
					-- surface.DrawTexturedRect(rx, ry, RTRSize, RTRSize)	
					
					local dh, dv, rx, ry
					
					dh = 1
					dv = 1
					-- self.AimSwayIntensity = 0
				
					if reticleTime == 1 and not freeze then
						dh = self:getDifferenceToAimPos(self.AimPos, self.AimAng, 0, 1, -2)
						dv = self:getDifferenceToAimPos(self.AimPos, self.AimAng, 1, 0, -2.5)
						-- self.AimSwayIntensity = self.AimSwayIntensityToRestore
					end
					
					rx = ((dh * (512 - RTRSize) / 2) + self.lastRX) / 2
					ry = ((dv * (512 - RTRSize) / 2) + self.lastRY) / 2
			
					surface.SetDrawColor(rc.r, rc.g, rc.b, 255)
					surface.SetTexture(surface.GetTextureID(att.reticle))
					surface.DrawTexturedRect(rx, ry, RTRSize, RTRSize)	
					
					surface.SetDrawColor(255, 255, 255, 150)
					surface.SetTexture(surface.GetTextureID(att.reticle))
					surface.DrawTexturedRect(rx + RTRSize/4, ry + RTRSize/4, RTRSize/2, RTRSize/2)
					
					if self.AttachmentModelsVM[att.name].showClip then
						local clip = self:Clip1()
						local clipPer = clip / self.Primary.ClipSize
						local textPos = 350
						
						surface.SetFont( "CW_HUD72" )
						surface.SetTextColor(255 * (1-clipPer), 255 * clipPer, 0, 255)
						surface.SetTextPos(textPos, textPos) 
						surface.DrawText(clip)
					end
					
					self.lastRX = rx
					self.lastRY = ry
				cam.End2D()
			-- end
			
		render.SetViewPort(0, 0, x, y)
		render.SetRenderTarget(old)
		
		if RDSLense then
			RDSLense:SetTexture("$basetexture", CustomizableWeaponry_KK_ReflexSightRT)
		end	
	end
	
	function att:attachFunc()
		self.lastRX = 0
		self.lastRY = 0
		
		if self.AttachmentModelsVM[att.name] then
			self.AttachmentModelsVM[att.name].animated = true
		end
		
		-- if self.WElements and self.WElements[att.name] then
			-- self.WElements[att.name].color.a = 255
		-- end
		
		-- self.AimSwayIntensityToRestore = self.AimSwayIntensity
	end
	
	function att:detachFunc()
		-- if self.WElements and self.WElements[att.name] then
			-- self.WElements[att.name].color.a = 0
		-- end
		-- self.AimSwayIntensity = self.AimSwayIntensityToRestore
	end
end

CustomizableWeaponry:registerAttachment(att)