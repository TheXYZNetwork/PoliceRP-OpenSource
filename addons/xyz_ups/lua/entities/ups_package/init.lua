AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/props_junk/cardboard_box001a.mdl")

	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
	local phys = self:GetPhysicsObject()
	phys:Wake()
end

function ENT:StartTouch(ent)
	if not ent:IsVehicle() then return end
	if not (ent:GetVehicleClass() == "courier_trucktdm") then return end
	if not ent:isKeysOwnedBy(self:CPPIGetOwner()) then return end
	self:Remove()
	ent.hasPackage = true
end