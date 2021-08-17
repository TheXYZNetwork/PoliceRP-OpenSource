include("shared.lua")
local firePar = "fire_large_01"
PrecacheParticleSystem(firePar)
game.AddParticles("particles/fire_01.pcf")
function ENT:Think()
	if LocalPlayer():GetPos():DistToSqr(self:GetPos()) > 15000000 then return end
	if self.particleCreated then return end

	self.particleCreated = true
	ParticleEffectAttach(firePar, PATTACH_ABSORIGIN_FOLLOW, self, 1)
end