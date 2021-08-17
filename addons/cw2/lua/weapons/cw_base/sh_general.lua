-- various convenience functions related to the weapon

local reg = debug.getregistry()
local GetVelocity = reg.Entity.GetVelocity
local Length = reg.Vector.Length
local GetAimVector = reg.Player.GetAimVector

-- no reason to get it over and over again, since if it's singleplayer, it's singleplayer
local SP = game.SinglePlayer()

--[[attachment inter-dependency logic:
requires a table, ie SWEP.AttachmentPosDependency
first index a string containing attachments that it depends on
second index is a string which contains the vector position
]]--

function LerpCW20(val, min, max) -- basically a wrapper that limits 'val' (aka progress) to a max of 1
	val = val > 1 and 1 or val
	return Lerp(val, min, max)
end

function SWEP:canCustomize()
	if not self.CanCustomize then
		return false
	end
	
	if self.ReloadDelay then
		return false
	end
	
	if self.NoCustomizeStates[self.dt.State] then
		return false
	end
	
	if not self.Owner:OnGround() then
		return false
	end
	
	return true
end

function SWEP:isLowOnMagAmmo()
	if self:Clip1() <= self.Primary.ClipSize * 0.25 or self:getReloadProgress() then
		return true
	end
end

function SWEP:isLowOnAmmo()
	if self.Owner:GetAmmoCount(self.Primary.Ammo) <= self.Primary.ClipSize then
		return true
	end
	
	return false
end

function SWEP:isLowOnTotalAmmo()
	if self.Owner:GetAmmoCount(self.Primary.Ammo) + self:Clip1() <= self.Primary.ClipSize * 2 then
		return true
	end
	
	return false
end

function SWEP:setM203Chamber(state)
	self.M203Chamber = state
	self:networkM203Chamber()
end

function SWEP:networkM203Chamber()
	umsg.Start("CW20_M203CHAMBER", self.Owner)
		umsg.Entity(self)
		umsg.Bool(self.M203Chamber)
	umsg.End()
end

function SWEP:resetAimBreathingState()
	self.AimBreathingEnabled = self.AimBreathingEnabled_Orig
end

function SWEP:maxOutWeaponAmmo(desiredAmmo)
	self:SetClip1(desiredAmmo + (self.Chamberable and 1 or 0))
end

function SWEP:isAiming()
	return self.dt.State == CW_AIMING
end

function SWEP:setupSuppressorPositions()
	self.SuppressorPositions = self.SuppressorPositions or {}
	
	if self.AttachmentModelsVM then
		for k, v in pairs(self.AttachmentModelsVM) do
			-- easy way to find all suppressor attachments, 'silencer' is there in case someone is gun-illiterate enough and calls them incorrectly
			if k:find("suppress") or k:find("silencer") then
				self.SuppressorPositions[k] = v.pos
				v.origPos = v.pos
			end
		end
	end
end

function SWEP:updateAttachmentPositions()
	if not self.AttachmentPosDependency and not self.AttachmentAngDependency then
		return
	end
	
	if not self.AttachmentModelsVM then
		return
	end
	
	-- loop through the VM attachment table
	for k, v in pairs(self.AttachmentModelsVM) do
		-- iterate through active attachments only
		if v.active then
			-- check for inter-dependencies of this attachment
			
			if self.AttachmentPosDependency then
				local inter = self.AttachmentPosDependency[k]
				
				if inter then
					-- loop through the attachment table, find active attachments
					local found = false
					
					for k2, v2 in pairs(inter) do
						if self.ActiveAttachments[k2] then
							v.pos = inter[k2]
							found = true
						end
					end
					
					-- reset the position in case none are active
					if not found then
						v.pos = v.origPos
					end
				end
			end
			
			if self.AttachmentAngDependency then
				local inter = self.AttachmentAngDependency[k]
				
				if inter then
					-- loop through the attachment table, find active attachments
					local found = false
					
					for k2, v2 in pairs(inter) do
						if self.ActiveAttachments[k2] then
							v.angle = inter[k2]
							found = true
						end
					end
					
					-- reset the position in case none are active
					if not found then
						v.angle = v.origAng
					end
				end
			end
		end
	end
