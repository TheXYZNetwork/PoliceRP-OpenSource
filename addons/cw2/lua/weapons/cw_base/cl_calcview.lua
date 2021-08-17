local FT, CT, cos1, cos2, ws, vel, att, ang
local Ang0, curang, curviewbob = Angle(0, 0, 0), Angle(0, 0, 0), Angle(0, 0, 0)
local reg = debug.getregistry()
local GetVelocity = reg.Entity.GetVelocity
local Length = reg.Vector.Length
local Right = reg.Angle.Right
local Up = reg.Angle.Up
local Forward = reg.Angle.Forward
local RotateAroundAxis = reg.Angle.RotateAroundAxis

SWEP.LerpBackSpeed = 10
SWEP.CurM203Angles = Angle(0, 0, 0)
SWEP.M203AngDiff = Angle(0, 0, 0)
SWEP.BreathFOVModifier = 0

-- free aim related vars start here
SWEP.lastEyeAngle = Angle(0, 0, 0)
SWEP.lastViewRoll = 0
SWEP.lastViewRollTime = 0
SWEP.forceFreeAimOffTime = false
SWEP.lastShotTime = 0
SWEP.curFOV = 90

SWEP.mouseX = 0
SWEP.mouseY = 0
SWEP.lastMouseActivity = 0

SWEP.autoCenterExclusions = {[CW_RUNNING] = true,
[CW_ACTION] = true,
[CW_HOLSTER_START] = true,
[CW_HOLSTER_END] = true} -- if the weapon's state is any of this, then we will force-auto-center if it is enabled
-- end here

local Ang0 = Angle(0, 0, 0)

function SWEP:getFreeAimToCenter()
	local ang = self.Owner:EyeAngles()
	
	return math.AngleDifference(self.lastEyeAngle.y, ang.y) + math.AngleDifference(self.lastEyeAngle.p, ang.p)
end

function SWEP:getFreeAimDotToCenter()
	local dist = self:getFreeAimToCenter()
	
	return dist / (GetConVarNumber("cw_freeaim_yawlimit") + GetConVarNumber("cw_freeaim_pitchlimit"))
end

SWEP.freeAimAutoCenterSpeed = 6

