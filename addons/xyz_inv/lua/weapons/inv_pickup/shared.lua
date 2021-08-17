SWEP.PrintName = "Inventory"
SWEP.Author = "Owain Owjo"
SWEP.Category = "XYZ Weapons"

SWEP.Slot = 1
SWEP.SlotPos = 4

SWEP.Spawnable = true

SWEP.ViewModel = ""
SWEP.WorldModel = ""
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

SWEP.DrawAmmo = false
SWEP.Base = "weapon_base"

SWEP.Secondary.Ammo = "none"

SWEP.HoldType = ""

SWEP.RenderGroup = RENDERGROUP_BOTH

function SWEP:Initialize()
    self:SetHoldType("normal")
end 

function SWEP:PrimaryAttack()
	if CLIENT then return end
	self:SetNextPrimaryFire(CurTime()+1)

	local entity = self.Owner:GetEyeTrace().Entity
	if not IsValid(entity) then return end
	if entity:GetPos():DistToSqr(self.Owner:GetPos()) > 8000 then return end
	Inventory.Core.PickupItem(self.Owner, entity)
end

function SWEP:SecondaryAttack()
	if SERVER then return end

	if XYZShit.CoolDown.Check("XYZInv:OpenUI", 1) then return end

	Inventory.Core.OpenInv()
end


function SWEP:Reload()
end