end

function SWEP:updateSuppressorPosition(suppressor)
	if not self.SuppressorPositions then
		return
	end
	
	if not self.AttachmentModelsVM then
		return
	end
	
	local found = false
	
	-- loop through the table
	for k, v in pairs(self.Attachments) do
		if v.last then -- check active attachments
			-- if there is one and it is in the SuppressorPositions table
			local suppressorPos = self.SuppressorPositions[v.atts[v.last]]
			
			if suppressorPos then
				--find every single VM element with part of the name "suppress" or "silencer" and update it's pos to what it is
				
				for k2, v2 in pairs(self.AttachmentModelsVM) do
					if CustomizableWeaponry.suppressors[k2] then
					--if k2:find("suppress") or k2:find("silencer") then
						v2.pos = suppressorPos
						found = true
						break
					end
				end
			end
		end
	end
	
	-- if nothing is found, revert the position back to origPos
	
	if not found then
		for k, v in pairs(self.AttachmentModelsVM) do
			if CustomizableWeaponry.suppressors[k] then
				v.pos = v.origPos
			end
		end
	end
end

function SWEP:canSeeThroughTelescopics(aimPosName)
	if self.dt.State == CW_AIMING and not self.Peeking and self.AimPos == self[aimPosName] then
		local canUseSights = CustomizableWeaponry.grenadeTypes:canUseProperSights(self.Grenade40MM)
		
		if self.dt.M203Active then
			if self.M203Chamber then
				if canUseSights then
					return true
				end
			else
				return true
			end
		else
			return true
		end
	end
	
	return false
end

function SWEP:hasExcludedAttachment(tbl, targetTable)
	targetTable = targetTable or self.ActiveAttachments
	
	for k, v in pairs(tbl) do
		if targetTable[v] then
			return true, targetTable[v]
		end
	end
	
	return false
end

function SWEP:isCategoryEligible(depend, exclude, activeAttachments)
	local state = false
	
	activeAttachments = activeAttachments or self.ActiveAttachments
	
	-- if there are dependencies, make sure we have at least one of them for this category
	if depend then
		for k, v in pairs(depend) do
			if activeAttachments[k] then
				return true
			end
		end
	else
		state = true -- if there are none, assume no exclusions
	end
	
	-- if there are exclusions, loop through, if there are any attachments that exclude the current category, don't allow us to attach it
	if exclude then
		for k, v in pairs(exclude) do
			if activeAttachments[k] then
				return false, -1, k -- active attachment that excludes this category
			end
		end
	end
	
	-- otherwise, return the final verdict
	return state, -2, depend -- either true or false, in case of false - attachment(s) we depend on is (are) not active
end

-- this function checks whether a certain attachment can be attached
-- it's different from the 'dependencies' and 'exclusions' tables in the Attachments table in the way that it checks eligibility on a per-attachment basis
-- keep in mind that the 'dependencies' and 'exclusions' you specify in the Attachments table are on a category basis

function SWEP:isAttachmentEligible(name, activeAttachments)
	local found = nil
	
	activeAttachments = activeAttachments or self.ActiveAttachments
	
	if self.AttachmentDependencies then
		local depend = self.AttachmentDependencies[name]
		
		-- loop through the active attachments, see if any of them are active
		if depend then
			found = false
			
			for k, v in pairs(depend) do
				-- if they are, that means we can proceed
				if activeAttachments[v] then
					found = true
					break
				end
			end
		end
	end
	
	if self.AttachmentExclusions then
		-- loop through the exclusions for this particular attachment, if there are any, let us know that we can't proceed
		local excl = self.AttachmentExclusions[name]
		
		if excl then
			for k, v in pairs(excl) do
				if activeAttachments[v] then
					return false, self.AttachmentEligibilityEnum.ACTIVE_ATTACHMENT_EXCLUSION, activeAttachments[v] -- active attachment excludes
				end
			end
		end
	end
	
	-- nil indicates that we can attach
	if found == nil then
		return true
	end
	
	-- or just return the result
	return found, self.AttachmentEligibilityEnum.NEED_ATTACHMENTS, self.AttachmentDependencies[name] -- in case of false - attachment we depend on is not attached
