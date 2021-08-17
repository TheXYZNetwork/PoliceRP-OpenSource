--- #
--- # KICK
--- #
xAdmin.Core.RegisterCommand("kick", "Kicks the target player", 30, function(admin, args)
	if not args or not args[1] then return end

	local target = xAdmin.Core.GetUser(args[1], admin)
	if not IsValid(target) then
        xAdmin.Core.Msg({Color(46, 170, 200), "[xAdmin] ", Color(255, 255, 255), "Please provide a valid target. The following was not recognised: "..args[1]}, admin)
		return
	end

    local reason = args[2] or "No reason given"
    if args[3] then
        for k, v in pairs(args) do
            if k < 3 then continue end
            reason = reason.." "..v
        end
    end

    if target:HasPower(admin:GetGroupPower()) then
        xAdmin.Core.Msg({Color(46, 170, 200), "[xAdmin] ", Color(255, 255, 255), target, " out powers you and thus you cannot kick them."}, admin)
        return
    end

    xAdmin.Core.Msg({target:Name(), " has been kicked by ", admin, " for: "..reason})
    target:Kick(reason)

    hook.Run("xAdminPlayerKicked", target, admin, reason)

    xAdmin.Database.LogPunishment("Kick", target, admin, reason, -1) -- -1 because a kick has no time aspect. We can then use this in other places to identify timeless entries.
end)

xAdmin.Core.RegisterCommand("ban", "Bans the target player", 40, function(admin, args)
	if not args or not args[1] then return end

	local target, targetPly = xAdmin.Core.GetID64(args[1], admin)
	if not target then
        xAdmin.Core.Msg({Color(46, 170, 200), "[xAdmin] ", Color(255, 255, 255), "Please provide a valid target. The following was not recognised: "..args[1]}, admin)
		return
	end

    -- Time is in minutes, however the database stores it as seconds.
    local time = xAdmin.Core.CovertTime(args[2] or 0)

    local reason = args[3] or "No reason given"
    if args[4] then
        for k, v in pairs(args) do
            if k < 4 then continue end
            reason = reason.." "..v
        end
    end

    if IsValid(targetPly) then
    	if targetPly:HasPower(admin:GetGroupPower()) then
    		xAdmin.Core.Msg({Color(46, 170, 200), "[xAdmin] ", Color(255, 255, 255), targetPly, " out powers you and thus you cannot ban them."}, admin)
    	    return
    	end


        targetPly:Kick(string.format(xAdmin.Config.BanFormat, admin:Name(), (time==0 and "Permanent") or string.NiceTime(time*60), reason))
    end

    xAdmin.Core.Msg({admin, " has banned ", ((IsValid(targetPly) and targetPly:Name()) or target), " for "..((time==0 and "permanent") or string.NiceTime(time*60)).." with the reason: "..reason})
    xAdmin.Database.CreateBan(target, (IsValid(targetPly) and targetPly:Name()) or "Unknown", admin:SteamID64(), admin:Name(), reason or "No reason given", time*60, function(data, q)
        hook.Run("xAdminPlayerBanned", ((IsValid(targetPly) and targetPly) or target), admin, reason, time * 60, q:lastInsert())
    end)
end)


xAdmin.Core.RegisterCommand("unban", "Unbans the target id", 50, function(admin, args)
    if not args or not args[1] then return end

    local target, targetPly = xAdmin.Core.GetID64(args[1], admin)
    if not target then
        xAdmin.Core.Msg({Color(46, 170, 200), "[xAdmin] ", Color(255, 255, 255), "Please provide a valid target. The following was not recognised: "..args[1]}, admin)
        return
    end

    local canUnBan, msg = hook.Run("xAdminCanUnBan", admin, target)
    if canUnBan == false then 
        xAdmin.Core.Msg({Color(46, 170, 200), "[xAdmin] ", color_white, msg}, admin)
        return
    end

    xAdmin.Core.Msg({admin, " has unbanned ".. target})
    xAdmin.Database.DestroyBan(target)

    hook.Run("xAdminPlayerUnBanned", target, admin)
end)