AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

	SWEP.magType = "srMag"
	SWEP.PrintName = "SR-338"

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.CSMuzzleFlashes = true
	
	SWEP.IconLetter = "w"
	killicon.Add( "", "", Color(255, 80, 0, 150))
	
	SWEP.OverallMouseSens = .7
	SWEP.MuzzleEffect = "muzzleflash_m14"
	SWEP.PosBasedMuz = true
	SWEP.NoDistance = true
	SWEP.CrosshairEnabled = false
	SWEP.ShellScale = 0.42
	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = -0, y = 0, z = 0}
	SWEP.ForeGripOffsetCycle_Draw = 0
	SWEP.ForeGripOffsetCycle_Reload = .85
	SWEP.ForeGripOffsetCycle_Reload_Empty = .85
	SWEP.SightWithRail = true
	SWEP.DisableSprintViewSimulation = false
	SWEP.SnapToIdlePostReload = true
	
	SWEP.EffectiveRange_Orig = 213.4 * 39.37
	SWEP.DamageFallOff_Orig = .21
	
	SWEP.BoltBone = "Bolt"
	SWEP.BoltBonePositionRecoverySpeed = 30
	SWEP.BoltShootOffset = Vector(-4, 0, 0)
	
	SWEP.SprintPos = Vector(4.119, -1.206, -3.12)
	SWEP.SprintAng = Vector(-12.664, 50.652, -13.367)
	
	SWEP.CSGOACOGPos = Vector(-3.0852, -2.5, 0.496)
	SWEP.CSGOACOGAng = Vector(0, 0, 0)

	SWEP.EoTech553Pos = Vector(-3.1, -2.5, 0.467)
	SWEP.EoTech553Ang = Vector(0, 0, 0)

	SWEP.FAS2AimpointPos = Vector(-3.067, -2.5, 0.706)
	SWEP.FAS2AimpointAng = Vector(0, 0, 0)

	SWEP.MicroT1Pos = Vector(-3.1, -2.5, 0.71)
	SWEP.MicroT1Ang = Vector(0, 0, 0)

	SWEP.KR_CMOREPos = Vector(-3.09, -2.5, 0.58)
	SWEP.KR_CMOREAng = Vector(0, 0, 0)

	SWEP.IronsightPos = Vector(-3.112, -1, 0.46)
	SWEP.IronsightAng = Vector(-0.4, 0.028, 0)

	SWEP.ShortDotPos = Vector(-3.0735, -2, 0.6)
	SWEP.ShortDotAng = Vector(0, 0, 0)

	SWEP.NXSPos = Vector(-3.091, -2.5, 0.603)
	SWEP.NXSAng = Vector(0, 0, 0)

	
	SWEP.CustomizePos = Vector(1.72, -4.02, -3.08)
	SWEP.CustomizeAng = Vector(23.92, 20.884, 6.884)
	
	SWEP.AlternativePos = Vector(-0.6711, -0.6711, 0)
	SWEP.AlternativeAng = Vector(0, 0, 0)

	SWEP.CustomizationMenuScale = 0.024
	SWEP.ViewModelMovementScale = 1
	
	SWEP.AttachmentModelsVM = {
	["md_sight_front"] = { type = "Model", model = "models/bunneh/frontsight.mdl", bone = "RSASS", rel = "", pos = Vector(-0.274, -28.4, 0), angle = Angle(0, -90, 0), size = Vector(1.25, 1.25, 1.25), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_fas2_aimpoint"] = { type = "Model", model = "models/c_fas2_aimpoint.mdl", bone = "RSASS", rel = "", pos = Vector(2.44, -9.601, -2.171), angle = Angle(0, 90, 0), size = Vector(1.1, 1.1, 1.1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["odec3d_cmore_kry"] = { type = "Model", model = "models/weapons/krycek/sights/odec3d_cmore_reddot.mdl", bone = "RSASS", rel = "", pos = Vector(2.559, -7.292, -1.321), angle = Angle(0, 90, 0), size = Vector(0.259, 0.259, 0.259), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_bipod"] = { type = "Model", model = "models/wystan/attachments/bipod.mdl", bone = "RSASS", rel = "", pos = Vector(2.549, -16.105, -3.636), angle = Angle(0, 180, 0), size = Vector(0.8, 0.8, 0.8), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_sight_rear"] = { type = "Model", model = "models/bunneh/rearsight.mdl", bone = "RSASS", rel = "", pos = Vector(5.309, 2.519, -0.01), angle = Angle(0, 90, 0), size = Vector(1.25, 1.25, 1.25), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_nxs"] = { type = "Model", model = "models/cw2/attachments/l96_scope.mdl", bone = "RSASS", rel = "", pos = Vector(2.569, -9, -0.35), angle = Angle(0, 90, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_microt1kh"] = { type = "Model", model = "models/cw2/attachments/microt1.mdl", bone = "RSASS", rel = "", pos = Vector(2.47, -7.792, -1.3), angle = Angle(0, 0, 0), size = Vector(0.4, 0.4, 0.4), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_fas2_eotech"] = { type = "Model", model = "models/c_fas2_eotech.mdl", bone = "RSASS", rel = "", pos = Vector(2.47, -9.832, -1.871), angle = Angle(0, 90, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_uecw_csgo_acog"] = { type = "Model", model = "models/gmod4phun/csgo/eq_optic_acog.mdl", bone = "RSASS", rel = "", pos = Vector(2.423, -1.341, -5.261), angle = Angle(0, 90, 0), size = Vector(0.85, 0.85, 0.85), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_schmidt_shortdot"] = { type = "Model", model = "models/cw2/attachments/schmidt.mdl", bone = "RSASS", rel = "", pos = Vector(2.789, -2.5, -6.531), angle = Angle(0, 90, 0), size = Vector(0.899, 0.899, 0.899), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_foregrip"] = { type = "Model", model = "models/wystan/attachments/foregrip1.mdl", bone = "RSASS", rel = "", pos = Vector(2.2, -23.378, -4.901), angle = Angle(0, 0, 0), size = Vector(0.6, 0.6, 0.6), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_saker222"] = { type = "Model", model = "models/cw2/attachments/556suppressor.mdl", bone = "RSASS", rel = "", pos = Vector(2.49, -12.4, -4.45), angle = Angle(0, 180, 0), size = Vector(0.699, 0.699, 0.699), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_anpeq15"] = { type = "Model", model = "models/cw2/attachments/anpeq15.mdl", bone = "RSASS", rel = "", pos = Vector(2.589, -16.026, -1.481), angle = Angle(0, -90, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

	SWEP.ForeGripHoldPos = {
	["l_wrist"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-5.557, 14.444, 5.556) },
	["l_upperarm"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-1.111, -1.111, 12.222) },
	["l_armtwist_1"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, -23.334) },
	["l_forearm"] = { scale = Vector(1, 1, 1), pos = Vector(1.896, 0.555, -0.556), angle = Angle(0, -3.333, 36.666) },
	["l_thumb_low"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(16.666, 14.444, 27.777) }
	
	}

	SWEP.ACOGAxisAlign = {right = 0.2, up = 0, forward = 0}
	SWEP.NXSAlign = {right = 0.2, up = 0, forward = 0}
	SWEP.SchmidtShortDotAxisAlign = {right = 0, up = 0, forward = 0}
	
	function SWEP:RenderTargetFunc()

	
	if self.AimPos != self.IronsightPos then -- if we have a sight/scope equiped, hide the front and rar sights
	self.AttachmentModelsVM.md_sight_front.active = false
	self.AttachmentModelsVM.md_sight_rear.active = false
	else
	self.AttachmentModelsVM.md_sight_front.active = true
	self.AttachmentModelsVM.md_sight_rear.active = true
	end

end
	
end

SWEP.MuzzleVelocity = 925 -- in meter/s

SWEP.LaserPosAdjust = Vector(-.7, 0, 0)--{x = 1, y = 0, z = 0}
SWEP.LaserAngAdjust = Angle(0, 180, 0) --{p = 2, y = 180, r = 0}

SWEP.LuaViewmodelRecoil = true
SWEP.CanRestOnObjects = false


SWEP.Attachments = {[4] = {header = "Optic", offset = {600, -400},  atts = {"md_microt1kh","odec3d_cmore_kry","md_fas2_eotech","md_fas2_aimpoint", "md_uecw_csgo_acog", "md_nxs"}},
[3] = {header = "Barrel", offset = {180, -400}, atts = {"md_saker222"}},
[1] = {header = "Handguard", offset = {-650, 100}, atts = {"md_foregrip","md_bipod"}},
[2] = {header = "Rail", offset = {-550, -350}, atts = {"md_anpeq15"}},
["+reload"] = {header = "Ammo", offset = {-400, 500}, atts = {"am_magnum","am_matchgrade"}}}

SWEP.Animations = {fire = {"shoot", "shoot2"},
	reload = "reload",
	idle = "idle1",
	draw = "draw"}
	
SWEP.Sounds = {	a = {[1] = {time = 0, sound = "CW_FOLEY_MEDIUM"}},

	reload = {[1] = {time = .6, sound = "SR338.Clipout"},
	[2] = {time = 1.8, sound = "SR338.Clipin"},
	[3] = {time = 2.25, sound = "SR338.Bolt"}}}

SWEP.HoldBoltWhileEmpty = false
SWEP.DontHoldWhenReloading = true
SWEP.LuaVMRecoilAxisMod = {vert = 1, hor = 1, roll = .25, forward = .25, pitch = 1}

SWEP.SpeedDec = 45

SWEP.Slot = 4
SWEP.SlotPos = 0
SWEP.OverallMouseSens = .8
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"semi"}
SWEP.Base = "cw_base"
SWEP.Category = "CW 2.0 - Ranged Rifles"

