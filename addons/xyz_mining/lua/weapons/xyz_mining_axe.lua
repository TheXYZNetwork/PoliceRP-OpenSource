SWEP.PrintName = "Pickaxe"
SWEP.Author = "Owain"
SWEP.Category = "XYZ Weapons"

SWEP.Slot = 0
SWEP.SlotPos = 4

SWEP.Spawnable = true

SWEP.HoldType = "pistol"
SWEP.UseHands = true
SWEP.ViewModelFOV = 85
SWEP.ViewModelFlip = false
SWEP.ViewModel			    = "models/freeman/c_exhibition_pickaxe.mdl"
SWEP.WorldModel			    = "models/freeman/w_exhibition_pickaxe.mdl"


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

    self.isDigging = false

    self:SetDeploySpeed(1)
end 

function SWEP:Holster()
	return not self.isDigging
end

function SWEP:PrimaryAttack()
	if CLIENT then return end

	local ply = self.Owner
	local target = ply:GetEyeTrace().Entity

	-- Not a mining ore node
	if not target.isOreNode then return end
	-- Distance check
	if ply:GetPos():DistToSqr(target:GetPos()) > 8000 then return end

	ply:GetViewModel():SendViewModelMatchingSequence(ply:GetViewModel():LookupSequence("swing"))

	self.isDigging = true

	timer.Simple(0.4, function()
		target:EmitSound("physics/concrete/rock_impact_hard"..math.random(1, 6)..".wav", 100, 100, 1)

		self.isDigging = false

		target:Mine(ply)
	end)

	self:SetNextPrimaryFire(CurTime() + Mining.Config.PickaxeCooldown)
end

function SWEP:SecondaryAttack()
end

function SWEP:Reload()
end