AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.Spawnable = true
ENT.PrintName = "[Alcohol] Base"
ENT.Category = "Alcohol"
ENT.AdminSpawnable = true

ENT.Model = "models/foodnhouseholditems/beercan01.mdl"

if CLIENT then return end

function ENT:Initialize()
	self:SetModel(self.Model)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetUseType(SIMPLE_USE)

	local phys = self:GetPhysicsObject()
	phys:Wake()
end


function ENT:Use(ply)
	Alcohol.ChangeUnits(ply, self.AlcoholUnits)

	ply:EmitSound(table.Random(Alcohol.Config.DrinkSounds), 50, 70)

	self:Remove()
end

function ENT:SetupDataTables()
	self:NetworkVar("Entity", 0, "owning_ent")
end