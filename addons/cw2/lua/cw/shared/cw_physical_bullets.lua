AddCSLuaFile()

CustomizableWeaponry.physicalBulletsEnabled = false
CustomizableWeaponry.SUPPRESS_CLIENTSIDE_BULLET_IMPACTS = false
CustomizableWeaponry.SUPPRESS_SERVERSIDE_BULLET_IMPACTS = true

CustomizableWeaponry.MUZZLE_VELOCITY_MULTIPLIER = 1
CustomizableWeaponry.WHIZ_DISTANCE = 192
CustomizableWeaponry.WHIZ_EVERY = 0.2

CustomizableWeaponry.physicalBulletBuffer = {} -- contains all physical bullets

-- don't run any additional code if the physical bullets are disabled
if not CustomizableWeaponry.physicalBulletsEnabled then
	return
end

if SERVER then
	util.AddNetworkString("CW20_PHYSBUL")
end

if CLIENT then -- register a different callback for server and client to avoid if CLIENT then/if SERVER then checks
	CustomizableWeaponry.callbacks:addNew("suppressDefaultImpactEffect", "CW20_suppressDefaultImpactEffect", function(self)
		if CustomizableWeaponry.SUPPRESS_CLIENTSIDE_BULLET_IMPACTS then
			return true, CLIENT
		end
		
		return false, CLIENT
	end)
else
	CustomizableWeaponry.callbacks:addNew("suppressDefaultImpactEffect", "CW20_suppressDefaultImpactEffect", function(self)
		if CustomizableWeaponry.SUPPRESS_SERVERSIDE_BULLET_IMPACTS then
			return true, SERVER
		end
		
		return false, SERVER
	end)
end

CustomizableWeaponry.callbacks:addNew("initialize", "CW20_initializePhysBullet", function(self)
	self.tracerRoundCounter = 0
end)

-- we suppress default bullets and their impact effects if phys bullets are enabled and create physical bullets per each shot instead
CustomizableWeaponry.callbacks:addNew("suppressDefaultBullet", "CW20_suppressDefaultBullet", function(self, startPos, direction, commmandNumber)
	-- fire and process a single step for the bullet, so that if we're close to an enemy, we'll hit them in the same tick when we fire
	local struct, index = CustomizableWeaponry:firePhysicalBullet(self.Owner, self:GetClass(), startPos, direction, (self.MuzzleVelocityConverted or 10000), true, self.Damage, nil, commmandNumber)
	
	if CustomizableWeaponry:processPhysicalBullet(struct, FrameTime()) then
		CustomizableWeaponry:removePhysicalBullet(self.Owner, index)
	end
	
	return true
end)

function CustomizableWeaponry:removePhysicalBullet(ply, index)
	table.remove(self.physicalBulletBuffer[ply], index)
end

function CustomizableWeaponry:createPhysicalBulletStructure(ply, wepClass, startPos, direction, velocity, isTracer, damage, fallSpeed, bulletID, noRicochet)
	return {
		player = ply,
		weapon = wepClass, -- we store the weapon class rather than the weapon object so that we can retrieve it's data later on when the bullet hits even if the weapon object is not valid anymore
		position = startPos,
		direction = direction,
		velocity = velocity,
		isTracer = isTracer,
		damage = damage,
		noRicochet = noRicochet,
		bulletID = bulletID,
		fallSpeed = fallSpeed or 1.5
	}
end

function CustomizableWeaponry:finalizePhysicalBulletStructure(wep, data)
	data.initialVelocity = data.velocity
	data.initialShotPosition = data.position * 1
	data.directionAngle = data.direction:Angle()
	
	if wep then
		CustomizableWeaponry.callbacks.processCategory(wep, "finalizePhysicalBullet", data)
	end
end

-- helper functions, since WriteVector compresses the vector and it loses precision
function net.WritePreciseVector(vector)
	net.WriteFloat(vector.x)
	net.WriteFloat(vector.y)
	net.WriteFloat(vector.z)
end

