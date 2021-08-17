AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/hunter/blocks/cube3x6x025.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
	local phys = self:GetPhysicsObject()
	phys:Wake()
	
	table.insert(XYZTrucker.Platforms, self)
end

function ENT:ONRemove()
	table.RemoveByValue(XYZTrucker.Platforms, self)
end

function ENT:StartTouch(vehicle)
	if not vehicle:IsVehicle() then return end
	if not vehicle.driver then return end

	local ply = vehicle.driver
	if not (vehicle == ply.truck_trailer) then return end
	if not (self == ply.truck_platform) then return end

	XYZTrucker.Core.FinishedJob(ply)
end