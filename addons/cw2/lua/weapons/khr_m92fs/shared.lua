AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

	SWEP.magType = "pistolMag"
	SWEP.PrintName = "M92FS"

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.CSMuzzleFlashes = true
	SWEP.SightWithRail = true
	
	SWEP.IconLetter = "y"
	killicon.Add( "khr_m92fs", "icons/killicons/khr_m92fs", Color(255, 80, 0, 150))
	SWEP.SelectIcon = surface.GetTextureID("icons/select/khr_m92fs")
	
	SWEP.MuzzleEffect = "muzzleflash_pistol"
	SWEP.PosBasedMuz = true
	
	SWEP.Shell = "smallshell"
	SWEP.ShellScale = .3
	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = 0, y = 0, z = 0}
	
	SWEP.EffectiveRange_Orig = 37 * 39.37
	SWEP.DamageFallOff_Orig = .45
	
	SWEP.IronsightPos = Vector(-1.841, 1, 0.75)
	SWEP.IronsightAng = Vector(-0.47, 0, 0)
	
	SWEP.SprintPos = Vector(0, 0, 0)
	SWEP.SprintAng = Vector(-15.478, 11.96, 0)
	
	SWEP.RMRPos = Vector(-1.836, -3, .08)
	SWEP.RMRAng = Vector(-0.401, -0, 0)
	
	SWEP.DocterPos = Vector(-1.85, -3, .11)
	SWEP.DocterAng = Vector(-0.401, -0, 0)
	
	SWEP.MicroT1Pos = Vector(-1.85, -3, -.125)
	SWEP.MicroT1Ang = Vector(-0.401, -0, 0)
	
	SWEP.CustomizePos = Vector(1.679, -3.418, -1.321)
	SWEP.CustomizeAng = Vector(21.106, 18.995, 16.18)
	
	SWEP.AlternativePos = Vector(-0.4, 0, -.2)
	SWEP.AlternativeAng = Vector(0, 0, 0)

	
	SWEP.MoveType = 1
	SWEP.ViewModelMovementScale = 0.8
	SWEP.BoltBone = "slide"
	SWEP.BoltBonePositionRecoverySpeed = 35 
	SWEP.BoltShootOffset = Vector(0, 0, -1.3)
	SWEP.BoltReloadOffset = Vector(0, 0, 1.3)
	SWEP.OffsetBoltDuringNonEmptyReload = true
	SWEP.EmptyBoltHoldAnimExclusion = "shoot_empty"
	SWEP.ReloadBoltBonePositionRecoverySpeed = 20
	SWEP.ReloadBoltBonePositionMoveSpeed = 999
	SWEP.StopReloadBoneOffset = .8
	SWEP.HoldBoltWhileEmpty = true
	SWEP.DontHoldWhenReloading = true
	SWEP.DisableSprintViewSimulation = true
	
	SWEP.LuaVMRecoilAxisMod = {vert = .45, hor = .5, roll = .5, forward = 1.5, pitch = 1.75}
	SWEP.CustomizationMenuScale = 0.009 -- how fast does the bolt bone move back into it's initial position after the weapon has fired
	
	SWEP.AttachmentModelsVM = {
    ["md_tundra9mm2"] = { type = "Model", model = "models/cw2/attachments/9mmsuppressor.mdl", bone = "weapon", pos = Vector(0, -1.923, 6), angle = Angle(0, 0, 90), size = Vector(0.49, 0.49, 0.49), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_insight_x2"] = { type = "Model", model = "models/cw2/attachments/pistollaser.mdl", bone = "weapon", rel = "", pos = Vector(0, -0.719, 1.557), angle = Angle(-90, -90, 180), size = Vector(0.09, 0.09, 0.09), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_rail"] = { type = "Model", model = "models/cw2/attachments/pistolrail.mdl", bone = "weapon", rel = "", pos = Vector(0, 0.1, 0.518), angle = Angle(-90, 0, -90), size = Vector(0.115, 0.115, 0.115), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["kry_docter_sight"] = { type = "Model", model = "models/weapons/krycek/sights/docter_reddot.mdl", bone = "weapon", rel = "", pos = Vector(-0.01, -2, 1.557), angle = Angle(90, -90, 0), size = Vector(0.68, 0.68, 0.68), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_rmr"] = { type = "Model", model = "models/cw2/attachments/pistolholo.mdl", bone = "weapon", rel = "", pos = Vector(-0.229, 1.789, -2.497), angle = Angle(90, 90, 180), size = Vector(0.629, 0.629, 0.629), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_microt1kh"] = { type = "Model", model = "models/cw2/attachments/microt1.mdl", bone = "weapon", rel = "", pos = Vector(0.004, -1.9, 0.919), angle = Angle(180, 0, -90), size = Vector(0.3, 0.3, 0.3), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
end

SWEP.MuzzleVelocity = 380 -- in meter/s

SWEP.LuaViewmodelRecoil = true
SWEP.CanRestOnObjects = false

SWEP.Attachments = {[1] = {header = "Rail", offset = {-700, -140}, atts = {"md_insight_x2"}},
[2] = {header = "Barrel Extension", offset = {-350, -550}, atts = {"md_tundra9mm2"}},
[3] = {header = "Optic", offset = {150, -450}, atts = {"md_rmr", "kry_docter_sight", "md_microt1kh"}},
["+reload"] = {header = "Ammo", offset = {350, -50}, atts = {"am_magnum", "am_matchgrade"}}}

	SWEP.LaserPosAdjust = Vector(0, -1, -1.2)
	SWEP.LaserAngAdjust = Angle(0, 180, 0) 

SWEP.Animations = {fire = {"fire"},
	reload = "reload_empty",
	idle = "idle",
	draw = "draw"}
	
SWEP.Sounds = {draw = {{time = 0.35, sound = "M92FS_DEPLOY"}},

	reload_empty = {[1] = {time = 0.20, sound = "M92FS_CLIPOUT"},
	[2] = {time = 1.2, sound = "M92FS_CLIPIN"},
	[3] = {time = 2.25, sound = "M92FS_SLIDE"}}}

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

SWEP.ViewModelFOV	= 70
SWEP.AimViewModelFOV = 65
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/khrcw2/v_khri_m92f.mdl"
SWEP.WorldModel		= "models/weapons/w_pist_elite_single.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 15
SWEP.Primary.DefaultClip	= 15
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "9x19MM"

SWEP.FireDelay = 0.1
SWEP.FireSound = "M92FS_FIRE"
SWEP.FireSoundSuppressed = "M92FS_FIRE_SUPPRESSED"
SWEP.Recoil = .70
SWEP.FOVPerShot = 0.2

SWEP.HipSpread = 0.038
SWEP.AimSpread = 0.0115
SWEP.VelocitySensitivity = 1
SWEP.MaxSpreadInc = 0.06
SWEP.SpreadPerShot = 0.0065
SWEP.SpreadCooldown = 0.21
SWEP.Shots = 1
SWEP.Damage = 22
SWEP.DeployTime = .7
SWEP.ADSFireAnim = false

SWEP.ReloadSpeed = 1.35
SWEP.ReloadTime = 2
SWEP.ReloadHalt = 2

SWEP.ReloadTime_Empty = 3
SWEP.ReloadHalt_Empty = 3

SWEP.SnapToIdlePostReload = true

function SWEP:IndividualThink()
	self.EffectiveRange = 37 * 39.37
	self.DamageFallOff = .45
	
	if self.ActiveAttachments.md_tundra9mm2 then
	self.EffectiveRange = ((self.EffectiveRange - 11.1 * 39.37))
	self.DamageFallOff = ((self.DamageFallOff + .135))
	end
	if self.ActiveAttachments.am_matchgrade then
	self.EffectiveRange = ((self.EffectiveRange + 5.55 * 39.37))
	self.DamageFallOff = ((self.DamageFallOff - .0675))
	end
end