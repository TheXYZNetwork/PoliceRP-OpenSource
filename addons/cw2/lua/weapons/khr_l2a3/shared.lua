AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

	SWEP.magType = "smgMag"
	SWEP.PrintName = "Sterling L2A3"

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.CSMuzzleFlashes = true
	
	SWEP.IconLetter = "w"
	killicon.Add( "khr_l2a3", "icons/killicons/khr_l2a3", Color(255, 80, 0, 150))
	SWEP.SelectIcon = surface.GetTextureID("icons/killicons/khr_l2a3")
	
	SWEP.MuzzleEffect = "muzzleflash_smg"
	SWEP.PosBasedMuz = true
	SWEP.Shell = "smallshell"
	SWEP.ShellScale = 0.45
	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = 0, y = 0, z = 0}
	SWEP.SightWithRail = true
	SWEP.DisableSprintViewSimulation = false
	
	SWEP.EffectiveRange_Orig = 38 * 39.37
	SWEP.DamageFallOff_Orig = .41
	
	SWEP.BoltBone = "WPN_Bolt_Handle"
	SWEP.BoltBonePositionRecoverySpeed = 60
	SWEP.BoltShootOffset = Vector(0, -2, 0)
	
	SWEP.IronsightPos = Vector(-1.675, 1, 1.2)
	SWEP.IronsightAng = Vector(-0.08, 0.04, 0)
	
	SWEP.MicroT1Pos = Vector(-1.565, -1, .56)
	SWEP.MicroT1Ang = Vector(0, 0, 0)
	
    SWEP.EoTech553Pos = Vector(-1.55, -1, .34)
	SWEP.EoTech553Ang = Vector(0, 0, 0)
	
	SWEP.KR_CMOREPos =  Vector(-1.55, -1, .39)
	SWEP.KR_CMOREAng =  Vector(0, 0, 0)
	
	SWEP.SprintPos = Vector(3.92, 0, -1.321)
	SWEP.SprintAng = Vector(-14.07, 24.622, -4.926)
	
	SWEP.AlternativePos = Vector(0.839, 0, -.5)
	SWEP.AlternativeAng = Vector(0, 0, 0)

	SWEP.CustomizationMenuScale = 0.02
	SWEP.ViewModelMovementScale = 1
	
	SWEP.AttachmentModelsVM = {
	    ["md_microt1kh"] = { type = "Model", model = "models/cw2/attachments/microt1.mdl", bone = "WPN_Master", rel = "", pos = Vector(0.02, -2.06, 3.779), angle = Angle(0, 180, 0), size = Vector(0.289, 0.289, 0.289), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["md_rail"] = { type = "Model", model = "models/wystan/attachments/rail.mdl", bone = "WPN_Master", rel = "", pos = Vector(0.209, 0, 2), angle = Angle(0, 90, 0), size = Vector(0.899, 0.899, 0.899), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["md_saker222"] = { type = "Model", model = "models/cw2/attachments/556suppressor.mdl", bone = "WPN_Master", rel = "", pos = Vector(0, -0.401, 0.54), angle = Angle(0, 0, 0), size = Vector(0.699, 0.699, 0.699), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["odec3d_cmore_kry"] = { type = "Model", model = "models/weapons/krycek/sights/odec3d_cmore_reddot.mdl", bone = "WPN_Master", rel = "", pos = Vector(-0.06, -1.9, 3.75), angle = Angle(0, -90, 0), size = Vector(0.209, 0.209, 0.209), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["md_fas2_eotech"] = { type = "Model", model = "models/c_fas2_eotech.mdl", bone = "WPN_Master", rel = "", pos = Vector(0, 0.4, 3.299), angle = Angle(0, -90, 0), size = Vector(0.8, 0.8, 0.8), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
	
end

SWEP.MuzzleVelocity = 390 -- in meter/s

SWEP.LuaVMRecoilAxisMod = {vert = 1.25, hor = .5, roll = 1, forward = 1, pitch = 1}

SWEP.LuaViewmodelRecoil = true


SWEP.Attachments = {[2] = {header = "Optic", offset = {500, -200}, atts = {"md_microt1kh", "odec3d_cmore_kry", "md_fas2_eotech"}},
[1] = {header = "Barrel", offset = {-500, -320}, atts = {"md_saker222"}},
["+reload"] = {header = "Ammo", offset = {-300, 200}, atts = {"am_magnum", "am_matchgrade"}}}

SWEP.Animations = {fire = {"shoot1", "shoot2"},
	reload = "reload",
	idle = "idle",
	draw = "draw"}
	
SWEP.Sounds = {	draw = {{time = 0, sound = "STER_Draw"}},

	reload = {[1] = {time = .4, sound = "STER_Magout"},
	[2] = {time = 1.95, sound = "STER_Maghit"},
	[3] = {time = 2.2, sound = "STER_Magin"},
	[4] = {time = 3, sound = "STER_Boltback"}}}

SWEP.HoldBoltWhileEmpty = true
SWEP.DontHoldWhenReloading = false
SWEP.Chamberable = false

SWEP.SpeedDec = 25

SWEP.Slot = 2
SWEP.SlotPos = 0
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"auto"}
SWEP.Base = "cw_base"
SWEP.Category = "CW 2.0 - SMGs"

SWEP.Author			= "Khris"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.OverallMouseSens = .9
SWEP.ViewModelFOV	= 80
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/khrcw2/v_khr_ste.mdl"
SWEP.WorldModel		= "models/weapons/w_smg_mp5.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 34
SWEP.Primary.DefaultClip	= 34
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "9x19MM"

SWEP.FireDelay = 0.109
SWEP.FireSound = "STER_Fire"
SWEP.FireSoundSuppressed = "STER_Firesup"
SWEP.Recoil = .78

SWEP.HipSpread = 0.050
SWEP.AimSpread = 0.0088
SWEP.VelocitySensitivity = 1
SWEP.MaxSpreadInc = 0.045
SWEP.SpreadPerShot = 0.004
SWEP.SpreadCooldown = 0.14
SWEP.Shots = 1
SWEP.Damage = 31
SWEP.DeployTime = 0.8

SWEP.ReloadSpeed = 1.4
SWEP.ReloadTime = 3.9
SWEP.ReloadTime_Empty = 3.9
SWEP.ReloadHalt = 3.9
SWEP.ReloadHalt_Empty = 3.9

function SWEP:IndividualThink()
	self.EffectiveRange = 38 * 39.37
	self.DamageFallOff = .41
	
	if self.ActiveAttachments.md_saker222 then
	self.EffectiveRange = ((self.EffectiveRange - 9.5 * 39.37))
	self.DamageFallOff = ((self.DamageFallOff + .1025))
	end
	if self.ActiveAttachments.am_matchgrade then
	self.EffectiveRange = ((self.EffectiveRange + 5.7 * 39.37))
	self.DamageFallOff = ((self.DamageFallOff - .0615))
	end
end