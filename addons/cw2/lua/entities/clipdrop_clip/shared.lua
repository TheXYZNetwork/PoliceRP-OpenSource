-- Zombie Extinguisher's clip drop
ENT.Type 			= "anim"
ENT.Base 			= "base_anim"
ENT.PrintName		= ""
ENT.Category		= ""

ENT.Spawnable		= false
ENT.AdminSpawnable	= false

ENT.ClipDrop_Sound = "Weapon.MagDropPistol"

if SERVER then

AddCSLuaFile("shared.lua")

function ENT:SpawnFunction(ply, tr)

	if (!tr.Hit) then return end
	
	local SpawnPos = tr.HitPos + tr.HitNormal * 16
	
	local ent = ents.Create("ClipDrop_Clip")
	
	ent:SetPos(SpawnPos)
	ent:Spawn()
	ent:Activate()
	ent.Planted = false
	
	return ent
end

/*---------------------------------------------------------
   Name: Initialize
---------------------------------------------------------*/
function ENT:Initialize()
	
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
	self.Entity:SetSolid(SOLID_VPHYSICS)
	self.Entity:DrawShadow(false)
	
	self.Entity:SetCollisionGroup(COLLISION_GROUP_WORLD)
	
	local phys = self.Entity:GetPhysicsObject()
	
	if (phys:IsValid()) then
		phys:Wake()
		phys:SetMass(40)
	end

	self.Entity:SetUseType(SIMPLE_USE)
end

/*---------------------------------------------------------
   Name: PhysicsCollide
---------------------------------------------------------*/
function ENT:PhysicsCollide(data, physobj)
				
	if (data.Speed > 1 and data.DeltaTime > 0.2) then
		self:EmitSound(self.ClipDrop_Sound, 100, 100)
	end
end

/*---------------------------------------------------------
   Name: OnTakeDamage
---------------------------------------------------------*/
function ENT:OnTakeDamage(dmginfo)
end

--[[---------------------------------------------------------
   Name: Use
-------------------------------------------------------]]--
function ENT:Use(activator, caller)
end

function ENT:Think()
	
	self.lifetime = self.lifetime or CurTime() + 15 -- Time in seconds before clip is removed

	if CurTime() > self.lifetime then
		self:Remove()
	end
end
end