SWEP.PrintName = "Prison Wrench"
SWEP.Author = "Owain"
SWEP.Category = "XYZ Weapons"

SWEP.Slot = 0
SWEP.SlotPos = 4

SWEP.Spawnable = true

SWEP.HoldType = "pistol"
SWEP.UseHands = true
SWEP.ViewModelFOV = 85
SWEP.ViewModelFlip = false
SWEP.ViewModel			    = "models/weapons/tfa_l4d2/c_pipewrench.mdl"
SWEP.WorldModel             = "models/weapons/tfa_l4d2/w_pipewrench.mdl"


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

    self.lastHolster = 0
end 

function SWEP:PrimaryAttack()
    if CLIENT then return end
	self:SetNextPrimaryFire(CurTime()+2)

    local ply = self.Owner

    if not (ply:Team() == PrisonSystem.Config.Prisoner) then
        XYZShit.Msg("Prisoner", PrisonSystem.Config.Color, "You must be a prisoner to use this.", ply)
        return
    end

    if (not PrisonSystem.ActiveJobs[ply:SteamID64()]) or (not (PrisonSystem.ActiveJobs[ply:SteamID64()].name == "maintenance")) then
        XYZShit.Msg("Prisoner", PrisonSystem.Config.Color, "Your current job does not allow this!", ply)
        return
    end

    local ent = ply:GetEyeTrace().Entity
    if not (ent:GetClass() == "xyz_prison_maintenance_node") then return end
    if not (ent:GetIsBroken()) then return end
    if ent:GetPos():Distance(ply:GetPos()) > 200 then return end

    local viewmodel = ply:GetViewModel()
    viewmodel:SendViewModelMatchingSequence(viewmodel:LookupSequence("attack_0"..math.random(1, 3)))

	ent:ProgressRepair(ply)

end

function SWEP:SecondaryAttack()
end

function SWEP:Reload()
end