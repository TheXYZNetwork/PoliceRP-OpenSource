AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/props/de_tides/vending_tshirt.mdl")
	self:SetUseType(SIMPLE_USE)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	
	local phys = self:GetPhysicsObject()
	phys:Wake()

	self.isDirty = false

	self:SetDirty(true)
end

local dirtyColor = Color(50, 50, 50)
function ENT:SetDirty(state)
	if state then
		self:SetColor(dirtyColor)
	else
		self:SetColor(color_white)
	end

	self.isDirty = state
end

function ENT:Use(activator, caller)
end