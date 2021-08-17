AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

SWEP.PrintName = "L85A2"

if CLIENT then
	SWEP.DrawCrosshair = false
	
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1.15
	SWEP.CustomizationMenuScale = 0.012
	
	SWEP.IconLetter = "i"
	killicon.AddFont("cw_g36c", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))

	SWEP.MuzzleEffect = "muzzleflash_6"
	SWEP.PosBasedMuz = false
	SWEP.SnapToGrip = true
	SWEP.ShellScale = 0.7
	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = -7, y = 0, z = 0}
	SWEP.ForeGripOffsetCycle_Draw = 0
	SWEP.ForeGripOffsetCycle_Reload = 0.52
	SWEP.ForeGripOffsetCycle_Reload_Empty = 0.52
	SWEP.FireMoveMod = 0.6
	
	SWEP.DrawTraditionalWorldModel = false
	SWEP.WM = "models/weapons/w_cw20_l85a2.mdl"
	SWEP.WMPos = Vector(0, -19, -7.5)
	SWEP.WMAng = Vector(-6, 0, 180)
		
	SWEP.IronsightPos = Vector(-2.218, -1.785, -0.072)
	SWEP.IronsightAng = Vector(0, 0, 0)
		
	SWEP.MicroT1Pos = Vector(-2.211, -5, 0.518)
	SWEP.MicroT1Ang = Vector(0, 0, 0)

	SWEP.EoTechPos = Vector(-2.221, -6.48, 0.103)
	SWEP.EoTechAng = Vector(0, 0, 0)
	
	SWEP.AimpointPos = Vector(-2.221, -6.48, 0.474)
	SWEP.AimpointAng = Vector(0, 0, 0)
	
	SWEP.ShortDotPos = Vector(-2.145, -7, 0.44)
	SWEP.ShortDotAng = Vector(0, 0, 0)
	
	SWEP.ACOGPos = Vector(-2.204, -7.3, 0.15)
	SWEP.ACOGAng = Vector(0, 0, 0)
	
	SWEP.SprintPos = Vector(1.786, 0, -1)
	SWEP.SprintAng = Vector(-10.778, 27.573, 0)

	SWEP.BackupSights = {["md_acog"] = {[1] = Vector(-2.199, -7.633, -0.973), [2] = Vector(0, 0, 0)}}

	SWEP.SightWithRail = true
	SWEP.ACOGAxisAlign = {right = 0.5, up = 0, forward = 0}
	SWEP.SchmidtShortDotAxisAlign = {right = 0.42, up = 0, forward = 0}
	
	SWEP.AlternativePos = Vector(-0.2, 0, -0.4)
	SWEP.AlternativeAng = Vector(0, 0, 0)

	SWEP.BaseArm = "Left_U_Arm"
	SWEP.BaseArmBoneOffset = Vector(-50, 0, 0)

	SWEP.AttachmentModelsVM = {
		["md_aimpoint"] = {model = "models/wystan/attachments/aimpoint.mdl", bone = "body", pos = Vector(-2.119, 2.118, 0.241), angle = Angle(-90, 0, -90), size = Vector(1, 1, 1)},
		["md_eotech"] = {model = "models/wystan/attachments/2otech557sight.mdl", bone = "body", pos = Vector(-8.197, 9.987, -0.348), angle = Angle(0, 3.332, -90), size = Vector(1.2, 1.2, 1.2)},
		["md_schmidt_shortdot"] = {model = "models/cw2/attachments/schmidt.mdl", bone = "body", pos = Vector(-1.6, 2.1, 0.3), angle = Angle(0, 0, -90), size = Vector(1, 1, 1)},
		["md_microt1"] = {model = "models/cw2/attachments/microt1.mdl", bone = "body", pos = Vector(3.588, -3.741, -0.049), angle = Angle(90, 0, -90), size = Vector(0.449, 0.449, 0.449)},
		["md_saker"] = {model = "models/cw2/attachments/556suppressor.mdl", bone = "body", pos = Vector(0.976, -2.477, -1.522), angle = Angle(0, 90, 0), size = Vector(0.5, 0.5, 0.5)},
		["md_anpeq15"] = {model = "models/cw2/attachments/anpeq15.mdl", bone = "body", pos = Vector(4.293, -1.867, -0.764), angle = Angle(180, 0, 0), size = Vector(0.6, 0.6, 0.6)},
		["md_acog"] = {model = "models/wystan/attachments/2cog.mdl", bone = "body", pos = Vector(-1.433, 2.134, 0.33), angle = Angle(-90, 0, -90), size = Vector(1, 1, 1)}
	}

	SWEP.LuaVMRecoilAxisMod = {vert = 1, hor = 2, roll = 1.5, forward = 1, pitch = 1}
	
	SWEP.LaserPosAdjust = Vector(-1, 0, 0)
	SWEP.LaserAngAdjust = Angle(0, 180, 0) 
	
	SWEP.Trivia = {text = "This weapon comes with a grippod pre-installed, which acts like a foregrip and a bipod.", x = -500, y = -360}
