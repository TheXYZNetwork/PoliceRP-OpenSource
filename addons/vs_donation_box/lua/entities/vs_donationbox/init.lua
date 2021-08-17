AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

util.AddNetworkString("vs_derma")
util.AddNetworkString("vs_derma_owner")
util.AddNetworkString("vs_toggle_donations")
util.AddNetworkString("vs_donate")
util.AddNetworkString("vs_withdraw")

function ENT:Initialize()
	self:SetModel("models/props/CS_militia/footlocker01_closed.mdl")
	-- Basic physics and functionality
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
	local phys = self:GetPhysicsObject()
	phys:Wake()

	self.health = 100
	self.coolDown = CurTime() + 1

	self:SetOpen(false)

	self.topDonators = {}

	self:CPPISetOwner(self:Getowning_ent())
	self:SetCurMoney(0)
end

function ENT:Use(ply)
	if self.coolDown > CurTime() then return end
	self.coolDown = CurTime() + 1
	
	if ply == self:Getowning_ent() then
		net.Start("vs_derma_owner")
			net.WriteEntity(self)
			net.WriteTable(self.topDonators)
		net.Send(ply)
		return
	end

	if !self:GetOpen() then return end
	net.Start("vs_derma")
		net.WriteEntity(self)
		net.WriteTable(self.topDonators)
	net.Send(ply)
end

function ENT:StartTouch(seed)
	if self.coolDown > CurTime() then return end
	self.coolDown = CurTime() + 1
end

function ENT:AddMoney(ply, nAmount)
	self:SetCurMoney(self:GetCurMoney()+nAmount)
	if !self.topDonators[1] then
		table.insert(self.topDonators, {name = ply:Nick(), amount = nAmount})
		return
	end 

	table.insert(self.topDonators, {name = "temp", amount = 0})
	for k, v in ipairs(self.topDonators) do
		if v.amount > nAmount then continue end
		table.insert(self.topDonators, k, {name = ply:Nick(), amount = nAmount})
		break
	end
	table.remove(self.topDonators, #self.topDonators)
	for k, v in ipairs(self.topDonators) do
		if k > 5 then
			table.remove(self.topDonators, k)
		end
	end

	Quest.Core.ProgressQuest(self:Getowning_ent(), "homeless", 4, nAmount)
end

function ENT:Withdraw(ply)
	ply:addMoney(self:GetCurMoney())
	self:SetCurMoney(0)
end

function ENT:SetOpenState(state)
	self:SetOpen(state)

	if state then
		self:SetModel("models/props/CS_militia/footlocker01_open.mdl")
	else
		self:SetModel("models/props/CS_militia/footlocker01_closed.mdl")
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

net.Receive("vs_withdraw", function(_, ply)
	local box = net.ReadEntity()

	if not box:GetClass() == "vs_donationbox" then return end
	if box:GetPos():Distance(ply:GetPos()) > 500 then return end
	if ply != box:Getowning_ent() then return end

	box:Withdraw(ply)
end)

net.Receive("vs_toggle_donations", function(_, ply)
	local box = net.ReadEntity()
	local state = net.ReadBool()

	if not box:GetClass() == "vs_donationbox" then return end
	if box:GetPos():Distance(ply:GetPos()) > 500 then return end
	if ply != box:Getowning_ent() then return end

	box:SetOpenState(state)
end)

net.Receive("vs_donate", function(_, ply)
	local box = net.ReadEntity()
	local amount = tonumber(net.ReadString())
	amount = math.Round(amount)

	if not box:GetClass() == "vs_donationbox" then return end
	if box:GetPos():Distance(ply:GetPos()) > 500 then return end
	if amount < 1 then return end
	if not ply:canAfford(amount) then return end

	ply:addMoney(-amount)
	box:AddMoney(ply, amount)
end)