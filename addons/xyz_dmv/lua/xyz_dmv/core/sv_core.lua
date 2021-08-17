net.Receive("xyz_dmv_addpoint", function(_, ply)
    if XYZShit.CoolDown.Check("DMV:AddPoint", 5, ply) then return end

    if not DMV.Config.PointManager[ply:Team()] then XYZShit.Msg("DMV", DMV.Config.Color, "You cannot manage the DMV", ply) return end
    local target = net.ReadEntity()
    if not IsValid(target) then return end
    if target:isCP()  then XYZShit.Msg("DMV", DMV.Config.Color, "This user is a Government official", ply) return end
    if licensedUsers[target:SteamID64()] ~= nil then
        XYZShit.DataBase.Query(string.format("UPDATE dmv_license SET points = points + 1 WHERE steamid='%s'", target:SteamID64()))
        XYZShit.Msg("DMV", DMV.Config.Color, ply:Nick().." has given you a point on your license", target)
        XYZShit.Msg("DMV", DMV.Config.Color, "You gave "..target:Nick().." a point on their license", ply)
        hook.Call("DMVPoint", nil, ply, target)
        XYZShit.DataBase.Query(string.format("SELECT * FROM dmv_license WHERE steamid='%s'", target:SteamID64()), function(data)
            if data[1] then
                licensedUsers[target:SteamID64()] = data[1].points
                if data[1].points < DMV.Config.MaxPoints then return end
                XYZShit.DataBase.Query(string.format("INSERT INTO dmv_revokes (steamid, date) VALUES ('%s', '%s') ON DUPLICATE KEY UPDATE date='%s', total = total + 1;", target:SteamID64(), os.time(), os.time()))
                XYZShit.DataBase.Query(string.format("DELETE FROM dmv_license WHERE steamid='%s'", target:SteamID64()))
                XYZShit.Msg("DMV", DMV.Config.Color, "Your license has been automatically revoked for hitting the maximum points on your license", target)
                XYZShit.Msg("DMV", DMV.Config.Color, target:Nick().."'s license was automatically revoked for hitting the maximum points on their license", ply)
                target:StripWeapon("weapon_drivers_license")
                licensedUsers[target:SteamID64()] = nil
                hook.Call("DMVRevoked", nil, target)
            end
        end )
    else
        XYZShit.Msg("DMV", DMV.Config.Color, "This player doesn't have a drivers license", ply)
    end
end)

net.Receive("xyz_dmv_rempoint", function(_, ply)
    if XYZShit.CoolDown.Check("DMV:RemovePoint", 5, ply) then return end

    if not DMV.Config.PointManager[ply:Team()] then XYZShit.Msg("DMV", DMV.Config.Color, "You cannot manage the DMV", ply) return end
    local target = net.ReadEntity()
    if not IsValid(target) then return end
    if target:isCP()  then XYZShit.Msg("DMV", DMV.Config.Color, "This user is a Government official", ply) return end
    if licensedUsers[target:SteamID64()] ~= nil then
        if licensedUsers[target:SteamID64()] == 0 then XYZShit.Msg("DMV", DMV.Config.Color, "This player has no points to remove", ply) return end
        XYZShit.DataBase.Query(string.format("UPDATE dmv_license SET points = points - 1 WHERE steamid='%s'", target:SteamID64()))
        XYZShit.Msg("DMV", DMV.Config.Color, ply:Nick().." has removed a point on your license", target)
        XYZShit.Msg("DMV", DMV.Config.Color, "You removed a point from "..target:Nick().."'s license", ply)
        hook.Call("DMVRemovePoint", nil, ply, target)
        XYZShit.DataBase.Query(string.format("SELECT * FROM dmv_license WHERE steamid='%s'", target:SteamID64()), function(data)
            if data[1] then
                licensedUsers[target:SteamID64()] = data[1].points
            end 
        end)
    else
        XYZShit.Msg("DMV", DMV.Config.Color, "This player doesn't have a drivers license", ply)
    end
end)

net.Receive("xyz_dmv_getpoints", function(_, ply)
    if not DMV.Config.PointManager[ply:Team()] then XYZShit.Msg("DMV", DMV.Config.Color, "You cannot manage the DMV", ply) return end
    local target = net.ReadEntity()
    if not IsValid(target) then return end
    if licensedUsers[target:SteamID64()] ~= nil then
        if licensedUsers[target:SteamID64()] == 0 then XYZShit.Msg("DMV", DMV.Config.Color, "This player has no points", ply) return end
        XYZShit.Msg("DMV", DMV.Config.Color, "This player has "..licensedUsers[target:SteamID64()].." point(s)", ply)
    else
        XYZShit.Msg("DMV", DMV.Config.Color, "This player doesn't have a drivers license", ply)
    end
end)

net.Receive("xyz_dmv_response", function(_, ply)
    local npc = net.ReadEntity()
    local tbl = net.ReadTable()

    if npc:GetClass() != "xyz_dmv" then return end
    if npc:GetPos():Distance(ply:GetPos()) > 500 then return end
    if npc.coolDown > CurTime() then return end
    npc.coolDown = CurTime() + 0.5

    for k, v in pairs(tbl) do
        local data = npc.Questions[k]
        if not (v == data.a) then
            XYZShit.Msg("DMV", DMV.Config.Color, "You have failed the test, you may retake it at any time.", ply)
            return
        end
    end

    if licensedUsers[ply:SteamID64()] then return end
    
    XYZShit.DataBase.Query(string.format("SELECT * FROM dmv_revokes WHERE steamid='%s'", ply:SteamID64()), function(data)
        if data[1] then
            if not ply:canAfford(5000*data[1].total) then XYZShit.Msg("DMV", DMV.Config.Color, "You can't afford a drivers license", ply) return end
            ply:addMoney(-5000*data[1].total)
            XYZShit.Msg("DMV", DMV.Config.Color, "You paid "..DarkRP.formatMoney(5000*data[1].total).." due to previous license revocations", ply)
        end 
        ply:Give("weapon_drivers_license")
        XYZShit.DataBase.Query(string.format("INSERT INTO dmv_license VALUES('%s', '%s', 0)", ply:SteamID64(), os.time()))
        licensedUsers[ply:SteamID64()] = 0
        Quest.Core.ProgressQuest(ply, "joyrider", 1)
        XYZShit.Msg("DMV", DMV.Config.Color, "You have passed the test. You have been issued your brand new drivers license. Drive safe now!", ply)
        hook.Call("DMVPassed", nil, ply)
    end )
end)

hook.Add("PlayerInitialSpawn", "xyz_license_load", function(ply)
    XYZShit.DataBase.Query(string.format("SELECT * FROM dmv_license WHERE steamid='%s'", ply:SteamID64()), function(data)
        if data[1] then
            licensedUsers[ply:SteamID64()] = data[1].points
            timer.Simple(0.5, function()
                ply:Give("weapon_drivers_license")
            end)
        end
    end)
end)

hook.Add("PlayerSpawn", "xyz_license_give", function(ply)
    if licensedUsers[ply:SteamID64()] then
        timer.Simple(0.5, function()
            if not IsValid(ply) then return end
            ply:Give("weapon_drivers_license")
        end)
    end
end)

hook.Add("playerUnArrested", "xyz_license_give", function(ply)
    if licensedUsers[ply:SteamID64()] then
        timer.Simple(0.5, function()
            ply:Give("weapon_drivers_license")
        end)
    end
end)