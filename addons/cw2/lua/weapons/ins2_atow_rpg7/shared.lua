AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
AddCSLuaFile("sh_soundscript.lua")
include("sh_sounds.lua")
include("sh_soundscript.lua")

	CustomizableWeaponry.firemodes:registerFiremode("rpgsingle", "SINGLE-SHOT", false, 0, 1)
	SWEP.PrintName = "RPG-7"

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.CSMuzzleFlashes = true
	
	SWEP.SelectIcon = surface.GetTextureID("vgui/inventory/weapon_rpg7")
	killicon.Add( "doi_ins2_rpg7", "vgui/inventory/weapon_rpg7", Color(255, 80, 0, 0))
	
	SWEP.MuzzleEffect = "muzzleflash_ak74"
	SWEP.PosBasedMuz = true
	SWEP.SightWithRail = true
	SWEP.CrosshairParts = {left = true, right = true, upper = false, lower = true}
	SWEP.HUD_MagText = "TUBE: "

	SWEP.IronsightPos = Vector(-2.12, 0, -1.021)
	SWEP.IronsightAng = Vector(2.77, -0.26, 7.034)
	
	SWEP.KobraPos = Vector(-2.1335, 0, -0.788)
	SWEP.KobraAng = Vector(2.77, -0.26, 7.034)

	SWEP.AimpointPos = Vector(-2.12, 0, -0.9233)
	SWEP.AimpointAng = Vector(2.77, -0.26, 7.034)

	SWEP.SprintPos = Vector(2, 0, -1)
	SWEP.SprintAng = Vector(-15.478, 20.96, -15)
	
	SWEP.CustomizePos = Vector(5.75, 1.627, -1.821)
	SWEP.CustomizeAng = Vector(20.009, 30.971, 16.669)

	SWEP.AlternativePos = Vector(-.15, 0, -.225)
	SWEP.AlternativeAng = Vector(0, 0, 0)
	
	SWEP.SwimPos = Vector(6.3158, -17.8947, 0)
	SWEP.SwimAng = Vector(79.5789, 0, 11.3684)
	
	SWEP.PronePos = Vector(0, 0, -5.1579)
	SWEP.ProneAng = Vector(-10, 42.7368, -50.9474)
	
	SWEP.MoveType = 0
	SWEP.ViewModelMovementScale = 1.2
	SWEP.OverallMouseSens = .65
	SWEP.DisableSprintViewSimulation = false
	
	SWEP.CustomizationMenuScale = 0.017
	
	SWEP.AttachmentModelsVM = {
	["md_ins2aimpoint"] = { type = "Model", model = "models/khrcw2/ins2pack/attachments/ins2aimpoint.mdl", bone = "RPG_Body", rel = "", pos = Vector(0.619, -2.12, 1.73), angle = Angle(0, -90, 0), size = Vector(0.649, 0.649, 0.649), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_rail"] = { type = "Model", model = "models/khrcw2/ins2pack/attachments/rails/rail1.mdl", bone = "RPG_Body", rel = "", pos = Vector(0.6, -3.06, -0.04), angle = Angle(0, 90, 0), size = Vector(0.5, 0.899, 0.899), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_ins2wsacog"] = { type = "Model", model = "models/khrcw2/ins2pack/attachments/ins2wsacog.mdl", bone = "RPG_Body", rel = "", pos = Vector(0.619, -1.88, 1.73), angle = Angle(0, -90, 0), size = Vector(0.569, 0.569, 0.569), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_ins2kobra"] = { type = "Model", model = "models/khrcw2/ins2pack/attachments/ins2kobra.mdl", bone = "RPG_Body", rel = "", pos = Vector(0.619, -2, 1.7), angle = Angle(0, -90, 0), size = Vector(0.689, 0.689, 0.689), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}

	SWEP.M82AxisAlign = {right = .02, up = -.015, forward = 0}
	SWEP.LuaVMRecoilAxisMod = {vert = 10, hor = 0, roll = .35, forward = 1.5, pitch = .45}
	SWEP.INS2AxisAlign = {right = 0, up = 0, forward = 0}
end

SWEP.BodyBGs = {main = 1, off = 0, on = 1}
SWEP.WarheadBGs = {main = 2, heat = 0, hv = 1, he = 2, hvat = 3}

SWEP.LuaViewmodelRecoil = true
SWEP.LuaViewmodelRecoilOverride = true
SWEP.FullAimViewmodelRecoil = true
SWEP.AimBreathingEnabled = true
SWEP.CanRestOnObjects = false

if CustomizableWeaponry_atowins2_optics then
SWEP.Attachments = {[1] = {header = "Finish", offset = {700, 350}, atts = {"ins2_atow_newfinish"}},
[2] = {header = "Optic", offset = {650, -450}, atts = {"md_ins2kobra","md_ins2aimpoint"}},
["+reload"] = {header = "Projectile", offset = {-415, 100}, atts = {"ins2_atow_hvrocket", "ins2_atow_herocket", "ins2_atow_hvatrocket", "ins2_atow_dudrocket"}}}
else
SWEP.Attachments = {[1] = {header = "Finish", offset = {700, 350}, atts = {"ins2_atow_newfinish"}},
["+reload"] = {header = "Projectile", offset = {-415, 100}, atts = {"ins2_atow_hvrocket", "ins2_atow_herocket", "ins2_atow_hvatrocket", "ins2_atow_dudrocket"}}}
end

SWEP.Animations = {fire = {"base_fire"},
	fire_aim = {"iron_fire"},
	reload = "base_reload",
	idle = "base_idle",
	draw = "base_draw"}
	

SWEP.SpeedDec = 60

SWEP.Slot = 4
SWEP.SlotPos = 0
SWEP.NormalHoldType = "rpg"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"rpgsingle"}
SWEP.Base = "cw_base"
SWEP.Category = "CW 2.0 - Special"

SWEP.Author			= "Khris"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 65
SWEP.AimViewModelFOV = 65
SWEP.ZoomAmount = 20
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/khrcw2/ins2rpg7.mdl"
SWEP.WorldModel		= "models/khrcw2/w_ins2rpg7.mdl"

SWEP.DrawTraditionalWorldModel = false
SWEP.WM = "models/khrcw2/w_ins2rpg7.mdl"
SWEP.WMPos = Vector(-1.05, 7.35, 2)
SWEP.WMAng = Vector(-10, 0, 180)

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 1
SWEP.Primary.DefaultClip	= 1
SWEP.Primary.Automatic		= false
SWEP.Chamberable			= false
SWEP.Primary.Ammo			= "RPG_Round"

SWEP.FireDelay = 60/915
SWEP.FireSound = "INS2RPG7_FIRE"
SWEP.Recoil = 1
SWEP.FOVPerShot = 20

SWEP.HipSpread = 0.05
SWEP.AimSpread = 0
SWEP.VelocitySensitivity = 1.5
SWEP.MaxSpreadInc = 0
SWEP.SpreadPerShot = 0
SWEP.SpreadCooldown = 0
SWEP.Shots = 1
SWEP.Damage = 2500
SWEP.DeployTime = .85
SWEP.HolsterTime = .75

SWEP.ADSFireAnim = true

SWEP.RecoilToSpread = 1.25

SWEP.ReloadSpeed = 1.1
SWEP.ReloadTime = 4.65
SWEP.ReloadHalt = 4.65
SWEP.ReloadTime_Empty = 4.65
SWEP.ReloadHalt_Empty = 4.65

function SWEP:IndividualThink()
	if self.ActiveAttachments.md_ins2kobra or self.ActiveAttachments.md_ins2aimpoint or self.ActiveAttachments.md_ins2wsacog then
	self:setBodygroup(self.BodyBGs.main, self.BodyBGs.on)
	else
	self:setBodygroup(self.BodyBGs.main, self.BodyBGs.off)
	end
end

function SWEP:fireAnimFunc()
	clip = self:Clip1()
	cycle = 0
	rate = 1
	anim = "safe"
	prefix = ""
	suffix = ""
	
	if self:isAiming() then
		suffix = suffix .. "_aim"
		cycle = self.ironFireAnimStartCycle
	end
	
	self:sendWeaponAnim(prefix .. "fire" .. suffix, rate, cycle)
end //*/

local simpleTextColor = Color(255, 210, 0, 255)
local mod = 25

function SWEP:DrawWeaponSelection(x, y, wide, tall, alpha)
	if self.SelectIcon then
		surface.SetTexture(self.SelectIcon)
		
		wide = wide - mod
		
		x = x + (mod / 2)
		y = y + (mod / 4) + (wide / 8)
		
		surface.SetDrawColor(255, 255, 255, alpha)
		
		surface.DrawTexturedRect(x, y, wide, (wide / 2))
	else
		simpleTextColor.a = alpha
		draw.SimpleText(self.IconLetter, self.SelectFont, x + wide / 2, y + tall * 0.2, simpleTextColor, TEXT_ALIGN_CENTER)
	end
end

if CLIENT then
	SWEP.RoundBeltBoneNames = {
		"RPG_Warhead",
	}
	
	local function removeRoundMeshes(wep) -- we hide all rounds left in the belt on a non-empty reload because if we don't we're left with ghost meshes moving around (bullets with no link to the mag get moved back to it)
		wep:adjustVisibleRounds(0)
	end
	
	local function adjustMeshByMaxAmmo(wep)
		wep:adjustVisibleRounds(wep.Owner:GetAmmoCount(wep.Primary.Ammo) + wep:Clip1())
	end
	
	SWEP.Sounds.base_reload[1].callback = adjustMeshByMaxAmmo
end

function SWEP:IndividualInitialize()
	if CLIENT then
		self:initBeltBones()
	end
end

function SWEP:initBeltBones()
	local vm = self.CW_VM
	self.roundBeltBones = {}

	for key, boneName in ipairs(self.RoundBeltBoneNames) do
		local bone = vm:LookupBone(boneName)
		self.roundBeltBones[key] = bone
	end
end

function SWEP:postPrimaryAttack()
	if CLIENT then
		self:adjustVisibleRounds()
	end
end

local fullSize = Vector(1, 1, 1)
local invisible = Vector(0, 0, 0)

function SWEP:adjustVisibleRounds(curMag)
	if not self.roundBeltBones then
		self:initBeltBones()
	end
	
	local curMag = curMag or self:Clip1()
	local boneCount = #self.roundBeltBones
	local vm = self.CW_VM
	
	for i = 1, boneCount do
		local roundID = boneCount - (i - 1)
		local element = self.roundBeltBones[roundID]
		
		local scale = curMag >= roundID and fullSize or invisible
		vm:ManipulateBoneScale(element, scale)
	end
end

function SWEP:PrimaryAttack()
	if not self:canFireWeapon(1) then
			return
	end
	
	--if self.Owner:KeyDown(IN_USE) then
		--self.Owner:EmitSound( "weapons/doipack/shared/snackbar1.wav", 75, math.random (75,125) )
		--self.Weapon:SetNextPrimaryFire( CurTime() + 1.45 )
		--local TauntSounds = {
		--"weapons/doipack/shared/snackbar1.wav",
		--"weapons/doipack/shared/snackbar2.wav",
		--"weapons/doipack/shared/snackbar3.wav",
		--"weapons/doipack/shared/snackbar4.wav"}
		--local random = math.random(1, #TauntSounds)  
		--self.Owner:EmitSound(TauntSounds[random]) 
		--if (!SERVER) then return end
		--	return
	--end

	if not self:canFireWeapon(2) then
		return
	end
	
	if self.dt.Safe then
		self:CycleFiremodes()
		return
	end
	
	if not self:canFireWeapon(3) then
		return
	end
	
	mag = self:Clip1()
	CT = CurTime()
	
	if mag == 0 then
		self:EmitSound("CW_EMPTY", 100, 100)
		self:SetNextPrimaryFire(CT + 0.25)
		return
	end
	
	if self.BurstAmount and self.BurstAmount > 0 then
		if self.dt.Shots >= self.BurstAmount then
			return
		end
		
		self.dt.Shots = self.dt.Shots + 1
	end
	
	self.Owner:SetAnimation(PLAYER_ATTACK1)
	
	if IsFirstTimePredicted() then
		local muzzleData = EffectData()
		muzzleData:SetEntity(self)
		util.Effect("cw_muzzleflash", muzzleData)
		
		if self.dt.Suppressed then
			self:EmitSound(self.FireSoundSuppressed, 105, 100)
		else
			self:EmitSound(self.FireSound, 105, 100)
		end
		
		if self.fireAnimFunc then
			self:fireAnimFunc()
		else
			if self.dt.State == CW_AIMING then
				if self.ADSFireAnim then
					self:playFireAnim()
				end
			else
				self:playFireAnim()
			end
		end
	end
	
			-- apply a global delay after shooting, if there is one

	Dist = self.Owner:GetShootPos():Distance(self.Owner:GetEyeTrace().HitPos)
	
	if Dist <= 45 then
		return
	end

	if self:Clip1() == 0 then
		return
	end

	aimVec = self.Owner:GetAimVector()
		
		local pos = self.Owner:GetShootPos()
		local eyeAng = self.Owner:EyeAngles()
		local forward = eyeAng:Forward()
		local offset = forward * 30 + eyeAng:Right() * 3.5 - eyeAng:Up() * 2.5
		
		if self:isAiming() then offset = forward * 35 + eyeAng:Right() * 0.5 - eyeAng:Up() * 2.5
		end
	
		if SERVER and not self.ActiveAttachments.ins2_atow_hvrocket and not self.ActiveAttachments.ins2_atow_herocket and not self.ActiveAttachments.ins2_atow_hvatrocket and not self.ActiveAttachments.ins2_atow_dudrocket then
		missile = ents.Create("ent_ins2rpgrocket")
		missile:SetPos(pos + offset)
		missile:SetAngles(eyeAng)
		missile:Spawn()
		missile:Activate()
		missile:SetOwner(self.Owner)
		local phys = missile:GetPhysicsObject()
		
	if IsValid(phys) then
		missile:SetVelocity(forward * 2996)
	end
end
		
		if SERVER and self.ActiveAttachments.ins2_atow_hvrocket then
		missile = ents.Create("ent_ins2rpghvrocket")
		missile:SetPos(pos + offset)
		missile:SetAngles(eyeAng)
		missile:Spawn()
		missile:Activate()
		missile:SetOwner(self.Owner)
		local phys = missile:GetPhysicsObject()
		
	
	if IsValid(phys) then
		missile:SetVelocity(forward * 2996)
	end
end

		if SERVER and self.ActiveAttachments.ins2_atow_herocket then
		missile = ents.Create("ent_ins2rpgherocket")
		missile:SetPos(pos + offset)
		missile:SetAngles(eyeAng)
		missile:Spawn()
		missile:Activate()
		missile:SetOwner(self.Owner)
		local phys = missile:GetPhysicsObject()
		
	
	if IsValid(phys) then
		missile:SetVelocity(forward * 2996)
	end
end

		if SERVER and self.ActiveAttachments.ins2_atow_hvatrocket then
		missile = ents.Create("ent_ins2rpghvatrocket")
		missile:SetPos(pos + offset)
		missile:SetAngles(eyeAng)
		missile:Spawn()
		missile:Activate()
		missile:SetOwner(self.Owner)
		local phys = missile:GetPhysicsObject()
		
	
	if IsValid(phys) then
		missile:SetVelocity(forward * 2996)
	end
end

		if SERVER and self.ActiveAttachments.ins2_atow_dudrocket then
		missile = ents.Create("ent_ins2rpgdudrocket")
		missile:SetPos(pos + offset)
		missile:SetAngles(eyeAng)
		missile:Spawn()
		missile:Activate()
		missile:SetOwner(self.Owner)
		local phys = missile:GetPhysicsObject()
		
	
	if IsValid(phys) then
		missile:SetVelocity(forward * 2996)
	end
end
	
	self:delayEverything(.65)
	self:setGlobalDelay(.65)
	
	self.Owner:ViewPunch(Angle(-2, 0, 1))
	
	
	self:SetClip1(0)
	
end