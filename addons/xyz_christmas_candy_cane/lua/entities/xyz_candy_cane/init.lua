AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/cloudstrifexiii/candycane/candycane.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
	local phys = self:GetPhysicsObject()
	phys:Wake()
	
	self:CPPISetOwner(self:Getowning_ent())
end

function ENT:Use(ply)
	if ply:Health() >= 100 then
		XYZShit.Msg("Medkit", Color(200, 100, 100), "You already have 100% health.", ply)
		return
	end

	ply:SetHealth(100)
	XYZShit.Msg("Medkit", Color(200, 100, 100), "You health has been refilled", ply)
	self:Remove()
end
