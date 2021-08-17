AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")


-- Sets the players model and basic physics ect..
function ENT:Initialize()
	self:SetModel("models/Humans/Group02/male_02.mdl")
	self:SetHullType(HULL_HUMAN);
	self:SetHullSizeNormal();
	self:SetNPCState(NPC_STATE_SCRIPT)
	self:SetSolid(SOLID_BBOX)
	self:SetUseType(SIMPLE_USE)
	self:DropToFloor()
	
	self:CapabilitiesAdd(CAP_ANIMATEDFACE + CAP_TURN_HEAD)
end

function ENT:AcceptInput(name, ply, caller)
	-- Basic checks
	if not ply:IsPlayer() then return end
	if ply:GetPos():Distance(self:GetPos()) > 100 then return end

	local plyOres = Mining.Users[ply:SteamID64()] or {}
	
	net.Start("Mining:UI")
		net.WriteEntity(self)
		net.WriteTable(plyOres)
	net.Send(ply)
end

function ENT:OnTakeDamage()        
	return 0    
end