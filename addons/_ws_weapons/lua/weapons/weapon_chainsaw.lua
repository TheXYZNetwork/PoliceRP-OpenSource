SWEP.ViewModel = "models/weapons/v_chain_s.mdl"
SWEP.WorldModel = "models/weapons/w_chainsaw.mdl"
SWEP.AutoSwitchTo = true
SWEP.Slot = 0 
SWEP.Spawnable = false
SWEP.AdminSpawnable = true
SWEP.HoldType = "physgun"
SWEP.PrintName = "Chainsaw (Simple)"
SWEP.Author = "LordiAnders"
SWEP.Category = "LordiAnders's Weapons"
SWEP.Spawnable = true  
SWEP.AutoSwitchFrom = false
SWEP.FiresUnderwater = false
SWEP.ViewModelFOV = 57
SWEP.Weight = 5 
SWEP.DrawCrosshair = true
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
SWEP.Primary.Delay = 0.5
SWEP.Primary.Force = 1

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.Ammo = "none"

if CLIENT then
SWEP.WepSelectIcon = surface.GetTextureID("vgui/entities/weapon_chainsaw")
killicon.Add( "weapon_chainsaw", "vgui/entities/weapon_chainsaw", Color( 255, 255, 255, 255 ) )
SWEP.BounceWeaponIcon = false
end

local IsBGOInstall = false
if BGOAddWeaponBlood then --BGO crash workaround
	IsBGOInstall = true
end

function SWEP:Initialize()
	self:SetHoldType(self.HoldType)
	if IsValid(self.Owner) then if IsBGOInstall then self.Owner:GetViewModel():SetSubMaterial(1,"models/weapons/v_models/d3_chainsaw/chain_noanim") end end
end

function SWEP:Deploy()
self.Weapon:SendWeaponAnim(ACT_VM_DRAW)
self:SetHoldType(self.HoldType)
self.Weapon:EmitSound("weapons/doom_chainsaw/knife_deploy1.wav")
if IsBGOInstall then self.Owner:GetViewModel():SetSubMaterial(1,"models/weapons/v_models/d3_chainsaw/chain_noanim") end
end

function SWEP:PrimaryAttack()
	self.Weapon:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
	self.Weapon:SendWeaponAnim(ACT_VM_HITCENTER)
	self.Weapon:EmitSound("weapons/doom_chainsaw/knife_slash1.wav")
	timer.Create("s_saw_attack"..self:EntIndex(), 0.15, 1, function()
		local trace = self.Owner:GetEyeTrace()
		self.Owner:ViewPunch( Angle( -10, 0, 0 ) )
		timer.Create("s_saw_down"..self:EntIndex(), 0.1, 1, function()
			self.Owner:ViewPunch( Angle( 10, 0, 0 ) )
		end)
		if trace.HitPos:Distance(self.Owner:GetShootPos()) <= 125 then
			bullet = {}
			bullet.Num    = 1
			bullet.Src    = self.Owner:GetShootPos()
			bullet.Dir    = self.Owner:GetAimVector()
			bullet.Spread = Vector(0, 0, 0)
			bullet.Tracer = 0
			bullet.Force  = 1000
			bullet.Damage = 12
			self.Owner:FireBullets(bullet)
			if ( trace.HitWorld ) then
				sound.Play("npc/manhack/grind"..math.random(1,5)..".wav",trace.HitPos)
				local effectdata = EffectData()
				effectdata:SetOrigin( trace.HitPos )
				effectdata:SetNormal( trace.HitNormal )
				effectdata:SetMagnitude( 2 )
				effectdata:SetScale( 8 )
				effectdata:SetRadius( 3 )
				util.Effect( "Sparks", effectdata )
			else
				sound.Play("weapons/melee/chainsaw_gore_0"..math.random(1,4)..".wav",trace.HitPos)
				local effectdata = EffectData()
				effectdata:SetOrigin(trace.HitPos)
				effectdata:SetMagnitude(math.random(1,3))
				effectdata:SetScale( 8 )
				effectdata:SetEntity(trace.Entity)
				util.Effect( "bloodstream", effectdata )
			end
		end
	end)
	self.Owner:SetAnimation(PLAYER_ATTACK1)
end

function SWEP:SecondaryAttack()
end

function SWEP:Holster()
	self:OnRemove()
	return true
end

function SWEP:OnRemove()
	if IsValid(self.Owner) then
		if IsBGOInstall then self.Owner:GetViewModel():SetSubMaterial(1,nil) end
	end

	timer.Destroy("s_saw_attack"..self:EntIndex())
	timer.Destroy("s_saw_down"..self:EntIndex())
end