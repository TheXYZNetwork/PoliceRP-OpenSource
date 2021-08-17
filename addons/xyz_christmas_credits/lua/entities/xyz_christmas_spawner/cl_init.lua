include("shared.lua")

function ENT:Initialize()
	self.speed = 1
	self.particleSys = ParticleEmitter(self:GetPos(), true) 
end

function ENT:Draw()
	if not self:GetIsActive() then return end
	self:DrawModel()	
end

function ENT:Think()
	if not self:GetIsActive() then return end
	if not LocalPlayer():IsLineOfSightClear(self) then return end
	self.speed = (5000 * FrameTime())
	self:SetAngles(self:GetAngles() + (Angle(0, self.speed, 0) * FrameTime())) 

	if LocalPlayer():GetPos():Distance(self:GetPos()) > 600 then return end
	local part = self.particleSys:Add("color", self:GetPos()) 
	part:SetDieTime(3)
	part:SetVelocity(Vector(math.random(-100, 50),math.random(-100, 50),math.random(1, 200)))
	part:SetColor(math.random(50, 255), math.random(50, 255), math.random(50, 255))
	part:SetStartSize(3)
	part:SetAngleVelocity(Angle(math.random(-500, 500),math.random(-500,500),math.random(-500,500)))
	part:SetEndSize(10) 
	part:SetBounce(0.8)
	part:SetCollide(true)
	part:SetGravity(Vector(0,0, -500))
end