end

SWEP.MuzzleVelocity = 930 -- in meter/s

SWEP.SightBGs = {main = 1, none = 1}
SWEP.LuaViewmodelRecoil = true
SWEP.LuaViewmodelRecoilOverride = true

SWEP.Attachments = {[1] = {header = "Sight", offset = {800, -300},  atts = {"md_microt1", "md_eotech", "md_aimpoint", "md_schmidt_shortdot", "md_acog"}},
	[2] = {header = "Barrel", offset = {-500, -300}, atts = {"md_saker"}},
	[3] = {header = "Rail", offset = {-500, 200},  atts = {"md_anpeq15"}},
	["+reload"] = {header = "Ammo", offset = {800, 100}, atts = {"am_magnum", "am_matchgrade"}}}

SWEP.Animations = {fire = {"shoot1", "shoot2", "shoot3"},
	reload = "Reload_Full",
	reload_empty = "Reload",
	idle = "idle",
	draw = "draw"}
	
SWEP.Sounds = {draw = {{time = 0, sound = "CW_FOLEY_LIGHT"},
	{time = 0.4, sound = "CW_G36C_SELECTFIRE"}},

	Reload = {{time = 0.2, sound = "CW_FOLEY_LIGHT"},
	{time = 0.73, sound = "CW_L85A2_MAGOUT"},
	{time = 1, sound = "CW_FOLEY_LIGHT"},
	{time = 1.3, sound = "CW_G36C_MAGDROP"},
	{time = 2.55, sound = "CW_L85A2_MAGIN"},
	{time = 3.7, sound = "CW_L85A2_BOLTPULL"},
	{time = 4.3, sound = "CW_FOLEY_MEDIUM"}},
	
	Reload_Full = {{time = 0.2, sound = "CW_FOLEY_LIGHT"},
	{time = 0.73, sound = "CW_L85A2_MAGOUT"},
	{time = 1, sound = "CW_FOLEY_LIGHT"},
	{time = 1.3, sound = "CW_G36C_MAGDROP"},
	{time = 2.55, sound = "CW_L85A2_MAGIN"},
	{time = 3, sound = "CW_FOLEY_MEDIUM"}}}

SWEP.SpeedDec = 30

SWEP.Slot = 3
SWEP.SlotPos = 0
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"auto", "semi"}
SWEP.Base = "cw_base"
SWEP.Category = "CW 2.0"

SWEP.Author			= "Spy"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/cw2/rifles/l85a2.mdl"
SWEP.WorldModel		= "models/weapons/w_cw20_l85a2.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 30
SWEP.Primary.DefaultClip	= 30
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "5.56x45MM"

SWEP.FireDelay = 0.07
SWEP.FireSound = "CW_L85A2_FIRE"
SWEP.FireSoundSuppressed = "CW_L85A2_FIRE_SUPPRESSED"
SWEP.Recoil = 1.3

SWEP.HipSpread = 0.045
SWEP.AimSpread = 0.0025
SWEP.VelocitySensitivity = 1.8
SWEP.MaxSpreadInc = 0.033
SWEP.SpreadPerShot = 0.007
SWEP.SpreadCooldown = 0.16
SWEP.Shots = 1
SWEP.Damage = 38
SWEP.DeployTime = 0.8

SWEP.ReloadSpeed = 1.35
SWEP.ReloadTime = 2.99
SWEP.ReloadTime_Empty = 2.99
SWEP.ReloadHalt = 4.1
SWEP.ReloadHalt_Empty = 5.05

-- the model that this L85A2 uses comes with a grippod, so we add bipod functionality to it, but make it very tame when compared to a regular bipod
SWEP.BipodInstalled = true
SWEP.BipodRecoilModifier = 0.75

function SWEP:getBipodHipSpread()
	return self.HipSpread * 0.75
end