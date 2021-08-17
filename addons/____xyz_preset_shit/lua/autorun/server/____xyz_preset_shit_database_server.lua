XYZShit.DataBase = {}

-- The IP of the database
XYZShit.DataBase.IP = "1.1.1.1"
-- The name of the database
XYZShit.DataBase.Name = "database_name" -- Table 1
-- The username to connect with
XYZShit.DataBase.Username = "user_name"
-- The password for that username
XYZShit.DataBase.Password = "user_password"


require("mysqloo")
-- Connection 1
function XYZShit.DataBase.Connect()
	XYZShit.DataBase.Database = mysqloo.connect(XYZShit.DataBase.IP, XYZShit.DataBase.Username, XYZShit.DataBase.Password, XYZShit.DataBase.Name, 3306) -- connects
	XYZShit.DataBase.Database.onConnected = function()
		print("XYZShit Database connected")

		print("Running hook XYZShitDBConnected:")
		hook.Run("XYZShitDBConnected")
	end
	XYZShit.DataBase.Database.onConnectionFailed = function( sqlerror )
		for i=1,10 do
			print("XYZShit Database connection failed. Error message:")
			print(sqlerror)
		end
	end
	XYZShit.DataBase.Database:connect()
end
XYZShit.DataBase.Connect()

function XYZShit.DataBase.Query(q, callback)
	local query = XYZShit.DataBase.Database:query(q)
	query.onSuccess = function( q, data)
		if callback then
			callback(data,q)
		end
	end
	query.onError = function(q, err, sqlQuery)
		print("An SQL error has occured:", error)
		print("This error was from the follow query:", sqlQuery)
	end
	query:start()
end

function XYZShit.DataBase.Escape(str) return XYZShit.DataBase.Database:escape(str) end

-- Connection Discord
function XYZShit.DataBase.Discord()
	XYZShit.DataBase.DatabaseDiscord = mysqloo.connect(XYZShit.DataBase.IP, XYZShit.DataBase.Username, XYZShit.DataBase.Password, "xsuite_master", 3306) -- connects
	XYZShit.DataBase.DatabaseDiscord.onConnected = function()
		print("XYZShit Discord connected")
	end
	XYZShit.DataBase.DatabaseDiscord.onConnectionFailed = function( sqlerror )
		for i=1,10 do
			print("XYZShit Discord connection failed. Error message:")
			print(sqlerror)
		end
	end
	XYZShit.DataBase.DatabaseDiscord:connect()
end
XYZShit.DataBase.Discord()

function XYZShit.DataBase.QueryDiscord(q, callback)
	local query = XYZShit.DataBase.DatabaseDiscord:query(q)
	query.onSuccess = function( _, data)
		if callback then
			callback(data)
		end
	end
	query:start()
end

function XYZShit.DataBase.EscapeDiscord(str) return XYZShit.DataBase.DatabaseDiscord:escape(str) end