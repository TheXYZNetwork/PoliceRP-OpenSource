--- #
--- # MUTE
--- #
xAdmin.Core.RegisterCommand("mute", "Mute a user", 50, function(admin, args)
	if not args or not args[1] then return end

	local target = xAdmin.Core.GetUser(args[1], admin)
	if not IsValid(target) then
		xAdmin.Core.Msg({Color(46, 170, 200), "[xAdmin] ", Color(255, 255, 255), "Please provide a valid target. The following was not recognised: "..args[1]}, admin)
		return
	end 

    -- Time is in minutes, however the database stores it as seconds.
    local time = xAdmin.Core.CovertTime(args[2] or 5) or 5

    local reason = args[3] or "No reason given"
    if args[4] then
        for k, v in pairs(args) do
            if k < 4 then continue end
            reason = reason.." "..v
        end
    end

	target.xAdmin_Mute = true
	timer.Remove("xAdmin:Mute:"..target:SteamID64())
	timer.Create("xAdmin:Mute:"..target:SteamID64(), time*60, 1, function()
		target.xAdmin_Mute = false
	end)
	xAdmin.Core.Msg({admin, " has muted ", target, " for ", Color(100, 0, 100), string.NiceTime(time*60), Color(255, 255, 255), " with the reason: "..reason})

	xAdmin.Database.LogPunishment("Mute", target, admin, reason, time*60)
    XYZShit.Webhook.Post("wallofshame", xAdmin.Info.FullName, admin:Name().." muted "..target:Name().." ("..target:SteamID64()..") for "..string.NiceTime(time*60).." for "..reason)
end)

--- #
--- # UNMUTE
--- #
xAdmin.Core.RegisterCommand("unmute", "Unmute a user", 50, function(admin, args)
	if not args or not args[1] then return end

	local target = xAdmin.Core.GetUser(args[1], admin)
	if not IsValid(target) then
		xAdmin.Core.Msg({Color(46, 170, 200), "[xAdmin] ", Color(255, 255, 255), "Please provide a valid target. The following was not recognised: "..args[1]}, admin)
		return
	end 

	target.xAdmin_Mute = false
	xAdmin.Core.Msg({admin, " has unmuted ", target})
end)

--- #
--- # MUTE/UNMUTE HOOK
--- #
hook.Add("PlayerSay", "xAdminPlayerGagged", function(ply, text)
	if ply.xAdmin_Mute then
		return ""
	end
end)

--- #
--- # GAG
--- #
xAdmin.Core.RegisterCommand("gag", "Gag a user", 50, function(admin, args)
	if not args or not args[1] then return end

	local target = xAdmin.Core.GetUser(args[1], admin)
	if not IsValid(target) then
		xAdmin.Core.Msg({Color(46, 170, 200), "[xAdmin] ", Color(255, 255, 255), "Please provide a valid target. The following was not recognised: "..args[1]}, admin)
		return
	end 

    -- Time is in minutes, however the database stores it as seconds.
    local time = xAdmin.Core.CovertTime(args[2] or 5) or 5

    local reason = args[3] or "No reason given"
    if args[4] then
        for k, v in pairs(args) do
            if k < 4 then continue end
            reason = reason.." "..v
        end
    end

	target.xAdmin_Gag = true
	timer.Remove("xAdmin:Gag:"..target:SteamID64())
	timer.Create("xAdmin:Gag:"..target:SteamID64(), time*60, 1, function()
		target.xAdmin_Gag = false
	end)
	xAdmin.Core.Msg({admin, " has gagged ", target, " for ", Color(100, 0, 100), string.NiceTime(time*60), Color(255, 255, 255), " with the reason: "..reason})

	xAdmin.Database.LogPunishment("Gag", target, admin, reason, time*60)
    XYZShit.Webhook.Post("wallofshame", xAdmin.Info.FullName, admin:Name().." gagged "..target:Name().." ("..target:SteamID64()..") for "..string.NiceTime(time*60).." for "..reason)
end)


--- #
--- # UNGAG
--- #
xAdmin.Core.RegisterCommand("ungag", "Ungag a user", 50, function(admin, args)
	if not args or not args[1] then return end

	local target = xAdmin.Core.GetUser(args[1], admin)
	if not IsValid(target) then
		xAdmin.Core.Msg({Color(46, 170, 200), "[xAdmin] ", Color(255, 255, 255), "Please provide a valid target. The following was not recognised: "..args[1]}, admin)
		return
	end 

	target.xAdmin_Gag = false
	xAdmin.Core.Msg({admin, " has ungagged ", target})
end)

--- #
--- # GAG/UNGAG HOOK
--- #
hook.Add("PlayerCanHearPlayersVoice", "xAdminPlayerMute", function(listener, talker)
	if talker.xAdmin_Gag then
		return false
	end
end)

--- #
--- # ADMINCHAT
--- #
hook.Add("PlayerSay", "xAdminAdminChat", function(ply, text)
	if string.sub(text, 1, 1) == "@" and ply:HasPower(xAdmin.Config.AdminChat) then
		for k, v in pairs(xAdmin.AdminChat) do
			xAdmin.Core.Msg({Color(46, 170, 200), "[xAdminChat] ", ply, Color(255, 255, 255), ": ", Color(0,150,255), string.TrimLeft(string.sub(text, 2))}, v)
		end
		return ""
	end
end)