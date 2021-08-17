AddCSLuaFile("shared.lua")

if CLIENT then
    SWEP.PrintName = "Dog"
    SWEP.Category         = "XYZ Weapons"
    SWEP.DrawAmmo = false
    SWEP.DrawCrosshair = true
    SWEP.ViewModelFOV = 70
    SWEP.ViewModelFlip = false
    SWEP.CSMuzzleFlashes = false

    SWEP.Slot = 4
end

SWEP.Spawnable = true
SWEP.AdminSpawnable = true
SWEP.HoldType = "knife"
SWEP.Author = ""
SWEP.Purpose = ""
SWEP.Instructions = "W00f w00f."

SWEP.ViewModel = ""
SWEP.WorldModel = ""

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "none"
SWEP.Primary.Delay = 1.5

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = true
SWEP.Secondary.Ammo = "none"

SWEP.Sounds = {
    "barks/dogbark_1.wav",
    "barks/dogbark_2.wav",
    "barks/dogbark_3.wav",
    "barks/doggrowl_1.wav"
}

function SWEP:Precache()
	util.PrecacheModel(self.ViewModel)

    for k, v in pairs(self.Sounds) do
        util.PrecacheSound(v)
    end
end

SWEP.NextBark = 0
function SWEP:Bark()
    if CurTime() < self.NextBark then return end

    if SERVER and not CLIENT then
        local bark = table.Random(self.Sounds)
        self.Owner:EmitSound(bark)
    end

    self.NextBark = CurTime() + 2.5
end

function SWEP:PrimaryAttack()
	self:Bark()
end

function SWEP:SecondaryAttack()
    self:Bark()
end

function SWEP:Reload()
    self:Bark()
end