SWEP.PrintName = "Tow Hook"
SWEP.Author = "Smith Bob"
SWEP.Category = "XYZ Weapons"

SWEP.Slot = 0
SWEP.SlotPos = 4

SWEP.Spawnable = true

SWEP.UseHands = true
SWEP.ViewModelFOV = 65
SWEP.ViewModelFlip = false
SWEP.ViewModel			    = "models/mechanical_system/hook.mdl"
SWEP.WorldModel			    = "models/mechanical_system/w_hook.mdl"


SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "none"

SWEP.Secondary.ClipSize 	 = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = true
SWEP.Secondary.Ammo = "none"
SWEP.UseHands = true

SWEP.DrawAmmo = false
SWEP.Base = "weapon_base"

SWEP.Secondary.Ammo = "none"
SWEP.HoldType = "normal"

function SWEP:Initialize()
    self:SetHoldType("normal")
end

function SWEP:Holster()
    if CLIENT then return true end

    local entHook = self.hook

    if IsValid(entHook) and entHook.player == self.Owner then
        entHook:Detach()
    end

    return true
end

function SWEP:PrimaryAttack()
    self:SetNextPrimaryFire(CurTime() + .5)

    if CLIENT then return end

    local entHook = self.hook

    if not IsValid(entHook) then return end
    if entHook.player ~= self.Owner then return end

    local tblTrace = self.Owner:GetEyeTrace()
    local ent = tblTrace.Entity
    local vecHitPos = tblTrace.HitPos

    if not IsValid(ent) then return end
    if not ent:IsVehicle() then return end
    if IsValid(ent.ishooked) then return end
    if ent:GetVehicleClass() == "tow_truck" then return end

    if vecHitPos:Distance(entHook:GetPos()) > 600 then
        return
    end
    
    if vecHitPos:DistToSqr(self.Owner:GetPos()) > 32500 then return end
    
    self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)

    timer.Simple(1, function()
        if timer.Exists(ent:EntIndex().."_clamp_impound_timer") then
            timer.Remove(ent:EntIndex().."_clamp_impound_timer") -- This makes it so the clamp will stay on the car. 
        end
        xLogs.Log(xLogs.Core.Player(ply).." hooked a "..ent:GetVehicleClass(), "Tow Truck")
        entHook:Attach(ent, vecHitPos)
    end)
end

function SWEP:Think()
    if CLIENT then return end

    local entHook = self.hook
    
    if not IsValid(entHook) then
       self:Remove()
       return
    end

    if entHook.player ~= self.Owner then
        entHook:Detach()
    end
end