function SWEP:CalcView(ply, pos, ang, fov)
	self.freeAimOn = self:isFreeAimOn()
	self.autoCenterFreeAim = GetConVarNumber("cw_freeaim_autocenter") > 0
	
	if self.dt.BipodDeployed then
		if not self.forceFreeAimOffTime then
			self.forceFreeAimOffTime = CurTime() + 0.5
		end
	else
		self.forceFreeAimOffTime = false
	end
		
	if self.freeAimOn then
		fov = 90 -- force FOV to 90 when in free aim mode, unfortunately, due to angles getting fucked up when FOV is not 90
		RunConsoleCommand("fov_desired", 90)
	end
	
	-- if we have free aim on, and we are not using a bipod, or we're using a bipod and we have not run out of "free aim time", then we should simulate free aim
	if self.freeAimOn and (not self.forceFreeAimOffTime or CurTime() < self.forceFreeAimOffTime) then
		local aiming = self.dt.State == CW_AIMING
		
		if self.shouldUpdateAngles then
			self.lastEyeAngle = self.Owner:EyeAngles()
			self.shouldUpdateAngles = false
		else
			local dot = math.Clamp(math.abs(self:getFreeAimDotToCenter()) + 0.3, 0.3, 1)
			
			local lazyAim = GetConVarNumber("cw_freeaim_lazyaim")
			self.lastEyeAngle.y = math.NormalizeAngle(self.lastEyeAngle.y - self.mouseX * lazyAim * dot)
			
			if not aiming and CurTime() > self.lastShotTime then -- we only want to modify pitch if we haven't shot lately
				self.lastEyeAngle.p = math.Clamp(self.lastEyeAngle.p + self.mouseY * lazyAim * dot, -89, 89)
			end
		end
		
		if self.autoCenterFreeAim then
			if self.mouseActive then
				self.lastMouseActivity = CurTime() + GetConVarNumber("cw_freeaim_autocenter_time")
			end
			
			local canAutoCenter = CurTime() > self.lastMouseActivity 
			local shouldAutoCenter = false
			local aimAutoCenter = GetConVarNumber("cw_freeaim_autocenter_aim") > 0
			
			if aiming then
				canAutoCenter = true
				shouldAutoCenter = true
			end
		
			if self.autoCenterExclusions[self.dt.State] then
				canAutoCenter = true
				shouldAutoCenter = true
			end
			
			if self.forceFreeAimOffTime then -- if we're being forced to turn free-aim off, do so
				canAutoCenter = true
				shouldAutoCenter = true
			end
		
			if canAutoCenter then
				local frameTime = FrameTime()
				
				self.freeAimAutoCenterSpeed = frameTime * 16
				
				if aiming then
					self.freeAimAutoCenterSpeed = frameTime * 25 --math.Approach(self.freeAimAutoCenterSpeed, frameTime * 40, frameTime * 6)
				end
				
				if self.autoCenterExclusions[self.dt.State] then
					shouldAutoCenter = true
				else
					if CurTime() > self.lastMouseActivity then
						shouldAutoCenter = true
						self.freeAimAutoCenterSpeed = frameTime * 6 --math.Approach(self.freeAimAutoCenterSpeed, frameTime * 6, frameTime * 6)
					end
				end
				
				self.freeAimAutoCenterSpeed = math.Clamp(self.freeAimAutoCenterSpeed, 0, 1)
					
				if shouldAutoCenter then
					self.lastEyeAngle = LerpAngle(self.freeAimAutoCenterSpeed, self.lastEyeAngle, self.Owner:EyeAngles())
				end
			end
		end
		
		local yawDiff = math.AngleDifference(self.lastEyeAngle.y, ang.y)
		local pitchDiff = math.AngleDifference(self.lastEyeAngle.p, ang.p)
		
		local yawLimit = GetConVarNumber("cw_freeaim_yawlimit")
		local pitchLimit = GetConVarNumber("cw_freeaim_pitchlimit")
		
		if yawDiff >= yawLimit then
			self.lastEyeAngle.y = math.NormalizeAngle(ang.y + yawLimit)
		elseif yawDiff <= -yawLimit then
			self.lastEyeAngle.y = math.NormalizeAngle(ang.y - yawLimit)
		end
		
		if pitchDiff >= pitchLimit then
			self.lastEyeAngle.p = math.NormalizeAngle(ang.p + pitchLimit)
		elseif pitchDiff <= -pitchLimit then
			self.lastEyeAngle.p = math.NormalizeAngle(ang.p - pitchLimit)
		end
		
		ang.y = self.lastEyeAngle.y
		ang.p = self.lastEyeAngle.p
		
		ang = ang
	else
		self.shouldUpdateAngles = true
	end
	
	FT, CT = FrameTime(), CurTime()
	
	local resetM203Angles = false
	
	self.M203CameraActive = false
	
	if self.AttachmentModelsVM then
		local m203 = self.AttachmentModelsVM.md_m203
		
		if m203 then
			if self.dt.State ~= CW_CUSTOMIZE then
				local CAMERA = m203.ent:GetAttachment(m203.ent:LookupAttachment("Camera")).Ang
				local modelAng = m203.ent:GetAngles()
				
				RotateAroundAxis(CAMERA, Right(CAMERA), self.M203CameraRotation.p)
				RotateAroundAxis(CAMERA, Up(CAMERA), self.M203CameraRotation.y)
				RotateAroundAxis(CAMERA, Forward(CAMERA), self.M203CameraRotation.r)

				local factor = math.abs(ang.p)
				local intensity = 1
				
				if factor >= 60 then
					factor = factor - 60
					intensity = math.Clamp(1 - math.abs(factor / 15), 0, 1)
				end
				
				self.M203AngDiff = math.NormalizeAngles((modelAng - CAMERA)) * 0.5 * intensity
			end
		end
	end
	
	ang = ang - self.M203AngDiff
	ang = ang - self.CurM203Angles * 0.5
	ang.r = ang.r + self.lastViewRoll
	
	if UnPredictedCurTime() > self.lastViewRollTime then
		self.lastViewRoll = LerpCW20(FrameTime() * 10, self.lastViewRoll, 0)
	end
	
	if UnPredictedCurTime() > self.FOVHoldTime or freeAimOn then
		self.FOVTarget = LerpCW20(FT * 10, self.FOVTarget, 0)
	end	
	
	if self.ReloadViewBobEnabled then
		if self.IsReloading and self.Cycle <= 0.9 then
			att = self.Owner:GetAttachment(1)
			
			if att then
				ang = ang * 1
				
				self.LerpBackSpeed = 1
				curang = LerpAngle(FT * 10, curang, (ang - att.Ang) * 0.1)
			else
				self.LerpBackSpeed = math.Approach(self.LerpBackSpeed, 10, FT * 50)
				curang = LerpAngle(FT * self.LerpBackSpeed, curang, Ang0)
			end
		else
			self.LerpBackSpeed = math.Approach(self.LerpBackSpeed, 10, FT * 50)
			curang = LerpAngle(FT * self.LerpBackSpeed, curang, Ang0)
		end

		RotateAroundAxis(ang, Right(ang), curang.p * self.RVBPitchMod)
		RotateAroundAxis(ang, Up(ang), curang.r * self.RVBYawMod)
		RotateAroundAxis(ang, Forward(ang), (curang.p + curang.r) * 0.15 * self.RVBRollMod)
	end
	
	if self.dt.State == CW_AIMING then
		if self.dt.M203Active and self.M203Chamber and not CustomizableWeaponry.grenadeTypes:canUseProperSights(self.Grenade40MM) then
			self.CurFOVMod = LerpCW20(FT * 10, self.CurFOVMod, 5)
		else
			local zoomAmount = self.ZoomAmount
			local simpleTelescopics = not self:canUseComplexTelescopics()
			local shouldDelay = false
			
			if simpleTelescopics then
				if self.SimpleTelescopicsFOV then
					zoomAmount = self.SimpleTelescopicsFOV
					shouldDelay = true
				end
			end
			
			if self.DelayedZoom or shouldDelay then
				if CT > self.AimTime then
					if self.SnapZoom or (self.SimpleTelescopicsFOV and simpleTelescopics) then
						self.CurFOVMod = zoomAmount
					else
						self.CurFOVMod = LerpCW20(FT * 10, self.CurFOVMod, zoomAmount)
					end
				else
					self.CurFOVMod = LerpCW20(FT * 10, self.CurFOVMod, 0)
				end
			else
				if self.SnapZoom or (self.SimpleTelescopicsFOV and simpleTelescopics) then
					self.CurFOVMod = zoomAmount
				else
					self.CurFOVMod = LerpCW20(FT * 10, self.CurFOVMod, zoomAmount)
				end
			end
		end
	else
		self.CurFOVMod = LerpCW20(FT * 10, self.CurFOVMod, 0)
	end
	
	if self.holdingBreath then
		self.BreathFOVModifier = math.Approach(self.BreathFOVModifier, 7, FT * 12)
	else
		self.BreathFOVModifier = math.Approach(self.BreathFOVModifier, 0, FT * 10)
	end
	
	fov = math.Clamp(fov - self.CurFOVMod - self.BreathFOVModifier, 5, 90)
	
	if self.Owner then
		if self.ViewbobEnabled then
			ws = self.Owner:GetWalkSpeed()
			vel = Length(GetVelocity(self.Owner))
			
			local intensity = 1
						
			if self:isPlayerProne() and vel >= self.BusyProneVelocity then
				intensity = 7
				cos1 = math.cos(CT * 6)
				cos2 = math.cos(CT * 7)
				curviewbob.p = cos1 * 0.1 * intensity
				curviewbob.y = cos2 * 0.2 * intensity
			else			
				if self.Owner:OnGround() and vel > ws * 0.3 then
					if vel < ws * 1.2 then
						cos1 = math.cos(CT * 15)
						cos2 = math.cos(CT * 12)
						curviewbob.p = cos1 * 0.15 * intensity
						curviewbob.y = cos2 * 0.1 * intensity
					else
						cos1 = math.cos(CT * 20)
						cos2 = math.cos(CT * 15)
						curviewbob.p = cos1 * 0.25 * intensity
						curviewbob.y = cos2 * 0.15 * intensity
					end
				else
					curviewbob = LerpAngle(FT * 10, curviewbob, Ang0)
				end
			end
		end
	end
	
	fov = fov - self.FOVTarget
	self.curFOV = fov
	
	return pos, ang + curviewbob * self.ViewbobIntensity, fov
