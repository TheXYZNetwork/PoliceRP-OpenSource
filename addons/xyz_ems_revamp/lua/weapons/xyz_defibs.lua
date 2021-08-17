SWEP.PrintName = "Defibrillator"
SWEP.Author = "Owain Owjo"
SWEP.Category = "XYZ Weapons"

SWEP.Slot = 0
SWEP.SlotPos = 4

SWEP.Spawnable = true	
SWEP.ViewModel = Model("models/sterling/c_owian_defib.mdl")
SWEP.WorldModel			    = "models/sterling/w_owain_defib.mdl"
SWEP.ViewModelFOV = 85
SWEP.UseHands = true

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "none"

SWEP.Secondary.ClipSize 	 = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = true
SWEP.Secondary.Ammo = "none"

SWEP.DrawAmmo = false
SWEP.Base = "weapon_base"

SWEP.Secondary.Ammo = "none"

SWEP.HoldType = ""

function SWEP:Initialize()
    self:SetHoldType("")
end 

local HealSound = Sound("HealthKit.Touch")
local DenySound = Sound("WallHealth.Deny")
local targetPly
local ply

function SWEP:PrimaryAttack()
	if SERVER then return end
	if XYZShit.CoolDown.Check("DefibsPrimary", 2) then return end

	ply = self.Owner 
	targetPly = XYZEMS.Core.GetClosestRagdoll(ply)

	if not targetPly then ply:EmitSound(DenySound) return end
	ply:EmitSound(HealSound)
	ply:GetViewModel():SendViewModelMatchingSequence(ply:GetViewModel():LookupSequence("discharge"))
	timer.Simple(1.2, function()
		ply:GetViewModel():SendViewModelMatchingSequence(ply:GetViewModel():LookupSequence("idle"))	
	end)

	net.Start("EMSRevivePly")
		net.WriteEntity(targetPly)
	net.SendToServer()
end

function SWEP:SecondaryAttack()
	if SERVER then return end
	if XYZShit.CoolDown.Check("DefibsSecondary", 4) then return end

	ply = self.Owner 
	ply:GetViewModel():SendViewModelMatchingSequence(ply:GetViewModel():LookupSequence("charging"))
	timer.Simple(3, function()
		ply:GetViewModel():SendViewModelMatchingSequence(ply:GetViewModel():LookupSequence("idle"))	
	end)
end


function SWEP:Reload()
end

function SWEP:GetViewModelPosition(pos, ang)
end