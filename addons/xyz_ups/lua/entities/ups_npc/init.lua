AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/Eli.mdl")
	self:SetHullType(HULL_HUMAN)
	self:SetHullSizeNormal()
	self:SetNPCState(NPC_STATE_SCRIPT)
	self:SetSolid(SOLID_BBOX)
	self:SetUseType(SIMPLE_USE)
	self:DropToFloor()
	self:SetTrigger(true)

	self:CapabilitiesAdd(CAP_ANIMATEDFACE + CAP_TURN_HEAD)
	
	self.coolDown = 0
end

function ENT:OnTakeDamage()        
	return 0    
end

function ENT:AcceptInput(name, activator)
	if self.coolDown > CurTime() then return end
	self.coolDown = CurTime() + 0.1
	-- Team check here
	if not (activator:Team() == TEAM_UPSDRIVER) then
		XYZShit.Msg("UPS", UPS.Config.Color, "You must be a UPS driver...", activator)
		return
	end

	if UPS.Core.ActiveDeliveries[activator:SteamID64()] then return end
	
	local clientTable = {}
	for k, v in pairs(UPS.Platforms) do
		clientTable[k] = {name = v.name, reward = v.reward, pos = v:GetPos()}
		if UPS.Core.RecentDeliveries[activator:SteamID64()] and UPS.Core.RecentDeliveries[activator:SteamID64()][k] then
			clientTable[k].cooldown = true
		end
	end

	net.Start("xyz_ups_menu")
		net.WriteTable(clientTable)
		net.WriteEntity(self)
	net.Send(activator)
end