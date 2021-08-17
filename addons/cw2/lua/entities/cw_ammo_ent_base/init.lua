AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	self:SetModel(self.Model) 
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetCollisionGroup(COLLISION_GROUP_NONE)
	self.CanHurt = true
	local phys = self:GetPhysicsObject()

	if phys and phys:IsValid() then
		phys:Wake()
	end
	
	self.dt.ammoCharge = self.AmmoCapacity
	
	self.HP = self.HealthAmount
end

local dmg, wep, am, cl, ammo, ED, pos, mag, amountToGive, maxAmmo

function ENT:OnTakeDamage(dmginfo)
	if self.Exploded then
		return
	end
	
	self:GetPhysicsObject():AddVelocity(dmginfo:GetDamageForce() * 0.02)
	
	dmg = dmginfo:GetDamage()
	self.HP = self.HP - dmg
	
	if self.HP <= 0 then
		self.Exploded = true
		
		pos = self:GetPos()
		util.BlastDamage(dmginfo:GetInflictor(), dmginfo:GetAttacker(), pos + Vector(0, 0, 32), self.ExplodeRadius, self.ExplodeDamage)
		
		ED = EffectData()
		ED:SetOrigin(pos)
		ED:SetScale(1)
		
		util.Effect("Explosion", ED)
		SafeRemoveEntity(self)
	end
end

function ENT:Use(activator, caller)
	if self.CaliberSpecific then
		if activator:IsPlayer() and activator:Alive() then
			if not activator.AmmoGiveDelay or CurTime() > activator.AmmoGiveDelay then
				activator:GiveAmmo(self.ResupplyAmount, self.Caliber)
				
				activator.AmmoGiveDelay = CurTime() + self.ResupplyTime
				self.dt.ammoCharge = self.dt.ammoCharge - self.ResupplyAmount
			end
			
			if self.dt.ammoCharge <= 0 then
				self:Remove()
			end
		end
	else
		if activator:IsPlayer() and activator:Alive() then
			if not activator.AmmoGiveDelay or CurTime() > activator.AmmoGiveDelay then
				if self.dt.ammoCharge > 0 then
					wep = activator:GetActiveWeapon()
					
					if IsValid(wep) then
						if wep.CW20Weapon then
							ammo = activator:GetAmmoCount(wep.Primary.Ammo)
							
							if ammo < wep.Primary.ClipSize_Orig * self.ResupplyMultiplier then
								-- check the amount of ammo that should be handed to the player
								amountToGive = math.Clamp(wep.Primary.ClipSize_Orig, 0, wep.Primary.ClipSize_Orig * self.ResupplyMultiplier)
								
								-- if it's greater than 0, give it to the player
								if amountToGive > 0 then
									activator:SetAmmo(math.Clamp(ammo + amountToGive, 0, wep.Primary.ClipSize_Orig * self.ResupplyMultiplier), wep.Primary.Ammo)
									activator:EmitSound("items/ammo_pickup.wav", 60, 100)
									self.dt.ammoCharge = self.dt.ammoCharge - 1
								end
							end
						end
					end
				end
				
				activator.AmmoGiveDelay = CurTime() + self.ResupplyTime
				
				if self.dt.ammoCharge <= 0 then
					SafeRemoveEntity(self)
				end
			end
		end
	end
end