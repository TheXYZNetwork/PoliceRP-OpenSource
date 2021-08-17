AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

	SWEP.magType = "pistolMag"
	
	CustomizableWeaponry:registerAmmo("9x21MM", "9x21MM Gyurza", 9, 21)
	SWEP.PrintName = "SR-1M"

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.CSMuzzleFlashes = true
	
	SWEP.IconLetter = "y"
	killicon.Add( "khr_sr1m", "icons/killicons/khr_sr1m", Color(255, 80, 0, 150))
	SWEP.SelectIcon = surface.GetTextureID("icons/select/khr_sr1m")
	
	SWEP.MuzzleEffect = "muzzleflash_pistol"
	SWEP.PosBasedMuz = true
	SWEP.SightWithRail = true
	
	SWEP.Shell = "smallshell"
	SWEP.ShellScale = .42
	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = 0, y = 0, z = 0}
	
	SWEP.EffectiveRange_Orig = 38.8 * 39.37
	SWEP.DamageFallOff_Orig = .45

	SWEP.IronsightPos = Vector(-2.547, -1.106, 0.86)
	SWEP.IronsightAng = Vector(-0.2, 0.035, 0)
	
	SWEP.RMRPos = Vector(-2.547, -6, -.18)
	SWEP.RMRAng = Vector(0, 0, 0)
	
	SWEP.DocterPos = Vector(-2.535, -6, -.1)
	SWEP.DocterAng = Vector(0, 0, 0)
	
	SWEP.MicroT1Pos = Vector(-2.55, -6, -.35)
	SWEP.MicroT1Ang = Vector(0, 0, 0)
	
	SWEP.SprintPos = Vector(0, 0, 0)
	SWEP.SprintAng = Vector(-15.478, 11.96, 0)
	
	SWEP.CustomizePos = Vector(3.25, -4.613, -2.651)
	SWEP.CustomizeAng = Vector(23.92, 16.884, 23.92)
	
	SWEP.AlternativePos = Vector(-.5, -1, -0.75)
	SWEP.AlternativeAng = Vector(0, .704, 0)

	
	SWEP.MoveType = 1
	SWEP.ViewModelMovementScale = 1
	SWEP.BoltBone = "usp_slide"
	SWEP.BoltShootOffset = Vector(-1.2, 0, 0)
	SWEP.BoltReloadOffset = Vector(1.6, 0, 0)
	SWEP.OffsetBoltDuringNonEmptyReload = true
	SWEP.EmptyBoltHoldAnimExclusion = "shoot_empty"
	SWEP.ReloadBoltBonePositionRecoverySpeed = 10
	SWEP.ReloadBoltBonePositionMoveSpeed = 8
	SWEP.StopReloadBoneOffset = .8
	SWEP.HoldBoltWhileEmpty = true
	SWEP.DontHoldWhenReloading = true
	SWEP.DisableSprintViewSimulation = true
	
	SWEP.LuaVMRecoilAxisMod = {vert = 1.2, hor = 2, roll = 2, forward = 1.5, pitch = 2}
	SWEP.CustomizationMenuScale = 0.0135
	SWEP.BoltBonePositionRecoverySpeed = 35 -- how fast does the bolt bone move back into it's initial position after the weapon has fired
	
	SWEP.AttachmentModelsVM = {
	
    ["kry_docter_sight"] = { type = "Model", model = "models/weapons/krycek/sights/docter_reddot.mdl", bone = "usp_main", rel = "", pos = Vector(1.7, -2.141, 0), angle = Angle(0, 0, -90), size = Vector(0.85, 0.85, 0.85), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_tundra9mm2"] = { type = "Model", model = "models/cw2/attachments/9mmsuppressor.mdl", bone = "usp_main", rel = "", pos = Vector(7.3, -0.977, -0.82), angle = Angle(0, -90, 0), size = Vector(0.649, 0.649, 0.649), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_microt1kh"] = { type = "Model", model = "models/cw2/attachments/microt1.mdl", bone = "usp_main", rel = "", pos = Vector(1, -2, 0), angle = Angle(90, -90, 0), size = Vector(0.36, 0.36, 0.36), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_rail"] = { type = "Model", model = "models/cw2/attachments/pistolrail.mdl", bone = "usp_main", rel = "", pos = Vector(0.518, 0.518, 0), angle = Angle(0, -180, 90), size = Vector(0.144, 0.144, 0.144), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_rmr"] = { type = "Model", model = "models/cw2/attachments/pistolholo.mdl", bone = "usp_main", rel = "", pos = Vector(-3.5, 2.97, 0.33), angle = Angle(0, 0, -90), size = Vector(0.85, 0.85, 0.85), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_insight_x2"] = { type = "Model", model = "models/cw2/attachments/pistollaser.mdl", bone = "usp_main", rel = "", pos = Vector(1.8, -0.401, 0), angle = Angle(0, -180, 90), size = Vector(0.12, 0.12, 0.12), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
	
	SWEP.LaserPosAdjust = Vector(0, 0, -1.6)
	SWEP.LaserAngAdjust = Angle(0, 180, 0) 
end

SWEP.MuzzleVelocity = 420 -- in meter/s

SWEP.LuaViewmodelRecoil = false
SWEP.CanRestOnObjects = false

SWEP.Attachments = {[3] = {header = "Optic", offset = {250, -550}, atts = {"md_rmr", "kry_docter_sight", "md_microt1kh"}},
[2] = {header = "Barrel Extension", offset = {-450, -550}, atts = {"md_tundra9mm2"}},
[1] = {header = "Rail", offset = {-700, -160}, atts = {"md_insight_x2"}},
["+reload"] = {header = "Ammo", offset = {450, -150}, atts = {"am_magnum", "am_matchgrade"}}}

SWEP.Animations = {fire = {"shoot2_u"},
	reload = "reload_u",
	idle = "idle_u",
	draw = "draw_unsil"}
	
SWEP.Sounds = {reload_u = {[1] = {time = 0.40, sound = "SR1M_MAGOUT"},
	[2] = {time = 1.3, sound = "SR1M_MAGIN"},
	[3] = {time = 1.75, sound = "SR1M_SLIDEREL"}},
	
	draw_unsil = {[1] = {time = 0.3, sound = "SR1M_SLIDE2"}}}

SWEP.SpeedDec = 25

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
SWEP.ViewModel		= "models/khrcw2/v_khri_sr1.mdl"
SWEP.WorldModel		= "models/weapons/w_pist_p228.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 18
SWEP.Primary.DefaultClip	= 18
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "9x21MM"

SWEP.FireDelay = 0.109
SWEP.FireSound = "SR1M_FIRE"
SWEP.FireSoundSuppressed = "SR1M_FIRE_SUPPRESSED"
SWEP.Recoil = .8
SWEP.FOVPerShot = 0.25

SWEP.HipSpread = 0.052
SWEP.AimSpread = 0.008
SWEP.VelocitySensitivity = 1.05
SWEP.MaxSpreadInc = 0.07
SWEP.SpreadPerShot = 0.0055
SWEP.SpreadCooldown = 0.20
SWEP.Shots = 1
SWEP.Damage = 24
SWEP.DeployTime = 1.2
SWEP.ADSFireAnim = false

SWEP.ReloadSpeed = .9
SWEP.ReloadTime = 1.7
SWEP.ReloadHalt = 1.7

SWEP.ReloadTime_Empty = 2.3
SWEP.ReloadHalt_Empty = 2.3

SWEP.SnapToIdlePostReload = true

function SWEP:IndividualThink()
	self.EffectiveRange = 38.8 * 39.37
	self.DamageFallOff = .45
	
	if self.ActiveAttachments.md_tundra9mm2 then
	self.EffectiveRange = ((self.EffectiveRange - 11.64 * 39.37))
	self.DamageFallOff = ((self.DamageFallOff + .135))
	end
	if self.ActiveAttachments.am_matchgrade then
	self.EffectiveRange = ((self.EffectiveRange + 5.82 * 39.37))
	self.DamageFallOff = ((self.DamageFallOff - .0675))
	end
end