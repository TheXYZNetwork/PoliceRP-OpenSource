--- #
--- # SET SECONDARY USERGROUP
--- #
xAdmin.Core.RegisterCommand("setsecondarygroup", "Set a user's secondary group", 93, function(admin, args)
	if not args or not args[1] or not args[2] then return end
	if not xSGroups.Groups[args[2]] then
		xAdmin.Core.Msg({Color(46, 170, 200), "[xAdmin] ", Color(255, 255, 255), args[2].." is not a valid usergroup"}, admin)
		return
	end

	local target, targetPly = xAdmin.Core.GetID64(args[1], admin)
	if not target then 
		xAdmin.Core.Msg({Color(46, 170, 200), "[xAdmin] ", Color(255, 255, 255), "Please provide a valid target. The following was not recognised: "..args[1]}, admin)
		return
	end

	xSGroups.Database.UpdateUsersGroup(target, xAdmin.Database.Escape(args[2]))

	if IsValid(targetPly) then
		xAdmin.Core.Msg({"Your secondary usergroup has been updated to the following: "..args[2]}, targetPly)
		xAdmin.Core.Msg({"You have updated "..targetPly:GetName().."'s secondary usergroup to: "..args[2]}, admin)

		xSGroups.Users[targetPly:SteamID64()] = args[2]

		net.Start("xSGroupsNetworkIDRank")
			net.WriteString(targetPly:SteamID64())
			net.WriteString(xSGroups.Users[targetPly:SteamID64()])
		net.Broadcast()
	else
		xAdmin.Core.Msg({"You have updated "..target.."'s secondary usergroup to: "..args[2]}, admin)
	end
end)


--- #
--- # GET USERGROUP
--- #
xAdmin.Core.RegisterCommand("getsecondarygroup", "Get a user's secondary group", 10, function(admin, args)
	if not args or not args[1] then return end
	local targetID, target = xAdmin.Core.GetID64(args[1], admin)
	if not targetID then
		xAdmin.Core.Msg({Color(46, 170, 200), "[xAdmin] ", Color(255, 255, 255), "Please provide a valid target. The following was not recognised: "..args[1]}, admin)
		return
	end

	if target and target:GetSecondaryUserGroup() then
		xAdmin.Core.Msg({target, "'s secondary usergroup is: "..target:GetSecondaryUserGroup()}, admin)
	else
		xSGroups.Database.GetUsersGroup(targetID, function(data)
			if not data[1] then
				xAdmin.Core.Msg({"No secondary group found with the following ID: "..targetID}, admin)
				return
			end
			xAdmin.Core.Msg({targetID.."'s secondary usergroup is: "..data[1].rank}, admin)
		end)
	end
end)