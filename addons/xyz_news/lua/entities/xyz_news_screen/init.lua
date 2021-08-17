AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT.Initialize(self)
	self:SetModel("models/props_phx/rt_screen.mdl")
	self:SetUseType(SIMPLE_USE)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)

	NewsSystem.ScreenCache[self:EntIndex()] = self

	self.health = 10
end

function ENT:Use(activator, caller)
end

function ENT:OnRemove()
	NewsSystem.ScreenCache[self:EntIndex()] = nil
end

function ENT:OnTakeDamage(dmg)
	self.health = (self.health) - dmg:GetDamage()
	if self.health <= 0 then
		self:Destruct()
		self:Remove()
	end
end

function ENT:Destruct()
	local vPoint = self:GetPos()
	local effectdata = EffectData()
	effectdata:SetStart(vPoint)
	effectdata:SetOrigin(vPoint)
	effectdata:SetScale(1)
	util.Effect("Explosion", effectdata)
end
