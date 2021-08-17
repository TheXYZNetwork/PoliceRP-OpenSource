--- #
--- # WARN
--- #
xAdmin.Core.RegisterCommand("warn", "Warn a user", 30, function(admin, args)
	if not args or not args[1] then
		return
	end

	local target, targetPly = xAdmin.Core.GetID64(args[1], admin)

	if not target then
		xAdmin.Core.Msg({xAdmin.Config.ColorLog, "[xWarn] ", color_white, "Please provide a valid target. The following was not recognised: " .. args[1]}, admin)
		return
	end

	local reason = args[2]

	if not reason then 
		xAdmin.Core.Msg({xAdmin.Config.ColorLog, "[xWarn] ", color_white, "Please provide a reason."}, admin)
		return
	end

	if args[3] then
		for k, v in pairs(args) do
			if k < 3 then continue end
			reason = reason .. " " .. v
		end
	end

	xWarn.Database.CreateWarn(target, (IsValid(targetPly) and targetPly:Name()) or "Unknown", admin:SteamID64(), admin:Name(), reason, nil, function(_, q)
		xAdmin.Core.Msg({admin, " warned ", ((IsValid(targetPly) and targetPly) or target), " for: ", Color(255, 0, 0), reason, color_white, " (", Color(128, 0, 128), q:lastInsert(), color_white, ")"})
		hook.Run("xWarnPlayerWarned", target, targetPly, admin, reason)
	end)
end)

--- #
--- # LISTWARNS
--- #
xAdmin.Core.RegisterCommand("warns", "View a user's warnings", 30, function(admin, args)
	if not args or not args[1] then
		return
	end

	local target, targetPly = xAdmin.Core.GetID64(args[1], admin)

	if not target then
		xAdmin.Core.Msg({xAdmin.Config.ColorLog, "[xWarn] ", color_white, "Please provide a valid target. The following was not recognised: " .. args[1]}, admin)
		return
	end

	xWarn.Database.GetWarns(target, function(warns)
		if warns == nil then xWarn.msg("You have no warnings!", user) return end
		for k, v in pairs(warns) do
			xWarn.msg(string.format("%s - \"%s\" (Warned by %s, %s ago.)", v.id, v.reason, v.admin, string.NiceTime(os.time() - v.time)), admin)
			-- Example:
			-- 1 - "Hi!" (Warned by MilkGames, 12 minutes ago.)
			-- ID Reason              Admin       Time ago
		end
		xWarn.msg(table.getn(warns) .. " warnings in total.", admin)
	end)
end)

--- #
--- # MYWARNS
--- #
xAdmin.Core.RegisterCommand("mywarns", "View your warnings", 0, function(user)
	xWarn.Database.GetWarns(user:SteamID64(), function(warns)
		if warns == nil then xWarn.msg("You have no warnings!", user) return end 
		for k, v in pairs(warns) do
			xWarn.msg(string.format("%s - \"%s\" (Warned by %s, %s ago.)", v.id, v.reason, v.admin, string.NiceTime(os.time() - v.time)), user)
			-- Example:
			-- 1 - "Hi!" (Warned by MilkGames, 12 minutes ago.)
			-- ID Reason              Admin       Time ago
		end
		xWarn.msg(table.getn(warns) .. " warnings in total.", user)
	end)
end)

--- #
--- # DELETEWARN
--- #
xAdmin.Core.RegisterCommand("deletewarn", "Delete a warning (by ID)", 40, function(admin, args)
	if not args or not args[1] then
		return
	end
	if (not tonumber(args[1])) then
		xAdmin.Core.Msg({Color(46, 170, 200), "[xWarn] ", color_white, "'" .. args[1] .. "' is not an ID. Please provide a valid ID."}, admin)
		return
	end
	xWarn.Database.GetWarnById(args[1], function(warn)
		if warn and warn[1] then
			local canDelete, msg = hook.Run("xWarnCanDeleteWarning", admin, warn[1])
			if canDelete == false then
				xAdmin.Core.Msg({Color(46, 170, 200), "[xWarn] ", color_white, msg}, admin)
				return
			end
			xWarn.Database.DestroyWarn(args[1])
			xAdmin.Core.Msg({admin, " deleted warning with ID ", args[1]})
			hook.Run("xWarnWarningDeleted", args[1], admin)
		else 
			xAdmin.Core.Msg({Color(46, 170, 200), "[xWarn] ", color_white, "'" .. args[1] .. "' is not a valid ID. Please provide a valid ID."}, admin)
		end
	end )
end)