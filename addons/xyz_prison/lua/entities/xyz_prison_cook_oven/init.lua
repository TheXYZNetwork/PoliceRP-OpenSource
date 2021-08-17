AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT.Initialize(self)
	self:SetModel("models/unioncity2/props_fastfood/kitchen_stove01.mdl")
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
	if ent.isCookedwd then return end
	-- Check if cleaned
	if not ent.isClean then return end
	-- Check if already prepped for deleting
	if ent.prepDelete then return end
	-- Check if active
	if self:GetIsActive() then return end

	ent.prepDelete = true

	self:StartCooking(ent:GetModel())

	ent:Remove()
end

function ENT:StartCooking(model)
	self:SetIsActive(true)
	timer.Create("PrisonSystem:StartCooking:"..self:EntIndex(),PrisonSystem.Config.Cook.CookTime, 1, function()
		if not IsValid(self) then return end

		self:EndCooking(model)
	end)
end

function ENT:EndCooking(model)
	self:SetIsActive(false)

	local ent = ents.Create("xyz_prison_cook_food")
	ent:SetPos(self:GetPos() + (self:GetUp()*65))
	ent:Spawn()
	ent:SetCooked(true)
	ent:SetModel(model)
end