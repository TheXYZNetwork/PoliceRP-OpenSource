if CustomizableWeaponry then

	AddCSLuaFile()
	AddCSLuaFile("sh_sounds.lua")
	include("sh_sounds.lua")
	
	util.PrecacheModel("models/cw2/pistols/silverballer.mdl")
	util.PrecacheModel("models/cw2/mag_silverballer.mdl")	
	util.PrecacheModel("models/weapons/w_silverballer.mdl")
	util.PrecacheModel("models/weapons/v_cw_fraggrenade.mdl")
	util.PrecacheModel("models/weapons/w_cw_fraggrenade_thrown.mdl")
	
	SWEP.PrintName = "Silverballer" -- What's this called in weapons spawn menu?

	if CLIENT then
		SWEP.DrawCrosshair = false -- False to hide default crosshair. Useful for centering ironsights but should be false for release.
		SWEP.CSMuzzleFlashes = true
		SWEP.ZoomAmount = 15 -- Zoom FOV by this much while aiming
		SWEP.AimSwayIntensity = 0.6
		
		SWEP.IconLetter = "f"
		SWEP.SelectIcon = surface.GetTextureID("vgui/hud/cw_silverballer") -- Icon to use for weapon select (1,2,3, mousewheel etc.)
		killicon.Add("cw_silverballer", "vgui/hud/kill/cw_silverballer", Color(255, 255, 255, 150)) -- Icon displayed when NPCs are killed with this SWep
		killicon.Add("cw_bullet_45acp", "vgui/hud/kill/cw_silverballer", Color(255, 255, 255, 150)) -- Icon displayed when NPCs are killed with this SWep
		
		SWEP.MuzzleEffect = "muzzleflash_pistol" -- Name of particle effect (Not a PCF) to use for muzzle flash
		SWEP.PosBasedMuz = true -- Zuh?
		
		SWEP.Shell = "smallshell" -- Type of ejected brass
		SWEP.ShellScale = 0.35 -- Size of ejected brass
		SWEP.ShellOffsetMul = 1
		SWEP.ShellPosOffset = {x = 0, y = 0, z = 0}

		SWEP.IronsightPos = Vector(-1.748, 0, 0.25)
		SWEP.IronsightAng = Vector(0.3, 0, 0)
		
		SWEP.SprintPos = Vector(1.634, -8.28, -7.311)
		SWEP.SprintAng = Vector(70, 0, 0)
		
		SWEP.MoveType = 1
		SWEP.ViewModelMovementScale = 0.8
		SWEP.FullAimViewmodelRecoil = true
		
		SWEP.LaserPosAdjust = Vector(0, 0, 0)
		SWEP.LaserAngAdjust = Angle(0.2, 180, 0)

		--[[SWEP.AttachmentModelsVM = {
			["md_anpeq15"] = {model = "models/cw2/attachments/anpeq15.mdl", bone = "M1911_Body", pos = Vector(0, 0.5, 1), angle = Angle(90, 90, 0), size = Vector(0.699, 0.699, 0.699)}
		}]]--
	end

	-- default values are 9x19MM, because we don't know what the user wants
	SWEP.CaseLength = 22.8
	SWEP.BulletDiameter = 11.5
	
	--SWEP.LuaViewmodelRecoil = true -- True to enforce LUA-based movement of bolt/slide bone on shoot.
	SWEP.ADSFireAnim = true -- True to enable SMD-based movement of bolt/slide while aiming
	SWEP.CanRestOnObjects = false
	SWEP.CustomizationMenuScale = 0.01	
	
	SWEP.LuaVMRecoilAxisMod = {vert = 1, hor = 1.5, roll = 3, forward = 1, pitch = 4}	

	SWEP.Attachments = {[1] = {header = "Barrel", offset = {-400, -300}, atts = {"bg_sb_ls", "bg_sb_sup"}},
		[2] = {header = "Light", offset = {-300, 100}, atts = {"bg_sb_x300", "bg_sb_m6x"}},
		[3] = {header = "Skin", offset = {90, -300}, atts = {"bg_sb_skin"}},
		--[4] = {header = "Laser", offset = {300, -50}, atts = {"bg_sb_laser"}, dependencies = {bg_sb_m6x = true}},
	["+reload"] = {header = "Ammo", offset = {400, 0}, atts = {"am_magnum", "am_matchgrade"}}}

	SWEP.AttachmentDependencies = {["bg_sb_laser"] = {"bg_sb_m6x"}} -- This is on a PER ATTACHMENT basis, NOTE: the exclusions and dependencies in the Attachments table is PER CATEGORY
	SWEP.AttachmentPosDependency = {["bg_sb_laser"] = {["bg_sb_m6x"] = Vector(0, 0, 0)}}
	
	-- Sequence names go here: "idle", NOT animation events like "ACT_VM_IDLE"
	SWEP.Animations = {fire = {"shoot1", "shoot2"},
		fire_dry = "shoot_empty",
		reload = "reload",
		reload_empty = "reload_2",
		idle = "idle",
		draw = "draw"}

