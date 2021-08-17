-- Setup
hook.Add( "xAdminPostInit", "xWarnSetupDB", function() -- Make sure xAdmin's loaded
	xAdmin.Database.Query("CREATE TABLE IF NOT EXISTS " .. xAdmin.Info.Name .. "_warns(id INTEGER PRIMARY KEY AUTO_INCREMENT, userid VARCHAR(32) NOT NULL, user TEXT NOT NULL, adminid VARCHAR(32) NOT NULL, admin TEXT NOT NULL, reason TEXT(64) NOT NULL, time INT(11) NOT NULL, banid INT(11) DEFAULT NULL)")
end )

function xWarn.Database.CreateWarn(userid, user, adminid, admin, reason, banid, callback)
	xAdmin.Database.Query(string.format("INSERT INTO %s_warns (userid, user, adminid, admin, reason, time, banid) VALUES ('%s', '%s', '%s', '%s', '%s', '%s', %s);", xAdmin.Info.Name, userid, xAdmin.Database.Escape(user) or "Unknown", adminid, xAdmin.Database.Escape(admin) or "Console", xAdmin.Database.Escape(reason) or "No reason given", os.time(), banid or "NULL"), function(data, q)
		if callback then
			callback(data, q)
		end
	end)
end

function xWarn.Database.GetWarns(userid, callback)
	xAdmin.Database.Query(string.format("SELECT * FROM %s_warns WHERE userid='%s';", xAdmin.Info.Name, userid), callback)
end

function xWarn.Database.GetWarnById(id, callback)
	xAdmin.Database.Query(string.format("SELECT * FROM %s_warns WHERE id='%s';", xAdmin.Info.Name, id), callback)
end

function xWarn.Database.DestroyWarn(id)
	xAdmin.Database.Query(string.format("DELETE FROM %s_warns WHERE id='%s';", xAdmin.Info.Name, id))
end

function xWarn.Database.DestroyBanWarn(id)
	xAdmin.Database.Query(string.format("DELETE FROM %s_warns WHERE banid='%s';", xAdmin.Info.Name, id))
end