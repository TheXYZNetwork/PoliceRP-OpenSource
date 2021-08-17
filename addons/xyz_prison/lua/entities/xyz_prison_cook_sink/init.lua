AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT.Initialize(self)
	self:SetModel("models/props_rpd/kitchen_sink01.mdl")
	self:SetUseType(SIMPLE_USE)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
end

function ENT:Use(activator, caller)
end


function ENT:StartTouch(ent)
	-- Check the ent is clothes
	if not (ent:GetClass() == "xyz_prison_cook_food") then return end
	-- Check if cooked
	if ent.isCooked then return end
	-- Check if cleaned
	if ent.isClean then return end
	-- Check if already prepped for deleting
	if ent.prepDelete then return end
	-- Check if active
	if self:GetIsActive() then return end

	ent.prepDelete = true

	self:StartCleaning(ent:GetModel())

	ent:Remove()
end

function ENT:StartCleaning(model)
	self:SetIsActive(true)
	timer.Create("PrisonSystem:StartCleaning:"..self:EntIndex(), PrisonSystem.Config.Cook.CleanTime, 1, function()
		if not IsValid(self) then return end

		self:EndCleaning(model)
	end)
end

function ENT:EndCleaning(model)
	self:SetIsActive(false)

	local ent = ents.Create("xyz_prison_cook_food")
	ent:SetPos(self:GetPos() + (self:GetUp()*65))
	ent.isClean = true
	ent:Spawn()
	ent:SetModel(model)
end