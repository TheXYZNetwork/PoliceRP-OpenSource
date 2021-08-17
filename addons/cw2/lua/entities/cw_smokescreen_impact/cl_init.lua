include("shared.lua")

ENT.SmokeFadeTime = 2
ENT.SmokeFadeInTime = 1
ENT.SmokeIntensity = 0
ENT.SmokeStartDistance = 384
ENT.SmokeMaxIntensityDistance = 128

function ENT:Initialize()
	self.InitTime = self:GetCreationTime()
	self.SmokeMaxIntensityDuration = self.SmokeDuration - self.SmokeFadeTime
	self.SmokeEndTime = self.InitTime + self.SmokeDuration
	self.SmokeFadeInDuration = self.InitTime + self.SmokeFadeInTime
	self.PartialIntensityDistance = self.SmokeStartDistance - self.SmokeMaxIntensityDistance
end

function ENT:Draw()
end

function ENT:OnRemove()
	self:StopParticles()
end

function ENT:Think()
	local CT = CurTime()
	
	-- get the distance from the impact position to the player
	local distToPlayer = EyePos():Distance(self:GetPos())
	
	if distToPlayer > self.SmokeStartDistance then
		return
	end
	
	local overallIntensity = 0
	
	-- if the lifetime of the grenade is nearing it's end, fade it out based on time left
	if CT > self.InitTime + self.SmokeMaxIntensityDuration then
		local timeRel = self.SmokeEndTime - CT
		
		overallIntensity = math.Clamp(timeRel / self.SmokeFadeTime, 0, 1)
	else
		-- if it's fresh and is only fading in, scale the intensity based on time left until full intensity
		if CT < self.SmokeFadeInDuration then
			local timeRel = math.Clamp(1 - (self.SmokeFadeInDuration - CT) / self.SmokeFadeInTime, 0, 1)
			
			overallIntensity = timeRel
		else
			-- overall, give it full intensity
			overallIntensity = 1
		end
	end
	
	if overallIntensity == 0 then
		return
	end
	
	-- time to figure out position-based intensity

	if distToPlayer > self.SmokeMaxIntensityDistance then
		-- if we're within the smoke's partial intensity distance, scale it based on the distance
		local distanceRel = 1 - math.Clamp((distToPlayer - self.SmokeMaxIntensityDistance) / self.PartialIntensityDistance, 0, 1)
		
		overallIntensity = overallIntensity * distanceRel
		
		-- and if we aren't just don't change the intensity (since we're at max intensity)
	end
	
	if not ply.CW_SmokeScreenIntensity or overallIntensity > ply.CW_SmokeScreenIntensity then
		ply.CW_SmokeScreenIntensity = overallIntensity
	end
end 