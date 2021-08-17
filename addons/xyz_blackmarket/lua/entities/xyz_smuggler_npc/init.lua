AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

util.AddNetworkString("xyz_smuggler_menu")
util.AddNetworkString("xyz_smuggler_spawn")

function ENT:Initialize()
	self:SetModel("models/monk.mdl")
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
	self.coolDown = CurTime() + 0.5
	
	-- Basic checks
	if activator:IsPlayer() == false then return end
	if activator:GetPos():Distance( self:GetPos() ) > 100 then return end

	net.Start("xyz_smuggler_menu")
		net.WriteEntity(self)
	net.Send(activator)
end

local plySpawnTracker = {}

net.Receive("xyz_smuggler_spawn", function(_, ply)
	if XYZShit.CoolDown.Check("xyz_smuggler_spawn", 5, ply) then
		return
	end

	if XYZShit.IsGovernment(ply:Team(), true) then
		XYZShit.Msg("Black Market", Color(200, 200, 200), "Get out of here you dirt cop!", ply)
		return
	end

	local npc = net.ReadEntity()
	local itemKey = net.ReadInt(32)

	if npc:GetClass() != "xyz_smuggler_npc" then return end
	if npc:GetPos():Distance(ply:GetPos()) > 500 then return end
	if npc.coolDown > CurTime() then return end
	npc.coolDown = CurTime() + 0.5

	if not npc.Items[itemKey] then return end
	local item = npc.Items[itemKey]

	if not plySpawnTracker[ply:SteamID64()] then
		plySpawnTracker[ply:SteamID64()] = {}
	end
	if not plySpawnTracker[ply:SteamID64()][item.ent] then
		plySpawnTracker[ply:SteamID64()][item.ent] = 0
	end

	if plySpawnTracker[ply:SteamID64()][item.ent] >= item.max then
		XYZShit.Msg("Black Market", Color(200, 200, 200), "Looks like you've bought out all my stock for now...", ply)
		return
	end

	if not ply:canAfford(item.price) then
		XYZShit.Msg("Black Market", Color(200, 200, 200), "You're too poor for this...", ply)
		return
	end

	if item.func then
		item.func(ply)
	else
		ply:Give(item.ent)
		XYZShit.Msg("Black Market", Color(200, 200, 200), "Enjoy this fine weapon!", ply)
	end
	ply:addMoney(-item.price)
	xLogs.Log(xLogs.Core.Player(ply).." has purchased "..item.ent.." for "..xLogs.Core.Color(DarkRP.formatMoney(item.price), Color(0, 200, 200)), "Black Market")

	Quest.Core.ProgressQuest(ply, "life_of_crime", 5)
	Quest.Core.ProgressQuest(ply, "jail_break", 5)
end)