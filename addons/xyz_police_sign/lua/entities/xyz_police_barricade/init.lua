AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/freeman/owain_barricade.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetUseType(SIMPLE_USE)

	self:SetModelScale(self:GetModelScale()*1.25, 0)
	self:Activate()

	local phys = self:GetPhysicsObject()
	phys:Wake()
	
	self:CPPISetOwner(self:Getowning_ent())

	self.curSkin = 0
end

function ENT:Use(_, ply)
	if not (ply == self:Getowning_ent()) then return end
	self.curSkin = self.curSkin + 1
	if self.curSkin >= 4 then self.curSkin = 0 end
	self:SetSkin(self.curSkin)
end