SWEP.PrintName = "Weapon Checker"
SWEP.Author = "Smith Bob"
SWEP.Category = "XYZ Weapons"

SWEP.Slot = 5
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

function SWEP:Initialize()
end 

function SWEP:PrimaryAttack()
	if CLIENT then return end
	self:SetNextPrimaryFire(CurTime()+2)

	local ply = self.Owner
	local target = ply:GetEyeTrace().Entity
	if not target:IsPlayer() then return end

	if ply:GetPos():Distance(target:GetPos()) > 95 then return end

    local illegals = {}

    if target:XYZIsArrested() then
        for k, v in pairs(target.arrestedWeapons) do
             if WeaponChecker.Config.Weapons[k] then
                illegals[k] = true
                if target:getJobTable() and target:getJobTable().weapons and table.HasValue(target:getJobTable().weapons, k) then
                    illegals[k] = "job"
                elseif v == "xstore" then
                    illegals[k] = "xstore"
                end
            end
        end
    else 
        for k, v in pairs(target:GetWeapons()) do
            if WeaponChecker.Config.Weapons[v:GetClass()] then
                illegals[v:GetClass()] = true
                if (target:getJobTable() and target:getJobTable().weapons and table.HasValue(target:getJobTable().weapons, v:GetClass())) or v.blockDrop ~= nil then
                    illegals[v:GetClass()] = "job"
                elseif v.xStore then
                    illegals[v:GetClass()] = "xstore"
                end
            end
        end
    end

    local inv = Inventory.SavedInvs[target:SteamID64()]


    net.Start("xyz_weaponchecker_menu")
    net.WriteTable(illegals)
    net.WriteTable(inv)
    net.WriteEntity(target)
	net.Send(ply)
end

function SWEP:SecondaryAttack()
end


function SWEP:Reload()
end