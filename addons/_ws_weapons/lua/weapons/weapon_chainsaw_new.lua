SWEP.ViewModelFOV = 53
SWEP.ViewModel = "models/weapons/v_chainsaw.mdl"
SWEP.WorldModel = "models/weapons/w_chainsaw.mdl"
SWEP.Slot = 1
SWEP.HoldType = "physgun" 
SWEP.Spawnable = true
SWEP.AdminSpawnable = false
SWEP.DrawCrosshair = false
SWEP.DrawAmmo = false
SWEP.PrintName = "Chainsaw"
SWEP.Author = "LordiAnders"
SWEP.Category = "LordiAnders's Weapons"
SWEP.base = "weapon_base"

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Ammo = "none"
SWEP.Primary.Automatic = true

SWEP.Secondary.Ammo = "none"

if CLIENT then
SWEP.WepSelectIcon = surface.GetTextureID("vgui/entities/weapon_chainsaw_new")
killicon.Add( "weapon_chainsaw_new", "vgui/entities/weapon_chainsaw_new", Color( 255, 255, 255, 255 ) )
SWEP.BounceWeaponIcon = false
end

function SWEP:Initialize()
	self:SetHoldType(self.HoldType)
	self:SetDeploySpeed(0.5)
	self.RSaw_Idle = CreateSound(self,"weapons/melee/chainsaw_idle.wav")
	self.RSaw_Attack = CreateSound(self,"weapons/melee/chainsaw_attack.wav")
	if CLIENT then
		emitter = ParticleEmitter(self:GetPos())
	end
end

function SWEP:Deploy()
	self:EmitSound("weapons/melee/chainsaw_start_01.wav",20.5)
	self.Owner:SetAnimation(PLAYER_RELOAD)
	timer.Create("rsaw_idlesound_start"..self:EntIndex(),3,1,function()
		if not IsValid(self) then return end
		self.RSaw_Idle:Play()
		self.RSaw_Idle:ChangeVolume(0.20,0.01)
	end)
end

function SWEP:Think()
	if self.Owner and IsValid(self.Owner) then
		if self.Owner:KeyPressed(IN_ATTACK) then
			self.RSaw_Idle:Stop()
			self.RSaw_Attack:Play()
			self.RSaw_Attack:ChangeVolume(0.30,0.01)
		elseif self.Owner:KeyReleased(IN_ATTACK) then
			self.RSaw_Idle:Play()
			self.RSaw_Idle:ChangeVolume(0.30,0.01)
			self.RSaw_Attack:Stop()
		end
	end
end

function SWEP:PrimaryAttack()
--Trace shit from weapon_fists.lua packed with Gmod
local trace = util.TraceLine( {
	start = self.Owner:GetShootPos(),
	endpos = self.Owner:GetShootPos() + self.Owner:GetAimVector() * 75,
	filter = self.Owner
} )

if ( !IsValid( trace.Entity ) ) then 
	trace = util.TraceHull( {
		start = self.Owner:GetShootPos(),
		endpos = self.Owner:GetShootPos() + self.Owner:GetAimVector() * 75,
		filter = self.Owner,
		mins = Vector( -10, -10, -8 ),
		maxs = Vector( 10, 10, 8 )
	} )
