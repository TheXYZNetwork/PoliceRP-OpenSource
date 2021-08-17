AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

	SWEP.magType = "pistolMag"
	SWEP.PrintName = "MP-443 Grach"

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.CSMuzzleFlashes = true
	SWEP.SightWithRail = true
	
	SWEP.IconLetter = "y"
	killicon.Add( "khr_grach", "icons/killicons/khr_grach", Color(255, 80, 0, 150))
	SWEP.SelectIcon = surface.GetTextureID("icons/select/khr_grach")
	
	SWEP.MuzzleEffect = "muzzleflash_pistol"
	SWEP.PosBasedMuz = true
	
	SWEP.Shell = "smallshell"
	SWEP.ShellScale = .35
	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = 0, y = 0, z = 0}
	
	SWEP.EffectiveRange_Orig = 36 * 39.37
	SWEP.DamageFallOff_Orig = .45

	SWEP.IronsightPos = Vector(-1.567, -1, 0.57)
	SWEP.IronsightAng = Vector(0.15, 0, 0)

	SWEP.SprintPos = Vector(0, 0, -1)
	SWEP.SprintAng = Vector(-15.478, 11.96, 0)

	SWEP.RMRPos = Vector(-1.5547, -5.234, -0.412)
	SWEP.RMRAng = Vector(0.15, 0, 0)

	SWEP.MicroT1Pos = Vector(-1.57, -5.234, -0.699)
	SWEP.MicroT1Ang = Vector(0.15, 0, 0)

	SWEP.DocterPos = Vector(-1.572, -5.234, -0.42)
	SWEP.DocterAng = Vector(0.15, 0, 0)

	SWEP.CustomizePos = Vector(3.417, -3.217, -2.613)
	SWEP.CustomizeAng = Vector(20.402, 20.402, 18.995)
	
	SWEP.AlternativePos = Vector(0, -2.5, -.6)
	SWEP.AlternativeAng = Vector(0, 0.703, 0)

	
	SWEP.MoveType = 1
	SWEP.ViewModelMovementScale = 1
	SWEP.BoltBone = "slide"
	SWEP.BoltShootOffset = Vector(-1.5, 0, 0)
	SWEP.HoldBoltWhileEmpty = true
	SWEP.DontHoldWhenReloading = true
	SWEP.DisableSprintViewSimulation = true
	
	SWEP.LuaVMRecoilAxisMod = {vert = .75, hor = 2, roll = 2, forward = 1.5, pitch = 2}
	SWEP.CustomizationMenuScale = 0.013
	SWEP.BoltBonePositionRecoverySpeed = 20 -- how fast does the bolt bone move back into it's initial position after the weapon has fired
	
	SWEP.AttachmentModelsVM = {
    ["kry_docter_sight"] = { type = "Model", model = "models/weapons/krycek/sights/docter_reddot.mdl", bone = "Gun", rel = "", pos = Vector(0.019, 1, 3.039), angle = Angle(0, -90, 1.5), size = Vector(0.85, 0.85, 0.85), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_microt1kh"] = { type = "Model", model = "models/cw2/attachments/microt1.mdl", bone = "Gun", rel = "", pos = Vector(0, 0.43, 2.93), angle = Angle(1.5, 0, 0), size = Vector(0.354, 0.354, 0.354), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_rail"] = { type = "Model", model = "models/cw2/attachments/pistolrail.mdl", bone = "Gun", rel = "", pos = Vector(0.09, -0.101, 0.33), angle = Angle(0, 90, -1.5), size = Vector(0.15, 0.15, 0.15), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_tundra9mm2"] = { type = "Model", model = "models/cw2/attachments/9mmsuppressor.mdl", bone = "Gun", rel = "", pos = Vector(0.075, 5.44, 1.23), angle = Angle(0, 180, 0), size = Vector(0.55, 0.55, 0.55), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_rmr"] = { type = "Model", model = "models/cw2/attachments/pistolholo.mdl", bone = "Gun", rel = "", pos = Vector(-0.12, -3.401, -1.201), angle = Angle(0, -90, 1.5), size = Vector(0.699, 0.699, 0.699), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_insight_x2"] = { type = "Model", model = "models/cw2/attachments/pistollaser.mdl", bone = "Gun", rel = "", pos = Vector(0.019, 1, 1.1), angle = Angle(0, 90, 0), size = Vector(0.119, 0.119, 0.119), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
end

SWEP.MuzzleVelocity = 370 -- in meter/s

SWEP.LuaViewmodelRecoil = false
SWEP.CanRestOnObjects = false

SWEP.Attachments = {[2] = {header = "Barrel Extension", offset = {-350, -550}, atts = {"md_tundra9mm2"}},
[1] = {header = "Rail", offset = {-650, -150}, atts = {"md_insight_x2"}},
[3] = {header = "Sight", offset = {200, -450}, atts = {"md_rmr", "kry_docter_sight", "md_microt1kh"}},
["+reload"] = {header = "Ammo", offset = {350, -50}, atts = {"am_7n31", "am_matchgrade"}}}

SWEP.LaserPosAdjust = Vector(0, -5, -1)
SWEP.LaserAngAdjust = Angle(0, 180, 0) 

SWEP.Animations = {fire = {"shoot1"},
	reload = "reload_nonempty",
	reload_empty = "reload_empty",
	idle = "idle",
	draw = "draw"}
	
SWEP.Sounds = {draw = {[1] = {time = 0, sound = "KZ75_DRAW"},
    [2] = {time = 0.4, sound = "GRACH_BAC"},
    [3] = {time = .55, sound = "GRACH_FOR"}},

	reload_nonempty = {[1] = {time = 0.6, sound = "GRACH_CLIPOUT"},
	[2] = {time = 1.4, sound = "GRACH_CLIPIN"}},
	
	reload_empty = {[1] = {time = 0.6, sound = "GRACH_CLIPOUT"},
	[2] = {time = 1.4, sound = "GRACH_CLIPIN"},
	[3] = {time = 2.1, sound = "GRACH_SLIDE"}}}

SWEP.SpeedDec = 20

SWEP.Slot = 1
SWEP.SlotPos = 0
SWEP.NormalHoldType = "pistol"
SWEP.RunHoldType = "normal"
SWEP.FireModes = {"semi"}
SWEP.Base = "cw_base"
SWEP.Category = "CW 2.0 - Pistols"

SWEP.Author			= "Khris"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= "Rack slide. Face barrel towards enemy. Do not eat."

SWEP.ViewModelFOV	= 75
SWEP.AimViewModelFOV = 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/khrcw2/v_khri_mp443.mdl"
SWEP.WorldModel		= "models/weapons/w_pist_glock18.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 18
SWEP.Primary.DefaultClip	= 18
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "9x19MM"

SWEP.FireDelay = 0.12
SWEP.FireSound = "GRACH_FIRE"
SWEP.FireSoundSuppressed = "GRACH_FIRE_SUPPRESSED"
SWEP.Recoil = .8
SWEP.FOVPerShot = 0.2

SWEP.HipSpread = 0.037
SWEP.AimSpread = 0.009
SWEP.VelocitySensitivity = 1.1
SWEP.MaxSpreadInc = 0.065
SWEP.SpreadPerShot = 0.005
SWEP.SpreadCooldown = 0.23
SWEP.Shots = 1
SWEP.Damage = 22
SWEP.DeployTime = .7
SWEP.ADSFireAnim = false

SWEP.ReloadSpeed = 1.2
SWEP.ReloadTime = 2.35
SWEP.ReloadHalt = 2.35

SWEP.ReloadTime_Empty = 2.7
SWEP.ReloadHalt_Empty = 2.7

function SWEP:IndividualThink()
	self.EffectiveRange = 36 * 39.37
	self.DamageFallOff = .45
	
	if self.ActiveAttachments.md_tundra9mm2 then
	self.EffectiveRange = ((self.EffectiveRange - 10.8 * 39.37))
	self.DamageFallOff = ((self.DamageFallOff + .135))
	end
	if self.ActiveAttachments.am_matchgrade then
	self.EffectiveRange = ((self.EffectiveRange + 5.4 * 39.37))
	self.DamageFallOff = ((self.DamageFallOff - .0675))
	end
end