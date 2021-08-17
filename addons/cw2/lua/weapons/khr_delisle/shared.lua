AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

	SWEP.magType = "arMag"
	SWEP.PrintName = "De Lisle Carbine"

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.CSMuzzleFlashes = true
	
	SWEP.IconLetter = "w"
	killicon.Add( "", "", Color(255, 80, 0, 150))
	
	SWEP.DrawTraditionalWorldModel = false
	SWEP.WM = "models/khrcw2/w_khri_delisle.mdl"
	SWEP.WMPos = Vector(-1, 1.5, 0)
	SWEP.WMAng = Vector(-5, 0, 180)
	
	SWEP.MuzzleEffect = "muzzleflash_suppressed"
	SWEP.PosBasedMuz = true
	SWEP.Shell = "smallshell"
	SWEP.ShellScale = 0.55
	SWEP.FireMoveMod = 2
	SWEP.ShellDelay = .5
	SWEP.SightWithRail = false
	SWEP.DisableSprintViewSimulation = false
	
	SWEP.EffectiveRange_Orig = 40.2 * 39.37
	SWEP.DamageFallOff_Orig = .41

	SWEP.IronsightPos = Vector(2.03, -2, 0.2)
	SWEP.IronsightAng = Vector(0.7, -0.05, 0)
	
	SWEP.SG1Pos = Vector(2.03, -2, 0.2)
	SWEP.SG1Ang = Vector(0.7, -0.05, 0)
	
	SWEP.CustomizePos = Vector(-3.8889, -1.6667, -1.6667)
	SWEP.CustomizeAng = Vector(18, -30, -10)
	
	SWEP.SprintPos = Vector(-1.6667, 1.6667, -0.5556)
	SWEP.SprintAng = Vector(-14, -26, 6)
	
	SWEP.AlternativePos = Vector(0.2, 0, -0.4)
	SWEP.AlternativeAng = Vector(0, 0, 0)

	SWEP.CustomizationMenuScale = 0.025
	SWEP.ViewModelMovementScale = 1
	
	SWEP.ACOGAxisAlign = {right = 0, up = 0, forward = 0}
	SWEP.PSO1AxisAlign = {right = 0, up = 0, forward = 90}
	SWEP.SchmidtShortDotAxisAlign = {right = 1, up = 0, forward = 0}
end

SWEP.SightBGs = {main = 2, scope = 1, none = 0}

SWEP.MuzzleVelocity = 255 -- in meter/s
SWEP.LuaViewmodelRecoil = false
SWEP.CanRestOnObjects = true


SWEP.Attachments = {--[1] = {header = "Sight", offset = {600, -400},  atts = {"bg_delislescope"}},
	["+reload"] = {header = "Ammo", offset = {-300, 400}, atts = {"am_magnum", "am_matchgrade"}}}

SWEP.Animations = {fire = {"shoot2"},
	reload = "reloadnon",
	reload_empty = "reload",
	idle = "idle",
	draw = "draw"}
	
SWEP.Sounds = {	shoot2 = {{time = .2, sound = "DELISLE_BOLT"}},

    draw = {{time = 0, sound = "AEK.Draw"}},

	reload = {[1] = {time = 0, sound = "KSKS.Cloth"},
	[2] = {time = .6, sound = "DELISLE_MAGOUT"},
	[3] = {time = 2.2, sound = "DELISLE_MAGIN1"},
	[4] = {time = 2.5, sound = "DELISLE_MAGIN2"},
	[5] = {time = 3.5, sound = "DELISLE_BOLT"}},
	
	reloadnon = {[1] = {time = 0, sound = "KSKS.Cloth"},
	[2] = {time = .6, sound = "DELISLE_MAGOUT"},
	[3] = {time = 2.2, sound = "DELISLE_MAGIN1"},
	[4] = {time = 2.5, sound = "DELISLE_MAGIN2"}}}

SWEP.ADSFireAnim = true
SWEP.LuaVMRecoilAxisMod = {vert = 1, hor = .5, roll = .25, forward = .75, pitch = 1.5}

SWEP.SpeedDec = 25

SWEP.OverallMouseSens = 1
SWEP.Slot = 3
SWEP.SlotPos = 0
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"bolt"}
SWEP.Base = "cw_base"
SWEP.Category = "CW 2.0 - Rifles"

SWEP.Author			= "Khris"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 75
SWEP.AimViewModelFOV = 70
SWEP.ViewModelFlip	= true
SWEP.ViewModel		= "models/khrcw2/v_khri_delisle.mdl"
SWEP.WorldModel		= "models/khrcw2/w_khri_delisle.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 11
SWEP.Primary.DefaultClip	= 11
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= ".45 ACP"
SWEP.ForceBackToHipAfterAimedShot = true
SWEP.ForcedHipWaitTime = .9

SWEP.FireDelay = 1.1
SWEP.FireSound = "DELISLE_FIRE"
SWEP.Recoil = .5

SWEP.HipSpread = 0.047
SWEP.AimSpread = 0.0007
SWEP.VelocitySensitivity = .9
SWEP.MaxSpreadInc = 0.055
SWEP.SpreadPerShot = 0.02
SWEP.SpreadCooldown = 1.2
SWEP.Shots = 1
SWEP.Damage = 65
SWEP.DeployTime = 1

SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 3.6
SWEP.ReloadTime_Empty = 4.6
SWEP.ReloadHalt = 3.6
SWEP.ReloadHalt_Empty = 4.6

function SWEP:IndividualThink()
	self.EffectiveRange = 40.2 * 39.37
	self.DamageFallOff = .41
	
	if self.ActiveAttachments.am_matchgrade then
	self.EffectiveRange = ((self.EffectiveRange + 8.04 * 39.37))
	self.DamageFallOff = ((self.DamageFallOff - .082))
	end
end