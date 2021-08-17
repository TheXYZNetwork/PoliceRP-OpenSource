-- Everything listed down here below may NOT be edited
-- or the addon will break!
-- Unless you know what you are doing...
SWEP.ViewModel = "models/weapons/v_chainsaw.mdl" 
SWEP.WorldModel = "models/weapons/w_chainsaw.mdl" 
SWEP.AutoSwitchTo = true 
SWEP.Slot = 0 
SWEP.HoldType = "shotgun" 
SWEP.PrintName = "Chainsaw (OLD)"  
SWEP.Author = "LordiAnders & Archemyde" 
SWEP.Category = "LordiAnders's Weapons"
SWEP.Spawnable = true  
SWEP.AutoSwitchFrom = false
SWEP.FiresUnderwater = false
SWEP.ViewModelFOV = 57
SWEP.Weight = 5 
SWEP.DrawCrosshair = false
SWEP.SlotPos = 0 
SWEP.DrawAmmo = false
SWEP.base = "weapon_base"

SWEP.Primary.Damage = 1
SWEP.Primary.Ammo = "none"
SWEP.Primary.Spread = 0
SWEP.Primary.NumberofShots = 1
SWEP.Primary.Automatic = true
SWEP.Primary.Recoil = 0
SWEP.Primary.ClipSize = -1
SWEP.Primary.Delay = 0.01
SWEP.Primary.Force = 1

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.Delay = 1.2
SWEP.Secondary.Ammo = "none"

local smoke = { 
	"particle/smokesprites_0001",
	"particle/smokesprites_0002",
	"particle/smokesprites_0003",
	"particle/smokesprites_0004",
	"particle/smokesprites_0005",
	"particle/smokesprites_0006",
	"particle/smokesprites_0007",
	"particle/smokesprites_0008",
	"particle/smokesprites_0009",
	"particle/smokesprites_0010",
	"particle/smokesprites_0012",
	"particle/smokesprites_0013",
	"particle/smokesprites_0014",
	"particle/smokesprites_0015",
	"particle/smokesprites_0016"
}

function SWEP:Initialize()
	self:SetDeploySpeed(0.5)
	self:SetHoldType("shotgun")
	timer.Simple(0.5,function()
		if IsValid(self) then
			self:SetHoldType("physgun")
		end
	end)
self.idlesound = CreateSound(self,Sound("weapons/melee/chainsaw_idle.wav"))
self.attacksound = CreateSound(self,Sound("weapons/melee/chainsaw_attack.wav"))
if CLIENT then
emitter = ParticleEmitter(self:GetPos())
end
end

function SWEP:Deploy()
	self:EmitSound("weapons/melee/chainsaw_start_01.wav")
	self:SetHoldType("shotgun")
	self.Owner:SetAnimation(PLAYER_RELOAD)
	timer.Simple(0.5,function()
		if IsValid(self) then
			self:SetHoldType("physgun")
		end
	end)
	timer.Create( "idlestart"..self:EntIndex(), 3, 1, function()
		self.idlesound:Play()
	end)
end

function SWEP:Think()
if CLIENT then
	emitter:SetPos(self:GetPos())
	local BoneIndx = self.Owner:LookupBone("ValveBiped.Bip01_R_Hand")
	local position = self.Owner:GetBonePosition( BoneIndx )
	local particle = emitter:Add( table.Random(smoke), position)
	particle:SetDieTime( 1 )
	particle:SetStartAlpha( 10 )
	particle:SetEndAlpha( 0 )
	particle:SetStartSize( 0 )
	particle:SetEndSize( math.Rand( 20, 30 ) )
	particle:SetRoll( math.Rand( 360, 480 ) )
	particle:SetRollDelta( math.Rand( -1, 1 ) )
	particle:SetColor( 180, 180, 180 )
	particle:SetVelocity(VectorRand()*10+vector_up*40)
	particle:SetGravity(Vector(math.Rand(-100,100),math.Rand(-100,100),math.Rand(150,200)))
	particle:SetAirResistance(100)
	particle:SetCollide(true)
end

	if !self.Owner or self.Owner == NULL then return end
	if self.Owner:KeyPressed(IN_ATTACK) then
	self.idlesound:Stop()
	self.attacksound:Play()
	elseif self.Owner:KeyReleased(IN_ATTACK) then
	self.attacksound:Stop()
	self.idlesound:Play()
	else
	end
end