function net.ReadPreciseVector()
	local x = net.ReadFloat()
	local y = net.ReadFloat()
	local z = net.ReadFloat()
	
	return Vector(x, y, z)
end

local SP = game.SinglePlayer()

function CustomizableWeaponry:firePhysicalBullet(ply, wepClass, startPos, direction, velocity, isTracer, damage, fallSpeed, bulletID, noRicochet, skipNetwork)
	local wep = ply:GetActiveWeapon()
	
	if IsValid(wep) then
		wep.tracerRoundCounter = wep.tracerRoundCounter + 1
		
		if wep.tracerRoundCounter >= 3 then
			isTracer = true
			wep.tracerRoundCounter = 0
		else
			isTracer = false
		end
		
		if wep.dt.State ~= CW_AIMING then
			startPos = startPos + ply:EyeAngles():Right() * 4
		end
	end
	
	velocity = velocity * CustomizableWeaponry.MUZZLE_VELOCITY_MULTIPLIER
	local struct = self:createPhysicalBulletStructure(ply, wepClass, startPos, direction, velocity, isTracer, damage, fallSpeed, bulletID, noRicochet)
	self.physicalBulletBuffer[ply] = self.physicalBulletBuffer[ply] or {}
	table.insert(self.physicalBulletBuffer[ply], struct)
	
	local pos, dir = struct.position, struct.direction
	
	if not skipNetwork then
		if SERVER then
			struct.position = nil -- set these 2 variables to nil so that they're not written (we do this because WriteVector compresses the vectors and we need them uncompressed on the client for precision)
			struct.direction = nil
			
			local recipients = player.GetAll()
			
			if not SP then
				for key, recipient in ipairs(recipients) do
					if recipient == ply then -- we don't send the bullet data to ourselves since it's already predicted in MP
						table.remove(recipients, key)
						break
					end
				end
			end

			net.Start("CW20_PHYSBUL")
				net.WriteTable(struct)
				net.WritePreciseVector(pos)
				net.WritePreciseVector(dir)
			net.Send(recipients)
			
			struct.position = pos
			struct.direction = dir
		end
	end
	
	self:finalizePhysicalBulletStructure(wep, struct)
	
	return struct, #self.physicalBulletBuffer[ply]
end

local traceData = {}
local bulletData = {}

local baseData = nil
local trace_normal = nil
local trace_walls = nil

-- initialize the vars above in InitPostEntity, because that's when the base files will be 100% registered
hook.Add("InitPostEntity", "CW20_PhysBul_InitPostEntity", function()
	baseData = weapons.Get("cw_base")
	trace_normal = baseData.NormalTraceMask
	trace_walls = baseData.WallTraceMask
end)

bulletData.Callback = function(attacker, traceResult, dmgInfo)
	local victim = traceResult.Entity

	if IsValid(victim) then 
		victim.LAST_HIT_BY_PHYSBUL = bulletData.BULLET_STRUCT -- store the last hit by the physical bullet
	end
	
	baseData = baseData or weapons.Get("cw_base")
	baseData.bulletCallback(attacker, traceResult, dmgInfo)
end

bulletData.Num = 1
bulletData.Tracer = 0

local zeroVec = Vector(0, 0, 0)
local tickRate = engine.TickInterval()

local PLAYER = FindMetaTable("Player")

if CLIENT then
	function PLAYER:cw20LagCompensation(state)
		-- do nothing, since according to the wiki "Despite being defined shared, it (:LagCompensation) can only be used server side in a Predicted Hook." and we don't want to set up different code on client and server
	end
else
	PLAYER.cw20LagCompensation = PLAYER.LagCompensation -- use the LagCompensation code instead
end

