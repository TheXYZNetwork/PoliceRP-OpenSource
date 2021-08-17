include("shared.lua")

local pos, ang, dlight, forward, CT

function ENT:Initialize()
	self.ParticleTime = 0
end

function ENT:Draw()
	self:DrawModel()
end

function ENT:Think()
	if self:GetDTInt(0) == 1 then
		pos, CT = self:GetPos(), CurTime()
		ang, forward = self:GetAngles(), self:GetForward()
		if CT > self.ParticleTime then
			ParticleEffect("rpg7_smoke_full", pos - forward * 7, ang, nil)
			ParticleEffect("rpg7_muzzle_full", pos - forward * 5, ang, nil)
			self.ParticleTime = CT + FrameTime() * 2
		end
		
		dlight = DynamicLight(self:EntIndex())
		
		if dlight then
			dlight.Pos = pos
			dlight.r = 255
			dlight.g = 255
			dlight.b = 100
			dlight.Brightness = 2
			dlight.Size = 384
			dlight.Decay = 384 * 3
			dlight.DieTime = CT + 0.1
		end
	end
end 