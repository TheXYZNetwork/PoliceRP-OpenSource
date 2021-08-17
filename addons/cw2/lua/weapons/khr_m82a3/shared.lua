AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

	SWEP.magType = "srMag"
	
	CustomizableWeaponry:registerAmmo(".50 BMG", ".50 BMG Rounds", 12.7, 99)
	CustomizableWeaponry:registerAmmo(".416 Barrett", ".416 Barrett Rounds", 10.6, 83)
	SWEP.PrintName = "M82A3"

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.CSMuzzleFlashes = true
	
	SWEP.IconLetter = "w"
	killicon.Add( "khr_m82a3", "icons/killicons/khr_m82a3", Color(255, 80, 0, 150))
	SWEP.SelectIcon = surface.GetTextureID("icons/killicons/khr_m82a3")
	
	SWEP.MuzzleEffect = "muzzle_center_M82"
	SWEP.PosBasedMuz = true
	SWEP.NoDistance = true
	SWEP.CrosshairEnabled = false
	SWEP.ShellScale = 0.5
	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = 0, y = 0, z = 0}
	SWEP.SightWithRail = false
	SWEP.DisableSprintViewSimulation = false
	SWEP.SnapToIdlePostReload = true
	
	SWEP.EffectiveRange_Orig = 335.7 * 39.37
	SWEP.DamageFallOff_Orig = .21
	
	SWEP.BoltBone = "bolt"
	SWEP.BoltBonePositionRecoverySpeed = 35
	SWEP.BoltShootOffset = Vector(-7.5, 0, 0)
	
	SWEP.IronsightPos = Vector(-2.158, -1, 0.779)
	SWEP.IronsightAng = Vector(-0.33, 0.09, 0)
	
	SWEP.SprintPos = Vector(4.119, -1.206, -3.12)
	SWEP.SprintAng = Vector(-12.664, 50.652, -13.367)
	
	SWEP.MicroT1Pos = Vector(-2.180, -2.5, 0.81)
	SWEP.MicroT1Ang = Vector(0, 0, 0)
	
	SWEP.EoTech553Pos = Vector(-2.180, -2.5, 0.51)
	SWEP.EoTech553Ang = Vector(0, 0, 0)	
	
	SWEP.KR_CMOREPos =  Vector(-2.180, -2.5, 0.645)
	SWEP.KR_CMOREAng =  Vector(0, 0, 0)
	
	SWEP.ELCANPos = Vector(-2.1867, -2.5, 0.574)
	SWEP.ELCANAng = Vector(0, 0, 0)
	
	SWEP.FAS2AimpointPos = Vector(-2.175, -2.5, 0.74)
	SWEP.FAS2AimpointAng = Vector(0, 0, 0)
	
	SWEP.CSGOACOGPos = Vector(-2.181, -2.5, 0.536)
	SWEP.CSGOACOGAng = Vector(0, 0, 0)
	
	SWEP.NXSPos = Vector(-2.191, -1.5, 0.569)
	SWEP.NXSAng = Vector(0, 0, 0)
	
	SWEP.ShortDotPos = Vector(-2.180, -2, 0.67)
	SWEP.ShortDotAng = Vector(0, 0, 0)
	
	SWEP.CustomizePos = Vector(4.239, 0, -3.441)
	SWEP.CustomizeAng = Vector(18.215, 18.291, 11.96)
	
	SWEP.AlternativePos = Vector(0, 1, 0)
	SWEP.AlternativeAng = Vector(0, 0, 0)

	SWEP.CustomizationMenuScale = 0.028
	SWEP.ViewModelMovementScale = 1.2
	
	SWEP.AttachmentModelsVM = {
	
	["md_uecw_csgo_acog"] = { type = "Model", model = "models/gmod4phun/csgo/eq_optic_acog.mdl", bone = "body", rel = "", pos = Vector(-2.3, -0.7, -0.024), angle = Angle(0, 0, -90), size = Vector(0.699, 0.699, 0.699), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["odec3d_cmore_kry"] = { type = "Model", model = "models/weapons/krycek/sights/odec3d_cmore_reddot.mdl", bone = "body", rel = "", pos = Vector(3.4, -3.941, 0.07), angle = Angle(0, 0, -90), size = Vector(0.2, 0.2, 0.2), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_nightforce_nxs"] = { type = "Model", model = "models/cw2/attachments/l96_scope.mdl", bone = "body", rel = "", pos = Vector(3.599, -4.801, 0.109), angle = Angle(0, 0, -90), size = Vector(0.899, 0.899, 0.899), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_fas2_aimpoint"] = { type = "Model", model = "models/c_fas2_aimpoint.mdl", bone = "body", rel = "", pos = Vector(5.199, -3.29, 0), angle = Angle(0, 0, -90), size = Vector(0.85, 0.85, 0.85), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_fas2_eotech"] = { type = "Model", model = "models/c_fas2_eotech.mdl", bone = "body", rel = "", pos = Vector(5.699, -3.461, 0), angle = Angle(0, 0, -90), size = Vector(0.85, 0.85, 0.85), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_schmidt_shortdot"] = { type = "Model", model = "models/cw2/attachments/schmidt.mdl", bone = "body", rel = "", pos = Vector(-0.92, 0.119, 0.27), angle = Angle(0, 0, -90), size = Vector(0.699, 0.699, 0.699), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_elcan"] = { type = "Model", model = "models/bunneh/elcan.mdl", bone = "body", rel = "", pos = Vector(-0.401, 0, 0.259), angle = Angle(-90, 0, -90), size = Vector(0.66, 0.66, 0.66), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_microt1kh"] = { type = "Model", model = "models/cw2/attachments/microt1.mdl", bone = "body", rel = "", pos = Vector(2.7, -3.951, 0.006), angle = Angle(90, -90, 0), size = Vector(0.28, 0.28, 0.28), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_sight_front"] = { type = "Model", model = "models/bunneh/frontsight.mdl", bone = "body", rel = "", pos = Vector(10.899, -4.75, 2.234), angle = Angle(0, 0, -90), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_sight_rear"] = { type = "Model", model = "models/bunneh/rearsight.mdl", bone = "body", rel = "", pos = Vector(-5.651, -4.75, 2.249), angle = Angle(0, 0, -90), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}



	SWEP.ACOGAxisAlign = {right = 0.2, up = 0, forward = 0}
	SWEP.NXSAlign = {right = 0, up = 0, forward = 0}
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

SWEP.MuzzleVelocity = 850 -- in meter/s
SWEP.LuaViewmodelRecoil = true
SWEP.LuaViewmodelRecoilOverride = true
SWEP.BipodFireAnim =  true
SWEP.BipodInstalled = true
SWEP.CanRestOnObjects = false


SWEP.Attachments = {[1] = {header = "Optic", offset = {600, -100},  atts = {"md_microt1kh","odec3d_cmore_kry","md_fas2_eotech","md_fas2_aimpoint", "md_schmidt_shortdot", "md_uecw_csgo_acog", "md_nightforce_nxs"}},
["+reload"] = {header = "Ammo", offset = {-250, 350}, atts = {"am_416barrett"}}}

SWEP.Animations = {fire = {"shoot"},
	reload = "reload",
	idle = "idle1",
	draw = "draw"}
	
SWEP.Sounds = {	draw = {[1] = {time = 0, sound = "K82.DRAW"}},

	reload = {[1] = {time = .25, sound = "K82.BOLTB"},
	[2] = {time = 1.4, sound = "K82.CLIPOUT"},
	[3] = {time = 2.55, sound = "K82.CLIPIN"},
	[4] = {time = 3.4, sound = "K82.BOLTF"}}}

SWEP.HoldBoltWhileEmpty = false
SWEP.DontHoldWhenReloading = true
SWEP.ADSFireAnim = false
SWEP.LuaVMRecoilAxisMod = {vert = .5, hor = 3.5, roll = .25, forward = .8, pitch = .5}

SWEP.SpeedDec = 55

SWEP.Slot = 4
SWEP.SlotPos = 0
SWEP.OverallMouseSens = .7
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"semi"}
SWEP.Base = "cw_base"
SWEP.Category = "CW 2.0 - Ranged Rifles"

SWEP.Author			= "Khris"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.AimViewModelFOV = 65
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/khrcw2/v_cjs_bf4_m82a3.mdl"
SWEP.WorldModel		= "models/khrcw2/w_cjs_bf4_m82a3.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 10
SWEP.Primary.DefaultClip	= 10
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= ".50 BMG"

SWEP.FireDelay = 60/180
SWEP.FireSound = "K82.FIRE"
SWEP.Recoil = 3.9

SWEP.HipSpread = 0.1
SWEP.AimSpread = 0.0022
SWEP.VelocitySensitivity = 2
SWEP.MaxSpreadInc = 0.6
SWEP.SpreadPerShot = 0.08
SWEP.SpreadCooldown = 0.5
SWEP.Shots = 1
SWEP.Damage = 175
SWEP.DeployTime = 1

SWEP.ReloadSpeed = .9
SWEP.ReloadTime = 4.3
SWEP.ReloadTime_Empty = 4.3
SWEP.ReloadHalt = 4.3
SWEP.ReloadHalt_Empty = 4.3


SWEP.Offset = {
Pos = {
Up = 0,
Right = 0,
Forward = 0,
},
Ang = {
Up = 0,
Right = -5,
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

function SWEP:IndividualThink()
	self.EffectiveRange = 335.7 * 39.37
	self.DamageFallOff = .21
	
	if self.ActiveAttachments.am_416barrett then
	self.EffectiveRange = ((self.EffectiveRange - 55.39 * 39.37))
	self.DamageFallOff = ((self.DamageFallOff - .084))
	end
end