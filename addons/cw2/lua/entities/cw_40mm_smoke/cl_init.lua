include("shared.lua")

function ENT:Initialize()
	self.Emitter = ParticleEmitter(self:GetPos())
	self.ParticleDelay = 0
end

function ENT:Draw()
	self:DrawModel()
end

function ENT:Think()
	//if CurTime() > self.ParticleDelay then
		local part = self.Emitter:Add("particle/smokesprites_000" .. math.random(1, 9), self:GetPos())
		part:SetStartSize(12)
		part:SetEndSize(16)
		part:SetStartAlpha(255)
		part:SetEndAlpha(0)
		part:SetDieTime(1)
		part:SetRoll(math.random(0, 360))
		part:SetRollDelta(0.01)
		part:SetColor(160, 160, 160)
		part:SetLighting(false)
		part:SetVelocity(VectorRand() * 25)
	//	self.ParticleDelay = CurTime() + 0.01
	//end
end 

function ENT:OnRemove()
	self.Emitter:Finish()
end