local Anims = {}

-- Load animations after the languages for translation purposes
hook.Add("loadCustomDarkRPItems", "loadAnimations", function()
    Anims[ACT_GMOD_GESTURE_BOW] = DarkRP.getPhrase("bow")
    Anims[ACT_GMOD_TAUNT_MUSCLE] = DarkRP.getPhrase("sexy_dance")
    Anims[ACT_GMOD_GESTURE_BECON] = DarkRP.getPhrase("follow_me")
    Anims[ACT_GMOD_TAUNT_LAUGH] = DarkRP.getPhrase("laugh")
    Anims[ACT_GMOD_TAUNT_PERSISTENCE] = DarkRP.getPhrase("lion_pose")
    Anims[ACT_GMOD_GESTURE_DISAGREE] = DarkRP.getPhrase("nonverbal_no")
    Anims[ACT_GMOD_GESTURE_AGREE] = DarkRP.getPhrase("thumbs_up")
    Anims[ACT_GMOD_GESTURE_WAVE] = DarkRP.getPhrase("wave")
    Anims[ACT_GMOD_TAUNT_DANCE] = DarkRP.getPhrase("dance")
end)

function DarkRP.addPlayerGesture(anim, text)
    if not anim then DarkRP.error("Argument #1 of DarkRP.addPlayerGesture (animation/gesture) does not exist.", 2) end
    if not text then DarkRP.error("Argument #2 of DarkRP.addPlayerGesture (text) does not exist.", 2) end

    Anims[anim] = text
end

function DarkRP.removePlayerGesture(anim)
    if not anim then DarkRP.error("Argument #1 of DarkRP.removePlayerGesture (animation/gesture) does not exist.", 2) end

    Anims[anim] = nil
end

local function physGunCheck(ply)
    local hookName = "darkrp_anim_physgun_" .. ply:EntIndex()
    hook.Add("Think", hookName, function()
        if IsValid(ply) and
           ply:Alive() and
           ply:GetActiveWeapon():IsValid() and
           ply:GetActiveWeapon():GetClass() == "weapon_physgun" and
           ply:KeyDown(IN_ATTACK) and
           (ply:GetAllowWeaponsInVehicle() or not ply:InVehicle()) then
            local ent = ply:GetEyeTrace().Entity
            if IsValid(ent) and ent:IsPlayer() and not ply.SaidHi then
                ply.SaidHi = true
                ply:DoAnimationEvent(ACT_SIGNAL_GROUP)
            end
        else
            if IsValid(ply) then
                ply.SaidHi = nil
            end
            hook.Remove("Think", hookName)
        end
    end)
end

hook.Add("KeyPress", "darkrp_animations", function(ply, key)
    if key == IN_ATTACK then
        local weapon = ply:GetActiveWeapon()

        if weapon:IsValid() then
            local class = weapon:GetClass()

            -- Saying hi/hello to a player
            if class == "weapon_physgun" then
                physGunCheck(ply)

            -- Hobo throwing poop!
            elseif class == "weapon_bugbait" then
                local Team = ply:Team()
                if RPExtraTeams[Team] and RPExtraTeams[Team].hobo then
                    ply:DoAnimationEvent(ACT_GMOD_GESTURE_ITEM_THROW)
                end
            end
        end
    end
end)

if SERVER then
    util.AddNetworkString("_DarkRP_CustomAnim")
    local function CustomAnim(ply, cmd, args)
        if ply:EntIndex() == 0 then return end
        local Gesture = tonumber(args[1] or 0)
        if not Anims[Gesture] then return end
        net.Start("_DarkRP_CustomAnim")
            net.WriteEntity(ply)
            net.WriteInt(Gesture, 32)
        net.Broadcast()
    end
--    concommand.Add("_DarkRP_DoAnimation", CustomAnim)
    return
end

local function KeysAnims()
    local ply = net.ReadEntity()
    local act = net.ReadString()

    if not IsValid(ply) then return end
    ply:AnimRestartGesture(GESTURE_SLOT_CUSTOM, act == "usekeys" and ACT_GMOD_GESTURE_ITEM_PLACE or ACT_HL2MP_GESTURE_RANGE_ATTACK_FIST, true)
end
net.Receive("anim_keys", KeysAnims)

local function CustomAnimation()
    local ply = net.ReadEntity()
    local act = net.ReadInt(32)

    if not IsValid(ply) then return end
    ply:AnimRestartGesture(GESTURE_SLOT_CUSTOM, act, true)
end
net.Receive("_DarkRP_CustomAnim", CustomAnimation)

local function AnimationMenu()
end
concommand.Add("_DarkRP_AnimationMenu", AnimationMenu)