end
	self:SendWeaponAnim(ACT_VM_HITCENTER)
	
	self.Owner:SetAnimation(PLAYER_ATTACK1)

	if trace.Entity:IsValid() then
		if SERVER then
			if trace.Entity:GetClass() == "func_breakable" or trace.Entity:GetClass() == "func_breakable_surf" then
				local bullet = {}
				bullet.Num = self.GunShots
				bullet.Src = self.Owner:GetShootPos()
				bullet.Dir = self.Owner:GetAimVector()
				bullet.Spread = Vector(0,0,0)
				bullet.Tracer = 0
				bullet.Force = 1
				bullet.Damage = 6
				self.Owner:FireBullets( bullet )
			else
				--trace.Entity:TakeDamage(6,self.Owner)
			end
		end
		if trace.Entity:IsPlayer() or trace.Entity:IsNPC() then
			self.RSaw_Attack:ChangePitch(50,0.30)
			local BLOOOD = EffectData()
			BLOOOD:SetOrigin(trace.HitPos)
			BLOOOD:SetMagnitude(math.random(1,3))
			BLOOOD:SetEntity(trace.Entity)
			util.Effect("bloodstream",BLOOOD)
		end
	else
		self.RSaw_Attack:ChangePitch(100,0.30)
	end
	
	if trace.HitWorld then
		self:SendWeaponAnim(ACT_VM_MISSCENTER)
		local effectdata = EffectData()
		effectdata:SetOrigin(trace.HitPos)
		effectdata:SetNormal(trace.HitNormal)
		effectdata:SetMagnitude(1)
		effectdata:SetScale(2)
		effectdata:SetRadius(1)
		util.Effect("Sparks",effectdata)
		sound.Play("npc/manhack/grind"..math.random(1,5)..".wav",trace.HitPos,20,150)
	end
	
	self.Weapon:SetNextPrimaryFire( CurTime() + 0.01)
	self.Weapon:SetNextSecondaryFire( CurTime() + 0.25 )
end

function SWEP:SecondaryAttack()
--Trace shit from weapon_fists.lua packed with Gmod
local trace = util.TraceLine( {
	start = self.Owner:GetShootPos(),
	endpos = self.Owner:GetShootPos() + self.Owner:GetAimVector() * 75,
	filter = self.Owner
} )

if ( !IsValid( trace.Entity ) ) then 
	trace = util.TraceHull( {
		start = self.Owner:GetShootPos(),
		endpos = self.Owner:GetShootPos() + self.Owner:GetAimVector() * 75,
		filter = self.Owner,
		mins = Vector( -10, -10, -8 ),
		maxs = Vector( 10, 10, 8 )
	} )
end
	self:SendWeaponAnim(ACT_VM_MISSCENTER)
	self:EmitSound("weapons/melee/chainsaw_die_01.wav",15.5)
	
	self.Owner:SetAnimation(PLAYER_ATTACK1)

	if trace.Entity:IsValid() then
		if SERVER then
			if trace.Entity:GetClass() == "func_breakable" or trace.Entity:GetClass() == "func_breakable_surf" then
				local bullet = {}
				bullet.Num = self.GunShots
				bullet.Src = self.Owner:GetShootPos()
				bullet.Dir = self.Owner:GetAimVector()
				bullet.Spread = Vector(0,0,0)
				bullet.Tracer = 0
				bullet.Force = 1
				bullet.Damage = 45
				self.Owner:FireBullets( bullet )
			else
				--trace.Entity:TakeDamage(45,self.Owner)
			end
		end
		if trace.Entity:IsPlayer() or trace.Entity:IsNPC() then
			local BLOOOD = EffectData()
			BLOOOD:SetOrigin(trace.HitPos)
			BLOOOD:SetMagnitude(math.random(1,3))
			BLOOOD:SetEntity(trace.Entity)
			util.Effect("bloodstream",BLOOOD)
			sound.Play("weapons/melee/chainsaw_gore_0"..math.random(1,4)..".wav",trace.HitPos, 15)
		end
	end
	
	if trace.HitWorld then
		self:SendWeaponAnim(ACT_VM_MISSCENTER)
		local effectdata = EffectData()
		effectdata:SetOrigin(trace.HitPos)
		effectdata:SetNormal(trace.HitNormal)
		effectdata:SetMagnitude(1)
		effectdata:SetScale(2)
		effectdata:SetRadius(1)
		util.Effect("Sparks",effectdata)
		sound.Play("npc/manhack/grind"..math.random(1,5)..".wav",trace.HitPos,15,150)
	end
	self.Weapon:SetNextPrimaryFire( CurTime() + 0.75)
	self.Weapon:SetNextSecondaryFire( CurTime() + 0.75 )
end

function SWEP:Holster()
	self:OnRemove()
	if IsValid(self.Owner) then
		self:EmitSound("weapons/melee/chainsaw_die_01.wav",30.5)
	end
	return true
end

function SWEP:OnRemove()
	timer.Destroy("rsaw_idlesound_start"..self:EntIndex())
	if not self.RSaw_Idle then return end
	self.RSaw_Idle:Stop()
	self.RSaw_Attack:Stop()
end