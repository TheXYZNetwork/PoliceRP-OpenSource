AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/freeman/owain_locker_door.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
	local phys = self:GetPhysicsObject()
	phys:Wake()

	self:SetAutomaticFrameAdvance(true)
	self:SetPlaybackRate(1)

	self:SetCooldown(0)
	self:SetHolding(100000)

	self.open = false
end

function ENT:Think() -- Used so that the animation runs at the correct FPS
	self:NextThink(CurTime())
	return true
end

function ENT:CloseDoor()
	self:SetCooldown(CurTime()+4)
	self.open = false

	local seq = self:LookupSequence("close")
	self:ResetSequence(seq)

	timer.Simple(3, function()
		local seq = self:LookupSequence("closeidle")
		self:ResetSequence(seq)
	end)
end

function ENT:OpenDoor()
	self:SetCooldown(CurTime()+4)
	self.open = true

	local seq = self:LookupSequence("open")
	self:ResetSequence(seq)

	timer.Simple(3, function()
		local seq = self:LookupSequence("openidle")
		self:ResetSequence(seq)
	end)
end

function ENT:Use(ply)
end


hook.Add("PlayerDeath", "xyz_armory_death", function(ply)
	if IsValid(ply.xyz_armory_active) then
		timer.Destroy("xyz_armory_reward")
		ply.xyz_armory_active:CloseDoor()
		ply.xyz_armory_active:SetCooldown(CurTime()+1200)
		ply.xyz_armory_active = nil
		XYZShit.Msg("Armory", Color(0, 50, 150), ply:Name().." has died while trying to raid the police armory.")
	end
end)

hook.Add("PlayerDisconnected", "xyz_armory_leave", function( ply )
	if IsValid(ply.xyz_armory_active) then
		timer.Destroy("xyz_armory_reward")
		ply.xyz_armory_active:CloseDoor()
		ply.xyz_armory_active:SetCooldown(CurTime()+1200)
		ply.xyz_armory_active = nil
		XYZShit.Msg("Armory", Color(0, 50, 150), ply:Name().." has abandoned the armory raid.")
	end
end)

hook.Add("OnPlayerChangedTeam", "xyz_armory_job", function( ply )
	if IsValid(ply.xyz_armory_active) then
		timer.Destroy("xyz_armory_reward")
		ply.xyz_armory_active:CloseDoor()
		ply.xyz_armory_active:SetCooldown(CurTime()+1200)
		ply.xyz_armory_active = nil
		XYZShit.Msg("Armory", Color(0, 50, 150), ply:Name().." has abandoned the armory raid.")
	end
end)