--[[ Old sound events
	SWEP.Sounds = {draw = {{time = 0, sound = "Silverballer.Deploy"}},

		reload = {[1] = {time = 0, sound = "Silverballer.Foley"},
		[2] = {time = 0.27, sound = "Silverballer.ClipOut"},
		[3] = {time = 1.1, sound = "Silverballer.ClipIn"},
		[4] = {time = 1.19, sound = "Silverballer.ClipLocked"},
		[5] = {time = 1.89, sound = "Silverballer.SlideBack"},
		[6] = {time = 2.05, sound = "Silverballer.SlideForward"}},
		
		reload_2 = {[1] = {time = 0, sound = "Silverballer.Foley"},
		[2] = {time = 0.27, sound = "Silverballer.ClipOut"},
		[3] = {time = 1.1, sound = "Silverballer.ClipIn"},
		[4] = {time = 1.19, sound = "Silverballer.ClipLocked"},
		[5] = {time = 1.89, sound = "Silverballer.SlideBack"},
		[6] = {time = 2.05, sound = "Silverballer.SlideForward"}}}
]]--
	SWEP.Sounds = {draw = {{time = 0, sound = "Silverballer.Deploy"}},

		reload = {[1] = {time = 0, sound = "Silverballer.Foley"},
		[2] = {time = 0.42, sound = "Silverballer.ClipOut"},
		[3] = {time = 1.1, sound = "Silverballer.ClipFoley"},
		[4] = {time = 1.38, sound = "Silverballer.ClipIn"},
		[5] = {time = 1.48, sound = "Silverballer.ClipLocked"}},
		
		reload_2 = {[1] = {time = 0, sound = "Silverballer.Foley"},
		[2] = {time = 0.42, sound = "Silverballer.ClipOut"},
		[3] = {time = 1.1, sound = "Silverballer.ClipFoley"},		
		[4] = {time = 1.375, sound = "Silverballer.ClipIn"},
		[5] = {time = 1.435, sound = "Silverballer.ClipLocked"},
		[6] = {time = 2.00, sound = "Silverballer.SlideForward"}}}

	SWEP.SpeedDec = 10 -- Fuck if I know

	SWEP.Slot = 1 -- Add this to # slot (starts at 0) of weapon selection 1-6 keys.
	SWEP.SlotPos = 0 -- Add to # position (starts at 0) of weapon selection slot. Should always be 0.
	SWEP.NormalHoldType = "revolver" 	--World model hold type for players/NPCs. pistol,revolver,rpg
	SWEP.RunHoldType = "revolver"			--Same for running
	SWEP.FireModes = {"semi"}
	SWEP.Base = "cw_base"
	SWEP.Category = "CW 2.0"			--Which spawn menu/weapons category this is in

	SWEP.Author			= "Doktor haus" --Who made this shit?
	SWEP.Contact		= "" --Who should everyone spam with requests and complaints?
	SWEP.Purpose		= "" --Why?
	SWEP.Instructions	= "" --how do i shot web

	SWEP.ViewModelFOV	= 70	--first person Field Of Vision
	SWEP.ViewModelFlip	= false --Mirror ViewModel horizontally?
	SWEP.ViewModel		= "models/cw2/pistols/silverballer.mdl"
	SWEP.WorldModel		= "models/weapons/w_silverballer.mdl"
	SWEP.DrawTraditionalWorldModel = false	--Whether to use world model's embedded/compiled origin
	SWEP.WM = "models/weapons/w_silverballer.mdl"
	SWEP.WMPos = Vector(1.3,-5.2,3.2)		--world model origin X,Y,Z
	SWEP.WMAng = Vector(0,180,180)			--world model angles X,Y,Z

	SWEP.Spawnable			= true
	SWEP.AdminSpawnable		= true

	SWEP.Primary.ClipSize		= 7
	SWEP.Primary.DefaultClip	= 7
	SWEP.Primary.Automatic		= false
	SWEP.Primary.Ammo			= ".45 ACP" --Ammo box entity to use
	SWEP.Primary.Round		= "cw_bullet_45acp" --Bullet which this thing spawns with FireRocket

	SWEP.ClipDrop_Enable = true	-- Should clip drop be enabled?
	SWEP.ClipDrop_Time = 0.4 -- Time in seconds before clip drops
	SWEP.ClipDrop_Clip_Model = "models/cw2/mag_silverballer.mdl" -- Which model should the clip use?
	SWEP.ClipDrop_Sound = "Weapon.MagDropPistol" -- Sound clip makes when colliding with things

	SWEP.FireDelay = 0.200000000000000
	SWEP.FireSound = "CW_SILVERBALLER_FIRE"
	SWEP.FireSoundSuppressed = "CW_SILVERBALLER_FIRE_SD"
	SWEP.Recoil = 2.0
	-- Recoil vars for GDCW impacts
	SWEP.Primary.Cone				= 0.0					// This is the variable	
	SWEP.Primary.ConeSpray			= 0.0					// Hip fire accuracy
	SWEP.Primary.ConeIncrement		= 0.0					// Rate of innacuracy
	SWEP.Primary.ConeMax			= 0.0					// Maximum Innacuracy
	SWEP.Primary.ConeDecrement		= 0.0					// Rate of accuracy	
	SWEP.Primary.KickUp				= 1					// Maximum up recoil (rise)
	SWEP.Primary.KickDown			= 0.5					// Maximum down recoil (skeet)
	SWEP.Primary.KickHorizontal		= 0					// Maximum side recoil (koolaid)	

	SWEP.HipSpread = 0.025
	SWEP.AimSpread = 0.005
	SWEP.VelocitySensitivity = 1.2
	SWEP.MaxSpreadInc = 0.06
	SWEP.SpreadPerShot = 0.02
	SWEP.SpreadCooldown = 0.32
	SWEP.Shots = 1
	SWEP.Damage = 40
	SWEP.DeployTime = 1

	SWEP.ReloadSpeed = 1
	SWEP.ReloadTime = 1.9
	SWEP.ReloadHalt = 1.8

	SWEP.ReloadTime_Empty = 2.5
	SWEP.ReloadHalt_Empty = 2.4
	SWEP.SnapToIdlePostReload = false