end

-- this function is ran every time an attachment is detached (or swapped, which is basically the same thing)
-- what it does is it checks every attachment for dependencies, and detaches everything that can't be on the weapon without a 'parent' attachment
function SWEP:checkAttachmentDependency()
	for k, v in ipairs(self.Attachments) do
		if v.last then
			local curAtt = v.atts[v.last]
			local foundAtt = CustomizableWeaponry.registeredAttachmentsSKey[curAtt]
			
			-- we've found an attachment that's currently on the weapon, check if it depends on anything
			if foundAtt then
				-- check if the category and the attachment are eligible
				if not self:isAttachmentEligible(foundAtt.name) or not self:isCategoryEligible(v.dependencies, v.exclusions) then
					-- they aren't eligible, time to detach them
					self:_detach(k, v.last)
				end
			end
		end
	end
end

-- restores the current firing sounds back to their original variants
function SWEP:restoreSound()
	self.FireSound = self.FireSound_Orig
	self.FireSoundSuppressed = self.FireSoundSuppressed_Orig
end

function SWEP:updateSoundTo(snd, var)
	if not snd then
		return
	end
	
	var = var or 0
	
	-- var 0 is the unsuppressed fire sound, var 1 is the suppressed
	if var == 0 then
		self.FireSound = Sound(snd)
		
		return self.FireSound
	elseif var == 1 then
		self.FireSoundSuppressed = Sound(snd)
		
		return self.FireSoundSuppressed
	end
end

function SWEP:setupCurrentIronsights(pos, ang)
	if SERVER then
		return
	end
	
	self.CurIronsightPos = pos
	self.CurIronsightAng = ang
end

function SWEP:resetSuppressorStatus()
	if self.SuppressedOnEquip ~= nil then
		self.dt.Suppressed = self.SuppressedOnEquip
	else
		-- default to false
		self.dt.Suppressed = false
	end
end

function SWEP:resetAimToIronsights()
	if SERVER then
		return
	end
	
	self.AimPos = self.CurIronsightPos
	self.AimAng = self.CurIronsightAng
	
	self.ActualSightPos = nil
	self.ActualSightAng = nil
	
	self.SightBackUpPos = nil
	self.SightBackUpAng = nil
end

function SWEP:revertToOriginalIronsights()
	if SERVER then
		return
	end
	
	self.CurIronsightPos = self.AimPos_Orig
	self.CurIronsightAng = self.AimAng_Orig
	
	if not self:isAttachmentActive("sights") then
		self.AimPos = self.CurIronsightPos
		self.AimAng = self.CurIronsightAng
	end
end

function SWEP:updateIronsights(index)
	if SERVER then
		return
	end
	
	self.AimPos = self[index .. "Pos"]
	self.AimAng = self[index .. "Ang"]
end

function SWEP:isAttachmentActive(category)
	if not category then
		return false
	end
	
	if not CustomizableWeaponry[category] then
		return false
	end
	
	for k, v in ipairs(self.Attachments) do
		if v.last then
			local curAtt = v.atts[v.last]

			if CustomizableWeaponry[category][curAtt] then
				return true
			end
		end
	end
	
	return false
end

local mins, maxs = Vector(-8, -8, -1), Vector(8, 8, 1)

local td = {}
td.mins = mins
td.maxs = maxs

function SWEP:CanRestWeapon(height)
	height = height or -1
	local vel = Length(GetVelocity(self.Owner))
	local pitch = self.Owner:EyeAngles().p
	
	if vel == 0 and pitch <= 60 and pitch >= -20 then
		local sp = self.Owner:GetShootPos()
		local aim = self.Owner:GetAimVector()
		
		td.start = sp
		td.endpos = td.start + aim * 35
		td.filter = self.Owner
				
		local tr = util.TraceHull(td)

		-- fire first trace to check whether there is anything IN FRONT OF US
		if tr.Hit then
			-- if there is, don't allow us to deploy
			return false
		end
		
		aim.z = height
		
		td.start = sp
		td.endpos = td.start + aim * 25
		td.filter = self.Owner
				
		tr = util.TraceHull(td)
		
		if tr.Hit then
			local ent = tr.Entity
			
			-- if the second trace passes, we can deploy
			if not ent:IsPlayer() and not ent:IsNPC() then
				return true
			end
		end
		
		return false
	end
	
	return false