function CustomizableWeaponry:processPhysicalBullet(bullet, dt)
	-- disabled accumulator, since it might be incorrect and I think it causes insane fps drops in specific cases (down to like 1 fps lol)
	--[[if dt > tickRate then -- primitive accumulator, for proper prediction
		while true do
			local newDelta = math.min(tickRate, dt)
			dt = dt - tickRate
			
			if self:processPhysicalBullet(bullet, newDelta) then
				return true
			end
			
			if dt <= 0 then -- we're out of delta time, end here
				return
			end
		end
	end]]--
	
	if util.PointContents(bullet.position) == CONTENTS_SOLID then
		return true
	end

	traceData.start = bullet.position
	traceData.endpos = traceData.start + bullet.direction * bullet.velocity * dt
	traceData.filter = bullet.player
	traceData.mask = trace_normal
	
	local oldPosition = bullet.position
	local oldDirection = bullet.direction
	
	local normalized = math.NormalizeAngle(bullet.directionAngle.p)
	bullet.directionAngle.p = math.Approach(normalized, 90, bullet.fallSpeed * dt) -- generate less garbage this way (angle -> direction VS direction -> angle -> direction)
	bullet.direction = bullet.directionAngle:Forward()
	
	bullet.player:cw20LagCompensation(true)
		local trace = util.TraceLine(traceData)
	bullet.player:cw20LagCompensation(false)
	
	bullet.velocity = math.Approach(bullet.velocity, bullet.initialVelocity * 0.9, dt * 10000) -- lose velocity over the flight
	bullet.position = trace.HitPos
	
	if trace.Hit or trace.HitSky then
		bulletData.Src = oldPosition
		bulletData.Dir = oldDirection
		bulletData.Spread 	= zeroVec
		bulletData.Force	= bullet.damage * 0.3
		bulletData.Damage = math.Round(bullet.damage)
		bulletData.BULLET_STRUCT = bullet
		
		local wepData = weapons.Get(bullet.weapon)
		local firer = bullet.player

		bullet.player:cw20LagCompensation(true)
			bullet.player:FireBullets(bulletData)
		bullet.player:cw20LagCompensation(false)
		
		if not bullet.noRicochet then
			if not trace.HitSky then
				local canPenetrate, dot = wepData:canPenetrate(trace, bullet.direction)
				local effRange, dmgFallOff, penStr, penRange = wepData:getEffectiveRange()
				
				if canPenetrate and dot > 0.26 then	
					traceData.start = trace.HitPos
					traceData.endpos = traceData.start + bullet.direction * penStr * (wepData.PenetrationMaterialInteraction[trace.MatType] and wepData.PenetrationMaterialInteraction[trace.MatType] or 1) * wepData.PenMod
					traceData.mask = trace_walls
					
					trace = util.TraceLine(traceData)
					
					traceData.start = trace.HitPos
					traceData.endpos = traceData.start + bullet.direction * 0.1
					traceData.mask = trace_normal

					trace = util.TraceLine(traceData) -- run ANOTHER trace to check whether we've penetrated a surface or not
					
					if not trace.Hit then
						math.randomseed(bullet.bulletID)
						self:firePhysicalBullet(bullet.player, bullet.weapon, trace.HitPos, math.randomizeVector(bullet.direction, 0.02), bullet.velocity * 0.6, bullet.tracer, bullet.damage * 0.5, bullet.fallSpeed * 3, bullet.bulletID, true, true)
					end
				else
					if dot and not bullet.noRicochet and wepData:canRicochet(trace, penRange) then
						local newDir = bullet.direction + (trace.HitNormal * dot) * 3
						math.randomseed(bullet.bulletID)
						math.randomizeVector(bullet.direction, 0.06)
						
						self:firePhysicalBullet(bullet.player, bullet.weapon, trace.HitPos, newDir, bullet.velocity * 0.6, bullet.tracer, bullet.damage * 0.5, bullet.fallSpeed * 2, bullet.bulletID, true, true)
					end
				end
			end
		end
		
		return true
	end
end

function CustomizableWeaponry:processBullets(ply, ucmd)
	local curIndex = 1
	local bullets = self.physicalBulletBuffer[ply]
	local frameTime = FrameTime()
	
	if bullets then
		local ft = FrameTime()
		
		for i = 1, #bullets do			
			if self:processPhysicalBullet(bullets[curIndex], ft) then
				table.remove(bullets, curIndex)
			else
				curIndex = curIndex + 1
			end
		end
	end
