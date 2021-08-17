-- Setup
hook.Add("xAdminPostInit", "xSGroupSetupDB", function() -- Make sure xAdmin's loaded
	xAdmin.Database.Query("CREATE TABLE IF NOT EXISTS "..xAdmin.Info.Name.."_secondary_user(userid VARCHAR(32) NOT NULL PRIMARY KEY, `rank` TEXT NOT NULL)")
	print(xAdmin.Info.Name.."_secondary_user")
end)

-- Use functions
function xSGroups.Database.UpdateUsersGroup(userid, rank)
	xAdmin.Database.Query(string.format("INSERT INTO %s_secondary_user (userid, `rank`) VALUES ('%s', '%s') ON DUPLICATE KEY UPDATE `rank`='%s';", xAdmin.Info.Name, userid, xAdmin.Database.Escape(rank), xAdmin.Database.Escape(rank)))
end

function xSGroups.Database.GetUsersGroup(userid, callback)
	xAdmin.Database.Query(string.format("SELECT * FROM %s_secondary_user WHERE userid='%s';", xAdmin.Info.Name, userid), callback)
end
