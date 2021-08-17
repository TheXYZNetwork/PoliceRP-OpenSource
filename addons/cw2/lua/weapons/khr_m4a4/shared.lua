AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")
	SWEP.PrintName = "M4A4"

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.CSMuzzleFlashes = true
	
	SWEP.IconLetter = ""
	killicon.AddFont("", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))
	
	SWEP.MuzzleEffect = "muzzleflash_pistol"
	SWEP.PosBasedMuz = true
	SWEP.MuzzleAtachment = 1
	SWEP.ShellScale = 0.2
	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = 0, y = 0, z = 0}
	SWEP.ForeGripOffsetCycle_Draw = 0
	SWEP.ForeGripOffsetCycle_Reload = .85
	SWEP.ForeGripOffsetCycle_Reload_Empty = .85
	SWEP.SightWithRail = true
	SWEP.DisableSprintViewSimulation = false
	SWEP.SnapToIdlePostReload = true
	
	SWEP.EffectiveRange_Orig = 97.5 * 39.37
	SWEP.DamageFallOff_Orig = .26
	
	SWEP.IronsightPos = Vector(-2.15, -2, 0.372)
	SWEP.IronsightAng = Vector(-0.4, 0.109, 1.111)

	SWEP.MicroT1Pos = Vector(-2.74, -4, 1.032)
	SWEP.MicroT1Ang = Vector(0, -0.5, 0)
	
	SWEP.EoTech553Pos = Vector(-1.121, -1, -0.15)
	SWEP.EoTech553Ang = Vector(0.4, 0, 0)	
	
	SWEP.CSGOACOGPos = Vector(-1.113, 0, -0.003)
	SWEP.CSGOACOGAng = Vector(0, 0, 0)
	
	SWEP.FAS2AimpointPos = Vector(-1.133, -1, 0.1)
	SWEP.FAS2AimpointAng = Vector(0, 0, 0)
	
	SWEP.AlternativePos = Vector(-0.48, 0, -0.16)
	SWEP.AlternativeAng = Vector(0, 0, 0)
	
	SWEP.CustomizePos = Vector(3.119, 0, -1.081)
	SWEP.CustomizeAng = Vector(20.402, 26.03, 15.477)
	
	SWEP.SprintPos = Vector(0.479, 0, -0.401)
	SWEP.SprintAng = Vector(-11.961, 25.326, -12.664)

	SWEP.CustomizationMenuScale = 0.013
	SWEP.ViewModelMovementScale = 1
	
	SWEP.AttachmentModelsVM = {
	["md_foregrip"] = { type = "Model", model = "models/wystan/attachments/foregrip1.mdl", bone = "weapon", rel = "", pos = Vector(-0.419, 0, -1.558), angle = Angle(0, 0, -90), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_saker222"] = { type = "Model", model = "models/cw2/attachments/556suppressor.mdl", bone = "weapon", rel = "", pos = Vector(0, -0.301, 1.899), angle = Angle(0, 0, -90), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_anpeq15"] = { type = "Model", model = "models/cw2/attachments/anpeq15.mdl", bone = "weapon", rel = "", pos = Vector(-0.101, -2.3, 3), angle = Angle(-90, 90, 0), size = Vector(0.379, 0.379, 0.379), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
	

	SWEP.ForeGripHoldPos = {
	["l_wrist"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(3.332, 3.332, -14.445) },
	["l_index_low"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(3.332, -1.111, 38.888) },
	["l_thumb_low"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(7.777, -23.334, 38.888) },
	["l_thumb_mid"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-14.445, 0, 0) },
	["l_forearm"] = { scale = Vector(1, 1, 1), pos = Vector(0.555, -0.556, 0), angle = Angle(23.333, -1.111, 0) }}
	
	
end

SWEP.LaserPosAdjust = Vector(-.4, -3, 0)--{x = 1, y = 0, z = 0}
SWEP.LaserAngAdjust = Angle(0, 179.8, 0) --{p = 2, y = 180, r = 0}

SWEP.LuaViewmodelRecoil = true
SWEP.CanRestOnObjects = true


SWEP.Attachments = {[2] = {header = "Handguard", offset = {-500, 0}, atts = {"md_foregrip"}},
	[1] = {header = "Barrel", offset = {-250, -400}, atts = {"md_saker222"}},
	[3] = {header = "Rail", offset = {250, -400}, atts = {"md_anpeq15"}},
	["+reload"] = {header = "Ammo", offset = {-700, 350}, atts = {"am_magnum", "am_matchgrade"}}}

SWEP.Animations = {fire = {"fire_1","fire_2","fire_3"},
	reload = "reload_1",
	idle = "origin",
	draw = "draw_1"}
	
SWEP.Sounds = {draw_1 = {{time = 0, sound = "M4A4.Boltpull"}},

	reload_1 = {[1] = {time = 0, sound = "M4A4.Cloth"},
	[2] = {time = .3, sound = "M4A4.Magout"},
	[3] = {time = 1.1, sound = "M4A4.Magin"},
	[4] = {time = 1.8, sound = "M4A4.Boltpull"}}}

SWEP.HoldBoltWhileEmpty = true
SWEP.DontHoldWhenReloading = true
SWEP.LuaVMRecoilAxisMod = {vert = .55, hor = .25, roll = .35, forward = .75, pitch = 1}

SWEP.SpeedDec = 30

SWEP.Slot = 3
SWEP.SlotPos = 0
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"auto", "semi"}
SWEP.Base = "cw_base"
SWEP.Category = "CW 2.0 - Rifles"

SWEP.Author			= "Khris"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.AimViewModelFOV = 60
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/weapons/v_khr_m4a4c.mdl"
SWEP.WorldModel		= "models/weapons/w_rif_m4a1.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 30
SWEP.Primary.DefaultClip	= 30
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "5.56x45MM"

SWEP.FireDelay = 60/850
SWEP.FireSound = "M4A4.FIRE"
SWEP.FireSoundSuppressed = "M4A4.FIRE.SUPPRESSED"
SWEP.Recoil = 1.06
SWEP.OverallMouseSens = .9
SWEP.HipSpread = 0.047
SWEP.AimSpread = 0.0033
SWEP.VelocitySensitivity = 1.5
SWEP.MaxSpreadInc = .053
SWEP.SpreadPerShot = 0.0058
SWEP.SpreadCooldown = .1
SWEP.Shots = 1
SWEP.Damage = 38
SWEP.DeployTime = .8
SWEP.RecoilToSpread = .5

SWEP.ReloadSpeed = .9
SWEP.ReloadTime = 2.7
SWEP.ReloadTime_Empty = 2.7
SWEP.ReloadHalt = 2.7
SWEP.ReloadHalt_Empty = 2.7

function SWEP:IndividualThink()
	self.EffectiveRange = 97.5 * 39.37
	self.DamageFallOff = .26
	
	if self.ActiveAttachments.md_saker222 then
	self.EffectiveRange = ((self.EffectiveRange - 24.375 * 39.37))
	self.DamageFallOff = ((self.DamageFallOff + .065))
	end
	if self.ActiveAttachments.am_matchgrade then
	self.EffectiveRange = ((self.EffectiveRange + 14.625 * 39.37))
	self.DamageFallOff = ((self.DamageFallOff - .039))
	end
end