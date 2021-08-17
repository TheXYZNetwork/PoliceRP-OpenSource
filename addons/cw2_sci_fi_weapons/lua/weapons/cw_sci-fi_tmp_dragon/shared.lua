AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")
SWEP.PrintName = "TMP Dragon"
if CLIENT then
	SWEP.DrawCrosshair = false
	
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1.15
	
	SWEP.IconLetter = "l"
	killicon.AddFont("cw2_sci-fi_tmp_dragon", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))
	
	SWEP.MuzzleEffect = "muzzleflash_ak74"
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
	SWEP.WM = "models/weapons/w_smg_tmd.mdl"
	SWEP.WMPos = Vector(-1.2, -2, -3.5)
	SWEP.WMAng = Vector(-10, 0, 190)

	SWEP.IronsightPos = Vector(0, 0, 0)
	SWEP.IronsightAng = Angle(0, 0, 0)

	SWEP.SprintPos = Vector(0, 0, 0)
	SWEP.SprintAng = Vector(-20, 0, 0)

	SWEP.CustomizePos = Vector(4.01, -4.75, -1.16)
	SWEP.CustomizeAng = Vector(8.432, 41.611, 0)

	SWEP.AlternativePos = Vector(-1.201, 0, 0.92)
	SWEP.AlternativeAng = Vector(0, 0, 0)

	SWEP.LuaVMRecoilAxisMod = {vert = 0.5, hor = 1, roll = 1, forward = 0.5, pitch = 0.5}
	
	--SWEP.BoltBone = "frame bolt"
	--SWEP.BoltShootOffset = Vector(-4.3, 0, 0)
	--SWEP.HoldBoltWhileEmpty = false
	--SWEP.DontHoldWhenReloading = true
	
	SWEP.LaserPosAdjust = Vector(-2, 0, 0)
	SWEP.LaserAngAdjust = Angle(0.9, 182, 0) 
end

SWEP.LuaViewmodelRecoil = false

SWEP.Attachments = {}

SWEP.Animations = {
	fire = {"4", "5"},
	reload = "2",
	idle = "1",
	draw = "3"
}
	
SWEP.Sounds = {
	["3"] = {
		{time = 0, sound = "CW_SCIFI_TMP_DRAGON_DEPLOY"}
	},

	["2"] = {
		[1] = {time = 0.3, sound = "CW_SCIFI_TMP_DRAGON_MAGOUT"},
		[2] = {time = 0.95, sound = "CW_SCIFI_TMP_DRAGON_MAGIN"}
	}
}


SWEP.SpeedDec = 40

SWEP.Slot = 2
SWEP.SlotPos = 0
SWEP.NormalHoldType = "pistol"
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
SWEP.ViewModel		= "models/weapons/v_smg_tmd.mdl"
SWEP.WorldModel		= "models/weapons/w_smg_tmd.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 30
SWEP.Primary.DefaultClip	= 60
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "5.56x45MM"

SWEP.FireDelay = 0.06
SWEP.FireSound = "CW_SCIFI_TMP_DRAGON_FIRE"
SWEP.FireSoundSuppressed = "CW_SCIFI_TMP_DRAGON_FIRE"
SWEP.Recoil = 1.5

SWEP.HipSpread = 0.05
SWEP.AimSpread = 0.002
SWEP.VelocitySensitivity = 2
SWEP.MaxSpreadInc = 0.06
SWEP.SpreadPerShot = 0.01
SWEP.SpreadCooldown = 0.17
SWEP.Shots = 1
SWEP.Damage = 28
SWEP.DeployTime = 0.8

SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 2
SWEP.ReloadTime_Empty = 2
SWEP.ReloadHalt = 2
SWEP.ReloadHalt_Empty = 2