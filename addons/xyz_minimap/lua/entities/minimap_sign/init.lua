AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/props_trainstation/tracksign02.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
	local phys = self:GetPhysicsObject()
	phys:Wake()

	self:DropToFloor()

	self:SetDisplayImage(1)
	self:SetDisplayName("")

	self.health = 100
end

function ENT:Use(ply)
	if not (self:Getowning_ent() == ply) then return end
	-- Opens derma
	net.Start("Minimap:Sign:UI")
		net.WriteEntity(self)
	net.Send(ply)
end

function ENT:OnTakeDamage(dmg)
	self.health = self.health - dmg:GetDamage()
	if self.health <= 0 then
		self:Destruct()
		self:Remove()
	end
end

-- Taken from tier printers lol
function ENT:Destruct()
	local vPoint = self:GetPos()
	local effectdata = EffectData()
	effectdata:SetStart(vPoint)
	effectdata:SetOrigin(vPoint)
	effectdata:SetScale(1)
	util.Effect("Explosion", effectdata)
end