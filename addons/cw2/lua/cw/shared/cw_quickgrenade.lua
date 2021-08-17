AddCSLuaFile()

CustomizableWeaponry.quickGrenade = CustomizableWeaponry.quickGrenade or {}

-- set this to 'false' to disable quick grenade functionality
CustomizableWeaponry.quickGrenade.enabled = false

-- the weapon action delay after throwing a grenade and re-equipping the weapon
CustomizableWeaponry.quickGrenade.postGrenadeWeaponDelay = 0.3
CustomizableWeaponry.quickGrenade.throwVelocity = 800
CustomizableWeaponry.quickGrenade.addVelocity = Vector(0, 0, 150) -- additional velocity independant from any factors
CustomizableWeaponry.quickGrenade.movementAddVelocity = 300 -- how much additional direction based velocity the grenade will receive based on the player's movement speed

CustomizableWeaponry.quickGrenade.canDropLiveGrenadeIfKilled = true
CustomizableWeaponry.quickGrenade.liveGrenadeVelocity = 100
CustomizableWeaponry.quickGrenade.liveGrenadeAddVelocity = Vector(0, 0, 20)
CustomizableWeaponry.quickGrenade.unthrownGrenadesGiveWeapon = false

-- func is called from the SWEP base	
function CustomizableWeaponry.quickGrenade:initializeQuickGrenade()
	if not self.enabled then
		return
	end
	
	-- this table defines in which states the player can't use the 'quick grenade' feature
	self.restrictedStates = {[CW_RUNNING] = true, 
		[CW_ACTION] = true,
		[CW_CUSTOMIZE] = true}
end

local td = {}

function CustomizableWeaponry.quickGrenade:getThrowOffset(player)
	local aimDir = player:EyeAngles() -- EyeAngles():Forward() because GetAimVector works in a retarded manner
	
	return aimDir:Up() * -3 + aimDir:Forward() * 30 + aimDir:Right() * 3
end

function CustomizableWeaponry.quickGrenade:getThrowVelocity(playerEnt, throwVelocity, addVelocity)
	throwVelocity = throwVelocity or self.throwVelocity
	addVelocity = addVelocity or self.addVelocity
	
	local forward = playerEnt:EyeAngles():Forward()
	local overallSideMod = playerEnt:KeyDown(IN_SPEED) and 2 or 1

	-- take the velocity into account
	addMod = math.Clamp(playerEnt:GetVelocity():Length() / playerEnt:GetRunSpeed(), 0, 1)
	
	local velocity = forward * throwVelocity + addVelocity
	local velNorm = playerEnt:GetVelocity():GetNormal()
	velNorm.z = 0
	
	-- add velocity based on player velocity normal
	velocity = velocity + velNorm * self.movementAddVelocity * addMod
	
	return velocity
end

function CustomizableWeaponry.quickGrenade:applyThrowVelocity(playerEnt, nade, throwVelocity, addVelocity)
	local phys = nade:GetPhysicsObject()
	
	if IsValid(phys) then
		local vel = self:getThrowVelocity(playerEnt, throwVelocity, addVelocity)
		
		phys:SetVelocity(vel)
		phys:AddAngleVelocity(Vector(math.random(-500, 500), math.random(-500, 500), math.random(-500, 500)))
	end
end

function CustomizableWeaponry.quickGrenade:canThrow()
	-- it's disabled, can't throw
	if not CustomizableWeaponry.quickGrenade.enabled then
		return false
	end
	
	-- can't throw if we're within a restricted state
	if CustomizableWeaponry.quickGrenade.restrictedStates[self.dt.State] then
		return false
	end
	
	-- can't throw while reloading
	if self.ReloadDelay then
		return false
	end
	
	-- can't throw with an active bipod
	if self.dt.BipodDeployed then
		return false
	end
	
	-- can't throw while changing weapons
	if self.HolsterDelay then
		return false
	end
	
	-- can't throw with no grenades
	if self.Owner:GetAmmoCount("Frag Grenades") <= 0 then
		return false
	end
	
	-- can't throw the grenade if we're really close to an object
	td.start = self.Owner:GetShootPos()
	td.endpos = td.start + CustomizableWeaponry.quickGrenade:getThrowOffset(self)
	td.filter = self.Owner
	
	local tr = util.TraceLine(td)
	
	-- something in front of us, can't throw
	if tr.Hit then
		return false
	end
	
	-- everything passes, can throw, woo!
	return true
end

local pinPullAnims = {"pullpin", "pullpin2", "pullpin3", "pullpin4"}
local SP = game.SinglePlayer()

