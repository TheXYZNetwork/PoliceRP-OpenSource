AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

-- Creating the net message stuff
util.AddNetworkString("xyz_police_sign_open")
util.AddNetworkString("xyz_police_sign_update")

function ENT:Initialize()
	self:SetModel("models/freeman/owain_roadsign.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetUseType(SIMPLE_USE)

	self:SetModelScale(self:GetModelScale()*2.5, 0)
	self:Activate()
	local phys = self:GetPhysicsObject()
	phys:Wake()
	
	self:CPPISetOwner(self:Getowning_ent())
	self.coolDown = 0
	self.health = 400

	--self:SetHead("!!ATTENTION!!")
	--self:SetBody("Please stand clear.\nThis area is off limits!\nPlease turn around when possible\nThank you for your co-operation")
	self:SetHead("")
	self:SetBody("")
end

-- Basic health system, deduct damage from heath, if health is <= 0 then run destroy function and remove the entity.
function ENT:OnTakeDamage(dmg)
	self.health = (self.health or 400) - dmg:GetDamage()
	if self.health <= 0 then
		self:Destruct()
		self:Remove()
	end
end

-- Destroy function, just some fanc effects.
function ENT:Destruct()
	local vPoint = self:GetPos()
	local effectdata = EffectData()
	effectdata:SetStart(vPoint)
	effectdata:SetOrigin(vPoint)
	effectdata:SetScale(1)
	util.Effect("Explosion", effectdata)
end

function ENT:Use(_, ply)
	if not (self:Getowning_ent() == ply) then return end
	net.Start("xyz_police_sign_open")
		net.WriteEntity(self)
	net.Send(ply)
end

net.Receive("xyz_police_sign_update", function(_, ply)
	local head = net.ReadString()
	local lines = net.ReadTable()
	local sign = net.ReadEntity()

	if sign.coolDown > CurTime() then return end
	sign.coolDown = CurTime() + 1

	if not sign:GetClass() == "xyz_police_sign" then return end
	if sign:GetPos():Distance(ply:GetPos()) > 500 then return end
	if not (sign:Getowning_ent() == ply) then return end

	head = string.sub(head, 0, 18)
	sign:SetHead(head)

	-- 32 char limit per line
	if table.Count(lines) > 11 then return end
	local newText = ""
	for k, v in pairs(lines) do
		print(k, v)
		if string.len(v) > 32 then
			v = string.sub(v, 0, 32)
		end
		newText = newText..string.gsub(v, "\n", "").."\n"
	end
	newText = string.sub(newText, 0, string.len(newText)-1)
	sign:SetBody(newText)
end)