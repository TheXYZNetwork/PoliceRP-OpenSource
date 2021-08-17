--[[


Written by Syranide, me@syranide.com
fixed and updated by minifisch, mail@minifisch.net
big thanks to Syranide! :)


]]
--
if SERVER then
    AddCSLuaFile()
end

if CLIENT then
    local target = {
        active = false
    }

    local snaptarget = {
        active = false
    }

    local snapkey = false
    local snaptime = false
    local snaplock = false
    local snapclick = false
    local snapclickfade = 0
    local snapcursor = false
    local snapspawnmenu = false

    local cache = {
        vPlayerPos = 0,
        vLookPos = 0,
        vLookClipPos = 0,
        vLookVector = 0
    }

    local condefs = {
        snap_enabled = 1,
        snap_gcboost = 1,
        snap_gcstrength = 125,
        snap_hidegrid = 0,
        snap_clickgrid = 0,
        snap_toggledelay = 0,
        snap_disableuse = 0,
        snap_allentities = 0,
        snap_alltools = 0,
        snap_enabletoggle = 0,
        snap_lockdelay = 0.5,
        snap_distance = 250,
        snap_gridlimit = 16,
        snap_gridsize = 8,
        snap_gridalpha = 0.4,
        snap_gridoffset = 0.5,
        snap_boundingbox = 1,
        snap_revertaim = 1,
        snap_centerline = 1
    }

    local convars = {}

    for key, value in pairs(condefs) do
        convars[#convars + 1] = key
    end

    local modelsaveset = {}
    local modeloffsets = {}

    local function DrawScreenLine(vsA, vsB)
        surface.DrawLine(vsA.x, vsA.y, vsB.x, vsB.y)
    end

    local function ToScreen(vWorld)
        local vsScreen = vWorld:ToScreen()

        return Vector(vsScreen.x, vsScreen.y, 0)
    end

    local function PointToScreen(vPoint)
        if cache.vLookVector:DotProduct(vPoint - cache.vLookClipPos) > 0 then return ToScreen(vPoint) end
    end

    local function LineToScreen(vStart, vEnd)
        local dotStart = cache.vLookVector:DotProduct(vStart - cache.vLookClipPos)
        local dotEnd = cache.vLookVector:DotProduct(vEnd - cache.vLookClipPos)

        if dotStart > 0 and dotEnd > 0 then
            return ToScreen(vStart), ToScreen(vEnd)
        elseif dotStart > 0 or dotEnd > 0 then
            local vLength = vEnd - vStart
            local vIntersect = vStart + vLength * ((cache.vLookClipPos:DotProduct(cache.vLookVector) - vStart:DotProduct(cache.vLookVector)) / vLength:DotProduct(cache.vLookVector))

            if dotStart <= 0 then
                return ToScreen(vIntersect), ToScreen(vEnd)
            else
                return ToScreen(vStart), ToScreen(vIntersect)
            end
        end
    end

    local function RayQuadIntersect(vOrigin, vDirection, vPlane, vX, vY)
        local vp = vDirection:Cross(vY)
        local d = vX:DotProduct(vp)
        if (d <= 0.0) then return end
        local vt = vOrigin - vPlane
        local u = vt:DotProduct(vp)
        if (u < 0.0 or u > d) then return end
        local v = vDirection:DotProduct(vt:Cross(vX))
        if (v < 0.0 or v > d) then return end

        return Vector(u / d, v / d, 0)
    end

    local function OnInitialize()
        for key, value in pairs(condefs) do
            CreateClientConVar(key, value, true, false)
        end

        for _, filename in ipairs(file.Find('smartsnap_offsets_*.png', "GAME")) do
            local file = file.Read(filename)

            if file then
                lines = string.Explode("\n", file)
                header = table.remove(lines, 1)

                if header == "SMARTSNAP_OFFSETS" then
                    for _, line in ipairs(lines) do
                        local pos = string.find(line, '=')

                        if pos then
                            local key = string.lower(string.Trim(string.sub(line, 1, pos - 1)))
                            local value = string.Trim(string.sub(line, pos + 1))
                            local c = string.Explode(",", value)
                            modeloffsets[key] = {tonumber(c[1]), tonumber(c[2]), tonumber(c[3]), tonumber(c[4]), tonumber(c[5]), tonumber(c[6])}
                        end
                    end
                end
            end
        end
    end

    local function OnShutDown()
        output = file.Read('smartsnap_offsets_custom.png')

        if output == nil then
            output = "SMARTSNAP_OFFSETS\n"
        end

        for model, _ in pairs(modelsaveset) do
            output = output .. model .. '=' .. table.concat(modeloffsets[model], ",") .. "\n"
        end

        file.Write('smartsnap_offsets_custom.png', output)
    end

    local function GetDevOffset()
        local model = string.lower(target.entity:GetModel())

        if modeloffsets[model] == nil then
            modeloffsets[model] = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0}
        end

        return modeloffsets[model]
    end

    concommand.Add("snap_dev_alloffset", function(player, command, arguments)
        if target.active == true then
            if #arguments >= 1 then
                local v = GetDevOffset()

                for i = 1, 6 do
                    v[i] = v[i] + tonumber(arguments[1])
                end
            end
        end
    end)

    concommand.Add("snap_dev_gridoffset", function(player, command, arguments)
        if target.active == true then
            if #arguments >= 1 then
                local v = GetDevOffset()
                v[target.face] = v[target.face] + tonumber(arguments[1])
            end
        end
    end)

    concommand.Add("snap_dev_saveoffset", function(player, command, arguments)
        if target.active == true then
            local v = GetDevOffset()
            modelsaveset[string.lower(target.entity:GetModel())] = true
        end
    end)

    local function SnapToggleGrid()
        if (GetConVarNumber("snap_enabled") == 0) then
            RunConsoleCommand('snap_enabled', '1')
        else
            RunConsoleCommand('snap_enabled', '0')
        end
    end

    local function SnapPress()
        if GetConVarNumber("snap_clickgrid") ~= 0 and not snapclick then
            snapclick = true
            snapclickfade = CurTime()
        elseif GetConVarNumber("snap_clickgrid") == 0 or snapclick then
            if (snaplock or snapcursor) then
                snaptime = false
            else
                local toggledelay = GetConVarNumber("snap_toggledelay")

                if (toggledelay > 0 and snaptime and snaptime + toggledelay > CurTime()) then
                    SnapToggleGrid()
                    snaptime = false
                    snaplock = false
                else
                    snaptime = CurTime()
                end
            end

            snapkey = target.active

            if (not snapcursor) then
                snaplock = false
            end
        end
    end

    local function SnapRelease()
        snapkey = false
    end

    local function SnapLock()
        snaplock = not snaplock
    end

    local function OnSpawnMenu()
        snapspawnmenu = true
    end

    local function OnKeyPress(player, key)
        if (key == IN_USE and GetConVarNumber("snap_disableuse") == 0) then
            SnapPress()
        end
    end

    local function OnKeyRelease(player, key)
        if (key == IN_USE and GetConVarNumber("snap_disableuse") == 0) then
            SnapRelease()
        end
    end

    local function OnThink()
        if (vgui.CursorVisible()) then
            if (not snapcursor and snaplock) then
                snaptarget = table.Copy(target)
            end

            snaptime = false
            snapcursor = true
        else
            if (snapcursor and snaplock) then
                target = snaptarget
            end

            snapspawnmenu = false
            snapcursor = false
        end

        if (GetConVarNumber("snap_enabletoggle") ~= 0) then
            if (snapkey and snaptime and not snaplock) then
                if (CurTime() > snaptime + GetConVarNumber("snap_lockdelay")) then
                    snaplock = true
                    snaptime = false
                end
            end
        end

        local locked = target.locked and target.active
        target.locked = (snapkey or snaplock and not snapcursor) and target.active

        if (not target.locked and locked and GetConVarNumber("snap_revertaim") ~= 0) then
            if (snapcursor) then
                local screen = target.entity:LocalToWorld(target.vector):ToScreen()
                gui.SetMousePos(math.Round(screen.x), math.Round(screen.y))
            else
                local angles = (target.entity:LocalToWorld(target.vector) - LocalPlayer():GetShootPos()):Angle()
                LocalPlayer():SetEyeAngles(angles)
            end
        end
    end

    local function CalculateGridAxis(L)
        local length = L:Length()
        local grid = math.Clamp(math.floor(length / (2 * GetConVarNumber("snap_gridsize"))) * 2, 2, GetConVarNumber("snap_gridlimit"))
        local offset = math.Clamp(GetConVarNumber("snap_gridoffset") / length, 0, 1 / grid)
        local scale = 1 - offset * 2

        return {
            length = length,
            offset = offset,
            scale = scale,
            grid = grid
        }
    end

    local function CalculateSnap(X, Y, v)
        local LX = CalculateGridAxis(X)
        local LY = CalculateGridAxis(Y)
        local BX = math.Clamp(math.Round(v.x * LX.grid), 0, LX.grid)
        local BY = math.Clamp(math.Round(v.y * LY.grid), 0, LY.grid)

        if BX == 1 and v.x < (1 / LX.grid + LX.offset) / 2 then
            BX = 0
        end

        if BX == LX.grid - 1 and v.x > 1 - (1 / LX.grid + LX.offset) / 2 then
            BX = LX.grid
        end

        if BY == 1 and v.y < (1 / LY.grid + LY.offset) / 2 then
            BY = 0
        end

        if BY == LY.grid - 1 and v.y > 1 - (1 / LY.grid + LY.offset) / 2 then
            BY = LY.grid
        end

        local RX = X * (BX / LX.grid)
        local RY = Y * (BY / LY.grid)

        if BX == 0 then
            RX = X * math.Clamp(LX.offset, 0, 1 / LX.grid)
        end

        if BX == LX.grid then
            RX = X * (1 - math.Clamp(LX.offset, 0, 1 / LX.grid))
        end

        if BY == 0 then
            RY = Y * math.Clamp(LY.offset, 0, 1 / LY.grid)
        end

        if BY == LY.grid then
            RY = Y * (1 - math.Clamp(LY.offset, 0, 1 / LY.grid))
        end

        return RX + RY
    end

    local function DrawGridLines(vOrigin, vSX, vSY, gridLines, offsetX, offsetY, sign)
        local centerline = (GetConVarNumber("snap_centerline") ~= 0)
        local vTemp = vOrigin + vSX * 0.5
        local vX = vTemp + vSY * (offsetY)
        local vY = vTemp + vSY * (1 - offsetY)
        local vOffset, temp
        local xtemp = ToScreen(vX) - ToScreen(vY)
        xtemp:Normalize()
        local vsNormal = xtemp

        if math.abs(vsNormal.x) < 1 - math.abs(vsNormal.y) then
            temp = -0.5 * sign
        else
            temp = 0.5 * sign
        end

        if math.abs(vsNormal.x) < math.abs(vsNormal.y) then
            vsOffset = Vector(temp, 0, 0)
        else
            vsOffset = Vector(0, temp, 0)
        end

        if offsetX < 1 / gridLines then
            local vTemp = vOrigin + vSX * offsetX
            local vX = vTemp + vSY * offsetY
            local vY = vTemp + vSY * (1 - offsetY)
            local vsX, vsY = LineToScreen(vX, vY)

            if (vsX) then
                DrawScreenLine(vsX + vsOffset, vsY + vsOffset)
            end
        end

        for i = 1, gridLines - 1 do
            local vTemp = vOrigin + vSX * (i / gridLines)
            local vX = vTemp + vSY * offsetY
            local vY = vTemp + vSY * (1 - offsetY)
            local vsX, vsY = LineToScreen(vX, vY)

            if (vsX) then
                if (gridLines / i == 2 and centerline) then
                    DrawScreenLine(vsX + vsOffset * -1, vsY + vsOffset * -1)
                    DrawScreenLine(vsX + vsOffset * 3, vsY + vsOffset * 3)
                else
                    DrawScreenLine(vsX + vsOffset, vsY + vsOffset)
                end
            end
        end

        if offsetX < 1 / gridLines then
            local vTemp = vOrigin + vSX * (1 - offsetX)
            local vX = vTemp + vSY * offsetY
            local vY = vTemp + vSY * (1 - offsetY)
            local vsX, vsY = LineToScreen(vX, vY)

            if (vsX) then
                DrawScreenLine(vsX + vsOffset, vsY + vsOffset)
            end
        end
    end

    local function DrawGrid(vOrigin, vSX, vSY)
        local LX = CalculateGridAxis(vSX)
        local LY = CalculateGridAxis(vSY)
        surface.SetDrawColor(0, 0, 0, math.Round(GetConVarNumber("snap_gridalpha") * 255))
        DrawGridLines(vOrigin, vSX, vSY, LX.grid, LX.offset, LY.offset, 1)
        DrawGridLines(vOrigin, vSY, vSX, LY.grid, LY.offset, LX.offset, 1)
        surface.SetDrawColor(255, 255, 255, math.Round(GetConVarNumber("snap_gridalpha") * 255))
        DrawGridLines(vOrigin, vSX, vSY, LX.grid, LX.offset, LY.offset, -1)
        DrawGridLines(vOrigin, vSY, vSX, LY.grid, LY.offset, LX.offset, -1)
    end

    local function DrawBoundaryLines(vOrigin, vOpposite)
        local vPoint

        if (vOrigin:Distance(vOpposite) > 5) then
            local x = vOpposite - vOrigin
            x:Normalize()
            vPoint = vOrigin + x * 5
        else
            vPoint = vOrigin + (vOpposite - vOrigin) / 2
        end

        local vsA, vsB = LineToScreen(vPoint, vOrigin)

        if (vsA) then
            surface.SetDrawColor(0, 0, 255, 192)
            DrawScreenLine(vsA, vsB)
        end
    end

    local function DrawBoundary(vOrigin, vX, vY, vZ)
        DrawBoundaryLines(vOrigin, vX)
        DrawBoundaryLines(vOrigin, vY)
        DrawBoundaryLines(vOrigin, vZ)
    end

    local function DrawSnapCross(vsCenter, r, g, b)
        surface.SetDrawColor(0, 0, 0, 255)
        DrawScreenLine(vsCenter + Vector(-2.5, -2.0), vsCenter + Vector(2.5, 3.0))
        DrawScreenLine(vsCenter + Vector(1.5, -2.0), vsCenter + Vector(-3.5, 3.0))
        surface.SetDrawColor(r, g, b, 255)
        DrawScreenLine(vsCenter + Vector(-1.5, -2.0), vsCenter + Vector(3.5, 3.0))
        DrawScreenLine(vsCenter + Vector(2.5, -2.0), vsCenter + Vector(-2.5, 3.0))
    end

    local function ComputeEdges(entity, obbmax, obbmin)
        return {
            lsw = entity:LocalToWorld(Vector(obbmin.x, obbmin.y, obbmin.z)),
            lse = entity:LocalToWorld(Vector(obbmax.x, obbmin.y, obbmin.z)),
            lnw = entity:LocalToWorld(Vector(obbmin.x, obbmax.y, obbmin.z)),
            lne = entity:LocalToWorld(Vector(obbmax.x, obbmax.y, obbmin.z)),
            usw = entity:LocalToWorld(Vector(obbmin.x, obbmin.y, obbmax.z)),
            use = entity:LocalToWorld(Vector(obbmax.x, obbmin.y, obbmax.z)),
            unw = entity:LocalToWorld(Vector(obbmin.x, obbmax.y, obbmax.z)),
            une = entity:LocalToWorld(Vector(obbmax.x, obbmax.y, obbmax.z))
        }
    end

    local function OnPaintHUD()
        target.active = false
        if GetConVarNumber("snap_clickgrid") ~= 0 and not snapclick then return end
        snapclickprev = snapclick
        snapclick = snapclickprev and snapclickfade > CurTime()
        if (GetConVarNumber("snap_enabled") == 0) then return end
        if (not LocalPlayer():Alive() or LocalPlayer():InVehicle()) then return end

        if (target.locked) then
            if (not target.entity:IsValid()) then return end
        else
            local trace = LocalPlayer():GetEyeTrace()
            cache.vLookTrace = trace
            if (not trace.HitNonWorld) then return end
            local entity = trace.Entity
            if (entity == nil) then return end
            if (not entity:IsValid()) then return end
            local class = entity:GetClass()
            if (class ~= 'prop_physics' and class ~= 'phys_magnet' and class ~= 'gmod_spawner' and GetConVarNumber('snap_allentities') == 0 or class == 'player') then return end
            if (not LocalPlayer():GetActiveWeapon():IsValid()) then return end
            if (LocalPlayer():GetActiveWeapon():GetClass() == 'weapon_physgun') then return end
            if (LocalPlayer():GetActiveWeapon():GetClass() ~= 'gmod_tool' and GetConVarNumber('snap_alltools') == 0) then return end
            target.entity = entity
        end

        --ErrorNoHalt(collectgarbage("count"))
        if GetConVarNumber("snap_gcboost") ~= 0 then
            collectgarbage("step", GetConVarNumber("snap_gcstrength"))
        end

        snapclick = snapclickprev
        snapclickfade = CurTime() + 0.25
        -- updating the cache perhaps shouldn't be done here, CalcView?
        cache.vLookPos = LocalPlayer():GetShootPos()
        cache.vLookVector = LocalPlayer():GetAimVector()
        cache.vLookClipPos = cache.vLookPos + cache.vLookVector * 3
        local model = string.lower(target.entity:GetModel())
        local offsets = modeloffsets[model]

        if not offsets then
            local offset = 0.25
            offsets = {offset, offset, offset, offset, offset, offset}
        end

        if cache.eEntity ~= target.entity or cache.vEntAngles ~= target.entity:GetAngles() or vEntPosition ~= target.entity:GetPos() then
            cache.eEntity = target.entity
            cache.vEntAngles = target.entity:GetAngles()
            cache.vEntPosition = target.entity:GetPos()
            local obbmax = target.entity:OBBMaxs()
            local obbmin = target.entity:OBBMins()
            local obvsnap = ComputeEdges(target.entity, obbmax, obbmin)
            local obbmax = target.entity:OBBMaxs() - Vector(offsets[5], offsets[3], offsets[1])
            local obbmin = target.entity:OBBMins() + Vector(offsets[6], offsets[4], offsets[2])
            local obvgrid = ComputeEdges(target.entity, obbmax, obbmin)
            local faces = {{obvgrid.unw, obvgrid.usw - obvgrid.unw, obvgrid.une - obvgrid.unw, obvgrid.lnw - obvgrid.unw, Vector(0, 0, -offsets[1])}, {obvgrid.lsw, obvgrid.lnw - obvgrid.lsw, obvgrid.lse - obvgrid.lsw, obvgrid.usw - obvgrid.lsw, Vector(0, 0, offsets[2])}, {obvgrid.unw, obvgrid.une - obvgrid.unw, obvgrid.lnw - obvgrid.unw, obvgrid.usw - obvgrid.unw, Vector(0, -offsets[3], 0)}, {obvgrid.usw, obvgrid.lsw - obvgrid.usw, obvgrid.use - obvgrid.usw, obvgrid.unw - obvgrid.usw, Vector(0, offsets[4], 0)}, {obvgrid.une, obvgrid.use - obvgrid.une, obvgrid.lne - obvgrid.une, obvgrid.unw - obvgrid.une, Vector(-offsets[5], 0, 0)}, {obvgrid.unw, obvgrid.lnw - obvgrid.unw, obvgrid.usw - obvgrid.unw, obvgrid.une - obvgrid.unw, Vector(offsets[6], 0, 0)}}
            cache.aGrid = obvgrid
            cache.aSnap = obvsnap
            cache.aFaces = faces
        end

        local obvgrid = cache.aGrid
        local obvsnap = cache.aSnap
        local faces = cache.aFaces

        if (not target.locked) then
            -- should improve this by expanding the bounding box or something instead!
            -- create a larger bounding box and then planes for each side, and check distance from the plane
            -- separate function perhaps?
            local distance = (LocalPlayer():GetPos() - target.entity:GetPos()):Length() - (obvgrid.unw - obvgrid.lse):Length()
            if (distance > GetConVarNumber("snap_distance")) then return end

            for face, vertices in ipairs(faces) do
                intersection = RayQuadIntersect(cache.vLookPos, cache.vLookVector, vertices[1], vertices[2], vertices[3])

                if (intersection) then
                    target.face = face
                    break
                end
            end

            if intersection == nil then return end
        end

        if (GetConVarNumber("snap_boundingbox") ~= 0) then
            DrawBoundary(obvgrid.unw, obvgrid.lnw, obvgrid.usw, obvgrid.une)
            DrawBoundary(obvgrid.une, obvgrid.lne, obvgrid.use, obvgrid.unw)
            DrawBoundary(obvgrid.lnw, obvgrid.unw, obvgrid.lsw, obvgrid.lne)
            DrawBoundary(obvgrid.lne, obvgrid.une, obvgrid.lse, obvgrid.lnw)
            DrawBoundary(obvgrid.usw, obvgrid.lsw, obvgrid.unw, obvgrid.use)
            DrawBoundary(obvgrid.use, obvgrid.lse, obvgrid.une, obvgrid.usw)
            DrawBoundary(obvgrid.lsw, obvgrid.usw, obvgrid.lnw, obvgrid.lse)
            DrawBoundary(obvgrid.lse, obvgrid.use, obvgrid.lne, obvgrid.lsw)
        end

        local vectorOrigin = faces[target.face][1]
        local vectorX = faces[target.face][2]
        local vectorY = faces[target.face][3]
        local vectorZ = faces[target.face][4]
        local vectorOffset = faces[target.face][5]
        local vectorGrid

        if (not target.locked) then
            vectorGrid = vectorOrigin + CalculateSnap(vectorX, vectorY, intersection)

            local trace = util.TraceLine({
                start = target.entity:LocalToWorld(target.entity:WorldToLocal(vectorGrid) - vectorOffset) - vectorZ:GetNormalized() * 0.01,
                endpos = vectorGrid + vectorZ
            })

            local vectorSnap = trace.HitPos
            target.offset = target.entity:WorldToLocal(vectorSnap)
            target.vector = target.entity:WorldToLocal(vectorGrid)
            target.error = true

            if (trace.Entity == nil or not trace.Entity:IsValid()) then
                snaperror = -1
            elseif (trace.Entity ~= target.entity) then
                snaperror = -2
            elseif (trace.HitPos == trace.StartPos) then
                snaperror = -2
            else
                snaperror = (LocalPlayer():GetEyeTrace().HitPos - trace.HitPos):Length()
                target.error = false

                if ((vectorSnap - vectorGrid):Length() > 0.5) then
                    local marker = PointToScreen(vectorSnap)

                    if (marker) then
                        DrawSnapCross(marker, 255, 255, 255)
                    end
                end
            end
        else
            vectorGrid = target.entity:LocalToWorld(target.vector)
            local vectorSnap = target.entity:LocalToWorld(target.offset)
            local marker = PointToScreen(vectorSnap)
            snaperror = (LocalPlayer():GetEyeTrace().HitPos - vectorSnap):Length()

            if (marker) then
                if (target.error == true) then
                    snaperror = -2
                    DrawSnapCross(marker, 0, 255, 255)
                elseif (snaperror < 0.001) then
                    DrawSnapCross(marker, 0, 255, 0)
                elseif (snaperror < 0.1) then
                    DrawSnapCross(marker, 255, 255, 0)
                else
                    DrawSnapCross(marker, 255, 0, 0)
                end
            end
        end

        if (GetConVarNumber("snap_hidegrid") == 0) then
            DrawGrid(vectorOrigin, vectorX, vectorY)
        end

        target.active = true
        local vsCursor = PointToScreen(vectorGrid)

        if (vsCursor) then
            if (snaperror == -1) then
                target.active = false
                DrawSnapCross(vsCursor, 0, 255, 255)
            elseif (snaperror == -2) then
                DrawSnapCross(vsCursor, 255, 0, 255)
            elseif (snaperror < 0.001) then
                DrawSnapCross(vsCursor, 0, 255, 0)
            elseif (snaperror < 0.1) then
                DrawSnapCross(vsCursor, 255, 255, 0)
            else
                DrawSnapCross(vsCursor, 255, 0, 0)
            end
        end
    end

    local function OnSnapView(player, origin, angles, fov)
        local targetvalid = target.active and target.locked and target.entity:IsValid()
        local snaptargetvalid = snaptarget.active and snaptarget.locked and snaptarget.entity:IsValid()

        if (snapcursor and not snapspawnmenu and targetvalid) then
            local screen = ToScreen(target.entity:LocalToWorld(target.offset))
            gui.SetMousePos(math.Round(screen.x), math.Round(screen.y))
        end

        if (not snapcursor and targetvalid) then
            return {
                angles = (target.entity:LocalToWorld(target.offset) - player:GetShootPos()):Angle()
            }
        elseif (snaplock and snaptargetvalid) then
            return {
                angles = (snaptarget.entity:LocalToWorld(snaptarget.offset) - player:GetShootPos()):Angle()
            }
        end
    end

    local function OnSnapAim(user)
        local targetvalid = target.active and target.locked and target.entity:IsValid()
        local snaptargetvalid = snaptarget.active and snaptarget.locked and snaptarget.entity:IsValid()

        if (not snapcursor and targetvalid) then
            user:SetViewAngles((target.entity:LocalToWorld(target.offset) - LocalPlayer():GetShootPos()):Angle())
        elseif (snaplock and snaptargetvalid) then
            user:SetViewAngles((snaptarget.entity:LocalToWorld(snaptarget.offset) - LocalPlayer():GetShootPos()):Angle())
        end
    end

    concommand.Add("+snap", SnapPress)
    concommand.Add("-snap", SnapRelease)
    concommand.Add("snaplock", SnapLock)
    concommand.Add("snaptogglegrid", SnapToggleGrid)
    hook.Add("Initialize", "SmartsnapInitialize", OnInitialize)
    hook.Add("SpawnMenuOpen", "SmartsnapSpawnMenu", OnSpawnMenu)
    hook.Add("Think", "SmartsnapThink", OnThink)
    hook.Add("ShutDown", "SmartsnapShutDown", OnShutDown)
    hook.Add("KeyPress", "SmartsnapKeyPress", OnKeyPress)
    hook.Add("KeyRelease", "SmartsnapKeyRelease", OnKeyRelease)
    hook.Add("CreateMove", "SmartsnapSnap", OnSnapAim)
    hook.Add("CalcView", "SmartsnapSnapView", OnSnapView)
    hook.Add("SpawnMenuOpen", "SmartsnapSpawnMenu", OnSpawnMenu)
    hook.Add("HUDPaintBackground", "SmartsnapPaintHUD", OnPaintHUD)

    local function OnPopulateToolPanel(panel)
        panel:AddControl("ComboBox", {
            Options = {
                ["default"] = condefs
            },
            CVars = convars,
            Label = "",
            MenuButton = "1",
            Folder = "smartsnap"
        })

        panel:AddControl("CheckBox", {
            Label = "Enable",
            Command = "snap_enabled"
        })

        panel:AddControl("CheckBox", {
            Label = "Use click grid (USE temporarily enables grid)",
            Command = "snap_clickgrid"
        })

        panel:AddControl("CheckBox", {
            Label = "Hide grid (only shows snap point)",
            Command = "snap_hidegrid"
        })

        panel:AddControl("CheckBox", {
            Label = "Smart toggle enabled",
            Command = "snap_enabletoggle"
        })

        panel:AddControl("CheckBox", {
            Label = "Revert aim to grid snap on detach",
            Command = "snap_revertaim"
        })

        panel:AddControl("CheckBox", {
            Label = "Enable for all entities",
            Command = "snap_allentities"
        })

        panel:AddControl("CheckBox", {
            Label = "Enable for all tools",
            Command = "snap_alltools"
        })

        panel:AddControl("CheckBox", {
            Label = "Draw thick center lines",
            Command = "snap_centerline"
        })

        panel:AddControl("Slider", {
            Label = "Grid toggle delay (double click snap-key)",
            Command = "snap_toggledelay",
            Type = "Float",
            Min = "0.0",
            Max = "0.2"
        })

        panel:AddControl("Slider", {
            Label = "Smart lock delay",
            Command = "snap_lockdelay",
            Type = "Float",
            Min = "0.0",
            Max = "5.0"
        })

        panel:AddControl("CheckBox", {
            Label = "Bounding box enabled",
            Command = "snap_boundingbox"
        })

        panel:AddControl("Slider", {
            Label = "Grid draw distance",
            Command = "snap_distance",
            Type = "Integer",
            Min = "50",
            Max = "1000"
        })

        panel:AddControl("Slider", {
            Label = "Grid edge offset",
            Command = "snap_gridoffset",
            Type = "Float",
            Min = "0.0",
            Max = "2.5"
        })

        panel:AddControl("Slider", {
            Label = "Grid transparency",
            Command = "snap_gridalpha",
            Type = "Float",
            Min = "0.1",
            Max = "1.0"
        })

        panel:AddControl("Slider", {
            Label = "Maximum number of snap points on an axis",
            Command = "snap_gridlimit",
            Type = "Integer",
            Min = "2",
            Max = "64"
        })

        panel:AddControl("Slider", {
            Label = "Minimum distance between each snap point",
            Command = "snap_gridsize",
            Type = "Integer",
            Min = "2",
            Max = "64"
        })

        panel:AddControl("Label", {
            Text = ""
        })

        panel:AddControl("Label", {
            Text = "The following option should prevent FPS drops from occuring, however it might have a slight impact on the average FPS while the grid is showing. Do NOT uncheck this option unless you are experiencing very low FPS or fully understands its purpose."
        })

        panel:AddControl("Label", {
            Text = "NOTE: This option is only effective when the grid is showing, it does not impact regular gameplay!"
        })

        panel:AddControl("Label", {
            Text = ""
        })

        panel:AddControl("CheckBox", {
            Label = "Garbage collection boost",
            Command = "snap_gcboost"
        })
    end

    function OnPopulateToolMenu()
        spawnmenu.AddToolMenuOption("Options", "Player", "SmartSnapSettings", "SmartSnap", "", "", OnPopulateToolPanel, {
            SwitchConVar = 'snap_enabled'
        })
    end

    hook.Add("PopulateToolMenu", "SmartSnapToolMenu", OnPopulateToolMenu)
end