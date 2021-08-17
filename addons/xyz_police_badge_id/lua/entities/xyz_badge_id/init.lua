AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")


-- Sets the players model and basic physics ect..
function ENT:Initialize()
	self:SetModel("models/humans/nypd1940/male_03.mdl")
	self:SetHullType(HULL_HUMAN);
	self:SetHullSizeNormal();
	self:SetNPCState(NPC_STATE_SCRIPT)
	self:SetSolid(SOLID_BBOX)
	self:SetUseType(SIMPLE_USE)
	self:DropToFloor()
	
	self:CapabilitiesAdd(CAP_ANIMATEDFACE + CAP_TURN_HEAD)
end

function ENT:OnTakeDamage()        
	return 0    
end

function ENT:AcceptInput(name, ply, caller)
	-- Basic checks
	if not ply:IsPlayer() then return end
	if ply:GetPos():Distance(self:GetPos()) > 100 then return end

	if not ply:IsVIP() then
		XYZShit.Msg("Government Badge ID", GovBadgeID.Config.Color, "Only VIP+ can change their Government Badge ID...", ply)
		return
	end
	

	net.Start("GovBadgeID:UI")
		net.WriteEntity(self)
	net.Send(ply)
end