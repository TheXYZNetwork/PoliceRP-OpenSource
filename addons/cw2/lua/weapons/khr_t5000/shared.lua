AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

	SWEP.magType = "srMag"
	SWEP.PrintName = "Orsis T-5000"

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.CSMuzzleFlashes = true
	
	SWEP.IconLetter = "w"
	killicon.Add( "khr_t5000", "icons/killicons/khr_t5000", Color(255, 80, 0, 150))
	SWEP.SelectIcon = surface.GetTextureID("icons/killicons/khr_t5000")
	
	SWEP.MuzzleEffect = "muzzleflash_g3"
	SWEP.PosBasedMuz = true
	SWEP.NoDistance = true
	SWEP.BipodFireAnim = false
	SWEP.CrosshairEnabled = false
	SWEP.ShellScale = 0.65
	SWEP.ShellDelay = .55
	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = -2, y = -2, z = 0}
	SWEP.SightWithRail = false
	SWEP.DisableSprintViewSimulation = false
	SWEP.SnapToIdlePostReload = true
	SWEP.ReticleInactivityPostFire = 1.3
	
	SWEP.EffectiveRange_Orig = 227.8 * 39.37
	SWEP.DamageFallOff_Orig = .21
	
	SWEP.IronsightPos = Vector(-3.151, -2, 0.529)
	SWEP.IronsightAng = Vector(0.95, 0.02, 0)
	
	SWEP.SprintPos = Vector(1.929, -1.407, -1.04)
	SWEP.SprintAng = Vector(-14.775, 25.326, -8.443)
	
	SWEP.MicroT1Pos = Vector(-3.14, -3, 0.66)
	SWEP.MicroT1Ang = Vector(0, 0, 0)
	
	SWEP.EoTech553Pos = Vector(-3.145, -3, 0.405)
	SWEP.EoTech553Ang = Vector(0, 0, 0)	
	
	SWEP.KR_CMOREPos =  Vector(-3.13, -3, 0.48)
	SWEP.KR_CMOREAng =  Vector(0, 0, 0)
	
	SWEP.FAS2AimpointPos = Vector(-3.135, -3, 0.735)
	SWEP.FAS2AimpointAng = Vector(0, 0, 0)
	
	SWEP.CSGOACOGPos = Vector(-3.13, -2, 0.507)
	SWEP.CSGOACOGAng = Vector(0, 0, 0)
	
	SWEP.NXSPos = Vector(-3.1456, -2, 0.5592)
	SWEP.NXSAng = Vector(0, 0, 0)

	SWEP.ShortDotPos = Vector(-3.14, -2, 0.5733)
	SWEP.ShortDotAng = Vector(0, 0, 0)
	
	SWEP.CustomizePos = Vector(3.72, 0, -0.801)
	SWEP.CustomizeAng = Vector(13.366, 22.513, 14.069)
	
	SWEP.AlternativePos = Vector(-.2, 0, -0.2)
	SWEP.AlternativeAng = Vector(0, 0, 0)

	SWEP.CustomizationMenuScale = 0.03
	SWEP.ViewModelMovementScale = 1
	
	SWEP.AttachmentModelsVM = {
	
	["md_uecw_csgo_acog"] = { type = "Model", model = "models/gmod4phun/csgo/eq_optic_acog.mdl", bone = "base", rel = "", pos = Vector(0.045, -3, -0.357), angle = Angle(0, -90, 0), size = Vector(0.8, 0.8, 0.8), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_nxs"] = { type = "Model", model = "models/cw2/attachments/l96_scope.mdl", bone = "base", rel = "", pos = Vector(-0.11, 4.675, 4.32), angle = Angle(0, -90, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_fas2_aimpoint"] = { type = "Model", model = "models/c_fas2_aimpoint.mdl", bone = "base", rel = "", pos = Vector(0, 5.3, 2.569), angle = Angle(0, -90, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["odec3d_cmore_kry"] = { type = "Model", model = "models/weapons/krycek/sights/odec3d_cmore_reddot.mdl", bone = "base", rel = "", pos = Vector(-0.08, 3.299, 3.349), angle = Angle(0, -90, 0), size = Vector(0.27, 0.27, 0.27), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_microt1kh"] = { type = "Model", model = "models/cw2/attachments/microt1.mdl", bone = "base", rel = "", pos = Vector(0, 2.599, 3.4), angle = Angle(0, 180, 0), size = Vector(0.379, 0.379, 0.379), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_shortdot"] = { type = "Model", model = "models/cw2/attachments/schmidt.mdl", bone = "base", rel = "", pos = Vector(-0.341, -1.8, -1.88), angle = Angle(0, -90, 0), size = Vector(0.899, 0.899, 0.899), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_fas2_eotech"] = { type = "Model", model = "models/c_fas2_eotech.mdl", bone = "base", rel = "", pos = Vector(0, 5.9, 2.799), angle = Angle(0, -90, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["rearsight"] = { type = "Model", model = "models/bunneh/rearsight.mdl", bone = "base", rel = "", pos = Vector(-2.271, -4.566, 4.375), angle = Angle(0, -90, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["frontsight"] = { type = "Model", model = "models/bunneh/frontsight.mdl", bone = "base", rel = "", pos = Vector(2.2, 32.338, 3.9), angle = Angle(0, 90, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}


	SWEP.ACOGAxisAlign = {right = 0, up = 0, forward = 0}
	SWEP.NXSAlign = {right = 0, up = 0, forward = 0}
	SWEP.SchmidtShortDotAxisAlign = {right = 0, up = 0, forward = 0}
	
	
	function SWEP:RenderTargetFunc()

	
	if self.AimPos != self.IronsightPos then -- if we have a sight/scope equiped, hide the front and rar sights
	self.AttachmentModelsVM.frontsight.active = false
	self.AttachmentModelsVM.rearsight.active = false
	else
	self.AttachmentModelsVM.frontsight.active = true
	self.AttachmentModelsVM.rearsight.active = true
	end
	
end

end

SWEP.MuzzleVelocity = 920 -- in meter/s

SWEP.LuaViewmodelRecoil = true
SWEP.FullAimViewmodelRecoil = false
SWEP.LuaViewmodelRecoilOverride = true	
SWEP.CanRestOnObjects = true
SWEP.BipodFireAnim =  true
SWEP.Chamberable = false
SWEP.ADSFireAnim = true

SWEP.BipodBGs = {main = 1, on = 1, off = 0}

SWEP.Attachments = {[2] = {header = "Optic", offset = {400, -400},  atts = {"md_microt1kh","odec3d_cmore_kry","md_fas2_eotech","md_fas2_aimpoint","md_shortdot","md_uecw_csgo_acog","md_nxs"}},
[1] = {header = "Bipod", offset = {-600, -200},  atts = {"bg_bipod"}},
["+reload"] = {header = "Ammo", offset = {-250, 250}, atts = {"am_magnum","am_matchgrade"}}}

SWEP.Animations = {fire = {"fire"},
	reload = "reload",
	idle = "idle",
	draw = "draw"}
	
SWEP.Sounds = {	fire = {[1] = {time = .4, sound = "T50.BOLTUP"},
[2] = {time = .5, sound = "T50.BOLTB"},
[3] = {time = .72, sound = "T50.BOLTF"},
[4] = {time = .82, sound = "T50.BOLTDOWN"}},

	draw = {[1] = {time = 0, sound = "T50.DRAW"}},

	reload = {[1] = {time = .05, sound = "T50.BOLTUP"},
	[2] = {time = .2, sound = "T50.BOLTB"},
	[3] = {time = .95, sound = "T50.MAGOUT"},
	[4] = {time = 2.15, sound = "T50.MAGIN"},
	[5] = {time = 2.9, sound = "T50.BOLTF"},
	[6] = {time = 3.05, sound = "T50.BOLTDOWN"}}}

SWEP.LuaVMRecoilAxisMod = {vert = 1.5, hor = 3.5, roll = .25, forward = .5, pitch = 1.5}

SWEP.SpeedDec = 35

SWEP.Slot = 4
SWEP.SlotPos = 0
SWEP.OverallMouseSens = .8
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"bolt"}
SWEP.Base = "cw_base"
SWEP.Category = "CW 2.0 - Ranged Rifles"

SWEP.Author			= "Khris"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 75
SWEP.AimViewModelFOV = 65
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/khrcw2/v_khri_t50.mdl"
SWEP.WorldModel		= "models/khrcw2/w_khri_t50.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 5
SWEP.Primary.DefaultClip	= 5
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= ".338 Lapua"

SWEP.FireDelay = 1.3
SWEP.FireSound = "T50.FIRE"
SWEP.Recoil = 2.75

SWEP.HipSpread = 0.07
SWEP.AimSpread = 0.0008
SWEP.VelocitySensitivity = 1.7
SWEP.MaxSpreadInc = 0.6
SWEP.SpreadPerShot = 0.08
SWEP.SpreadCooldown = 0.2
SWEP.Shots = 1
SWEP.Damage = 90
SWEP.DeployTime = .6

SWEP.ReloadSpeed = 1.1
SWEP.ReloadTime = 3.5
SWEP.ReloadTime_Empty = 3.5
SWEP.ReloadHalt = 3.5
SWEP.ReloadHalt_Empty = 3.5


SWEP.Offset = {
Pos = {
Up = -.9,
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

function SWEP:IndividualThink()
	self.EffectiveRange = 227.8 * 39.37
	self.DamageFallOff = .21
	
	if self.ActiveAttachments.am_matchgrade then
	self.EffectiveRange = ((self.EffectiveRange + 34.17 * 39.37))
	self.DamageFallOff = ((self.DamageFallOff - .0315))
	end
end