end

hook.Add("PlayerCanPickupWeapon", "CW20_PlayerCanPickupWeapon", function(ply, wep)
	if wep.CW20_CANT_PICKUP then
		return false
	end
	
	return nil
end)

-- on the server we just process the bullets as usual, since the hook is ran for every single player
-- on the client we do a player.GetAll iteration, since the hook is called only on the local player
if SERVER then
	hook.Add("StartCommand", "CW20_processBulletsStartCommand", function(ply, ucmd)
		CustomizableWeaponry:processBullets(ply, ucmd) -- simulate bullets on a per-player basis to enable prediction
	end)
else
	hook.Add("StartCommand", "CW20_processBulletsStartCommand", function(localPly, ucmd)
		if (SERVER or ucmd:TickCount() ~= 0) then
			for key, ply in ipairs(player.GetAll()) do
				CustomizableWeaponry:processBullets(ply, ucmd)
			end
		end
	end)
end

hook.Add("PlayerDisconnected", "CW20_PlayerDisconnectedPhysBul", function(ply)
	CustomizableWeaponry.physicalBulletBuffer[ply] = nil -- wipe bullets when a player disconnects
end)

if CLIENT then
	net.Receive("CW20_PHYSBUL", function(len, pl)
		local struct = net.ReadTable()
		struct.position = net.ReadPreciseVector()
		struct.direction = net.ReadPreciseVector()
	
		CustomizableWeaponry:finalizePhysicalBulletStructure(struct.weapon, struct)
		CustomizableWeaponry.physicalBulletBuffer[struct.player] = CustomizableWeaponry.physicalBulletBuffer[struct.player] or {}
		
		table.insert(CustomizableWeaponry.physicalBulletBuffer[struct.player], struct)
		
		if CustomizableWeaponry:processPhysicalBullet(struct, FrameTime()) then
			CustomizableWeaponry:removePhysicalBullet(struct.player, index)
		end
	end)
	
	local t = {["$basetexture"] = "sprites/glow03",
		["$additive"] = "1",
		["$vertexcolor"] = "1",
		["$vertexalpha"] = "1"}
		
	local bulletTracer = CreateMaterial("cw20_bullet_tracer", "UnlitGeneric", t)
	local clr = Color(255, 167, 112, 255)
	
	local bulletWhizTime = 0

	function CustomizableWeaponry:renderTracerBullets()
		local localPlayer, CT = LocalPlayer(), CurTime() 
		local playerPos = EyePos()
		local eyeAngles = EyeAngles():Forward()
		
		for ply, data in pairs(self.physicalBulletBuffer) do
			if not IsValid(ply) then -- player does not exist, don't draw his bullets
				self.physicalBulletBuffer[ply] = nil
			else
				for key, bulletData in ipairs(data) do
					local pos = bulletData.position
					local norm = bulletData.direction:GetNormal()

					if bulletData.player ~= localPlayer and norm:DotProduct(eyeAngles:GetNormalized()) < 0 and CT > bulletWhizTime and bulletData.position:Distance(playerPos) <= self.WHIZ_DISTANCE then -- emit a whiz sound
						EmitSound("weapons/fx/nearmiss/bulletLtoR0" .. math.random(3, 9) .. ".wav", pos, ply:EntIndex(), CHAN_AUTO, 1, 70, 0, 100)
						bulletWhizTime = CT + self.WHIZ_EVERY
					end
					
					if bulletData.isTracer or bulletData.player == localPlayer then
						render.SetMaterial(bulletTracer)
						render.DrawSprite(pos + norm * 128, 8, 8, clr)
						render.DrawBeam(pos + norm * 256, pos, 4, 0, 1, clr)
					end
				end
			end
		end
	end
	
	hook.Add("PostDrawOpaqueRenderables", "CW20_PostDrawOpaqueRenderables", function()
		CustomizableWeaponry:renderTracerBullets()
	end)
end