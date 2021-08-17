AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/uc/props_club/dj_set.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
	self:CPPISetOwner(self:Getowning_ent())

	self.health = 100

	self:SetNWBool("CarRadio:On", true)
	self:SetNWBool("CarDealer:Radio", true)
end

function ENT:OnTakeDamage(dmg)
	self.health = (self.health) - dmg:GetDamage()
	if self.health <= 0 then
		self:Destruct()
		self:Remove()
	end
end

function ENT:Destruct()
	local vPoint = self:GetPos()
	local effectdata = EffectData()
	effectdata:SetStart(vPoint)
	effectdata:SetOrigin(vPoint)
	effectdata:SetScale(1)
	util.Effect("Explosion", effectdata)
end

function ENT:Use(ply)
	if self:Getowning_ent() == ply then 
		if XYZShit.CoolDown.Check("DJSet:Use", 3, ply) then return end

		net.Start("CarRadio:OpenPortableUI")
			net.WriteEntity(self)
		net.Send(ply)
	end
end