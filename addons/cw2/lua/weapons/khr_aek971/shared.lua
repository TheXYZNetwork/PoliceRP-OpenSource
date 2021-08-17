AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

	SWEP.magType = "arMag"
	SWEP.PrintName = "AEK-971"

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.CSMuzzleFlashes = true
	
	SWEP.IconLetter = "w"
	killicon.Add( "", "", Color(255, 80, 0, 150))
	
	SWEP.MuzzleEffect = "muzzleflash_ak47"
	SWEP.PosBasedMuz = true
	SWEP.ShellScale = 0.3
	SWEP.ShellDelay = .02
	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = -0, y = 0, z = 0}
	SWEP.ForeGripOffsetCycle_Draw = 0
	SWEP.ForeGripOffsetCycle_Reload = .85
	SWEP.ForeGripOffsetCycle_Reload_Empty = .85
	SWEP.SightWithRail = true
	SWEP.DisableSprintViewSimulation = false
	SWEP.SnapToIdlePostReload = true
	
	SWEP.EffectiveRange_Orig = 80.3 * 39.37
	SWEP.DamageFallOff_Orig = .33
	
	SWEP.BoltBone = "slide"
	SWEP.BoltBonePositionRecoverySpeed = 50
	SWEP.BoltShootOffset = Vector(-2, 0, 0)
	
	SWEP.IronsightPos = Vector(-2.66, -1.6667, 0.38)
	SWEP.IronsightAng = Vector(0.1, 0.6, 0)

	SWEP.CSGOACOGPos = Vector(-2.744, -2.5, -0.96)
	SWEP.CSGOACOGAng = Vector(0, 0, 0)

	SWEP.FAS2AimpointPos = Vector(-2.719, -2.5, -0.848)
	SWEP.FAS2AimpointAng = Vector(0, 0, 0)

	SWEP.EoTech553Pos = Vector(-2.725, -2.5, -1.056)
	SWEP.EoTech553Ang = Vector(0, 0, 0)

	SWEP.MicroT1Pos = Vector(-2.737, -2.5, -0.805)
	SWEP.MicroT1Ang = Vector(0, 0, 0)

	SWEP.KR_CMOREPos = Vector(-2.74, -2.5, -0.95)
	SWEP.KR_CMOREAng = Vector(0, 0, 0)

	SWEP.PSOPos = Vector(-2.5813, 0.5, -0.114)
	SWEP.PSOAng = Vector(0, 0, 0)

	SWEP.ShortDotPos = Vector(-2.7323, -2.5, -0.876)
	SWEP.ShortDotAng = Vector(0, 0, 0)

	SWEP.KobraPos = Vector(-2.695, -2.5, -0.15)
	SWEP.KobraAng = Vector(0, 0, 0)
	
	SWEP.AlternativePos = Vector(-0.5556, -0.4, -0.5556)
	SWEP.AlternativeAng = Vector(0, 0, 0)
	
	SWEP.SprintPos = Vector(0.5556, -0.5556, 0.5556)
	SWEP.SprintAng = Vector(-30, 34, -22)

	SWEP.BackupSights = {["md_acog"] = {[1] = Vector(-1.12, -1, -.73), [2] = Vector(0, 0, 0)}}
	SWEP.CustomizationMenuScale = 0.024
	SWEP.ViewModelMovementScale = 1
	
	SWEP.AttachmentModelsVM = {
    ["md_uecw_csgo_acog"] = { type = "Model", model = "models/gmod4phun/csgo/eq_optic_acog.mdl", bone = "Plane02", rel = "", pos = Vector(-5.7, 0.019, -0.47), angle = Angle(0, 0, 0), size = Vector(0.649, 0.649, 0.649), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_fas2_aimpoint"] = { type = "Model", model = "models/c_fas2_aimpoint.mdl", bone = "Plane02", rel = "", pos = Vector(1.557, 0.019, 1.85), angle = Angle(0, 0, 0), size = Vector(0.899, 0.899, 0.899), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["odec3d_cmore_kry"] = { type = "Model", model = "models/weapons/krycek/sights/odec3d_cmore_reddot.mdl", bone = "Plane02", rel = "", pos = Vector(-0.519, 0.109, 2.539), angle = Angle(0, 0, 0), size = Vector(0.209, 0.209, 0.209), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_pso1"] = { type = "Model", model = "models/cw2/attachments/pso.mdl", bone = "Plane02", rel = "", pos = Vector(-4.5, 0, -1), angle = Angle(0, -90, 0), size = Vector(0.649, 0.649, 0.649), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_pbs12"] = { type = "Model", model = "models/cw2/attachments/pbs1.mdl", bone = "Plane02", rel = "", pos = Vector(17, 0.239, -0.65), angle = Angle(0, -90, 0), size = Vector(0.699, 0.699, 0.699), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_microt1kh"] = { type = "Model", model = "models/cw2/attachments/microt1.mdl", bone = "Plane02", rel = "", pos = Vector(-0.801, 0.035, 2.569), angle = Angle(0, -90, 0), size = Vector(0.3, 0.3, 0.3), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_fas2_eotech"] = { type = "Model", model = "models/c_fas2_eotech.mdl", bone = "Plane02", rel = "", pos = Vector(1.957, 0.025, 2.059), angle = Angle(0, 0, 0), size = Vector(0.85, 0.85, 0.85), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_rail"] = { type = "Model", model = "models/wystan/attachments/akrailmount.mdl", bone = "Plane02", rel = "", pos = Vector(-0.601, 0.259, 0.8), angle = Angle(0, 90, 0), size = Vector(0.899, 0.899, 0.899), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_schmidt_shortdot"] = { type = "Model", model = "models/cw2/attachments/schmidt.mdl", bone = "Plane02", rel = "", pos = Vector(-4.676, 0.3, -1.53), angle = Angle(0, 0, 0), size = Vector(0.699, 0.699, 0.699), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_kobra"] = { type = "Model", model = "models/cw2/attachments/kobra.mdl", bone = "Plane02", rel = "", pos = Vector(-0.519, -0.371, -1.3), angle = Angle(0, -90, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_foregrip"] = { type = "Model", model = "models/wystan/attachments/foregrip1.mdl", bone = "Plane02", rel = "", pos = Vector(-1.9, 0.5, -2.3), angle = Angle(0, 90, 0), size = Vector(0.6, 0.6, 0.6), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}

	SWEP.ForeGripHoldPos = {
	["Left_Hand"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-1.111, -18.889, -16.667) },
	["Left_L_Arm"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-16.667, 12.222, 72.222) },
	["Left_U_Arm"] = { scale = Vector(1, 1, 1), pos = Vector(-4.259, 1.296, 2.778), angle = Angle(-16.667, 5.556, 3.332) }}
	
	SWEP.ACOGAxisAlign = {right = 0, up = 0, forward = 0}
	SWEP.SchmidtShortDotAxisAlign = {right = 0, up = 0, forward = 0}
	SWEP.PSO1AxisAlign = {right = 0, up = 0, forward = 90}
end

SWEP.MuzzleVelocity = 850 -- in meter/s
SWEP.LuaViewmodelRecoil = true
SWEP.CanRestOnObjects = true


SWEP.Attachments = {[3] = {header = "Sight", offset = {450, -400},  atts = {"md_microt1kh","md_kobra","odec3d_cmore_kry","md_fas2_eotech","md_fas2_aimpoint", "md_schmidt_shortdot", "md_uecw_csgo_acog", "md_pso1"}},
	[2] = {header = "Barrel", offset = {-50, -450}, atts = {"md_pbs12"}},
	[1] = {header = "Handguard", offset = {-400, -150}, atts = {"md_foregrip"}},
	["+reload"] = {header = "Ammo", offset = {-450, 250}, atts = {"am_magnum", "am_matchgrade"}}}

SWEP.Animations = {fire = {"shoot3", "shoot2", "shoot1"},
	reload = "reload",
	idle = "idle",
	draw = "draw"}
	
SWEP.Sounds = {	draw = {{time = .2, sound = "AEK.Draw"}},

	reload = {[1] = {time = .6, sound = "AEK.Clipout"},
	[2] = {time = 1, sound = "AEK.Clipin"},
	[3] = {time = 2, sound = "AEK.Boltpull"}}}

SWEP.HoldBoltWhileEmpty = false
SWEP.DontHoldWhenReloading = true
SWEP.LuaVMRecoilAxisMod = {vert = .75, hor = 1.25, roll = .35, forward = .25, pitch = 1.25}

SWEP.SpeedDec = 35

SWEP.Slot = 3
SWEP.SlotPos = 0
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"auto", "3burst", "semi"}
SWEP.Base = "cw_base"
SWEP.Category = "CW 2.0 - Rifles"

