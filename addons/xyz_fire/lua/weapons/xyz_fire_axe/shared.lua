SWEP.PrintName = "Fire Axe"
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


SWEP.ViewModel = "models/craphead_scripts/ocrp2/props_meow/weapons/c_axe.mdl"
SWEP.WorldModel = "models/craphead_scripts/ocrp2/props_meow/weapons/w_axe.mdl"

function SWEP:Initialize()
	self:SetWeaponHoldType("pistol")

    self:SendWeaponAnim(ACT_VM_DRAW)
	self:SetNextPrimaryFire(CurTime() + 1)
end


function SWEP:PrimaryAttack()
	if CLIENT then return end
	local ply = self.Owner
	local ent = ply:GetEyeTrace().Entity
	if ent:IsVehicle() then return end

	if (not ent:isDoor()) and (not ent.isFadingDoor) then return end
	if ent:GetPos():DistToSqr(ply:GetPos()) > 10000 then return end

	-- It's a fading door
	if ent.isFadingDoor then
		ent:fadeActivate()
		-- Only trigger the fading door for 5 seconds
		timer.Simple(5, function()
			ent:fadeDeactivate()
		end)
	-- Otherwise assume it's a door
	else
		ent:keysUnLock()
		ent:Fire("toggle")
	end

    local viewmodel = ply:GetViewModel()
    viewmodel:SendViewModelMatchingSequence(viewmodel:LookupSequence("use"))
	self:SetNextPrimaryFire(CurTime()+1)

	ply:EmitSound("physics/wood/wood_box_break1.wav")
end


function SWEP:SecondaryAttack()
end


function SWEP:Reload()
end