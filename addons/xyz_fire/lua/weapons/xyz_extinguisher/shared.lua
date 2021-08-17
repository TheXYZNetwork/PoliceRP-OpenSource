SWEP.PrintName = "Fire Extinguisher"
SWEP.Author = "Owain Owjo"
SWEP.Category = "XYZ Weapons"

SWEP.Slot = 0
SWEP.SlotPos = 4

SWEP.Spawnable = true
SWEP.ViewModelFOV = 85
SWEP.UseHands = true

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "none"

SWEP.Secondary.ClipSize 	 = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = true
SWEP.Secondary.Ammo = "none"


SWEP.ViewModel = "models/craphead_scripts/ocrp2/props_meow/weapons/c_extinguisher.mdl"
SWEP.WorldModel = "models/craphead_scripts/ocrp2/props_meow/weapons/w_extinguisher.mdl"

function SWEP:Initialize()
	self:SetWeaponHoldType("normal")

    self:SendWeaponAnim(ACT_VM_DRAW)
	self:SetNextPrimaryFire(CurTime() + 1)
end

-- Taken from the example on the wiki https://wiki.facepunch.com/gmod/ents.FindInCone
function SWEP:GetEntsInCone()
	local size = 200
	local dir = self.Owner:GetAimVector()
	local angle = math.cos(math.rad(15)) -- 15 degrees
	local startPos = self.Owner:EyePos()

	return ents.FindInCone(startPos, dir, size, angle)
end

function SWEP:PrimaryAttack()
	self.Attacking = true

	self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
    self:SetNextPrimaryFire(CurTime() + 2)
	
	self.Weapon:SendWeaponAnim(ACT_VM_RECOIL1)
	self.Weapon:SetNextPrimaryFire(CurTime() + 0.1)
	
--	self.Weapon:EmitSound(Sound("ambient/wind/wind_hit2.wav"))
	local ExtinguishEffect = EffectData()
	ExtinguishEffect:SetAttachment(1)
	ExtinguishEffect:SetEntity(self.Owner)
	ExtinguishEffect:SetOrigin(self.Owner:GetShootPos())
	ExtinguishEffect:SetNormal(self.Owner:GetAimVector())
	util.Effect("xyz_fire_extinguish", ExtinguishEffect)

	if SERVER then
		local ents = self:GetEntsInCone()
		for k, v in pairs(ents) do
			if not (v:GetClass() == "xyz_fire_origin" or v:GetClass() == "prop_vehicle_jeep") then continue end
			if not v.nextReduce then v.nextReduce = CurTime() end
			if v.nextReduce > CurTime() then continue end
			if v:GetClass() == "prop_vehicle_jeep" then
				if v:VC_getHealth(true) > 35 then return end
				v:VC_repairHealth(25)
				v.nextReduce = CurTime() + .5
			else 
				v.nextReduce = CurTime() + 1
				v:ReduceHealth(1, self.Owner)
			end
			
		end
	end
end

function SWEP:Think()
	if not self.Owner:KeyDown( IN_ATTACK ) then
		if self.Attacking then
			self.Attacking = false

			self:SendWeaponAnim(ACT_VM_SECONDARYATTACK)
			self:SetNextPrimaryFire(CurTime() + 0.5)
		end
	end
end

function SWEP:SecondaryAttack()
end


function SWEP:Reload()
end

if SERVER then return end
hook.Remove("PostDrawOpaqueRenderables", "conetest")