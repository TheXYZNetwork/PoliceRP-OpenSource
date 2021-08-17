
include("shared.lua")
AddCSLuaFile("shared.lua")

function ENT:Initialize()
	self:SetModel("models/mechanical_system/w_hook.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
	self:SetCollisionGroup(COLLISION_GROUP_WEAPON)

	local phys = self:GetPhysicsObject()

	if ( phys ) then 
		phys:Wake() 
		phys:SetMass(100)
		phys:SetDamping(4, 4)
		phys:Wake()
	end

	self.length = 600
end

--[[
	desc: Attach hook to vehicle
	return: nil
]]--

function ENT:Attach(ent)
	self:GetPhysicsObject():SetMass(65)
	self:GetPhysicsObject():RecheckCollisionFilter()
	self.constWeld = constraint.Weld(ent, self, 0, 0, 0)

	self.ent = ent

	Quest.Core.ProgressQuest(self:GetParent().truck.owner, "he_fix_it_falafel", 3)
end

--[[
	desc: Create rope
	return: nil
]]--

function ENT:CreateRope(entTrailer)
	local vecHook = XYZTowTruck.Positions.hookpos.vec

	self.rope = constraint.Elastic(
		entTrailer, 
		self, 
		0, 
		0, 
		vecHook, 
		Vector(0, 0, 0), 
		1000000000, 
		0.75, 
		0.2, 
		"cable/cable", 
		2, 
		true
	)

	self.rope:Fire("SetLength", tostring(self.length), 0)
	self.rope:Fire("SetSpringLength", tostring(self.length), 0)
end

function ENT:SetRopeConfig(boolEnabled, boolGettingBigger)
	self.boolRopeSizing = boolEnabled
	self.boolGettingBigger = boolGettingBigger
end

function ENT:Think()
	if ( not IsValid(self.rope) ) then return end
	if ( not self.boolRopeSizing ) then return end

	self.length = self.length + ( self.boolGettingBigger and 10 or -10)

	self.length = math.Clamp(self.length, 30, 600)

	self.rope:Fire("SetLength", tostring(self.length), 0)
	self.rope:Fire("SetSpringLength", tostring(self.length), 0)

	self:NextThink(CurTime() + .15)
	return true	
end

function ENT:Use(pPlayer)
	local entParent = self.parent

	if ( not entParent or not IsValid(entParent) ) then return end

	if ( not entParent:IsAttached() ) then return end

	entParent:Detach()
end	

function ENT:OnRemove()
	if ( IsValid(self.rope) ) then 
		self.rope:Remove()
	end
end