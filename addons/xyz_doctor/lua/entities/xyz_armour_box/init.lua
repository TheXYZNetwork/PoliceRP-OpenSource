AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/freeman/owain_hardigg_armour.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
	local phys = self:GetPhysicsObject()
	phys:Wake()
	
	self:CPPISetOwner(self:Getowning_ent())

	if not self:GetFirstSpawn() then
		self:SetUsesLeft(10)
		self:SetFirstSpawn(true)
	end

	self.coolDown = 0
end

function ENT:Use(ply)
	if self.coolDown > CurTime() then return end
	self.coolDown = CurTime() + 1

	if ply:Armor() >= 100 then return
		XYZShit.Msg("Armour", Color(100, 100, 200), "You already have 100% armour.", ply)
	end

	local curArmour = ply:Armor()
	if curArmour > 80 then
		XYZShit.Msg("Armour", Color(100, 100, 200), "You armour has been increased by "..100-curArmour.."%", ply)
		ply:SetArmor(100)
		self:UsedOnce()
		return
	end

	ply:SetArmor(curArmour + 20)
	XYZShit.Msg("Armour", Color(100, 100, 200), "You armour has been increased by 20%", ply)

	self:UsedOnce()
end

function ENT:UsedOnce()
	local usesLeft = self:GetUsesLeft()

	if usesLeft <= 1 then
		self:Remove()
		if IsValid(self:Getowning_ent()) then
			XYZShit.Msg("Armour", Color(100, 100, 200), "Your armour box is empty and has been removed", self:Getowning_ent())
		end
	end

	self:SetUsesLeft(usesLeft - 1)
end