AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

local spd, ent

function ENT:Initialize()
	self:SetModel("models/Items/AR2_Grenade.mdl") 
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetCollisionGroup(COLLISION_GROUP_NONE)
	local phys = self:GetPhysicsObject()

	if phys and phys:IsValid() then
		phys:Wake()
	end
	
	self:GetPhysicsObject():SetBuoyancyRatio(0)
	
	spd = physenv.GetPerformanceSettings()
    spd.MaxVelocity = 2996
	
    physenv.SetPerformanceSettings(spd) -- set grenade's max. speed to it's real life muzzle velocity
end

function ENT:Use(activator, caller)
	return false
end

function ENT:OnRemove()
	return false
end 

function ENT:PhysicsCollide(data, physobj)
	local hitPos = self:GetPos()

	local smokeScreen = ents.Create("cw_smokescreen_impact")
	smokeScreen:SetPos(hitPos)
	smokeScreen:Spawn()
	smokeScreen:CreateParticles()

	self:Remove()
	
	self:Remove()
end
