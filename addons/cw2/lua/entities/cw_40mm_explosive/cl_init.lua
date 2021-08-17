include("shared.lua")

function ENT:Initialize()
	self.Emitter = ParticleEmitter(self:GetPos())
	self.ParticleDelay = 0
end

function ENT:Draw()
	self:DrawModel()
end

function ENT:Think()
	if not self.dt.Misfire then
		local part = self.Emitter:Add("particle/smokesprites_000" .. math.random(1, 9), self:GetPos())
		part:SetStartSize(12)
		part:SetEndSize(16)
		part:SetStartAlpha(255)
		part:SetEndAlpha(0)
		part:SetDieTime(1)
		part:SetRoll(math.random(0, 360))
		part:SetRollDelta(0.01)
		part:SetColor(120, 120, 120)
		part:SetLighting(false)
		part:SetVelocity(VectorRand() * 25)
	end
end 

function ENT:OnRemove()
	self.Emitter:Finish()
end