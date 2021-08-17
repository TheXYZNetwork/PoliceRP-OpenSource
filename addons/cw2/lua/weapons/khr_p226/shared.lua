AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

	SWEP.magType = "pistolMag"
	
	CustomizableWeaponry:registerAmmo(".357 SIG", ".357 SIG", 9, 22)
	SWEP.PrintName = "SIG P226"

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.CSMuzzleFlashes = true
	SWEP.SightWithRail = true
	
	SWEP.IconLetter = "y"
	killicon.Add( "khr_p226", "icons/killicons/khr_p226", Color(255, 80, 0, 150))
	SWEP.SelectIcon = surface.GetTextureID("icons/select/khr_p226")
	
	SWEP.MuzzleEffect = "muzzleflash_6"
	SWEP.PosBasedMuz = true
	
	SWEP.Shell = "smallshell"
	SWEP.ShellScale = .3
	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = 0, y = 0, z = 0}
	
	SWEP.EffectiveRange_Orig = 40.6 * 39.37
	SWEP.DamageFallOff_Orig = .42

	SWEP.IronsightPos = Vector(-2.273, 0, 1.075)
	SWEP.IronsightAng = Vector(0, 0.06, 0)
	
	SWEP.SprintPos = Vector(0, 0, 0)
	SWEP.SprintAng = Vector(-15.478, 11.96, 0)
	
	SWEP.RMRPos = Vector(-2.27, -4, .4)
	SWEP.RMRAng = Vector(0, 0, 0)
	
	SWEP.DocterPos = Vector(-2.285, -4, .41)
	SWEP.DocterAng = Vector(0, 0, 0)
	
	SWEP.MicroT1Pos = Vector(-2.3, -4, .165)
	SWEP.MicroT1Ang = Vector(0, 0, 0)
	
	SWEP.CustomizePos = Vector(1.679, -3.418, -1.321)
	SWEP.CustomizeAng = Vector(21.106, 18.995, 16.18)
	
	SWEP.AlternativePos = Vector(-.5, 0, .1)
	SWEP.AlternativeAng = Vector(0, 0, 0)

	
	SWEP.MoveType = 1
	SWEP.ViewModelMovementScale = 0.8
	SWEP.BoltBone = "slide"
	SWEP.BoltShootOffset = Vector(0, 0, -1)
	SWEP.BoltReloadOffset = Vector(0, 0, 1.2)
	SWEP.OffsetBoltDuringNonEmptyReload = true
	SWEP.BoltBonePositionRecoverySpeed = 9
	SWEP.ReloadBoltBonePositionRecoverySpeed = 9
	SWEP.ReloadBoltBonePositionMoveSpeed = 9
	SWEP.StopReloadBoneOffset = .65
	SWEP.HoldBoltWhileEmpty = true
	SWEP.DontHoldWhenReloading = true
	SWEP.DisableSprintViewSimulation = true
	
	SWEP.LuaVMRecoilAxisMod = {vert = .56, hor = .5, roll = .5, forward = 1.75, pitch = 2}
	SWEP.CustomizationMenuScale = 0.01
	
	SWEP.AttachmentModelsVM = {
    ["md_tundra9mm2"] = { type = "Model", model = "models/cw2/attachments/9mmsuppressor.mdl", bone = "weapon", pos = Vector(.04, -1.24, 6), angle = Angle(0, 180, 90), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_insight_x2"] = { type = "Model", model = "models/cw2/attachments/pistollaser.mdl", bone = "weapon", rel = "", pos = Vector(0, -1, 1.8), angle = Angle(-90, -90, 180), size = Vector(0.1, 0.1, 0.1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_rail"] = { type = "Model", model = "models/cw2/attachments/pistolrail.mdl", bone = "weapon", rel = "", pos = Vector(0.03, -0.5, 0.818), angle = Angle(-90, 0, -90), size = Vector(0.12, 0.12, 0.12), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["kry_docter_sight"] = { type = "Model", model = "models/weapons/krycek/sights/docter_reddot.mdl", bone = "weapon", rel = "", pos = Vector(0.023, -2.7, 1.857), angle = Angle(90, -90, 0), size = Vector(0.68, 0.68, 0.68), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_rmr"] = { type = "Model", model = "models/cw2/attachments/pistolholo.mdl", bone = "weapon", rel = "", pos = Vector(-.2, 1.1, -2.15), angle = Angle(90, 90, 180), size = Vector(0.629, 0.629, 0.629), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_microt1kh"] = { type = "Model", model = "models/cw2/attachments/microt1.mdl", bone = "weapon", rel = "", pos = Vector(0.02, -2.6, 1.25), angle = Angle(180, 0, -90), size = Vector(0.3, 0.3, 0.3), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
end

SWEP.MuzzleVelocity = 440 -- in meter/s

SWEP.LuaViewmodelRecoil = false
SWEP.CanRestOnObjects = false

SWEP.Attachments = {[1] = {header = "Rail", offset = {-700, 0}, atts = {"md_insight_x2"}},
[2] = {header = "Barrel Extension", offset = {-450, -520}, atts = {"md_tundra9mm2"}},
[3] = {header = "Optic", offset = {150, -400}, atts = {"md_rmr", "kry_docter_sight", "md_microt1kh"}},
["+reload"] = {header = "Ammo", offset = {350, -50}, atts = {"am_magnum", "am_matchgrade"}}}

	SWEP.LaserPosAdjust = Vector(0, -1, -1.2)
	SWEP.LaserAngAdjust = Angle(0, 180, 0) 

SWEP.Animations = {fire = {"shoot1","shoot2","shoot3"},
	reload = "reload",
	idle = "idle",
	draw = "draw"}
	
SWEP.Sounds = {draw = {{time = 0, sound = "K226_DRAW"}},

	reload = {[1] = {time = 0.20, sound = "K226_CLIPOUT"},
	[2] = {time = 1.2, sound = "K226_CLIPIN"},
	[3] = {time = 1.8, sound = "K226_SLIDEREL"}}}

SWEP.SpeedDec = 15

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
SWEP.ViewModel		= "models/khrcw2/v_khri_p226.mdl"
SWEP.WorldModel		= "models/weapons/w_pist_p228.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 12
SWEP.Primary.DefaultClip	= 12
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= ".357 SIG"

SWEP.FireDelay = 0.109
SWEP.FireSound = "K226_FIRE"
SWEP.FireSoundSuppressed = "K226_FIRE_SUPPRESSED"
SWEP.Recoil = 1
SWEP.FOVPerShot = 0.25

SWEP.HipSpread = 0.034
SWEP.AimSpread = 0.011
SWEP.VelocitySensitivity = 1
SWEP.MaxSpreadInc = 0.06
SWEP.SpreadPerShot = 0.0065
SWEP.SpreadCooldown = 0.21
SWEP.Shots = 1
SWEP.Damage = 26
SWEP.DeployTime = .5
SWEP.ADSFireAnim = false

SWEP.ReloadSpeed = .9
SWEP.ReloadTime = 1.5
SWEP.ReloadHalt = 1.5

SWEP.ReloadTime_Empty = 2.3
SWEP.ReloadHalt_Empty = 2.3

SWEP.SnapToIdlePostReload = true

function SWEP:IndividualThink()
	self.EffectiveRange = 40.6 * 39.37
	self.DamageFallOff = .42
	
	if self.ActiveAttachments.md_tundra9mm2 then
	self.EffectiveRange = ((self.EffectiveRange - 12.18 * 39.37))
	self.DamageFallOff = ((self.DamageFallOff + .126))
	end
	if self.ActiveAttachments.am_matchgrade then
	self.EffectiveRange = ((self.EffectiveRange + 6.09 * 39.37))
	self.DamageFallOff = ((self.DamageFallOff - .063))
	end
end