end

-- Per-weapon functions ------------------------------------------------------------------------------
--[[ Any functions different from the default cw_base go here to avoid conflicts.
This way, I don't have to make a copy of the base and don't need to update all my CW2 SWeps every
time I add something.
Keep the order of functions the same.
Clip drop and GDCW stuff go here, but only on SWeps which use them. ]]--

-- Clip drop ---------------------------
function SWEP:Reload()
	CT = CurTime()
	
	if self.ReloadDelay or CT < self.ReloadWait or self.dt.State == CW_ACTION or self.ShotgunReloadState != 0 then
		return
	end
	
	if CT < self.GlobalDelay then
		return
	end
	
	if self.Owner:KeyDown(IN_USE) and self.dt.State != CW_RUNNING then
		self:CycleFiremodes()
		return
	end
	
	if self.dt.M203Active then
		if not self.M203Chamber and self.Owner:GetAmmoCount("40MM") > 0 then
			if IsFirstTimePredicted() then
				self:reloadM203()
			end
			
			self.dt.State = CW_IDLE
			return
		end
	end
	
	mag = self:Clip1()
	
	if (self.Chamberable and mag >= self.Primary.ClipSize_Orig + 1) or self.Owner:GetAmmoCount(self.Primary.Ammo) == 0 then
		return
	end
	
	if not self.Chamberable and mag >= self.Primary.ClipSize then
		return
	end
	
	if self.dt.M203Active then
		if SERVER and SP then
			SendUserMessage("CW20_M203OFF_RELOAD", self.Owner)
		end
		
		if CLIENT then
			self:resetM203Anim()
		end
	end
	
	self.dt.State = CW_IDLE
	self.dt.M203Active = false
	
	self:beginReload()
	self:clipDrop()
end

function SWEP:clipDrop()
	if self.ClipDrop_Enable then
		if not self.Sex then
			if !SERVER then return end 
			timer.Create("clip_drop_007_:p"..self.Owner:UserID(), self.ClipDrop_Time, 1, 
			function()
			local bitchpos = self.Owner:GetPos() + (self.Owner:GetUp() * 30) + (self.Owner:GetRight() * 0) + (self.Owner:GetForward() * 3)
			local angles = self.Owner:GetAngles()
			local ent = ents.Create("ClipDrop_clip")
			ent:SetPos(bitchpos)
			ent:SetAngles(angles)
			ent:SetModel(self.ClipDrop_Clip_Model)
			ent:Spawn()
			end)
		end
	end
end

