AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

util.AddNetworkString("XYZArmoryOpenUI")
util.AddNetworkString("XYZArmoryCollectWeapon")

-- Used to limit the amount of weapons a user can have per life
XYZWeaponCap = {}

function ENT:Initialize()
	self:SetModel("models/humans/nypd1940/male_03.mdl")
	self:SetHullType(HULL_HUMAN);
	self:SetHullSizeNormal();
	self:SetNPCState(NPC_STATE_SCRIPT)
	self:SetSolid(SOLID_BBOX)
	self:SetUseType(SIMPLE_USE)
	self:DropToFloor()
end

function ENT:OnTakeDamage()        
	return 0    
end

function ENT:Use(ply)
	if not XYZWeaponCap[ply:SteamID64()] then
		XYZWeaponCap[ply:SteamID64()] = 0
	end
	if XYZWeaponCap[ply:SteamID64()] >= (XYZArmoryCap[ply:Team()] or 1) then
		XYZShit.Msg("Armory", Color(40, 160, 40), "You have already reached your weapon limit for this life", ply)
		return
	end

	net.Start("XYZArmoryOpenUI")
		net.WriteEntity(self)
	net.Send(ply)
end

net.Receive("XYZArmoryCollectWeapon", function(_, ply)
	if not XYZWeaponCap[ply:SteamID64()] then
		XYZWeaponCap[ply:SteamID64()] = 0
	end

	if XYZWeaponCap[ply:SteamID64()] >= (XYZArmoryCap[ply:Team()] or 1) then
		XYZShit.Msg("Armory", Color(40, 160, 40), "You have already reached your weapon limit for this life", ply)
		return
	end

	local npc = net.ReadEntity()
	local key = net.ReadInt(32)

	if not (npc:GetClass() == "xyz_weapon_armory") then return end
	if npc:GetPos():Distance(ply:GetPos()) > 500 then return end

	local weaponTbl = XYZArmoryItems[key]
	if not weaponTbl then return end

	if not weaponTbl.check(ply) then return end

	ply:Give(weaponTbl.class).armory = true
	XYZWeaponCap[ply:SteamID64()] = XYZWeaponCap[ply:SteamID64()] + 1
end)

hook.Add("PlayerSpawn", "XYZArmoryResetCap", function(ply)
	XYZWeaponCap[ply:SteamID64()] = 0
end)

hook.Add("canDropWeapon", "XYZArmoryDropWep", function(ply, wep)
	if wep.armory then return false end
end)