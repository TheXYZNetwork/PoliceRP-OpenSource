AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT.Initialize(self)

	self:SetModel("models/freeman/vault/floor_safe_door.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)

	self:SetAutomaticFrameAdvance(true)
	self:SetPlaybackRate(1)

	local seq = self:LookupSequence("close")
	self:ResetSequence(seq)
end