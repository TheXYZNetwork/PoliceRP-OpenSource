AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

	SWEP.magType = "srMag"
	SWEP.PrintName = "M95"

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.CSMuzzleFlashes = true
	
	SWEP.IconLetter = "w"
	killicon.Add( "khr_m82a3", "icons/killicons/khr_m82a3", Color(255, 80, 0, 150))
	
	SWEP.MuzzleEffect = "muzzle_center_M82"
	SWEP.PosBasedMuz = true
	SWEP.NoDistance = true
	SWEP.ShellScale = 0.55
	SWEP.ShellOffsetMul = 1
	SWEP.ShellDelay = .9
	SWEP.ShellPosOffset = {x = 0, y = 0, z = 0}
	SWEP.SightWithRail = false
	SWEP.DisableSprintViewSimulation = false
	SWEP.SnapToIdlePostReload = true
	SWEP.CrosshairEnabled = false
	SWEP.ReticleInactivityPostFire = 1.3
	
	SWEP.EffectiveRange_Orig = 335.7 * 39.37
	SWEP.DamageFallOff_Orig = .21
	
	SWEP.IronsightPos = Vector(-3.129, -1, 0.62)
	SWEP.IronsightAng = Vector(-0.7, 0.25, 0)
	
	SWEP.SprintPos = Vector(4.119, -1.206, -3.12)
	SWEP.SprintAng = Vector(-12.664, 50.652, -13.367)

	SWEP.CSGOACOGPos = Vector(-3.112, -1.5, 0.577)
	SWEP.CSGOACOGAng = Vector(0, 0, 0)

	SWEP.NXSPos = Vector(-3.1597, -.5, 0.652)
	SWEP.NXSAng = Vector(0, 0, 0)

	SWEP.ShortDotPos = Vector(-3.094, -1.5, 0.8)
	SWEP.ShortDotAng = Vector(0, 0, 0)

	SWEP.FAS2AimpointPos = Vector(-3.14, -2.5, 0.91)
	SWEP.FAS2AimpointAng = Vector(0, 0, 0)
	
	SWEP.CustomizePos = Vector(4.239, 0, -3.441)
	SWEP.CustomizeAng = Vector(23.215, 18.291, 11.96)
	
	SWEP.AlternativePos = Vector(-1, 1, 0)
	SWEP.AlternativeAng = Vector(0, 0, 0)

	SWEP.CustomizationMenuScale = 0.028
	SWEP.ViewModelMovementScale = 1.5
	
	SWEP.AttachmentModelsVM = {
	["md_uecw_csgo_acog"] = { type = "Model", model = "models/gmod4phun/csgo/eq_optic_acog.mdl", bone = "M95", rel = "", pos = Vector(-3.231, 1, -6.356), angle = Angle(0, -90, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_nightforce_nxs"] = { type = "Model", model = "models/cw2/attachments/l96_scope.mdl", bone = "M95", rel = "", pos = Vector(-3.451, 9.699, -0.52), angle = Angle(0, -90, 0), size = Vector(1.25, 1.25, 1.25), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_fas2_aimpoint"] = { type = "Model", model = "models/c_fas2_aimpoint.mdl", bone = "M95", rel = "", pos = Vector(-3.3, 11.947, -2.671), angle = Angle(0, -90, 0), size = Vector(1.2, 1.2, 1.2), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_schmidt_shortdot"] = { type = "Model", model = "models/cw2/attachments/schmidt.mdl", bone = "M95", rel = "", pos = Vector(-3.636, 2.674, -7.56), angle = Angle(0, -90, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_sight_front"] = { type = "Model", model = "models/bunneh/frontsight.mdl", bone = "M95", rel = "", pos = Vector(-0.257, 25.7, -0.24), angle = Angle(0, 90, 0), size = Vector(1.399, 1.399, 1.399), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_sight_rear"] = { type = "Model", model = "models/bunneh/rearsight.mdl", bone = "M95", rel = "", pos = Vector(-6.476, -1.8, -0.24), angle = Angle(0, -90, 0), size = Vector(1.399, 1.399, 1.399), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}



	SWEP.ACOGAxisAlign = {right = 0, up = 0, forward = 0}
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
SWEP.CanRestOnObjects = false

SWEP.BipodBGs = {main = 1, on = 1, off = 0}


SWEP.Attachments = {[2] = {header = "Optic", offset = {600, -200},  atts = {"md_fas2_aimpoint", "md_schmidt_shortdot", "md_uecw_csgo_acog", "md_nightforce_nxs"}},
[1] = {header = "Bipod", offset = {-600, -200},  atts = {"bg_bipod"}},
["+reload"] = {header = "Ammo", offset = {-250, 500}, atts = {"am_416barrett"}}}

SWEP.Animations = {fire = {"fire"},
	reload = "reload",
	idle = "idle",
	draw = "draw"}
	
SWEP.Sounds = {	fire = {[1] = {time = .6, sound = "K95.BOLTB"},
[2] = {time = .8, sound = "K95.BOLTF"}},

    draw = {{time = .2, sound = "K95.DRAW"}},

	reload = {[1] = {time = .5, sound = "K95.BOLTB"},
	[2] = {time = 1, sound = "K82.CLIPOUT"},
	[3] = {time = 2.2, sound = "K82.CLIPIN"},
	[4] = {time = 2.7, sound = "K95.BOLTF"}}}

SWEP.HoldBoltWhileEmpty = false
SWEP.DontHoldWhenReloading = true
SWEP.ADSFireAnim = true
SWEP.LuaVMRecoilAxisMod = {vert = .5, hor = 3.5, roll = .25, forward = .8, pitch = .5}
SWEP.ForceBackToHipAfterAimedShot = true

SWEP.SpeedDec = 45

SWEP.Slot = 4
SWEP.SlotPos = 0
SWEP.OverallMouseSens = .7
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"bolt"}
SWEP.Base = "cw_base"
SWEP.Category = "CW 2.0 - Ranged Rifles"

SWEP.Author			= "Khris"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 80
SWEP.AimViewModelFOV = 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/khrcw2/v_snip_m95.mdl"
SWEP.WorldModel		= "models/khrcw2/w_snip_m95.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 5
SWEP.Primary.DefaultClip	= 5
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= ".50 BMG"

SWEP.FireDelay = 1.6
SWEP.FireSound = "K95.FIRE"
SWEP.Recoil = 3.25

SWEP.HipSpread = 0.084
SWEP.AimSpread = 0.002
SWEP.VelocitySensitivity = 1.8
SWEP.MaxSpreadInc = 0.4
SWEP.SpreadPerShot = 0.05
SWEP.SpreadCooldown = 0.2
SWEP.Shots = 1
SWEP.Damage = 160
SWEP.DeployTime = 1

SWEP.ReloadSpeed = .8
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