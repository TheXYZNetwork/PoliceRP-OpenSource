AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetUseType(SIMPLE_USE)

	local phys = self:GetPhysicsObject()
	phys:Wake()

	self.health = 100
end

function ENT:Use(ply)
	net.Start("CashRegister:Confirm:Purchase")
		net.WriteEntity(self)
	net.Send(ply)
end


function ENT:SetCashRegister(ent)
	self.cashRegister = ent
end

function ENT:GetCashRegister(ent)
	return self.cashRegister
end

function ENT:SetData(data)
	self.data = data

	local wep = weapons.Get(self.data.class)
	local name = self.data.data.info.displayName
	if wep then
		name = wep.PrintName
	end

	self:SetDisplayName(name)
	self:SetModel(data.data.info.displayModel)
end