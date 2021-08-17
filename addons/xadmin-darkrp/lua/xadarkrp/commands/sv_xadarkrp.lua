--- #
--- # forcerpname
--- #
xAdmin.Core.RegisterCommand("forcerpname", "[DarkRP] Set someone's RPName", 80, function(admin, args)
	if not args or not args[1] then
		return
	end

	local target, targetPly = xAdmin.Core.GetID64(args[1], admin)

	if not targetPly then
		xAdmin.Core.Msg({xAdmin.Config.ColorLog, "[xADarkRP] ", color_white, "Please provide a valid target. The following was not recognised: " .. args[1]}, admin)
		return
	end

	local name = args[2]

	if not name then
		xAdmin.Core.Msg({xAdmin.Config.ColorLog, "[xADarkRP] ", color_white, "Please provide an RPName."}, admin)
		return
	end

	if args[3] then
		for k, v in pairs(args) do
			if k < 3 then continue end
			name = name .. " " .. v
		end
	end

	DarkRP.storeRPName(targetPly, name)
    targetPly:setDarkRPVar("rpname", name)

	xAdmin.Core.Msg({admin, " forced ", targetPly, "'s RPName to: ", Color(128, 0, 128), name})
end)

--- #
--- # freerpname
--- #
xAdmin.Core.RegisterCommand("freerpname", "[DarkRP] Free an RPName", 80, function(admin, args)
	if not args or not args[1] then
		return
	end

	local name = args[1]

	if not name then
		xAdmin.Core.Msg({xAdmin.Config.ColorLog, "[xADarkRP] ", color_white, "Please provide an RPName."}, admin)
		return
	end

	if args[2] then
		for k, v in pairs(args) do
			if k < 2 then continue end
			name = name .. " " .. v
		end
	end

	MySQLite.query(("UPDATE darkrp_player SET rpname = NULL WHERE rpname = %s"):format(MySQLite.SQLStr(name)))

	xAdmin.Core.Msg({admin, " freed RPName ", Color(128, 0, 128), name})
end)

--- #
--- # forceunown
--- #
xAdmin.Core.RegisterCommand("forcesell", "[DarkRP] Force sell the door you're looking at", 80, function(admin)
	local door = admin:GetEyeTrace().Entity
	if not IsValid(door) then return end

	door:removeAllKeysExtraOwners()
	door:removeAllKeysAllowedToOwn()
	door:Fire("unlock", "", 0)
	door:keysUnOwn(door:getDoorOwner())
	door:setKeysTitle(nil)

	xAdmin.Core.Msg({admin, " force sold a door."})
end)

--- #
--- # forceunownall
--- #
xAdmin.Core.RegisterCommand("forceunownall", "[DarkRP] Force unown all doors owned by a player", 80, function(admin, args)
	if not args or not args[1] then
		return
	end

	local target, targetPly = xAdmin.Core.GetID64(args[1], admin)

	if not targetPly then
		xAdmin.Core.Msg({xAdmin.Config.ColorLog, "[xADarkRP] ", color_white, "Please provide a valid target. The following was not recognised: " .. args[1]}, admin)
		return
	end

	targetPly:keysUnOwnAll()

	xAdmin.Core.Msg({admin, " force unowned all doors owned by ", targetPly})
end)

--- #
--- # forceremoveowner
--- #
xAdmin.Core.RegisterCommand("forceremoveowner", "[DarkRP] Force remove an owner from the door you're looking at", 80, function(admin, args)
	local door = admin:GetEyeTrace().Entity
	if not IsValid(door) then return end

	if not args or not args[1] then
		return
	end

	local target, targetPly = xAdmin.Core.GetID64(args[1], admin)

	if not targetPly then
		xAdmin.Core.Msg({xAdmin.Config.ColorLog, "[xADarkRP] ", color_white, "Please provide a valid target. The following was not recognised: " .. args[1]}, admin)
		return
	end

	if door:isKeysAllowedToOwn(targetPly) then
        door:removeKeysAllowedToOwn(targetPly)
    end

    if door:isMasterOwner(targetPly) then
        door:keysUnOwn()
    elseif door:isKeysOwnedBy(targetPly) then
       door:removeKeysDoorOwner(targetPly)
    end

	xAdmin.Core.Msg({admin, " force unowned a door from ", targetPly})
end)

--- #
--- # removemoney
--- #
xAdmin.Core.RegisterCommand("removemoney", "[DarkRP] Remove money from someone's wallet", 90, function(admin, args)
	if not args or not args[1] then
		return
	end

	local target, targetPly = xAdmin.Core.GetID64(args[1], admin)

	if not targetPly then
		xAdmin.Core.Msg({xAdmin.Config.ColorLog, "[xADarkRP] ", color_white, "Please provide a valid target. The following was not recognised: " .. args[1]}, admin)
		return
	end

	local amount = tonumber(args[2])

	if not amount or amount <= 0 then
		xAdmin.Core.Msg({xAdmin.Config.ColorLog, "[xADarkRP] ", color_white, "Please provide a valid amount you want to remove from the target"}, admin)
		return
	end

	if not targetPly:canAfford(amount) then return end
	targetPly:addMoney(-amount)

	xAdmin.Core.Msg({admin, " has removed ", Color(0, 255, 0), DarkRP.formatMoney(amount), Color(255, 255, 255), " from ", targetPly})
end)

--- #
--- # addmoney
--- #
xAdmin.Core.RegisterCommand("addmoney", "[DarkRP] Add money to someone's wallet", 90, function(admin, args)
	if not args or not args[1] then
		return
	end

	local target, targetPly = xAdmin.Core.GetID64(args[1], admin)

	if not targetPly then
		xAdmin.Core.Msg({xAdmin.Config.ColorLog, "[xADarkRP] ", color_white, "Please provide a valid target. The following was not recognised: " .. args[1]}, admin)
		return
	end

	local amount = tonumber(args[2])

	if not amount or amount <= 0 then
		xAdmin.Core.Msg({xAdmin.Config.ColorLog, "[xADarkRP] ", color_white, "Please provide a valid amount you want to add to the target"}, admin)
		return
	end

	targetPly:addMoney(amount)

	xAdmin.Core.Msg({admin, " has added ", Color(0, 255, 0), DarkRP.formatMoney(amount), Color(255, 255, 255), " to ", targetPly})
end)