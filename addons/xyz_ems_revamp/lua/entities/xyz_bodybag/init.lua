AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

-- Sets the players model and basic physics ect..
function ENT:Initialize()
	self:SetModel("models/freeman/owain_body_bag.mdl")

	-- Basic physics and functionality
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_NONE)
	self:SetUseType(SIMPLE_USE)
	local phys = self:GetPhysicsObject()
	phys:Wake()
	self:SetCollisionGroup(COLLISION_GROUP_WEAPON)
end


function ENT:Use(ply)
	if not XYZEMS.Core.IsEMS(ply) then return end

	XYZShit.Msg("EMS", Color(155, 0, 0), "You have collected the bodybag!", ply)
	
	ply:addMoney(XYZEMS.Config.BodyBagReward)

	net.Start("EMSBroadcastBodyBagRemove")
		net.WriteInt(self:EntIndex(), 32)
	net.Broadcast()
	self:Remove() 
end