end

function SWEP:reduceBreathAmount(recoilMod, regenTime)
	recoilMod = recoilMod or 0.2
	regenTime = regenTime or self.BreathRegenDelay
	
	self.breathRegenWait = CurTime() + regenTime
	self.BreathLeft = math.Clamp(self.BreathLeft - self.Recoil * recoilMod * 0.25, 0, 1)
end

function SWEP:stopHoldingBreath(time, regenTime, recoilMod)
	if self.holdingBreath then
		time = time or self.BreathDelay
		regenTime = regenTime or self.BreathRegenDelay
		
		self.holdingBreath = false
		self.breathWait = CurTime() + time
		self:reduceBreathAmount(recoilMod) -- if we're aiming, reduce it by using the recoilMod variable passed on to us
		surface.PlaySound("ins2/focus_inhale.wav")
	else
		self.breathRegenWait = CurTime() + 0.2
	end
end

function SWEP.CreateMove(move)
	ply = LocalPlayer()
	wep = ply:GetActiveWeapon()
	
	if IsValid(wep) and wep.CW20Weapon then
		local FT = FrameTime()
		local CT = CurTime()
		
		local shouldFreeze = false
		local mouseSensitivityMod = wep:AdjustMouseSensitivity() -- we should ignore mouse sensitivity into account when adjusting via mouse movement
		
		-- make sure we're: 1) customizing; 2) are in the adjustment tab; 3) have an active attachment
		if wep.dt.State == CW_CUSTOMIZE then
			shouldFreeze = CustomizableWeaponry.callbacks.processCategory(wep, "shouldFreezeView", move:GetMouseX() / mouseSensitivityMod)
			local canAdjustAttachment = false
			
			if type(shouldFreeze) == "boolean" then
				canAdjustAttachment = not shouldFreeze
			else
				canAdjustAttachment = true
			end
			
			if canAdjustAttachment then
				canAdjustAttachment = wep.CustomizationTab == CustomizableWeaponry.interactionMenu.TAB_ATTACHMENT_ADJUSTMENT and CustomizableWeaponry.sightAdjustment:getCurrentAttachment() and ply:KeyDown(IN_ATTACK)
			end
			
			if canAdjustAttachment then
				ply._holdAngles = ply._holdAngles or ply:EyeAngles()
					
				move:SetViewAngles(ply._holdAngles) -- prevent moving of the view area while adjusting attachment position
				CustomizableWeaponry.sightAdjustment:adjust(wep, move:GetMouseX() * 0.001 / mouseSensitivityMod)
				return
			else
				if not shouldFreeze then
					ply._holdAngles = nil
				end
			end
		end
				
		if shouldFreeze == false then
			ply._holdAngles = nil
		elseif shouldFreeze == true then
			ply._holdAngles = ply._holdAngles or ply:EyeAngles()
				
			move:SetViewAngles(ply._holdAngles) -- prevent moving of the view area while adjusting attachment position
			return
		end
		
		if wep.freeAimOn then
			wep.mouseX = move:GetMouseX()
			wep.mouseY = move:GetMouseY()
			
			wep.mouseActive = wep.mouseX ~= 0 or wep.mouseY ~= 0
		end
		
		local vel = ply:GetVelocity():Length()
		local aiming = wep.dt.State == CW_AIMING
		
		if wep.AimBreathingEnabled then
			if wep.holdingBreath then
				if vel > wep.BreathHoldVelocityMinimum and CT > wep.breathReleaseWait then
					wep:stopHoldingBreath(nil, nil, 0)
					wep.noBreathHoldingUntilKeyRelease = true
				else
					wep.CurBreatheIntensity = math.Approach(wep.CurBreatheIntensity, 0, FT * wep.BreathIntensityDrainRate)
					
					if CT > wep.breathReleaseWait then
						wep.BreathLeft = math.Approach(wep.BreathLeft, 0, FT * wep.BreathDrainRate)
					end
					
					if wep.BreathLeft <= 0 then
						wep:stopHoldingBreath(nil, nil, 0)
						wep.noBreathHoldingUntilKeyRelease = true
					end
				end
			else
				if CT > wep.breathRegenWait then
					wep.BreathLeft = math.Approach(wep.BreathLeft, 1, FT * wep.BreathRegenRate)
				end
				
				if aiming then
					if wep.dt.BipodDeployed then
						wep.CurBreatheIntensity = math.Approach(wep.CurBreatheIntensity, wep.BreathIntensityOnBipod, FT * wep.BreathIntensitySwitchRate)
					elseif not wep.BipodInstalled and wep:CanRestWeapon(wep.WeaponRestHeightRequirement) then
						wep.CurBreatheIntensity = math.Approach(wep.CurBreatheIntensity, wep.BreathIntensityOnRest, FT * wep.BreathIntensitySwitchRate)
					else
						wep.CurBreatheIntensity = math.Approach(wep.CurBreatheIntensity, 1, FT * wep.BreathIntensityRegenRate)
					end
				else
					wep.CurBreatheIntensity = math.Approach(wep.CurBreatheIntensity, 1, FT * wep.BreathIntensityRegenRate)
				end
			end
		end
		
		if wep.dt and aiming and wep.AimBreathingEnabled then
			if wep.AimBreathingEnabled then
				if wep.Owner:KeyDown(IN_SPEED) then
					if CT > wep.breathWait then
						if not wep.noBreathHoldingUntilKeyRelease and vel < wep.BreathHoldVelocityMinimum then
							-- can only start holding breath if we have at least 50% of our breath
							if not wep.holdingBreath and wep.BreathLeft >= wep.MinimumBreathPercentage then
								wep.holdingBreath = true
								wep.breathReleaseWait = CT + 0.5
								surface.PlaySound("ins2/focus_exhale.wav")
							end
						end
					end
				else
					if CT > wep.breathReleaseWait then
						if wep.holdingBreath then
							wep:stopHoldingBreath(nil, nil, 0)
						end
						
						wep.noBreathHoldingUntilKeyRelease = false
					end
				end
			end
		
			ang = move:GetViewAngles()
			ang.p = ang.p - math.cos(CT * 1.25) * 0.003 * wep.AimBreathingIntensity * wep.CurBreatheIntensity
			
			move:SetViewAngles(ang)
		end
		
		if wep.dt.BipodDeployed and wep.DeployAngle then
			ang = move:GetViewAngles()
			
			local EA = ply:EyeAngles()
			dif = math.AngleDifference(EA.y, wep.DeployAngle.y)
			
			if dif >= wep.BipodAngleLimitYaw then
				ang.y = wep.DeployAngle.y + wep.BipodAngleLimitYaw
			elseif dif <= -wep.BipodAngleLimitYaw then
				ang.y = wep.DeployAngle.y - wep.BipodAngleLimitYaw
			end
			
			dif = math.AngleDifference(EA.p, wep.DeployAngle.p)
			
			if dif >= wep.BipodAngleLimitPitch then
				ang.p = wep.DeployAngle.p + wep.BipodAngleLimitPitch
			elseif dif <= -wep.BipodAngleLimitPitch then
				ang.p = wep.DeployAngle.p - wep.BipodAngleLimitPitch
			end

			move:SetViewAngles(ang)
		end
	end