SWEP.Author			= "Khris"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""
SWEP.FireMoveMod = 1
SWEP.OverallMouseSens = .85
SWEP.ViewModelFOV	= 80
SWEP.AimViewModelFOV = 75
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/khrcw2/v_rif_aek97.mdl"
SWEP.WorldModel		= "models/khrcw2/w_rif_aek97.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 30
SWEP.Primary.DefaultClip	= 30
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "5.45x39MM"

SWEP.FireDelay = 60/800
SWEP.FireSound = "AEK.FIRE"
SWEP.FireSoundSuppressed = "AEK.SUPFIRE"
SWEP.Recoil = 1.15

SWEP.HipSpread = 0.050
SWEP.AimSpread = 0.0035
SWEP.VelocitySensitivity = 1.8
SWEP.MaxSpreadInc = 0.060
SWEP.SpreadPerShot = 0.007
SWEP.SpreadCooldown = 0.15
SWEP.Shots = 1
SWEP.Damage = 31
SWEP.DeployTime = 1
SWEP.RecoilToSpread = .8

SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 2.7
SWEP.ReloadTime_Empty = 2.7
SWEP.ReloadHalt = 2.7


SWEP.Offset = {
Pos = {
Up = 1,
Right = 0,
Forward = 0,
},
Ang = {
Up = 0,
Right = -10,
Forward = 180,
}
}

