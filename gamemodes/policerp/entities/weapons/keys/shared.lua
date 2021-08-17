AddCSLuaFile()

if SERVER then
    AddCSLuaFile("cl_menu.lua")
    util.AddNetworkString("anim_keys")
    util.AddNetworkString("KeysMenu")
end

if CLIENT then
    SWEP.PrintName = "Keys"
    SWEP.Slot = 1
    SWEP.SlotPos = 1
    SWEP.DrawAmmo = false
    SWEP.DrawCrosshair = false

    include("cl_menu.lua")
end

SWEP.Author = "DarkRP Developers"
SWEP.Instructions = "Left click to lock\nRight click to unlock\nReload for door settings or animation menu"
SWEP.Contact = ""
SWEP.Purpose = ""
SWEP.IsDarkRPKeys = true

SWEP.WorldModel = ""
SWEP.ViewModel = Model("models/freeman/c_xyz_old_key.mdl")

SWEP.ViewModelFOV = 62
SWEP.ViewModelFlip = false
SWEP.AnimPrefix  = "rpg"

SWEP.UseHands = true

SWEP.Spawnable = true
SWEP.AdminOnly = true
SWEP.Category = "DarkRP (Utility)"
SWEP.Sound = "doors/door_latch3.wav"
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = 0
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = ""

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = 0
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = ""

function SWEP:Initialize()
    self.nextReloadTime = 0
    self:SetHoldType("normal")
end

function SWEP:Deploy()
    self.nextReloadTime = 0
    if CLIENT or not IsValid(self:GetOwner()) then return true end
    -- self:GetOwner():DrawWorldModel(false)
    return true
end

function SWEP:Holster()
    return true
end

-- function SWEP:PreDrawViewModel()
--     return true
-- end

local function lookingAtLockable(ply, ent)
    local eyepos = ply:EyePos()
    return IsValid(ent)             and
        ent:isKeysOwnable()         and
        (
            ent:isDoor()    and eyepos:DistToSqr(ent:GetPos()) < 4225
            or
            ent:IsVehicle() and eyepos:DistToSqr(ent:NearestPoint(eyepos)) < 10000
        )

end

local function lockUnlockAnimation(ply, snd)
    ply:EmitSound("npc/metropolice/gear" .. math.floor(math.Rand(1,7)) .. ".wav")
    timer.Simple(0.9, function() if IsValid(ply) then ply:EmitSound(snd) end end)

    local RP = RecipientFilter()
    RP:AddAllPlayers()

    net.Start("anim_keys")
    net.WriteEntity(ply)
    net.WriteString("usekeys")
    net.Send(RP)

    ply:AnimRestartGesture(GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_GMOD_GESTURE_ITEM_PLACE, true)
end

local function doKnock(ply, sound)
    ply:EmitSound(sound, 100, math.random(90, 110))
    net.Start("anim_keys")
    net.WriteEntity(ply)
    net.WriteString("knocking")
    net.Broadcast()

    ply:AnimRestartGesture(GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_HL2MP_GESTURE_RANGE_ATTACK_FIST, true)
end

function SWEP:PrimaryAttack()
    -- local trace = self:GetOwner():GetEyeTrace()
    --
    -- if not lookingAtLockable(self:GetOwner(), trace.Entity) then return end

    self:SetNextPrimaryFire(CurTime() + 0.3)

    -- if CLIENT then return end
    --
    -- if self:GetOwner():canKeysLock(trace.Entity) then
    --     trace.Entity:keysLock() -- Lock the door immediately so it won't annoy people
    --     lockUnlockAnimation(self:GetOwner(), self.Sound)
    -- elseif trace.Entity:IsVehicle() then
    --     DarkRP.notify(self:GetOwner(), 1, 3, DarkRP.getPhrase("do_not_own_ent"))
    -- else
    --     doKnock(self:GetOwner(), "physics/wood/wood_crate_impact_hard2.wav")
    -- end
end

function SWEP:SecondaryAttack()
    -- local trace = self:GetOwner():GetEyeTrace()
    --
    -- if not lookingAtLockable(self:GetOwner(), trace.Entity) then return end

    self:SetNextSecondaryFire(CurTime() + 0.3)

    -- if CLIENT then return end
    --
    -- if self:GetOwner():canKeysUnlock(trace.Entity) then
    --     trace.Entity:keysUnLock() -- Unlock the door immediately so it won't annoy people
    --     lockUnlockAnimation(self:GetOwner(), self.Sound)
    -- elseif trace.Entity:IsVehicle() then
    --     DarkRP.notify(self:GetOwner(), 1, 3, DarkRP.getPhrase("do_not_own_ent"))
    -- else
    --     doKnock(self:GetOwner(), "physics/wood/wood_crate_impact_hard3.wav")
    -- end
end

function SWEP:Reload()

end

-- I don't know, it just stopped working the original way
hook.Add( "Think", "KeysMenu", function()
    for k, ply in pairs( player.GetAll() ) do
        if CLIENT and ply ~= LocalPlayer() then continue end

        local wep = ply:GetActiveWeapon()
        if IsValid( wep ) and wep:GetClass() == "keys" and !ply:InVehicle() then
            if ply:KeyPressed(IN_ATTACK) then
                local trace = ply:GetEyeTrace()

                if not lookingAtLockable(ply, trace.Entity) then continue end

                ply.nextPrimTime = ply.nextPrimTime or 0
                if CurTime() < ply.nextPrimTime then continue end
                ply.nextPrimTime = CurTime() + 0.3

                if CLIENT then continue end

                if ply:canKeysLock(trace.Entity) then
                    trace.Entity:keysLock() -- Lock the door immediately so it won't annoy people
                    lockUnlockAnimation(ply, wep.Sound)
                elseif trace.Entity:IsVehicle() then
                    DarkRP.notify(ply, 1, 3, DarkRP.getPhrase("do_not_own_ent"))
                else
                    doKnock(ply, "physics/wood/wood_crate_impact_hard2.wav")
                end
            elseif ply:KeyPressed( IN_ATTACK2 ) then
                local trace = ply:GetEyeTrace()

                if not lookingAtLockable(ply, trace.Entity) then continue end

                ply.nextSecTime = ply.nextSecTime or 0
                if CurTime() < ply.nextSecTime then continue end
                ply.nextSecTime = CurTime() + 0.3

                if CLIENT then continue end

                if ply:canKeysUnlock(trace.Entity) then
                    trace.Entity:keysUnLock() -- Unlock the door immediately so it won't annoy people
                    lockUnlockAnimation(ply, wep.Sound)
                elseif trace.Entity:IsVehicle() then
                    DarkRP.notify(ply, 1, 3, DarkRP.getPhrase("do_not_own_ent"))
                else
                    doKnock(ply, "physics/wood/wood_crate_impact_hard3.wav")
                end
            elseif ply:KeyPressed( IN_RELOAD ) then
                local trace = ply:GetEyeTrace()
                if not IsValid(trace.Entity) or (IsValid(trace.Entity) and ((not trace.Entity:isDoor() and not trace.Entity:IsVehicle()) or ply:EyePos():DistToSqr(trace.HitPos) > 40000)) then
                    if CLIENT and not DarkRP.disabledDefaults["modules"]["animations"] then RunConsoleCommand("_DarkRP_AnimationMenu") end
                    continue
                end

                if SERVER then
                    ply.nextReloadTime = ply.nextReloadTime or 0
                    if CurTime() < ply.nextReloadTime then continue end
                    ply.nextReloadTime = CurTime() + 1

                    net.Start("KeysMenu")
                    net.Send(ply)
                end
            end
        end
    end
end)