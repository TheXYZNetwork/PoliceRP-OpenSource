-- Setup
require("mysqloo")
function xLogs.Database.Connect()
	xLogs.Database.Connection = mysqloo.connect("1.1.1.1", "user_name", "user_password", "database_name", 3306) -- connects
	xLogs.Database.Connection.onConnected = function()
		print("=========================")
		print("xLogs database connected")
		print("=========================")

		print("Migrating data to archive")
		xLogs.Database.Query(string.format("INSERT INTO xlogs_archive SELECT * FROM xlogs WHERE server='%s';", xLogs.Info.FullName))
		xLogs.Database.Query(string.format("DELETE FROM xlogs WHERE server = '%s';", xLogs.Info.FullName))
		xLogs.Database.Query(string.format("DELETE FROM xlogs_archive WHERE time < (NOW() - INTERVAL 3 DAY) AND server='%s';", xLogs.Info.FullName))

	end
	xLogs.Database.Connection.onConnectionFailed = function(db, sqlerror)
		print("=========================")
		print("xLogs database failed:")
		for i=1,10 do
			print(sqlerror)
		end
		print("=========================")
	end
	xLogs.Database.Connection:connect()
end
xLogs.Database.Connect()

function xLogs.Database.Query(q, callback)
	local query = xLogs.Database.Connection:query(q)
	query.onSuccess = function( q, data)
		if callback then
			callback(data,q)
		end
	end
	query:start()
end

function xLogs.Database.Escape(str)
	return xLogs.Database.Connection:escape(str)
end

-- Use functions
function xLogs.Database.CreateCategory(category, parent, name)
	xLogs.Database.Query(string.format("SELECT * FROM xlogs_category WHERE category='%s' AND parent='%s' AND name='%s';", category, parent, name), function(data)
		if data and data[1] then return end
		xLogs.Database.Query(string.format("INSERT INTO xlogs_category(category, parent, name) VALUES ('%s', '%s', '%s');", category, parent, name))
	end)
end




function xLogs.Database.LogEvent(log, category)
	xLogs.Database.Query(string.format("INSERT INTO xlogs (server, log, category) VALUES ('%s', '%s', '%s');", xLogs.Info.FullName, xLogs.Database.Escape(log), xLogs.Database.Escape(category)))
end
