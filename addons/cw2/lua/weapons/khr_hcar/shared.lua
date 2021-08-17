AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

	SWEP.magType = "brMag"
	SWEP.PrintName = "HCAR"

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1.1
	
	SWEP.IconLetter = "w"
	killicon.Add( "khr_hcar", "icons/killicons/khr_hcar", Color(255, 80, 0, 150))
	SWEP.SelectIcon = surface.GetTextureID("icons/killicons/khr_hcar")
	
	SWEP.MuzzleEffect = "muzzleflash_m14"
	SWEP.PosBasedMuz = true
	SWEP.SnapToGrip = true
	SWEP.ShellScale = 0.35
	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = 0, y = 0, z = 0}
	SWEP.ForeGripOffsetCycle_Draw = 0
	SWEP.ForeGripOffsetCycle_Reload = .9
	SWEP.ForeGripOffsetCycle_Reload_Empty = .9
	SWEP.FireMoveMod = 2
	SWEP.CustomizationMenuScale = 0.021
	
	SWEP.EffectiveRange_Orig = 189.5 * 39.37
	SWEP.DamageFallOff_Orig = .22
	
	SWEP.IronsightPos = Vector(-2.717, -4, 0.439)
	SWEP.IronsightAng = Vector(.2, .05, 0)
	
	SWEP.FoldsightPos = Vector(-2.717, -4, 0.439)
	SWEP.FoldsightAng = Vector(.3, .05, 0)
	
    SWEP.EoTech553Pos = Vector(-2.701, -5, 0.449)
	SWEP.EoTech553Ang = Vector(0.4, 0, 0)	
	
	SWEP.CSGOACOGPos = Vector(-2.7076, -4, 0.512)
	SWEP.CSGOACOGAng = Vector(0, 0, 0)
	
	SWEP.KR_CMOREPos =  Vector(-2.701, -5, 0.4)
	SWEP.KR_CMOREAng =  Vector(0.4, 0, 0)	
	
	SWEP.ShortDotPos = Vector(-2.7076, -4, 0.512)
	SWEP.ShortDotAng = Vector(0, 0, 0)
	
	SWEP.FAS2AimpointPos = Vector(-2.704, -5, 0.654)
	SWEP.FAS2AimpointAng = Vector(0, 0, 0)
	
	SWEP.CustomizePos = Vector(3.119, -5, -2.081)
	SWEP.CustomizeAng = Vector(20.402, 26.03, 15.477)
	
	SWEP.SprintPos = Vector(1.786, -5, -1)
	SWEP.SprintAng = Vector(-20.778, 27.573, 0)
	
	SWEP.M203Pos = Vector(-0.562, -2.481, 0.24)
	SWEP.M203Ang = Vector(0, 0, 0)

	SWEP.SightWithRail = false
	SWEP.ADSFireAnim = false
	
	SWEP.AlternativePos = Vector(-.619, -3, -.04)
	SWEP.AlternativeAng = Vector(0, 0, 0)

	SWEP.AttachmentModelsVM = {
	    ["md_m203"] = {model = "models/cw2/attachments/m203.mdl", bone = "weapon", pos = Vector(-1.897, 6.752, 2.397), angle = Angle(0, 90, 0), size = Vector(0.899, 0.8, 0.899)},
	    ["md_saker222"] = {model = "models/cw2/attachments/556suppressor.mdl", bone = "weapon", pos = Vector(-0.06, -3.8, -1.961), angle = Angle(0, 180, 0), size = Vector(0.699, 0.699, 0.699)},
	    ["md_anpeq15"] = {model = "models/cw2/attachments/anpeq15.mdl", bone = "weapon", pos = Vector(0, -8.11, 0.865), angle = Angle(0, -90, 0), size = Vector(0.37, 0.37, 0.37)},
		["md_fas2_aimpoint"] = {model = "models/c_fas2_aimpoint.mdl", bone = "weapon", pos = Vector(-0.051, -2, 0.379), angle = Angle(0, 90, 0), size = Vector(0.85, 0.85, 0.85)},
		["md_uecw_csgo_acog"] = {model = "models/gmod4phun/csgo/eq_optic_acog.mdl", bone = "weapon", pos = Vector(-0.08, 5, -1.991), angle = Angle(0, 90, 0), size = Vector(0.649, 0.649, 0.649)},
		["md_fas2_eotech"] = {model = "models/c_fas2_eotech.mdl", bone = "weapon", pos = Vector(-0.06, -2.597, 0.518), angle = Angle(0, 90, 0), size = Vector(0.85, 0.85, 0.85)},
		["md_microt1"] = {model = "models/cw2/attachments/microt1.mdl", bone = "weapon", pos = Vector(-.032, 1, 1.06), angle = Angle(0, 0, 0), size = Vector(0.3, 0.3, 0.3)},
		["md_foregrip"] = {model = "models/wystan/attachments/foregrip1.mdl", bone = "weapon", pos = Vector(.4, 2.5, -3.5), angle = Angle(0, 180, 0), size = Vector(0.65, 0.65, 0.65)},
		["md_bipod"] = { type = "Model", model = "models/wystan/attachments/bipod.mdl", bone = "weapon", rel = "", pos = Vector(0.105, -11, -2.06), angle = Angle(0, 0, 0), size = Vector(.8, .8, .8), color = Color(255, 255, 255, 0), bodygroup = {1,1}},
		["odec3d_cmore_kry"] = { type = "Model", model = "models/weapons/krycek/sights/odec3d_cmore_reddot.mdl", bone = "weapon", rel = "", pos = Vector(0.029, -0.32, 1.049), angle = Angle(0, 90, 0), size = Vector(0.23, 0.23, 0.23), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["md_schmidt_shortdot"] = { type = "Model", model = "models/cw2/attachments/schmidt.mdl", bone = "weapon", rel = "", pos = Vector(0.218, 3.635, -2.76), angle = Angle(0, 90, 0), size = Vector(0.649, 0.649, 0.649), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}

	SWEP.ForeGripHoldPos = {
		["biped_fing23.1"] = {pos = Vector(0, 0, 0), angle = Angle(-7.778, 0, -54.445) },
		["biped_fing53.l"] = {pos = Vector(0, 0, 0), angle = Angle(0, 0, -45.556) },
		["biped_clav.l"] = {pos = Vector(-0.186, -13.889, 3.148), angle = Angle(-14.445, -7.778, 54.444) },
		["biped_fing13.l"] = {pos = Vector(0, 0, 0), angle = Angle(0, 0, 21.111) },
		["biped_fing11.l"] = {pos = Vector(0, 0, 0), angle = Angle(10, 0, 0) },
		["biped_fing22.l"] = {pos = Vector(0, 0, 0), angle = Angle(14.444, -7.778, -21.112) },
		["biped_fing51.l"] = {pos = Vector(0, 0, 0), angle = Angle(-10, 18.888, -63.334) },
		["biped_fing42.l"] = {pos = Vector(0, 0, 0), angle = Angle(0, 0, -58.889) },
		["biped_fing33.l"] = {pos = Vector(0, 0, 0), angle = Angle(0, 3.332, -61.112) },
		["biped_fing21.l"] = {pos = Vector(0, 0, 0), angle = Angle(0, 5.556, -12.223) },
		["biped_hand.l"] = {pos = Vector(0, 0, 0), angle = Angle(32.222, 18.888, 23.333) },
		["biped_fing12.l"] = {pos = Vector(0, 0, 0), angle = Angle(12.222, 1.11, 21.111) },
		["biped_fing31.l"] = {pos = Vector(0, 0, 0), angle = Angle(-1.111, -3.333, 3.332) }
	
	}
	
	SWEP.ACOGAxisAlign = {right = 0, up = 0, forward = 0}
	SWEP.SchmidtShortDotAxisAlign = {right = 1, up = 90, forward = 0}
 
	SWEP.LuaVMRecoilAxisMod = {vert = 1, hor = 0, roll = 1, forward = 0, pitch = 1}
end

	SWEP.M203HoldPos = {
		["biped_shoulder.l"] = { scale = Vector(1, 1, 1), pos = Vector(-2.76, 2.651, 1.386), angle = Angle(0, 0, 0) }
	}

SWEP.M203CameraRotation = {p = -90, y = 0, r = -90}
	
SWEP.LaserPosAdjust = Vector(0.1, 0, 0)--{x = 1, y = 0, z = 0}
SWEP.LaserAngAdjust = Angle(0, 180, 0) --{p = 2, y = 180, r = 0}

SWEP.LuaViewmodelRecoil = true

SWEP.Attachments = {[1] = {header = "Sight", offset = {900, -250},  atts = {"bg_hcarfoldsight", "odec3d_cmore_kry", "md_fas2_eotech", "md_fas2_aimpoint", "md_uecw_csgo_acog"}},
    [5] = {header = "Rail", offset = {-350, -500}, atts = {"md_anpeq15"}},
	[2] = {header = "Barrel", offset = {400, -600}, atts = {"md_muzl", "md_saker222"}},
	[6] = {header = "Bolt", offset = {350, -100}, atts = {"md_lightbolt"}},
	[3] = {header = "Handguard", offset = {-700, -150}, atts = {"md_foregrip","md_bipod"}},
	[4] = {header = "Magazine", offset = {-650, 250}, atts = {"bg_3006extmag"}},
	["+reload"] = {header = "Ammo", offset = {1000, 150}, atts = {"am_magnum", "am_matchgrade"}}}

SWEP.Animations = {fire = {"shoot1", "shoot2", "shoot3"},
	reload = "reload",
	idle = "idle",
	draw = "draw"}
	
SWEP.Sounds = {draw = {{time = 0, sound = "HCar.Rattle1"}},

	
	reload = {[1] = {time = 0, sound = "HCar.Rattle1"},
	[2] = {time = 0.4, sound = "HCar.Clipout"},
	[3] = {time = 1.95, sound = "HCar.Clipin"},
	[4] = {time = 2.54, sound = "HCar.Boltslap"}}}
	
SWEP.SpeedDec = 55

SWEP.Slot = 3
SWEP.SlotPos = 0
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"auto", "semi"}
SWEP.Base = "cw_base"
SWEP.Category = "CW 2.0 - Ranged Rifles"

SWEP.Author			= "Khris"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.OverallMouseSens = .75
SWEP.ViewModelFOV	= 80
SWEP.AimViewModelFOV = 75
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/weapons/hcar.mdl"
SWEP.WorldModel		= "models/weapons/w_snip_g3sg1.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true


SWEP.Primary.ClipSize		= 20
SWEP.Primary.DefaultClip	= 20
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= ".30-06"

SWEP.FireDelay = 60/450
SWEP.FireSound = "CW_HCAR_FIRE"
SWEP.FireSoundSuppressed = "CW_HCAR_FIRE_SUPPRESSED"
SWEP.Recoil = 1.9
SWEP.FOVPerShot = .8

SWEP.RailBGs = {main = 3, on = 1, off = 0}
SWEP.BipodBGs = {main = 4, on = 1, off = 0}
SWEP.SightBGs = {main = 2, sg1 = 1, none = 0}

SWEP.HipSpread = 0.092
SWEP.AimSpread = 0.002
SWEP.VelocitySensitivity = 2.5
SWEP.MaxSpreadInc = 0.06
SWEP.SpreadPerShot = 0.015
SWEP.SpreadCooldown = 0.2
SWEP.Shots = 1
SWEP.Damage = 55
SWEP.DeployTime = .5
SWEP.RecoilToSpread = .5

SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 3
SWEP.ReloadTime_Empty = 3
SWEP.ReloadHalt = 3
SWEP.ReloadHalt_Empty = 3

function SWEP:IndividualThink()
	self.EffectiveRange = 189.5 * 39.37
	self.DamageFallOff = .22
	self.RecoilToSpread = .8
	
	if self.ActiveAttachments.md_saker222 then
	self.EffectiveRange = ((self.EffectiveRange - 47.375 * 39.37))
	self.DamageFallOff = ((self.DamageFallOff + .055))
	end
	if self.ActiveAttachments.md_lightbolt then
	self.RecoilToSpread = ((self.RecoilToSpread + .4))
	end
	if self.ActiveAttachments.am_matchgrade then
	self.EffectiveRange = ((self.EffectiveRange * 1.15))
	self.DamageFallOff = ((self.DamageFallOff * .85))
	end
end