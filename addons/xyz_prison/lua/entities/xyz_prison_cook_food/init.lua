AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
	self:SetModel(table.Random(PrisonSystem.Config.Cook.Models))
	self:SetUseType(SIMPLE_USE)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)

	local phys = self:GetPhysicsObject()
	phys:Wake()

	self.isCooked = false
end

local dirtyColor = Color(200, 200, 200)
function ENT:SetCooked(state)
	if state then
		self:SetColor(dirtyColor)
	else
		self:SetColor(color_white)
	end

	self.isCooked = state
end

function ENT:Use(activator, caller)
end