end

function SWEP:getSpreadModifiers()
	local mul = 1
	local mulMax = 1

	-- decrease spread increase when aiming
	if self.Owner:Crouching() then
		mul = mul * 0.75
	end
	
	-- and when a bipod is deployed
	if self.dt.BipodDeployed then
		mul = mul * 0.5
		mulMax = 0.5 -- decrease maximum spread increase
	end
	
	return mul, mulMax
end

function SWEP:getFinalSpread(vel, maxMultiplier)
	maxMultiplier = maxMultiplier or 1
	
	local final = self.BaseCone
	local aiming = self.dt.State == CW_AIMING
	-- take the continuous fire spread into account
	final = final + self.AddSpread
	
	-- and the player's velocity * mobility factor
	
	if aiming then
		-- irl the accuracy of your weapon goes to shit when you start moving even if you aim down the sights, so when aiming, player movement will impact the spread even more than it does during hip fire
		-- but we're gonna clamp it to a maximum of the weapon's hip fire spread, so that even if you aim down the sights and move, your accuracy won't be worse than your hip fire spread
		final = math.min(final + (vel / 10000 * self.VelocitySensitivity) * self.AimMobilitySpreadMod, self.HipSpread)
	else
		final = final + (vel / 10000 * self.VelocitySensitivity)
	end
	
	if self.ShootWhileProne and self:isPlayerProne() then
		final = final + vel / 1000
	end
	
	-- as well as the spread caused by rapid mouse movement
	final = final + self.Owner.ViewAff
	
	-- lastly, return the final clamped value
	return math.Clamp(final, 0, 0.09 + self:getMaxSpreadIncrease(maxMultiplier))
end

function SWEP:isNearWall()
	if not self.NearWallEnabled then
		return false
	end
	
	td.start = self.Owner:GetShootPos()
	td.endpos = td.start + self.Owner:EyeAngles():Forward() * 30
	td.filter = self.Owner
	
	local tr = util.TraceLine(td)
	
	if tr.Hit or (IsValid(tr.Entity) and not tr.Entity:IsPlayer()) then
		return true
	end
	
	return false
end

function SWEP:performBipodDelay(time)
	time = time or self.BipodDeployTime
	local CT = CurTime()
	
	self.BipodDelay = CT + time
	self:SetNextPrimaryFire(CT + time)
	self:SetNextSecondaryFire(CT + time)
	self.ReloadWait = CT + time
end

function SWEP:delayEverything(time)
	time = time or 0.15
	local CT = CurTime()
	
	self.BipodDelay = CT + time
	self:SetNextPrimaryFire(CT + time)
	self:SetNextSecondaryFire(CT + time)
	self.ReloadWait = CT + time
	self.HolsterWait = CT + time
end

function SWEP:isBipodIdle()
	if self.dt.BipodDeployed and self.DeployAngle and self.dt.State == CW_IDLE then 
		return true
	end
	
	return false
end

function SWEP:isBipodDeployed()
	if self.dt.BipodDeployed then
		return true
	end
	
	return false
end

function SWEP:isReloading()
	if self.ReloadDelay then
		return true
	end
	
	if (SP and CLIENT) then
		if self.IsReloading then
			if self.Cycle < 0.98 then
				return true
			end
		end
	end
	
	return false
end

