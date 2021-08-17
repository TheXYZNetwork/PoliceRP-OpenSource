AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

/* 
-- env_fire_large_b
Fire:
fire_jet_01
fire_jet_01_flame
fire_large_01 -
fire_large_02
 - fire_large_base
fire_medium_01
fire_medium_03 + _brownsmoke

Smoke:
smoke_burning_engine_01
smoke_gib_01
smoke_medium_02d
*/

PrecacheParticleSystem("fire_large_01")
game.AddParticles("particles/fire_01.pcf")
function ENT:Initialize()
	self:SetModel("models/hunter/plates/plate1x1.mdl")
	self:SetNoDraw(true)
	self:DrawShadow(false)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:DropToFloor()
	self:GetPhysicsObject():EnableMotion(false)

	self.health = math.random(XYZFire.Config.HealthMin, XYZFire.Config.HealthMax)

	self.nextReduce = 0
	self.tblKey = table.insert(XYZFire.AllFires, self)

	timer.Create("XYZFire:SpreadFire:"..self:EntIndex(), math.random(XYZFire.Config.SpreadSpeedMin, XYZFire.Config.SpreadSpeedMax), 0, function()
		if not IsValid(self) then return end
		if #XYZFire.AllFires >= (XYZFire.Config.MaxActiveFires*4) then return end

		local childFire = XYZFire.Core.StartFire()
		childFire:SetPos(self:GetPos()+Vector(math.random(-XYZFire.Config.OriginArea*0.5, XYZFire.Config.OriginArea*0.5), math.random(-XYZFire.Config.OriginArea*0.5, XYZFire.Config.OriginArea*0.5), 0))
	end)
end

function ENT:Touch(ent)
	if not IsValid(ent) then return end

	if ent:IsPlayer() then
		if XYZShit.CoolDown.Check("XYZFire:Damage:"..self:EntIndex()..":"..ent:SteamID64(), 0.5, ent) then return end
		ent:TakeDamage(math.random(XYZFire.Config.MinDamage, XYZFire.Config.MaxDamage), self)
	elseif ent:IsVehicle() then
		if XYZShit.CoolDown.Check("XYZFire:Damage:"..self:EntIndex()..":"..ent:EntIndex(), 0.5) then return end
		ent:VC_damageHealth(45)
	end
end

function ENT:ReduceHealth(amount, attacker)
	self.health = self.health - (amount or 1)
	if self.health <= 0 then
		self:Remove()
		attacker:addMoney(250)
	end
end

function ENT:OnRemove()
	timer.Remove("XYZFire:SpreadFire:"..self:EntIndex())
	XYZFire.AllFires[self.tblKey] = nil
end