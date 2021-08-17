function XYZBadges.Core.GiveIDBadge(id, id_name)
	XYZShit.DataBase.Query(string.format("INSERT INTO badges VALUES(%s, '%s', '0', '%s')", XYZShit.DataBase.Escape(id), XYZShit.DataBase.Escape(id_name), "true")) -- Good luck injecting through this.
end

function XYZBadges.Core.IDHasBadge(id, id_name, callback)
	XYZShit.DataBase.Query(string.format("SELECT * FROM badges WHERE userid=%s AND badge='%s'", XYZShit.DataBase.Escape(id), XYZShit.DataBase.Escape(id_name)), function(data)
		if data and data[1] then
			callback(true)
			return
		end
		callback(false)
	end)
end

hook.Add("PlayerInitialSpawn", "xyz_badges_load", function(ply)
	XYZBadges.Core.UsersBadges[ply:SteamID64()] = {}
	XYZShit.DataBase.Query(string.format("SELECT * FROM badges WHERE userid=%s", ply:SteamID64()), function(data)
		if not data then return end
		
		for k, v in pairs(data) do
			XYZBadges.Core.UsersBadges[ply:SteamID64()][v.badge] = true
		end
		net.Start("xyz_badge_network_general")
			net.WriteString(ply:SteamID64())
			net.WriteTable(XYZBadges.Core.UsersBadges[ply:SteamID64()])
		net.Broadcast()

		local otherBadges = {}
		for k, v in pairs(player.GetAll()) do
			if not table.IsEmpty(XYZBadges.Core.UsersBadges[v:SteamID64()]) then
				otherBadges[v:SteamID64()] = XYZBadges.Core.UsersBadges[v:SteamID64()]
			end
		end

		net.Start("xyz_badge_network_join")
			net.WriteTable(otherBadges)
		net.Send(ply)
	end)
end)

net.Receive("xyz_badge_admin_give", function(_, ply)
	if not ply:IsAdmin() then return end
	local id = net.ReadString()
	local badge = net.ReadString()

	local target = player.GetBySteamID64(id)
	if target then
		target:GiveBadge(badge)
	else
		XYZBadges.Core.IDHasBadge(id, badge, function(hasBadge)
			if hasBadge then return end
			XYZBadges.Core.GiveIDBadge(id, badge)
		end)
	end
end)

concommand.Add("badge_give", function(ply, cmd, args)
	if not (ply == NULL) then return end
	if (not args[1]) then print("Invalid SteamID64") return end
	if (not args[2]) or (not XYZBadges.Config.Badges[args[2]]) then
		print("Please rerun the command with one of these badge options")
		for k, v in pairs(XYZBadges.Config.Badges) do
			print(k)
		end
		return
	end

	local target = player.GetBySteamID64(args[1])
	if target then
		target:GiveBadge(args[2])
	else
		XYZBadges.Core.IDHasBadge(args[1], args[2], function(hasBadge)
			if hasBadge then return end
			XYZBadges.Core.GiveIDBadge(args[1], args[2])
		end)
	end
end)