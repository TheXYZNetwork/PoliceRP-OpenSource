AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

PNC.Platforms = PNC.Platforms or {} 
function ENT:Initialize()
	self:SetModel("models/hunter/blocks/cube3x6x025.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
	local phys = self:GetPhysicsObject()
	phys:Wake()

	self.name = "Waypoint"
	
	self.id = table.insert(PNC.Platforms, self)
end


function ENT:OnRemove()
	PNC.Platforms[self.id] = nil
end

function ENT:StartTouch(vehicle)
	if not vehicle:IsVehicle() then return end
	if not PNC.Config.AllowedVehicles[vehicle:GetVehicleClass()] then return end

	local ply = vehicle:GetDriver()
	if not IsValid(ply) then return end
	if not ply:IsPlayer() then return end

	local plyData = PNC.Core.ActivePatrols[ply:SteamID64()]

	if not plyData then return end

	if not (self == plyData.pads[plyData.current]) then return end
	if plyData.foot then return end

	plyData.current = plyData.current + 1
	if plyData.current > 5 then
		PNC.Core.EndPatrol(ply, true)
	else
		net.Start("xyz_pnc_patrol_next")
		net.Send(ply)
	end
end