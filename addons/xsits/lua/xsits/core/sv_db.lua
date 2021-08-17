-- Setup
require("mysqloo")
function xSits.Database.Connect()
	if xSits.Database.Connection then return end
	xSits.Database.Connection = mysqloo.connect("1.1.1", "user_name", "user_password", "user_database", 3306) -- connects
	xSits.Database.Connection.onConnected = function()
		print("=========================")
		print("xSits database connected")
		print("=========================")
		print("Checking and creating the following tables:")

		print(xSits.Info.Name.."_sit_history")
		xSits.Database.Query("CREATE TABLE IF NOT EXISTS "..xSits.Info.Name.."_sit_history(id INT NOT NULL AUTO_INCREMENT, creator VARCHAR(32) NOT NULL, claimer VARCHAR(32), reason VARCHAR(128) NOT NULL, staffonline TEXT NOT NULL, created INT(32) NOT NULL, PRIMARY KEY (id))")

		print(xSits.Info.Name.."_rating")
		xSits.Database.Query("CREATE TABLE IF NOT EXISTS "..xSits.Info.Name.."_rating(id INT(32) NOT NULL, rating INT(32) NOT NULL, PRIMARY KEY (id))")
	end
	xSits.Database.Connection.onConnectionFailed = function(db, sqlerror)
		print("=========================")
		print("xSits database failed:")
		for i=1,10 do
			print(sqlerror)
		end
		print("=========================")
	end
	xSits.Database.Connection:connect()
end
xSits.Database.Connect()

function xSits.Database.Query(q, callback)
	local query = xSits.Database.Connection:query(q)
	print(q)
	query.onSuccess = function(q, data)
		print("query.onSuccess")
		if callback then
			callback(data,q)
		end
	end
	query:start()
end

function xSits.Database.Escape(str)
	return xSits.Database.Connection:escape(str)
end

-- Use functions
function xSits.Database.LogSitCreation(creator, reason, staff, callback)
	print("xSits.Database.LogSitCreation")
	local staffOnline = {}
	for k, v in pairs(staff or player.GetAll()) do
		if XYZShit.Staff.All[v:GetUserGroup()] then
			table.insert(staffOnline, v:SteamID64())
		end
	end
	staffOnline = util.TableToJSON(staffOnline)
	xSits.Database.Query(string.format("INSERT INTO %s_sit_history(creator, reason, staffonline, created) VALUES('%s', '%s', '%s', %i);", xSits.Info.Name, xSits.Database.Escape(creator:SteamID64()), xSits.Database.Escape(reason), xSits.Database.Escape(staffOnline), os.time()))
	xSits.Database.Query(string.format("SELECT LAST_INSERT_ID() FROM %s_sit_history LIMIT 1;", xSits.Info.Name), callback)
end

function xSits.Database.UpdateSitClaimer(id, creator, claimer, created)
	if id then
		xSits.Database.Query(string.format("UPDATE %s_sit_history SET claimer='%s' WHERE id=%i;", xSits.Info.Name, xSits.Database.Escape(claimer:SteamID64()), id))
	else
		xSits.Database.Query(string.format("UPDATE %s_sit_history SET claimer='%s' WHERE creator='%s' AND created=%i;", xSits.Info.Name, xSits.Database.Escape(claimer:SteamID64()), xSits.Database.Escape(creator:SteamID64()), created))
	end
end

function xSits.Database.GiveRating(id, rating)
	if id then
		xSits.Database.Query(string.format("INSERT INTO %s_rating(id, rating) VALUES(%i, %i);", xSits.Info.Name, id, rating))
	end
end