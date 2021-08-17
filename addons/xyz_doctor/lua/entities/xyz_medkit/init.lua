AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/freeman/owain_medkit.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
	local phys = self:GetPhysicsObject()
	phys:Wake()
	
	self:CPPISetOwner(self:Getowning_ent())

	if not self:GetFirstSpawn() then
		self:SetUsesLeft(5)
		self:SetFirstSpawn(true)
	end

	self.coolDown = 0
end

function ENT:Use(ply)
	if self.coolDown > CurTime() then return end
	self.coolDown = CurTime() + 1

	if ply:Health() >= 100 then return
		XYZShit.Msg("Medkit", Color(200, 100, 100), "You already have 100% health.", ply)
	end

	local curHealth = ply:Health()
	if curHealth > 80 then
		XYZShit.Msg("Medkit", Color(200, 100, 100), "You health has been increased by "..100-curHealth.."%", ply)
		ply:SetHealth(100)
		self:UsedOnce()
		return
	end

	ply:SetHealth(curHealth + 20)
	XYZShit.Msg("Medkit", Color(200, 100, 100), "You health has been increased by 20%", ply)

	self:UsedOnce()
end

function ENT:UsedOnce()
	local usesLeft = self:GetUsesLeft()

	if usesLeft <= 1 then
		self:Remove()
		if IsValid(self:Getowning_ent()) then
			XYZShit.Msg("Medkit", Color(200, 100, 100), "Your medkit is empty and has been removed", self:Getowning_ent())
		end
	end

	self:SetUsesLeft(usesLeft - 1)
end