function SWEP:PrimaryAttack()
local trace = self.Owner:GetEyeTrace()
self:SendWeaponAnim(ACT_VM_HITCENTER)
self.Owner:ViewPunch( Angle( math.random(-0.5,0.5), math.random(-0.5,0.5), 0 ) )

if trace.HitPos:Distance(self.Owner:GetShootPos()) <= 75 then

	bullet = {}
	bullet.Num    = 1
	bullet.Src    = self.Owner:GetShootPos()
	bullet.Dir    = self.Owner:GetAimVector()
	bullet.Spread = Vector(0, 0, 0)
	bullet.Tracer = 0
	bullet.Force  = 1000
	bullet.Damage = 12
self.Owner:FireBullets(bullet)
self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
	if ( trace.HitWorld ) then

	self:EmitSound("npc/manhack/grind" .. math.random( 1, 5 ) .. ".wav")
	self:SendWeaponAnim(ACT_VM_MISSCENTER)
	local effectdata = EffectData()
	effectdata:SetOrigin( trace.HitPos )
	effectdata:SetNormal( trace.HitNormal )
	effectdata:SetMagnitude( 1 )
	effectdata:SetScale( 2 )
	effectdata:SetRadius( 1 )
	util.Effect( "Sparks", effectdata )

	self.BaseClass.ShootEffects( self )
	else
	local effectdata = EffectData()
			effectdata:SetOrigin(trace.HitPos)
			effectdata:SetMagnitude(math.random(1, 3))
			effectdata:SetEntity(trace.Entity)
	util.Effect( "bloodstream", effectdata )
	self.attacksound:PlayEx( 100, 50 )
	end
else
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self.attacksound:PlayEx( 100, 100 )
	self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
end

end

function SWEP:SecondaryAttack()
local trace = self.Owner:GetEyeTrace()
		self:SetHoldType("melee2")
		self.Owner:SetAnimation(PLAYER_ATTACK1)
		self.Owner:EmitSound("weapons/melee/chainsaw_die_01.wav", 50, 100)
		self.Owner:ViewPunch( Angle( -10, 0, 0 ) )
		timer.Simple(0.5,function()
			if IsValid(self) then
			self:SetHoldType("physgun")
			end
		end)
		timer.Simple(0.1,function()
			if not IsValid(self.Owner) then return end
			self.Owner:ViewPunch( Angle( 10, 0, 0 ) )
		end)
if trace.HitPos:Distance(self.Owner:GetShootPos()) <= 75 then
self:SendWeaponAnim(ACT_VM_MISSCENTER)
	bullet = {}
	bullet.Num    = 1
	bullet.Src    = self.Owner:GetShootPos()
	bullet.Dir    = self.Owner:GetAimVector()
	bullet.Spread = Vector(0, 0, 0)
	bullet.Tracer = 0
	bullet.Force  = 1000
	bullet.Damage = 45
self.Owner:FireBullets(bullet)
self.Owner:SetAnimation( PLAYER_ATTACK1 )
self:EmitSound("weapons/melee/chainsaw_die_01.wav")
	self:SetNextSecondaryFire( CurTime() + self.Secondary.Delay )
	if ( trace.HitWorld ) then

	self:EmitSound("npc/manhack/grind" .. math.random( 1, 5 ) .. ".wav")
	self:SendWeaponAnim(ACT_VM_MISSCENTER)
	local effectdata = EffectData()
	effectdata:SetOrigin( trace.HitPos )
	effectdata:SetNormal( trace.HitNormal )
	effectdata:SetMagnitude( 2 )
	effectdata:SetScale( 8 )
	effectdata:SetRadius( 3 )
	util.Effect( "Sparks", effectdata )

	self.BaseClass.ShootEffects( self )
	else
	local effectdata = EffectData()
	effectdata:SetOrigin(trace.HitPos)
	effectdata:SetMagnitude(math.random(1, 3))
	effectdata:SetEntity(ent)
	util.Effect( "bloodstream", effectdata )
	end
else
	self:EmitSound("weapons/melee/chainsaw_die_01.wav")
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self:SendWeaponAnim(ACT_VM_MISSCENTER)
	self:SetNextSecondaryFire( CurTime() + self.Secondary.Delay )
end

end

function SWEP:Holster()
	if IsValid(self.Owner) then self.Owner:EmitSound("weapons/melee/chainsaw_die_01.wav") end
	self:OnRemove()
	return true
end

function SWEP:OnRemove()
	timer.Destroy("idlestart"..self:EntIndex())
	self.idlesound:Stop()
	self.attacksound:Stop()
end