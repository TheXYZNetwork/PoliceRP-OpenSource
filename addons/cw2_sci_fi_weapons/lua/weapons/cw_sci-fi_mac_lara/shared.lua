AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")
SWEP.PrintName = "Lightning LZ-1 Lara QQ"
if CLIENT then
	SWEP.DrawCrosshair = false
	
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1.15
	
	SWEP.IconLetter = "b"
	killicon.AddFont("cw2_sci-fi_mac_lara", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))
	
	SWEP.MuzzleEffect = "muzzleflash_smg"
	SWEP.PosBasedMuz = true
	SWEP.SnapToGrip = true
	SWEP.ShellScale = 0.4
	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = 4, y = 0, z = -3}
	SWEP.ForeGripOffsetCycle_Draw = 0.7
	SWEP.ForeGripOffsetCycle_Reload = 0.8
	SWEP.ForeGripOffsetCycle_Reload_Empty = 0.9
	SWEP.FireMoveMod = 0.6

	
	SWEP.DrawTraditionalWorldModel = false
	SWEP.WM = "models/weapons/w_smg_macla.mdl"
	SWEP.WMPos = Vector(-1, -4, -1)
	SWEP.WMAng = Vector(0, 0, 180)

	SWEP.IronsightPos = Vector(0, 0, 0)
	SWEP.IronsightAng = Angle(0, 0, 0)

	SWEP.SprintPos = Vector(0, 0, 0)
	SWEP.SprintAng = Vector(-20, 0, 0)

	SWEP.CustomizePos = Vector(4.01, -4.75, -1.16)
	SWEP.CustomizeAng = Vector(8.432, 41.611, 0)

	SWEP.AlternativePos = Vector(-1.201, 0, 0.92)
	SWEP.AlternativeAng = Vector(0, 0, 0)
	
	SWEP.LuaVMRecoilAxisMod = {vert = 0.5, hor = 1, roll = 1, forward = 0.5, pitch = 0.5}
	
	SWEP.LaserPosAdjust = Vector(-2, 0, 0)
	SWEP.LaserAngAdjust = Angle(0.9, 182, 0) 
end

SWEP.LuaViewmodelRecoil = false

SWEP.Attachments = {}

SWEP.Animations = {
	fire = {"3", "4", "5"},
	reload = "2",
	idle = "1",
	draw = "6"
}
	
SWEP.Sounds = {
	["6"] = {
		{time = 0, sound = "CW_SCIFI_MAC_LARA_DEPLOY"}
	},

	["2"] = {
		{time = 0, sound = "CCW_SCIFI_MAC_LARA_RELOAD"}
	}
}


SWEP.SpeedDec = 40

SWEP.Slot = 2
SWEP.SlotPos = 0
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"auto", "semi"}
SWEP.Base = "cw_base"
SWEP.Category = "CW 2.0 - Sci-Fi"

SWEP.Author			= "Owain"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= true
SWEP.ViewModel		= "models/weapons/v_smg_macla.mdl"
SWEP.WorldModel		= "models/weapons/w_smg_macla.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 30
SWEP.Primary.DefaultClip	= 60
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "5.56x45MM"

SWEP.FireDelay = 0.04
SWEP.FireSound = "CW_SCIFI_MAC_LARA_FIRE"
SWEP.FireSoundSuppressed = "CW_SCIFI_MAC_LARA_FIRE"
SWEP.Recoil = 1.5

SWEP.HipSpread = 0.05
SWEP.AimSpread = 0.002
SWEP.VelocitySensitivity = 2
SWEP.MaxSpreadInc = 0.06
SWEP.SpreadPerShot = 0.01
SWEP.SpreadCooldown = 0.17
SWEP.Shots = 1
SWEP.Damage = 23
SWEP.DeployTime = 0.8

SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 4
SWEP.ReloadTime_Empty = 4
SWEP.ReloadHalt = 4
SWEP.ReloadHalt_Empty = 4