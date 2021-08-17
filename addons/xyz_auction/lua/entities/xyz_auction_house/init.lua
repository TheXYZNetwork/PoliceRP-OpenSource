AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")


-- Sets the players model and basic physics ect..
function ENT:Initialize()
	self:SetModel("models/mossman.mdl")
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

	if XYZShit.CoolDown.Check("AuctionHouse:NPC", 3, ply) then return end

	net.Start("AuctionHouse:UI")
		net.WriteEntity(self)
		net.WriteTable(AuctionHouse.ActiveListings)
	net.Send(ply)
end