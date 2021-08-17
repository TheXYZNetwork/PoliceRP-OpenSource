AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	self:SetModel(self.Model)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
	local phys = self:GetPhysicsObject()
	phys:Wake()

	self:CPPISetOwner(self:Getowning_ent())
	
	self.health = 100

	self.data = {
		holding = 0,
		totalProcessed = 0,
		transactionsMade = 0,
		open = false
	}

	self.items = {}
end

function ENT:Use(ply)
	if not (ply == self:Getowning_ent()) then return end

	net.Start("CashRegister:UI")
		net.WriteEntity(self)
		net.WriteUInt(self.data.holding, 32)
		net.WriteUInt(self.data.totalProcessed, 32)
		net.WriteUInt(self.data.transactionsMade, 32)
		net.WriteBool(self.data.open)
		net.WriteTable(self.items)
	net.Send(ply)
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

function ENT:OnRemove()
	local owner = self:Getowning_ent()
	for k, v in pairs(self.items) do
		if not IsValid(v) then continue end

		if IsValid(owner) then
			Inventory.Core.GiveItem(owner:SteamID64(), v.data.class, v.data.data)
		end

		v:Remove()
	end
end


function ENT:AddItem(ent)
	table.insert(self.items, ent)
end

function ENT:RemoveItem(ent, wasSale)
	for k, v in pairs(self.items) do
		if not (v == ent) then continue end

		self.items[k] = nil
	end

	if wasSale then
		local price = ent:GetPrice()

		self.data.totalProcessed = self.data.totalProcessed + price
		self.data.transactionsMade = self.data.transactionsMade + 1
		self.data.holding = self.data.holding + (price - (price * CashRegister.Config.Fee))
	end
end

function ENT:GetMoney()
	return self.data.holding
end

function ENT:EmptyMoney()
	self.data.holding = 0
end