function SWEP:canOpenInteractionMenu()
	if self.dt.State == CW_CUSTOMIZE then
		return true
	end
	
	if CustomizableWeaponry.callbacks.processCategory(self, "disableInteractionMenu") then
		return false
	end
	
	if table.Count(self.Attachments) == 0 then
		return false
	end
	
	if self.ReloadDelay then
		return false
	end
	
	local CT = CurTime()
	
	if CT < self.ReloadWait or CT < self.BipodDelay or self.dt.BipodDeployed then
		return false
	end
	
	if Length(GetVelocity(self.Owner)) >= self.Owner:GetWalkSpeed() * self.RunStateVelocity then
		return false
	end
	
	if not self.Owner:OnGround() then
		return false
	end
	
	return true
end

function SWEP:setupBipodVars()
	-- network/predict bipod angles
	
	if SP and SERVER then
		umsg.Start("CW20_DEPLOYANGLE", self.Owner)
			umsg.Angle(self.Owner:EyeAngles())
		umsg.End()
	else
		self.DeployAngle = self.Owner:EyeAngles()
	end
	
	-- delay all actions
	self:performBipodDelay()
end

function SWEP:canUseComplexTelescopics()
	if SERVER then
		return true
	end

	if CustomizableWeaponry.callbacks.processCategory(self, "forceComplexTelescopics") then
		return true
	end

	if self:GetClass() == "cw_sci-fi_scout_xbow" then
		return false
	end
	
	return GetConVarNumber("cw_simple_telescopics") <= 0
end

function SWEP:canUseSimpleTelescopics()
	if not self:canUseComplexTelescopics() and self.SimpleTelescopicsFOV then
		return true
	end
	
	return false
end

function SWEP:setGlobalDelay(delay, forceNetwork, forceState, forceTime)
	if SERVER then
		if (SP or forceNetwork) then
			umsg.Start("CW20_GLOBALDELAY", self.Owner)
				umsg.Float(delay)
			umsg.End()
		end
		
		if forceState and forceTime then
			self:forceState(forceState, forceTime, true)
		end
	end
	
	self.GlobalDelay = CurTime() + delay
end

function SWEP:forceState(state, time, network)
	self.forcedState = state
	self.ForcedStateTime = CurTime() + time
	
	if SERVER and network then
		umsg.Start("CW20_FORCESTATE", self.Owner)
			umsg.Short(state)
			umsg.Float(time)
		umsg.End()
	end
end

function SWEP:setupBallisticsInformation()
	local info = CustomizableWeaponry.ammoTypes[self.Primary.Ammo]
	
	if not info then
		return
	end
	
	self.BulletDiameter = info.bulletDiameter
	self.CaseLength = info.caseLength
end

function SWEP:seekPresetPosition(offset)
	offset = offset or 0
	local count = #self.PresetResults
	
	if offset > 0 and self.PresetPosition + 10 > count then
		return
	end
	
	self.PresetPosition = math.Clamp(self.PresetPosition + offset, 1, count)
end

function SWEP:setPresetPosition(offset, force)
	offset = offset or 0
	
	if force then
		self.PresetPosition = math.max(self.PresetPosition, 1)
		return
	end
	
	local count = #self.PresetResults
	
	-- clamp the maximum and minimum position
	self.PresetPosition = math.Clamp(offset, 1, count)
end

function SWEP:getDesiredPreset(bind)
	local desired = bind == "slot0" and 10 or tonumber(string.Right(bind, 1))
	local pos = self.PresetPosition + desired
	
	return pos
end

function SWEP:attemptPresetLoad(entry)
	if not self.PresetResults then
		return false
	end
	
	entry = entry - 1
	
	local result = self.PresetResults[entry]
	
	if not result then
		return false
	end
	
	CustomizableWeaponry.preset.load(self, result.displayName)
	return true
end

function SWEP:getActiveAttachmentInCategory(cat)
	local category = self.Attachments[cat]
	
	if category then
		if category.last then
			return category.atts[category.last]
		end
	end
	
	return nil
end


