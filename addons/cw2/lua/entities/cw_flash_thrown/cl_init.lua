include("shared.lua")

function ENT:Initialize()
	self.Entity.Emitter = ParticleEmitter(self.Entity:GetPos())
	self.Entity.ParticleDelay = 0
end

function ENT:Draw()
	self.Entity:DrawModel()
end

function ENT:OnRemove()
	local dlight = DynamicLight(self:EntIndex())
	
	dlight.r = 255 
	dlight.g = 255
	dlight.b = 255
	dlight.Brightness = 4
	dlight.Pos = self:GetPos()
	dlight.Size = 256
	dlight.Decay = 128
	dlight.DieTime = CurTime() + 0.1
end