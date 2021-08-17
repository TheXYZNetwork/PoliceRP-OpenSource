local function ccLock(ply, args)
    if ply:EntIndex() == 0 then
        print(DarkRP.getPhrase("cmd_cant_be_run_server_console"))
        return
    end

    local trace = ply:GetEyeTrace()
    local ent = trace.Entity

    if not IsValid(ent) or not ent:isKeysOwnable() or ply:EyePos():DistToSqr(ent:GetPos()) > 40000 then
        DarkRP.notify(ply, 1, 4, DarkRP.getPhrase("must_be_looking_at", DarkRP.getPhrase("door_or_vehicle")))
        return
    end

    DarkRP.notify(ply, 0, 4, DarkRP.getPhrase("locked"))

    ent:keysLock()

    if not ent:CreatedByMap() then return end
    MySQLite.query(string.format([[REPLACE INTO darkrp_door VALUES(%s, %s, %s, 1, %s);]],
        MySQLite.SQLStr(ent:doorIndex()),
        MySQLite.SQLStr(string.lower(game.GetMap())),
        MySQLite.SQLStr(ent:getKeysTitle() or ""),
        ent:getKeysNonOwnable() and 1 or 0
        ))

    DarkRP.log(ply:Nick() .. " (" .. ply:SteamID() .. ") force-locked a door with forcelock (locked door is saved)", Color(30, 30, 30))
    DarkRP.notify(ply, 0, 4, "Forcefully locked")
end
DarkRP.definePrivilegedChatCommand("forcelock", "DarkRP_ChangeDoorSettings", ccLock)

local function ccUnLock(ply, args)
    if ply:EntIndex() == 0 then
        print(DarkRP.getPhrase("cmd_cant_be_run_server_console"))
        return
    end

    local trace = ply:GetEyeTrace()
    local ent = trace.Entity

    if not IsValid(ent) or not ent:isKeysOwnable() or ply:EyePos():DistToSqr(ent:GetPos()) > 40000 then
        DarkRP.notify(ply, 1, 4, DarkRP.getPhrase("must_be_looking_at", DarkRP.getPhrase("door_or_vehicle")))
        return
    end

    DarkRP.notify(ply, 0, 4, DarkRP.getPhrase("unlocked"))
    ent:keysUnLock()

    if not ent:CreatedByMap() then return end
    MySQLite.query(string.format([[REPLACE INTO darkrp_door VALUES(%s, %s, %s, 0, %s);]],
        MySQLite.SQLStr(ent:doorIndex()),
        MySQLite.SQLStr(string.lower(game.GetMap())),
        MySQLite.SQLStr(ent:getKeysTitle() or ""),
        ent:getKeysNonOwnable() and 1 or 0
        ))

    DarkRP.log(ply:Nick() .. " (" .. ply:SteamID() .. ") force-unlocked a door with forcelock (unlocked door is saved)", Color(30, 30, 30))
    DarkRP.notify(ply, 0, 4, "Forcefully unlocked")
end
DarkRP.definePrivilegedChatCommand("forceunlock", "DarkRP_ChangeDoorSettings", ccUnLock)
