AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

ENT.ExplodeRadius = 384
ENT.ExplodeDamage = 100

local phys, ef

function ENT:Initialize()
	self:SetModel("models/Items/BoxSRounds.mdl") 
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetCollisionGroup(COLLISION_GROUP_NONE)
	self.NextImpact = 0
	phys = self:GetPhysicsObject()

	if phys and phys:IsValid() then
		phys:Wake()
	end
	
	self:GetPhysicsObject():SetBuoyancyRatio(0)
end

function ENT:Use(activator, caller)
	if activator:IsPlayer() then
		local attachments = self:getAttachments()
		
		if not CustomizableWeaponry:hasSpecifiedAttachments(activator, attachments) then
			CustomizableWeaponry.giveAttachments(activator, attachments)
			self:Remove()
		end
	end
	
	return true
end

function ENT:OnRemove()
	return false
end 

local vel, len, CT