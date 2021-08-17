-- Setup
require("mysqloo")
function xAdmin.Database.Connect()
	if xAdmin.Database.Connection then return end
	xAdmin.Database.Connection = mysqloo.connect("1.1.1.1", "user_name", "user_password", "database_name", 3306) -- connects
	xAdmin.Database.Connection.onConnected = function()
		print("=========================")
		print("xAdmin database connected")
		print("=========================")
		print("Checking and creating the following tables:")

		hook.Run( "xAdminPostInit" )

		print(xAdmin.Info.Name.."_active_bans")
		xAdmin.Database.Query("CREATE TABLE IF NOT EXISTS "..xAdmin.Info.Name.."_active_bans(userid VARCHAR(32) NOT NULL PRIMARY KEY, user TEXT NOT NULL, adminid VARCHAR(32) NOT NULL, admin TEXT NOT NULL, reason TEXT NOT NULL, start INT(11) NOT NULL, _end INT(11) NOT NULL)")

		print(xAdmin.Info.Name.."_users")
		xAdmin.Database.Query("CREATE TABLE IF NOT EXISTS "..xAdmin.Info.Name.."_users(userid VARCHAR(32) NOT NULL PRIMARY KEY, rank TEXT NOT NULL)")

		print("xadmin_ban_archive")
		xAdmin.Database.Query("CREATE TABLE IF NOT EXISTS xadmin_ban_archive(id INT(11) NOT NULL AUTO_INCREMENT, userid VARCHAR(32) NOT NULL, user TEXT NOT NULL, adminid VARCHAR(32) NOT NULL, admin TEXT NOT NULL, reason TEXT NOT NULL, server TEXT NOT NULL, start INT(11) NOT NULL, end INT(11) NOT NULL, PRIMARY KEY (id))")

		print("xadmin_punishment_archive")
		xAdmin.Database.Query("CREATE TABLE IF NOT EXISTS xadmin_punishment_archive(id INT(11) NOT NULL AUTO_INCREMENT, userid VARCHAR(32) NOT NULL, user TEXT NOT NULL, adminid VARCHAR(32) NOT NULL, admin TEXT NOT NULL, punishment VARCHAR(128) NOT NULL, reason TEXT NOT NULL, length INT(6) NOT NULL, server TEXT NOT NULL, created INT(11) NOT NULL, PRIMARY KEY (id))")

	end
	xAdmin.Database.Connection.onConnectionFailed = function(db, sqlerror)
		print("=========================")
		print("xAdmin database failed:")
		for i=1,10 do
			print(sqlerror)
		end
		print("=========================")
	end
	xAdmin.Database.Connection:connect()
end
xAdmin.Database.Connect()

function xAdmin.Database.Query(q, callback)
	local query = xAdmin.Database.Connection:query(q)
	query.onSuccess = function( q, data)
		if callback then
			callback(data,q)
		end
	end
	query:start()
end

function xAdmin.Database.Escape(str)
	return xAdmin.Database.Connection:escape(str)
end

-- Use functions
function xAdmin.Database.UpdateUsersGroup(userid, rank)
	xAdmin.Database.Query(string.format("INSERT INTO %s_users (userid, rank) VALUES ('%s', '%s') ON DUPLICATE KEY UPDATE rank='%s';", xAdmin.Info.Name, userid, rank, rank))
end
function xAdmin.Database.GetUsersGroup(userid, callback)
	xAdmin.Database.Query(string.format("SELECT * FROM %s_users WHERE userid='%s';", xAdmin.Info.Name, userid), callback)
end


-- Ban functions
function xAdmin.Database.CreateBan(userid, user, adminid, admin, reason, tEnd, callback)
	xAdmin.Database.Query(string.format("INSERT INTO %s_active_bans (userid, user, adminid, admin, reason, start, _end) VALUES ('%s', '%s', '%s', '%s', '%s', %s, %s) ON DUPLICATE KEY UPDATE adminid='%s', admin='%s', reason='%s', start=%s, _end=%s;", xAdmin.Info.Name, userid, xAdmin.Database.Escape(user) or "Unknown", adminid, xAdmin.Database.Escape(admin) or "Console", xAdmin.Database.Escape(reason) or "No reason given", os.time(), tEnd, adminid, xAdmin.Database.Escape(admin) or "Console", xAdmin.Database.Escape(reason) or "No reason given", os.time(), tEnd))
	xAdmin.Database.Query(string.format("INSERT INTO xadmin_ban_archive (userid, user, adminid, admin, reason, server, start, end) VALUES ('%s', '%s', '%s', '%s', '%s', '%s', %s, %s);", userid, xAdmin.Database.Escape(user) or "Unknown", adminid, xAdmin.Database.Escape(admin) or "Console", xAdmin.Database.Escape(reason) or "No reason given", xAdmin.Info.FullName, os.time(), tEnd), callback)
end

function xAdmin.Database.DestroyBan(userid)
	xAdmin.Database.Query(string.format("DELETE FROM %s_active_bans WHERE userid='%s';", xAdmin.Info.Name, userid))
end

function xAdmin.Database.IsBanned(userid, callback)
	xAdmin.Database.Query(string.format("SELECT * FROM %s_active_bans WHERE userid='%s';", xAdmin.Info.Name, userid), callback)
end

function xAdmin.Database.LastBan(userid, callback)
	xAdmin.Database.Query(string.format("SELECT * FROM xadmin_ban_archive WHERE userid='%s' ORDER BY id DESC LIMIT 1;", userid), callback)
end

-- Other functions
function xAdmin.Database.LogPunishment(punishment, user, admin, reason, length)
	xAdmin.Database.Query(string.format("INSERT INTO xadmin_punishment_archive (userid, user, adminid, admin, punishment, reason, length, server, created) VALUES ('%s', '%s', '%s', '%s', '%s', '%s', %s, '%s', %s);", user:SteamID64(), xAdmin.Database.Escape(user:Name()), IsValid(admin) and admin:SteamID64() or "0", IsValid(admin) and xAdmin.Database.Escape(admin:Name()) or "Console", xAdmin.Database.Escape(punishment), xAdmin.Database.Escape(reason) or "No reason given", length, xAdmin.Info.FullName, os.time()))
end