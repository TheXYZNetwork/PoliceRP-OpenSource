-- CREATE TABLE play_time (userid TEXT, total INTEGER, last INTEGER)
util.AddNetworkString("xyz_time_self")
util.AddNetworkString("xyz_time_request")
util.AddNetworkString("xyz_time_request_return")
util.AddNetworkString("xyz_time_broadcast")

local days10 = 60*60*24*10
hook.Add("PlayerInitialSpawn", "xyz_time_load", function(ply)
	XYZShit.DataBase.Query(string.format("SELECT * FROM play_time WHERE userid='%s'", ply:SteamID64()), function(data)
		if not data or not data[1] then
			XYZShit.DataBase.Query(string.format("INSERT INTO play_time VALUES('%s', 0, %i)", ply:SteamID64(), os.time()))

			ply.xyz_timeJoined = os.time()
			ply.xyz_timeTotal = 0

			net.Start("xyz_time_self")
				net.WriteInt(0, 32)
			net.Send(ply)

			net.Start("xyz_time_broadcast")
				net.WriteString(ply:SteamID64())
				net.WriteInt(0, 32)
			net.Broadcast()
		else
			XYZShit.DataBase.Query(string.format("UPDATE play_time SET last=%i WHERE userid='%s'", os.time(), ply:SteamID64()))

			ply.xyz_timeJoined = os.time()
			ply.xyz_timeTotal = data[1].total


			timer.Simple(1, function()
				if not ply:HasBadge(id_name) then
					if ply.xyz_timeTotal >= days10 then
						ply:GiveBadge("nolifer")
					end
				end
			end)

			net.Start("xyz_time_self")
				net.WriteInt(data[1].total, 32)
			net.Send(ply)

			net.Start("xyz_time_broadcast")
				net.WriteString(ply:SteamID64())
				net.WriteInt(data[1].total, 32)
			net.Broadcast()
		end
	end)
end)

hook.Add("PlayerDisconnected", "xyz_time_leave", function(ply)
	XYZShit.DataBase.Query(string.format("UPDATE play_time SET total=%i WHERE userid='%s'", ply.xyz_timeTotal + os.difftime(os.time(), ply.xyz_timeJoined), ply:SteamID64()))
end)

net.Receive("xyz_time_request", function(_, ply)
	local tbl = {}
	for k, v in pairs(player.GetAll()) do
		table.insert(tbl, {ply = v:SteamID64(), time = v.xyz_timeTotal, join = os.difftime(os.time(), v.xyz_timeJoined)})
	end
	net.Start("xyz_time_request_return")
		net.WriteTable(tbl)
	net.Send(ply)
end)

timer.Create("xyz_timer_update", 60*15, 0, function()
	for k, v in pairs(player.GetAll()) do
		XYZShit.DataBase.Query(string.format("UPDATE play_time SET total=%i WHERE userid='%s'", v.xyz_timeTotal + os.difftime(os.time(), v.xyz_timeJoined), v:SteamID64()))
		if not v:HasBadge(id_name) then
			if v.xyz_timeTotal >= days10 then
				v:GiveBadge("nolifer")
			end
		end
	end
end)