function CustomizableWeaponry.quickGrenade:createThrownGrenade(player)
	local pos = player:GetShootPos()
	local offset = CustomizableWeaponry.quickGrenade:getThrowOffset(player)
	local eyeAng = player:EyeAngles()
	local forward = eyeAng:Forward()
	
	local nade = ents.Create("cw_grenade_thrown")
	nade:SetPos(pos + offset)
	nade:SetAngles(eyeAng)
	nade:Spawn()
	nade:Activate()
	nade:Fuse(3)
	nade:SetOwner(player)
	
	return nade
end

function CustomizableWeaponry.quickGrenade:createUnthrownGrenade(player)
	local pos = player:GetShootPos()
	local offset = CustomizableWeaponry.quickGrenade:getThrowOffset(player)
	local eyeAng = player:EyeAngles()
	local forward = eyeAng:Forward()
	
	local nade = ents.Create("cw_grenade_unthrown") -- it's inactive and can be picked up as ammo
	nade:SetPos(pos + offset)
	nade:SetAngles(eyeAng)
	nade:Spawn()
	nade:Activate()
	
	return nade
end

function CustomizableWeaponry.quickGrenade:throw()
	local CT = CurTime()
	
	self:setGlobalDelay(1.9)
	self:SetNextPrimaryFire(CT + 1.9)
	
	if SERVER and SP then
		SendUserMessage("CW20_THROWGRENADE", self.Owner)
	end
	
	self.dt.State = CW_ACTION
	
	if (not SP and IsFirstTimePredicted()) or SP then
		if self:filterPrediction() then
			self:EmitSound("CW_HOLSTER")
		end
		
		CustomizableWeaponry.callbacks.processCategory(self, "beginThrowGrenade")
		
		if CLIENT then
			CustomizableWeaponry.actionSequence.new(self, 0.45, nil, function()
				self.GrenadePos.z = -10
				self.grenadeTime = CurTime() + 1.5
				self:playAnim(table.Random(pinPullAnims), 1, 0, self.CW_GREN)
			end)
			
			CustomizableWeaponry.actionSequence.new(self, 0.5, nil, function()
				surface.PlaySound("weapons/pinpull.wav")
			end)
			
			CustomizableWeaponry.actionSequence.new(self, 1.1, nil, function()
				self:playAnim("throw", 1.1, 0, self.CW_GREN)
			end)
		end
		
		if SERVER then
			CustomizableWeaponry.actionSequence.new(self, 0.3, nil, function()
				self.canDropGrenade = true
			end)
		
			CustomizableWeaponry.actionSequence.new(self, 0.5, nil, function()
				self.liveGrenade = true
			end)
		
			CustomizableWeaponry.actionSequence.new(self, 1.15, nil, function()
				local nade = CustomizableWeaponry.quickGrenade:createThrownGrenade(self.Owner)
				CustomizableWeaponry.quickGrenade:applyThrowVelocity(self.Owner, nade, throwVelocity, addVelocity)
				
				self.liveGrenade = false
				self.canDropGrenade = false
				self.Owner:RemoveAmmo(1, "Frag Grenades")
				
				CustomizableWeaponry.callbacks.processCategory(self, "finishThrowGrenade")
			end)
		end
		
		CustomizableWeaponry.actionSequence.new(self, 1.8, nil, function()
			local delay = CustomizableWeaponry.quickGrenade.postGrenadeWeaponDelay
			self:SetNextPrimaryFire(CT + delay)
			self:SetNextSecondaryFire(CT + delay)
		end)
	end
end

function CustomizableWeaponry.quickGrenade.DoPlayerDeathCallback(victim, attacker, dmginfo)
	local wep = victim:GetActiveWeapon()
	
	if IsValid(wep) and wep.CW20Weapon then
		if wep.canDropGrenade then
			local nade = nil
			local throwVel, addVel = nil, nil
			
			if wep.liveGrenade then
				nade = CustomizableWeaponry.quickGrenade:createThrownGrenade(victim)
			else
				nade = CustomizableWeaponry.quickGrenade:createUnthrownGrenade(victim) 
			end
			
			CustomizableWeaponry.quickGrenade:applyThrowVelocity(victim, nade, CustomizableWeaponry.quickGrenade.liveGrenadeVelocity, CustomizableWeaponry.quickGrenade.liveGrenadeAddVelocity)
		end
	end
end

hook.Add("DoPlayerDeath", "CustomizableWeaponry.quickGrenade.DoPlayerDeathCallback", CustomizableWeaponry.quickGrenade.DoPlayerDeathCallback)