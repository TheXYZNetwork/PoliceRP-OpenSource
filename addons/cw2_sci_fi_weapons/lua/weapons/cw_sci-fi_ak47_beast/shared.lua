AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")
SWEP.PrintName = "Ak47 Beast"
if CLIENT then
	SWEP.DrawCrosshair = false
	
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1.15
	
	SWEP.IconLetter = "b"
	killicon.AddFont("cw2_sci-fi_ak47_beast", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))
	
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
	SWEP.WM = "models/weapons/w_rif_akmp.mdl"
	SWEP.WMPos = Vector(-47, 0, -2.5)
	SWEP.WMAng = Vector(0, 90, 210)

	SWEP.IronsightPos = Vector(8.08, 0, 2.78)
	SWEP.IronsightAng = Angle(0, 3.8, 0)

	SWEP.SprintPos = Vector(0, -7, 2)
	SWEP.SprintAng = Vector(-15, -30, 0)

	SWEP.CustomizePos = Vector(4.01, -4.75, -1.16)
	SWEP.CustomizeAng = Vector(8.432, 41.611, 0)

	SWEP.AlternativePos = Vector(-1.201, 0, 0.92)
	SWEP.AlternativeAng = Vector(0, 0, 0)
	

	SWEP.BaseArm = "Bip01 L UpperArm"
	SWEP.BaseArmBoneOffset = Vector(-50, 0, 0)
	
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
	fire = {"shoot1", "shoot2", "shoot3"},
	reload = "reload",
	idle = "idle",
	draw = "draw"
}
	
SWEP.Sounds = {
	draw = {
		{time = 0, sound = "CW_FOLEY_MEDIUM"}
	},

	reload = {
		[1] = {time = 0.5, sound = "CW_SCIFI_AK47_BEAST_MAGOUT"},
		[2] = {time = 0.95, sound = "CW_SCIFI_AK47_BEAST_MAGIN"},
		[3] = {time = 1.55, sound = "CW_SCIFI_AK47_BEAST_BOLTPULL"}
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
SWEP.ViewModel		= "models/weapons/v_rif_akmp.mdl"
SWEP.WorldModel		= "models/weapons/w_rif_akmp.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 35
SWEP.Primary.DefaultClip	= 70
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "5.56x45MM"

SWEP.FireDelay = 0.08
SWEP.FireSound = "CW_SCIFI_AK47_BEAST_FIRE"
SWEP.FireSoundSuppressed = "CW_SCIFI_AK47_BEAST_FIRE"
SWEP.Recoil = 1.5

SWEP.HipSpread = 0.05
SWEP.AimSpread = 0.002
SWEP.VelocitySensitivity = 2
SWEP.MaxSpreadInc = 0.06
SWEP.SpreadPerShot = 0.01
SWEP.SpreadCooldown = 0.17
SWEP.Shots = 1
SWEP.Damage = 34
SWEP.DeployTime = 0.8

SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 2
SWEP.ReloadTime_Empty = 2
SWEP.ReloadHalt = 2
SWEP.ReloadHalt_Empty = 2


--SWEP.AimPos = Vector(8.08, 0, 2.78)
--SWEP.AimAng = Angle(0, 3.8, 0)