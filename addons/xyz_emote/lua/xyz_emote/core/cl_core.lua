net.Receive("Emote:Give", function()
    local animationID = net.ReadString()
    table.insert(Emote.Users, animationID)
end)

net.Receive("Emote:Reset", function()
    local ply = net.ReadEntity()
    if not IsValid(ply) then return end

    ply:AnimResetGestureSlot(GESTURE_SLOT_CUSTOM)

    if ply == LocalPlayer() then
        Emote.Active = false
    end
end)

net.Receive("Emote:Camera", function()
    Emote.Active = net.ReadString()
end)

concommand.Add("emote_camera_reset", function()
    Emote.Active = false
end)

function Emote.Core.StartAnimation(animationID)
    net.Start("Emote:Do")
        net.WriteString(animationID)
    net.SendToServer()
end

hook.Add("Move", "Emote:Movement", function(ply, mv)
    if not Emote.Active then return end

    local animationData = Emote.Config.Animations[Emote.Active]
    if not animationData then return end
    if not animationData.movementSpeed then return end

    mv:SetMaxSpeed(animationData.movementSpeed)
end)
-- The circle UI shit
local currentSelected
local menuIsShowing = false
hook.Add("PlayerButtonDown", "Emote:ShowMenu", function(ply, button)
    if not (ply == LocalPlayer()) then return end
    if not (button == Emote.Config.MenuKey) then return end

    -- Not in vehicle
    if IsValid(LocalPlayer():GetVehicle()) then return end

    -- Some kinda other UI?
    if gui.IsGameUIVisible() then return end
    -- The player is dead
    if not ply:Alive() then return end
    -- There is some other UI showing
    if vgui.CursorVisible() then return end
    -- Menu is already open
    if menuIsShowing then return end

    menuIsShowing = true
    gui.EnableScreenClicker(true)
end)
hook.Add("PlayerButtonUp", "Emote:HideMenu", function(ply, button)
    if not (ply == LocalPlayer()) then return end
    if not (button == Emote.Config.MenuKey) then return end

    if not menuIsShowing then return end

    menuIsShowing = false
    gui.EnableScreenClicker(false)

    if not currentSelected then return end
    local animationID = Emote.Users[currentSelected]
    if not animationID then return end

    Emote.Core.StartAnimation(animationID)
end)

hook.Add("CalcView", "Emote:Camera", function(ply, origin, angles, fov, znear, zfar)
    if not Emote.Active then return end
    
    -- 0 = Third Person    1 = Over the Shoulder.
    local view = {}
    view.origin = origin - (angles:Forward() * 120)
    view.angles = angles
    view.fov = fov
    view.drawviewer = true

    local traceData = {}
    traceData.start = view.origin
    traceData.endpos = view.origin - (angles:Forward() * -10)
    traceData.filter = ply
    local trace = util.TraceLine(traceData)
    pos = trace.HitPos

    if(trace.Fraction < 1) then
        view.origin = origin + trace.HitNormal * 5
    end

    return view
end)

local grey = Color(30, 30, 30, 240)
local darkGrey = Color(30, 30, 30, 200)
local fadedIcon = Color(255, 255, 255, 55)
local overlay
hook.Add("HUDPaint", "Emote:Wheel", function()
    if not menuIsShowing then return end
    if not overlay then
        overlay = Color(Emote.Config.Color.r, Emote.Config.Color.g, Emote.Config.Color.b, 100)
    end

    local count = table.Count(Emote.Users)
    if count <= 0 then return end

    draw.NoTexture()
    surface.SetDrawColor(grey)

    local midW, midH, rad = ScrW()*0.5, ScrH()*0.5, ScrH()*0.4

    -- The base background cricle?
    XYZUI.DrawCircle(midW, midH, rad, 1)
    surface.SetDrawColor(darkGrey)
    XYZUI.DrawCircle(midW, midH, 50, 1)
    --Emote.UI.DrawWedge(midW, midH, 50, rad, 0, 360, 1)

    
    -- Get the ang of the mouse around the center of the circle
    local angle = (math.deg(math.atan2(gui.MouseY() -(ScrH()*0.5), gui.MouseX() - (ScrW()*0.5))) % 360 + 90) % 360
    local dist = math.sqrt((midW - gui.MouseX()) ^ 2 + (midH - gui.MouseY()) ^ 2)

    currentSelected = nil
    -- Maths is hard
    for j = 0, count-1 do
        local i = 360/count*j
        local emoteID = j + 1
        local animationID = Emote.Users[emoteID]
        local animationData = Emote.Config.Animations[animationID]
        if not animationData then continue end

        if (not (dist > (ScrH()*0.4))) and (not (dist < 50)) and (not ((not (angle > (i - 1))) or (not (angle < (i + 360 / count - 1))))) then
            currentSelected = emoteID
            draw.NoTexture()
            surface.SetDrawColor(overlay)
            --Emote.UI.DrawWedge(midW, midH, 50, rad, i - 1, i + 360 / count - 1, 1)
            --Emote.UI.DrawWedge(midW, midH, rad-1, rad + 10, i - 1, i + 360 / count - 1, 1)
            Emote.UI.DrawWedge(midW, midH, 50, rad - 10, i - 1, i + 360 / count - 1, 1)
        end

        local x = math.cos(math.rad(i-90+180/count))*(rad * 0.6)
        local y = math.sin(math.rad(i-90+180/count))*(rad * 0.6)
        draw.NoTexture()
        if currentSelected == emoteID then
            surface.SetDrawColor(color_white)
        else
           surface.SetDrawColor(fadedIcon)
        end
        surface.SetMaterial(XYZShit.Image.GetMat(animationData.icon))
        surface.DrawTexturedRectRotated(midW + x, midH + y, 150, 150, 0)
    end     
end)