end

hook.Add("CreateMove", "CW20 CreateMove", SWEP.CreateMove)

function SWEP:AdjustMouseSensitivity()
	local sensitivity = 1
	local mod = math.Clamp(self.OverallMouseSens, 0.1, 1) -- not lower than 10% and not higher than 100% (in case someone uses atts that increase handling)
	local freeAimMod = 1
	
	if self.freeAimOn and not self.dt.BipodDeployed then
		local dist = math.abs(self:getFreeAimDotToCenter())
		
		local mouseImpendance = GetConVarNumber("cw_freeaim_center_mouse_impendance")
		freeAimMod = 1 - (mouseImpendance - mouseImpendance * dist)
	end
	
	if self.dt.State == CW_RUNNING then
		if self.RunMouseSensMod then
			return self.RunMouseSensMod * mod
		end
	end
	
	if self.dt.State == CW_AIMING then
		-- if we're aiming and our aiming position is that of the sight we have installed - decrease our mouse sensitivity
		if (self.OverrideAimMouseSens and self.AimPos == self.ActualSightPos) and (self.dt.M203Active and CustomizableWeaponry.grenadeTypes:canUseProperSights(self.Grenade40MM) or not self.dt.M203Active) then
			--return self.OverrideAimMouseSens * mod
			sensitivity = self.OverrideAimMouseSens
		end
		
		--return math.Clamp(1 - self.ZoomAmount / 100, 0.1, 1) * mod 
		sensitivity = math.Clamp(sensitivity - self.ZoomAmount / 100, 0.1, 1) 
	end
	
	sensitivity = sensitivity * mod
	sensitivity = sensitivity * freeAimMod
	
	return sensitivity --1 * self.OverallMouseSens
end