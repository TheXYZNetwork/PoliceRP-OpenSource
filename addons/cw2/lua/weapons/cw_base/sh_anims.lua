local SP = game.SinglePlayer()

-- lol
function SWEP:sendWeaponAnim(anim, speed, cycle)
	-- what the fuck are you doing without an anim name
	if not anim then
		return
	end
	
	-- make sure we don't set/send nil args
	speed = speed or 1
	cycle = cycle or 0
	
	-- prediction is disabled in SP, so just send the anim via UMSG
	if SP and SERVER then
		umsg.Start("CW20_ANIMATE", self.Owner)
			umsg.String(anim)
			umsg.Float(speed)
			umsg.Float(cycle)
		umsg.End()
		
		return
	end
	
	if self.animCallbacks and self.animCallbacks[anim] then
		self.animCallbacks[anim](self)
	end
	
	-- in MP just play the anim on the player, clientside
	
	if CLIENT then
		if anim:find("reload") then
			if self:Clip1() == 0 then
				self.wasEmpty = true
				
				if self.BoltBoneID and self.DontHoldWhenReloading then
					self:setBoltBonePosition(Vector(0, 0, 0))
				end
			else
				self.wasEmpty = false
			end
		end
	end
	
	self:playAnim(anim, speed, cycle)
end

function SWEP:playAnim(anim, speed, cycle, ent)
	ent = ent or self.CW_VM
	cycle = cycle or 0
	speed = speed or 1
	
	local foundAnim = anim
	
	if ent == self.CW_VM then
		foundAnim = self.Animations[anim]
		
		if not foundAnim then
			return
		end
		
		if type(foundAnim) == "table" then
			foundAnim = table.Random(foundAnim)
		end
		
		if self.Sounds[foundAnim] then
			self:setCurSoundTable(self.Sounds[foundAnim], speed, cycle, foundAnim)
		else
			self:removeCurSoundTable()
		end
	end

	if SERVER then
		return
	end
	
	ent:ResetSequence(foundAnim)
	
	if cycle > 0 then
		ent:SetCycle(cycle)
	else
		ent:SetCycle(0)
	end
	
	ent:SetPlaybackRate(speed)
end

function SWEP:setCurSoundTable(animTable, speed, cycle, origAnim)
	local found = 1
	
	if cycle ~= 0 then
		-- get the length of the animation and relative time to animation
		local animLen = self.CW_VM:SequenceDuration()
		local timeRel = animLen * cycle
		local foundInTable = false
		
		-- loop through the table, and find the entry which the cycle has not passed yet
		for k, v in ipairs(animTable) do
			if timeRel < v.time then
				found = k
				foundInTable = true
				break
			end
		end
		
		if not foundInTable then
			found = false
		end
	end
	
	if found then
		self.CurSoundTable = animTable
		self.CurSoundEntry = found
		self.SoundTime = (CLIENT and UnPredictedCurTime() or CurTime())
		self.SoundSpeed = speed
		
		if CLIENT then
			if origAnim == self.Animations.draw then
				if self.drawnFirstTime then
					self.SoundTime = self.SoundTime - 0.22
				end
			
				self.drawnFirstTime = true
			end
		end
	else
		self:removeCurSoundTable()
	end
end

function SWEP:removeCurSoundTable()
	-- wipes all current animation sound table information to turn it off
	self.CurSoundTable = nil
	self.CurSoundEntry = nil
	self.SoundTime = nil
	self.SoundSpeed = nil
end

if CLIENT then
	local function CW20_ANIMATE(um)
		local anim = um:ReadString()
		local speed = um:ReadFloat()
		local cycle = um:ReadFloat()
		
		local ply = LocalPlayer()
		local wep = ply:GetActiveWeapon()
		
		if not IsValid(wep) then
			return
		end
		
		if wep.sendWeaponAnim then
			wep:sendWeaponAnim(anim, speed, cycle)
		end
	end
	
	usermessage.Hook("CW20_ANIMATE", CW20_ANIMATE)
	
	local function CW20_EFFECTS()
		local ply = LocalPlayer()
		local wep = ply:GetActiveWeapon()
		
		if not IsValid(wep) or not  wep.CW20Weapon then
			return
		end
		
		wep:makeFireEffects()
	end
	
	usermessage.Hook("CW20_EFFECTS", CW20_EFFECTS)
end