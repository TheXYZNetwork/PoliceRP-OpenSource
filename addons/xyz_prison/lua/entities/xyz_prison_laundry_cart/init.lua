AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT.Initialize(self)
	self:SetModel("models/props_wasteland/laundry_cart002.mdl")
	self:SetUseType(SIMPLE_USE)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)

	self.cooldown = 0
end

function ENT:Use(activator, caller)
	if CurTime() < self.cooldown then return end
	if self:GetHoldingClothes() <= 0 then return end

	local ent = ents.Create("xyz_prison_laundry_clothes")
	ent:SetPos(self:GetPos() + (self:GetUp() * 20))
	ent:Spawn()
	ent:SetDirty(true)

	self:SetHoldingClothes(self:GetHoldingClothes() - 1)

	self.cooldown = CurTime() + 1
end

function ENT:StartTouch(ent)
	if CurTime() < self.cooldown then return end

	-- Check the ent is clothes
	if not (ent:GetClass() == "xyz_prison_laundry_clothes") then return end
	-- Check if dirty
	if not ent.isDirty then return end
	-- Check if already prepped for deleting
	if ent.prepDelete then return end

	-- Check the cart space
	if self:GetHoldingClothes() >= PrisonSystem.Config.Laundry.CartLimit then return end

	self:SetHoldingClothes(self:GetHoldingClothes() + 1)

	ent.prepDelete = true
	ent:Remove()
	
	self.cooldown = CurTime() + 1
end
