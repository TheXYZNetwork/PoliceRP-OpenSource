include("shared.lua")
AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")

function ENT:Initialize()
	self:SetModel("models/props_borealis/bluebarrel001.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
	self:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
end

--[[
	desc: Check if hook is attached
	return: bool
]]--

function ENT:IsAttached()
	return self.ent and IsValid(self.ent)
end

--[[
	desc: Detach hook
	return: nil
]]--

function ENT:Detach()
	constraint.RemoveConstraints(self, "Elastic")

	if ( self.player and IsValid(self.player) ) then
		self.player:StripWeapon("xyz_hook")
	end

	if ( IsValid(self.hook) ) then
		constraint.RemoveConstraints(self.hook, "Elastic")
		self.hook:Remove()
	end

	self.player = nil
	if self.ent then
		self.ent.ishooked = nil
		self.ent = nil
	end

	self.length = 600
	
end

--[[
	desc: Attach hook to vehicle
	return: nil
]]--

function ENT:Attach(ent, vecPos)
	self:Detach()

	ent:SetHandbrake(false)
	
	local entTrailer = self:GetParent()

	local angPos = ent:GetAngles()

	angPos:RotateAroundAxis(angPos:Forward(), 90)

	local entHook = ents.Create("xyz_tow_truck_hook")
	entHook:SetPos(self:GetPos())
	entHook:SetAngles(angPos)
	entHook:Spawn()
	entHook:Activate()
	entHook:CreateRope(entTrailer)
	entHook.parent = self
	self.hook = entHook

	entHook.constNoCollide = constraint.NoCollide(entHook, entTrailer, 0, 0)

	// Need timer to disable rope folding
	timer.Simple(.1, function()
		if ( not IsValid(entHook) ) then return end
		if ( not IsValid(ent) ) then return end
		if ( not IsValid(self) ) then return end
		
		entHook:SetPos(vecPos - ent:GetForward() * -8)
		entHook:Attach(ent)
	end)

	ent:DeleteOnRemove(entHook)
	
	self.ent = ent
	ent.ishooked = entHook
end

function ENT:Use(ply)
	if XYZShit.CoolDown.Check("xyzTowHookUse", 5, ply) then return end
	if self:GetParent().truck.owner ~= ply then return end
	if ( not self:GetParent():IsDown() ) then
		XYZShit.Msg("Mechanic", Color(213, 195, 30), "Trailer needs to be down", ply)
		return
	end

	if ( self.player and IsValid(self.player) ) then
		if ( self.player == ply ) then
			self:Detach()
			return
		end

		XYZShit.Msg("Mechanic", Color(213, 195, 30), "Hook already used", ply)
		return
	end

	if ( self:IsAttached() ) then 
		self:Detach()
		return 
	end

	local strSwep = "xyz_hook"

	local entWep = ply:GetWeapon(strSwep)

	if ( not ply:HasWeapon(strSwep) ) then
		entWep = ply:Give(strSwep)
	end

	ply:SelectWeapon(strSwep)

	constraint.Elastic(self, ply, 0, 0, Vector(0, 0, 0), Vector(0, 0, 0), 600, 0, 0, "cable/cable", 1, true) 

	self.player = ply

	entWep.hook = self
end

function ENT:Think()
	local ply = self.player

	if ( IsValid(ply) and ply:GetPos():Distance(self:GetPos()) > 600 ) then
		self:Detach()
		return
	end
end

function ENT:OnRemove()
	if ( IsValid(self.hook) ) then
		self.hook:Remove()
	end

	if ( IsValid(self.rope) ) then
		self.rope:Remove()
	end
end