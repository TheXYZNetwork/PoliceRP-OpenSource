XYZRacing.Platforms = XYZRacing.Platforms or {} 
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/hunter/blocks/cube3x6x025.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	local phys = self:GetPhysicsObject()
	phys:Wake()
	
	table.insert(XYZRacing.Platforms, self)
end

function ENT:ONRemove()
	table.RemoveByValue(XYZRacing.Platforms, self)
end

function ENT:StartTouch(vehicle)
	if not vehicle:IsVehicle() then return end
	if not vehicle:GetDriver() then return end

	local activeRace = XYZRacing.Core.InActiveRace(vehicle:GetDriver())

	if not activeRace then return end
	if not (self == activeRace.platform) then return end
	XYZRacing.Core.Finish(activeRace, vehicle:GetDriver())
end