-- GDCW --------------------------------
function SWEP:FireRocket() 

	if self.Owner:KeyDown(IN_ATTACK2) then
	aim = self.Owner:GetAimVector()+(VectorRand()*self.Primary.Cone/360)
	else 
	aim = self.Owner:GetAimVector()+(VectorRand()*math.Rand(0,0.04))
	end

	if !self.Owner:IsNPC() then
	pos = self.Owner:GetShootPos()
	else
	pos = self.Owner:GetShootPos()+self.Owner:GetAimVector()*50
	end

	if SERVER then
		local bullet = ents.Create(self.Primary.Round)
		if !bullet:IsValid() then return false end
		bullet:SetAngles(aim:Angle()+Angle(90,0,0))
		bullet:SetPos(pos)
		bullet:SetOwner(self.Owner)
		bullet:Spawn()
		bullet:Activate()
		end

		-- RECOIL FOR SINGLEPLAYER IS RIGHT BELOW THESE WORDS
		if SERVER and (self.Single) and !self.Owner:IsNPC() then
		local anglo = Angle(math.Rand(-self.Primary.KickDown,self.Primary.KickUp), math.Rand(-self.Primary.KickHorizontal,self.Primary.KickHorizontal), 0)
		self.Owner:ViewPunch(anglo)
		angle = self.Owner:EyeAngles() - anglo
		self.Owner:SetEyeAngles(angle)
		end

	if (!self.Single)  and !self.Owner:IsNPC() then		// RECOIL FOR MULTIPLAYER IS RIGHT BELOW THESE WORDS
	self.Primary.Cone = math.Clamp(self.Primary.Cone+self.Primary.ConeIncrement,0,self.Primary.ConeMax)
	local anglo = Angle(math.Rand(-self.Primary.KickDown,self.Primary.KickUp), math.Rand(-self.Primary.KickHorizontal,self.Primary.KickHorizontal), 0)
	self.Owner:ViewPunch(anglo)
	end
end

function SWEP:PrimaryAttack()
	if self.ShotgunReloadState != 0 then
		return
	end
	
	if self.ReloadDelay then
		return
	end
	
	if self.Owner:KeyDown(IN_USE) then
		if CustomizableWeaponry.quickGrenade.canThrow(self) then
			CustomizableWeaponry.quickGrenade.throw(self)
			return
		end
	end
	
	if CurTime() < self.GlobalDelay then
		return false
	end
	
	if self.dt.Safe then
		self:CycleFiremodes()
		return
	end
	
	local preFireResult = CustomizableWeaponry.callbacks.processCategory(self, "preFire")
	
	if preFireResult then
		return
	end
	
	if self:isNearWall() then
		return
	end
	
	if self.InactiveWeaponStates[self.dt.State] then
		return
	end
	
	if self.dt.State == CW_AIMING and self.dt.M203Active then
		if self.M203Chamber then
			self:fireM203(IsFirstTimePredicted())
			
			return
		end
	end
	
	mag = self:Clip1()
	
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
	CT = CurTime()
	
	if IsFirstTimePredicted() then
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
		
		-- Whether to use GDCW bullet
		if self.gdcw == 1 then
			self:FireRocket(self.Damage, self.CurCone, self.ClumpSpread, self.Shots)
			self:makeFireEffects()
			self:MakeRecoil()
			self:addFireSpread(CT)
		else		
			self:FireBullet(self.Damage, self.CurCone, self.ClumpSpread, self.Shots)
			self:makeFireEffects()
			self:MakeRecoil()
			self:addFireSpread(CT)
		end
		
		if CLIENT then
			self:simulateRecoil()
		end
		
		if SP and SERVER then
			SendUserMessage("CW_Recoil", self.Owner)
		end
		
		-- apply a global delay after shooting, if there is one
		if self.GlobalDelayOnShoot then
			self.GlobalDelay = CT + self.GlobalDelayOnShoot
		end
	end
	
	CustomizableWeaponry.callbacks.processCategory(self, "postFire")
	
	local suppressAmmoUsage = CustomizableWeaponry.callbacks.processCategory(self, "shouldSuppressAmmoUsage")
	
	if not suppressAmmoUsage then
		self:TakePrimaryAmmo(self.AmmoPerShot)
	end
	
	self:SetNextPrimaryFire(CT + self.FireDelay)
	
	-- either force the weapon back to hip after firing, or don't
	if self.ForceBackToHipAfterAimedShot then
		self.dt.State = CW_IDLE
		self:SetNextSecondaryFire(CT + self.ForcedHipWaitTime)
	else
		self:SetNextSecondaryFire(CT + self.FireDelay)
	end
	
	self.ReloadWait = CT + (self.WaitForReloadAfterFiring and self.WaitForReloadAfterFiring or self.FireDelay)
	
	CustomizableWeaponry.callbacks.processCategory(self, "postConsumeAmmo")
end