function SWEP:getSightColor(data)
	-- why are you passing nil :(
	if not data then
		-- assume it's a sight we're trying to get the color for
		return CustomizableWeaponry.defaultColors[CustomizableWeaponry.COLOR_TYPE_SIGHT]
	end
	
	local found = self.SightColors[data]
	
	if found then
		return found.color
	end
end

-- this function sets up reticle and laser beam colors for all sights/laser sights
function SWEP:setupReticleColors()
	self.SightColors = {}
	
	for k, v in ipairs(self.Attachments) do
		for k2, v2 in ipairs(v.atts) do
			local foundAtt = CustomizableWeaponry.registeredAttachmentsSKey[v2]
			
			if foundAtt then
				-- if the found attachment has a color type enum, that means it is colorable (wow!)
				-- therefore, we need to add it to the color table
				if foundAtt.colorType then
					local def = CustomizableWeaponry.colorableParts.defaultColors[foundAtt.colorType]
					self.SightColors[foundAtt.name] = {type = foundAtt.colorType, color = def.color, last = 1, display = CustomizableWeaponry.colorableParts:makeColorDisplayText(def.display)}
				end
			end
		end
	end
end

function SWEP:isReloadingM203()
	if not self.AttachmentModelsVM then
		return false
	end
	
	local m203 = self.AttachmentModelsVM.md_m203
	
	if m203 and m203.active then
		if self.curM203Anim == self.M203Anims.reload then
			if m203.ent:GetCycle() <= 0.9 then
				return true
			end
		end
	end
	
	return false
end

function SWEP:filterPrediction()
	if (SP and SERVER) or not SP then
		return true
	end
	
	return false
end

function SWEP:getMagCapacity()
	local mag = self:Clip1()
	
	if mag > self.Primary.ClipSize_Orig then
		return self.Primary.ClipSize_Orig .. " + " .. mag - self.Primary.ClipSize_Orig
	end
	
	return mag
end

function SWEP:getReloadProgress()
	if self.IsReloading and self.Cycle <= 0.98 then
		if self.ShotgunReload then
			return math.Clamp(math.ceil(self:getAnimSeek() / self.InsertShellTime * 100), 0, 100)
		else
			if self.wasEmpty then
				return math.Clamp(math.ceil(self:getAnimSeek() / self.ReloadHalt_Empty * 100), 0, 100)
			else
				return math.Clamp(math.ceil(self:getAnimSeek() / self.ReloadHalt * 100), 0, 100)
			end
		end
	end
	
	return nil
end

function SWEP:isReticleActive()
	if self.reticleInactivity and UnPredictedCurTime() < self.reticleInactivity then
		return false
	end
	
	return true
end

if CLIENT then
	function SWEP:getReticleAngles()
		if self.freeAimOn then
			local ang = self.CW_VM:GetAngles()
			ang.p = ang.p + self.AimAng.x
			ang.y = ang.y - self.AimAng.y
			ang.r = ang.r - self.AimAng.z
			
			return ang
		end
		
		return self.Owner:EyeAngles() + self.Owner:GetPunchAngle()
	end
	
	function SWEP:getTelescopeAngles()
		if self.freeAimOn then
			return self.Owner:EyeAngles()
		end
		
		return self:getMuzzlePosition().Ang
	end
	
	function SWEP:getLaserAngles(model)
		--if self.freeAimOn then
		--	return self.Owner:EyeAngles()
		--end
		
		return model:GetAngles()
	end
end

local trans = {["MOUSE1"] = "LEFT MOUSE BUTTON",
	["MOUSE2"] = "RIGHT MOUSE BUTTON"}
	
local b, e

function SWEP:getKeyBind(bind)
	b = input.LookupBinding(bind)
	e = trans[b]
	
	return b and ("[" .. (e and e or string.upper(b)) .. "]") or "[NOT BOUND, " .. bind .. "]"
end

-- GENERAL MATH FUNCS

function math.ApproachVector(startValue, endValue, amount)
	startValue.x = math.Approach(startValue.x, endValue.x, amount)
	startValue.y = math.Approach(startValue.y, endValue.y, amount)
	startValue.z = math.Approach(startValue.z, endValue.z, amount)
	
	return startValue
end

function math.NormalizeAngles(ang)
	ang.p = math.NormalizeAngle(ang.p)
	ang.y = math.NormalizeAngle(ang.y)
	ang.r = math.NormalizeAngle(ang.r)
	
	return ang
end