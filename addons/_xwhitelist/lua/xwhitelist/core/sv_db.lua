-- Setup
require("mysqloo")
function xWhitelist.Database.Connect()
	if xWhitelist.Database.Connection then return end
	xWhitelist.Database.Connection = mysqloo.connect("1.1.1.1", "user_name", "user_password", "database_name", 3306) -- connects
	xWhitelist.Database.Connection.onConnected = function()
		print("=========================")
		print("xWhitelist database connected")
		print("=========================")
		print("Checking and creating the following tables:")

		print(xWhitelist.Info.Name.."_whitelists")
		xWhitelist.Database.Query("CREATE TABLE IF NOT EXISTS "..xWhitelist.Info.Name.."_whitelist(userid VARCHAR(32) NOT NULL, job VARCHAR(64) NOT NULL, UNIQUE KEY `unique_index` (`userid`,`job`))")

		print(xWhitelist.Info.Name.."_blacklist")
		xWhitelist.Database.Query("CREATE TABLE IF NOT EXISTS "..xWhitelist.Info.Name.."_blacklist(userid VARCHAR(32) NOT NULL, job VARCHAR(64) NOT NULL, UNIQUE KEY `unique_index` (`userid`,`job`))")

		print(xWhitelist.Info.Name.."_job_info")
		xWhitelist.Database.Query("CREATE TABLE IF NOT EXISTS "..xWhitelist.Info.Name.."_job_info(job varchar(64) NOT NULL, name varchar(64) NOT NULL, category varchar(64) NOT NULL, PRIMARY KEY (`job`))")

		print("Adding all jobs to the info table")
		for k, v in pairs(RPExtraTeams) do
			xWhitelist.Database.AddNewJob(v.command, v.name, v.category)
		end
		print("- xWhitelist loading complete -")

	end
	xWhitelist.Database.Connection.onConnectionFailed = function(db, sqlerror)
		print("=========================")
		print("xWhitelist database failed:")
		for i=1,10 do
			print(sqlerror)
		end
		print("=========================")
	end
	xWhitelist.Database.Connection:connect()
end
xWhitelist.Database.Connect()

function xWhitelist.Database.Query(q, callback)
	local query = xWhitelist.Database.Connection:query(q)
	query.onSuccess = function( q, data)
		if callback then
			callback(data,q)
		end
	end
	query:start()
end

function xWhitelist.Database.Escape(str)
	return xWhitelist.Database.Connection:escape(str)
end

-- Use functions
function xWhitelist.Database.AddNewJob(job, name, category, callback)
	xWhitelist.Database.Query(string.format("INSERT INTO %s_job_info(job, name, category) VALUES ('%s', '%s', '%s');", xWhitelist.Info.Name, xWhitelist.Database.Escape(job), xWhitelist.Database.Escape(name), xWhitelist.Database.Escape(category)), callback)
end
function xWhitelist.Database.GetUsersWhitelists(userid, callback)
	xWhitelist.Database.Query(string.format("SELECT * FROM %s_whitelist WHERE userid='%s';", xWhitelist.Info.Name, xWhitelist.Database.Escape(userid)), callback)
end
function xWhitelist.Database.GetUsersBlacklists(userid, callback)
	xWhitelist.Database.Query(string.format("SELECT * FROM %s_blacklist WHERE userid='%s';", xWhitelist.Info.Name, xWhitelist.Database.Escape(userid)), callback)
end

function xWhitelist.Database.GiveUserWhitelist(userid, job)
	xWhitelist.Database.Query(string.format("INSERT INTO %s_whitelist(userid, job) VALUES ('%s', '%s');", xWhitelist.Info.Name, xWhitelist.Database.Escape(userid), xWhitelist.Database.Escape(job)))
end
function xWhitelist.Database.RemoveUserWhitelist(userid, job)
	xWhitelist.Database.Query(string.format("DELETE FROM %s_whitelist WHERE userid='%s' AND job='%s';", xWhitelist.Info.Name, xWhitelist.Database.Escape(userid), xWhitelist.Database.Escape(job)))
end

function xWhitelist.Database.GiveUserBlackist(userid, job)
	xWhitelist.Database.Query(string.format("INSERT INTO %s_blacklist(userid, job) VALUES ('%s', '%s');", xWhitelist.Info.Name, xWhitelist.Database.Escape(userid), xWhitelist.Database.Escape(job)))
end
function xWhitelist.Database.RemoveUserBlacklist(userid, job)
	xWhitelist.Database.Query(string.format("DELETE FROM %s_blacklist WHERE userid='%s' AND job='%s';", xWhitelist.Info.Name, xWhitelist.Database.Escape(userid), xWhitelist.Database.Escape(job)))
end