function SWEP:DrawWorldModel( )
        local hand, offset, rotate

        local pl = self:GetOwner()

        if IsValid( pl ) then
                        local boneIndex = pl:LookupBone( "ValveBiped.Bip01_R_Hand" )
                        if boneIndex then
                                local pos, ang = pl:GetBonePosition( boneIndex )
                                pos = pos + ang:Forward() * self.Offset.Pos.Forward + ang:Right() * self.Offset.Pos.Right + ang:Up() * self.Offset.Pos.Up

                                ang:RotateAroundAxis( ang:Up(), self.Offset.Ang.Up)
                                ang:RotateAroundAxis( ang:Right(), self.Offset.Ang.Right )
                                ang:RotateAroundAxis( ang:Forward(),  self.Offset.Ang.Forward )

                                self:SetRenderOrigin( pos )
                                self:SetRenderAngles( ang )
                                self:DrawModel()
                        end
        else
                self:SetRenderOrigin( nil )
                self:SetRenderAngles( nil )
                self:DrawModel()
        end
end
SWEP.ReloadHalt_Empty = 2.7

function SWEP:IndividualThink()
	self.EffectiveRange = 80.3 * 39.37
	self.DamageFallOff = .33
	
	if self.ActiveAttachments.md_pbs12 then
	self.EffectiveRange = ((self.EffectiveRange - 20.075 * 39.37))
	self.DamageFallOff = ((self.DamageFallOff + .0825))
	end
	if self.ActiveAttachments.am_matchgrade then
	self.EffectiveRange = ((self.EffectiveRange + 12.045 * 39.37))
	self.DamageFallOff = ((self.DamageFallOff - .0495))
	end
end