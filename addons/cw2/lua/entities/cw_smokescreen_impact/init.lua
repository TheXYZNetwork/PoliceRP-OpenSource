AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

local spd, ent

function ENT:Initialize()
	self:SetModel("models/Items/AR2_Grenade.mdl") 
	self:PhysicsInit(SOLID_NONE)
	self:SetMoveType(MOVETYPE_NONE)
	self:SetSolid(SOLID_NONE)
	self:SetCollisionGroup(COLLISION_GROUP_NONE)
	
	timer.Simple(self.SmokeDuration, function()
		SafeRemoveEntity(self)
	end)
end

function ENT:CreateParticles()
	self:EmitSound("weapons/smokegrenade/sg_explode.wav", 100, 100)
	ParticleEffect("cstm_smoke", self:GetPos(), Angle(0, 0, 0), self)
end

function ENT:Use(activator, caller)
	return false
end

function ENT:OnRemove()
	self:StopParticles()
	return false
end 