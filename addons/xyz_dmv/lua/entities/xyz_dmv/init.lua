AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

licensedUsers = {}

-- Sets the players model and basic physics ect..
function ENT:Initialize()
	self:SetModel("models/breen.mdl")
	self:SetHullType(HULL_HUMAN);
	self:SetHullSizeNormal();
	self:SetNPCState(NPC_STATE_SCRIPT)
	self:SetSolid(SOLID_BBOX)
	self:SetUseType(SIMPLE_USE)
	self:DropToFloor()
	
	self:CapabilitiesAdd(CAP_ANIMATEDFACE + CAP_TURN_HEAD)

	self.coolDown = 0
end

function ENT:OnTakeDamage()        
	return 0    
end

function ENT:AcceptInput(name, ply, caller)
	-- Basic checks
	if !ply:IsPlayer() then return end
	if ply:GetPos():Distance(self:GetPos()) > 100 then return end

	if licensedUsers[ply:SteamID64()] then
		XYZShit.Msg("DMV", DMV.Config.Color, "You already have a license, you do not need to retake the test.", ply)
		return
	end

	-- Opens derma
	net.Start("xyz_dmv")
		net.WriteEntity(self)
	net.Send(ply)
end