SWEP.Author			= "Khris"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 80
SWEP.AimViewModelFOV = 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/khrcw2/v_snip_sr338.mdl"
SWEP.WorldModel		= "models/weapons/w_snip_g3sg1.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 10
SWEP.Primary.DefaultClip	= 10
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= ".338 Lapua"

SWEP.FireDelay = 60/300
SWEP.FireSound = "SR338_FIRE"
SWEP.FireSoundSuppressed = "SR338_SUPFIRE"
SWEP.Recoil = 2.5

SWEP.HipSpread = 0.08
SWEP.AimSpread = 0.0013
SWEP.VelocitySensitivity = 1.9
SWEP.MaxSpreadInc = 0.065
SWEP.SpreadPerShot = 0.015
SWEP.SpreadCooldown = 0.33
SWEP.RecoilToSpread = 1
SWEP.Shots = 1
SWEP.Damage = 80
SWEP.DeployTime = .8

SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 2.9
SWEP.ReloadTime_Empty = 2.9
SWEP.ReloadHalt = 2.9
SWEP.ReloadHalt_Empty = 2.9

function SWEP:IndividualThink()
	self.EffectiveRange = 213.4 * 39.37
	self.DamageFallOff = .21
	
	if self.ActiveAttachments.md_saker222 then
	self.EffectiveRange = ((self.EffectiveRange - 70.42 * 39.37))
	self.DamageFallOff = ((self.DamageFallOff + .0693))
	end
	if self.ActiveAttachments.am_matchgrade then
	self.EffectiveRange = ((self.EffectiveRange + 32.01 * 39.37))
	self.DamageFallOff = ((self.DamageFallOff - .0315))
	end
end