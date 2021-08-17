AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT.Initialize(self)
	self:SetModel("models/props_trainstation/payphone001a.mdl")
	self:SetUseType(SIMPLE_USE)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)

	table.insert(XYZ_HITMAN.Phones, self)
end

function ENT:Use(activator, caller)
	if XYZShit.IsGovernment(activator:Team()) or activator.UCOriginalJob then return end

	net.Start("xyz_hitman_open")
	if XYZ_HITMAN.Config.HitmanJobs[caller:Team()] then 
		net.WriteTable(XYZ_HITMAN.Core.ActiveHits)
	end
	net.Send(caller)
end