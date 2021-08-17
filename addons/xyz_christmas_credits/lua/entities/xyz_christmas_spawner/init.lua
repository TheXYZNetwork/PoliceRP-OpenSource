AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/hunter/blocks/cube025x025x025.mdl")

	local view = table.Random(self.ViewTypes)
	self:SetModel(view.model)
	if view.action then
		view.action(self)
	end

	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
	local phys = self:GetPhysicsObject()
	phys:Wake()

	self:SetIsActive(true)
end

function ENT:StartTouch(ply)
	if not self:GetIsActive() then return end
	if not ply:IsPlayer() then return end

	self:SetIsActive(false)
	self:SetCollisionGroup(COLLISION_GROUP_DEBRIS)

	local creditAmount = math.random(5, 10)
	XYZChristmasCredits.Database.GiveCredits(ply, creditAmount)
	XYZShit.Msg("Christmas Credits", Color(246, 70, 99), ply:Name().." has collected "..creditAmount.." credits")

	timer.Simple(math.random(5*60, 10*60), function()
		if not IsValid(self) then return end
		
		local view = table.Random(self.ViewTypes)
		self:SetModel(view.model)
		if view.action then
			view.action(self)
		end
	
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetUseType(SIMPLE_USE)
		local phys = self:GetPhysicsObject()
		if IsValid(phys) then
			phys:EnableMotion(false)
		end

		self:SetCollisionGroup(COLLISION_GROUP_NONE)
	
		self:SetIsActive(true)
	end)
end