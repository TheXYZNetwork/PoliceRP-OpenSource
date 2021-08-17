-- Setup
require("mysqloo")
function xStore.Database.Connect()
	if xStore.Database.Connection then return end
	xStore.Database.Connection = mysqloo.connect("1.1.1.1", "user_name", "user_password", "database_name", 3306) -- connects
	xStore.Database.Connection.onConnected = function()
		print("=========================")
		print("xStore database connected")
		print("=========================")
		print("Checking and creating the following tables:")

		print(xStore.Info.Name.."_items")
		xStore.Database.Query("CREATE TABLE IF NOT EXISTS "..xStore.Info.Name.."_items (`id` int(11) NOT NULL AUTO_INCREMENT, `userid` varchar(32) NOT NULL, `packagename` varchar(32) NOT NULL, `paid` int(11) NOT NULL, `active` int(1) NOT NULL, `created` int(11) NOT NULL, PRIMARY KEY (`id`))")

		print(xStore.Info.Name.."_active_listings")
		xStore.Database.Query("CREATE TABLE IF NOT EXISTS "..xStore.Info.Name.."_active_listings (`id` int(11) NOT NULL AUTO_INCREMENT, `userid` varchar(32) NOT NULL, `credits` int(11) NOT NULL, `cost` int(11) NOT NULL, `created` int(11) NOT NULL, PRIMARY KEY (`id`))")

		print(xStore.Info.Name.."_listing_history")
		xStore.Database.Query("CREATE TABLE IF NOT EXISTS "..xStore.Info.Name.."_listing_history (`id` int(11) NOT NULL AUTO_INCREMENT, `userid` varchar(32) NOT NULL, `purchaser` varchar(32) NOT NULL, `credits` int(11) NOT NULL, `cost` int(11) NOT NULL, `created` int(11) NOT NULL, PRIMARY KEY (`id`))")
	
		print(xStore.Info.Name.."_custom_classes")
		xStore.Database.Query("CREATE TABLE IF NOT EXISTS "..xStore.Info.Name.."_custom_classes (`id` int(11) NOT NULL AUTO_INCREMENT, `userid` varchar(32) NOT NULL, `name` varchar(64) NOT NULL, `model` varchar(256) NOT NULL, `slots` int(11) NOT NULL, `license` int(1) NOT NULL, `weapons` text NOT NULL, `created` int(11) NOT NULL, PRIMARY KEY (`id`))")
	
		print(xStore.Info.Name.."_cc_access")
		xStore.Database.Query("CREATE TABLE IF NOT EXISTS "..xStore.Info.Name.."_cc_access (`id` int(11), `userid` varchar(32) NOT NULL, `created` int(11) NOT NULL, UNIQUE KEY `unique_index` (`id`, `userid`))")
	
		hook.Run("xStoreDatabaseConnected")
	end
	xStore.Database.Connection.onConnectionFailed = function(db, sqlerror)
		print("=========================")
		print("xStore database failed:")
		for i=1,10 do
			print(sqlerror)
		end
		print("=========================")
	end
	xStore.Database.Connection:connect()
end
xStore.Database.Connect()

function xStore.Database.Query(q, callback)
	print(q)
	local query = xStore.Database.Connection:query(q)
	query.onSuccess = function( q, data)
		if callback then
			callback(data,q)
		end
	end
	query:start()
end

function xStore.Database.Escape(str)
	return xStore.Database.Connection:escape(str)
end


function xStore.Database.GiveUserItem(id, packagename, paid)
	xStore.Database.Query(string.format("INSERT INTO %s_items(userid, packagename, paid, active, created) VALUES('%s', '%s', %i, 1, %i)", xStore.Info.Name, xStore.Database.Escape(id), xStore.Database.Escape(packagename), xStore.Database.Escape(tostring(paid)), os.time()))
end
function xStore.Database.SetItemState(id, packagename, state)
	if state then
		state = 1
	else
		state = 0
	end
	xStore.Database.Query(string.format("UPDATE %s_items SET active=%i WHERE userid='%s' AND packagename='%s'", xStore.Info.Name, state, xStore.Database.Escape(id), xStore.Database.Escape(packagename)))
end


function xStore.Database.GetUserItem(id, callback)
	xStore.Database.Query(string.format("SELECT * FROM %s_items WHERE userid='%s'", xStore.Info.Name, xStore.Database.Escape(id)), callback)
end

function xStore.Database.GetUsersCredits(id, callback)
	xStore.Database.Query(string.format("SELECT * FROM credits WHERE userid='%s'", xStore.Database.Escape(id)), function(data)
		if data[1] then
			callback(data[1].credits)
		else
			callback(0)
		end
	end)
end


function xStore.Database.CreateListing(id, credits, cost)
	xStore.Database.Query(string.format("INSERT INTO %s_active_listings(userid, credits, cost, created) VALUES('%s', %i, %i, %i)", xStore.Info.Name, xStore.Database.Escape(id), xStore.Database.Escape(tostring(credits)), xStore.Database.Escape(tostring(cost)), os.time()))
end
function xStore.Database.RemoveListing(id, created)
	xStore.Database.Query(string.format("DELETE FROM %s_active_listings WHERE userid='%s' AND created=%i", xStore.Info.Name, xStore.Database.Escape(id), xStore.Database.Escape(tostring(created))))
end
function xStore.Database.ArchiveListing(id, purchaser, credits, cost, created)
	xStore.Database.Query(string.format("INSERT INTO %s_listing_history(userid, purchaser, credits, cost, created) VALUES('%s', '%s', %i, %i, %i)", xStore.Info.Name, xStore.Database.Escape(id), xStore.Database.Escape(purchaser), xStore.Database.Escape(tostring(credits)), xStore.Database.Escape(tostring(cost)), xStore.Database.Escape(tostring(created))))
end
function xStore.Database.GetActiveListings(callback)
	xStore.Database.Query(string.format("SELECT * FROM %s_active_listings", xStore.Info.Name), function(data)
		callback(data)
	end)
end


function xStore.Database.CreateCustomClass(userid, name, model, slots, weapons, callback)
	xStore.Database.Query(string.format("INSERT INTO %s_custom_classes(userid, name, model, slots, license, weapons, created) VALUES('%s', '%s', '%s', %i, %i, '%s', %i)", xStore.Info.Name, xStore.Database.Escape(tostring(userid)), xStore.Database.Escape(name), xStore.Database.Escape(model), xStore.Database.Escape(tostring(slots)), 0, util.TableToJSON(weapons), os.time()))
	xStore.Database.Query(string.format("SELECT LAST_INSERT_ID() FROM %s_custom_classes LIMIT 1;", xStore.Info.Name), callback)
end
function xStore.Database.EditCustomClass(key, name, model, slots, weapons)
	xStore.Database.Query(string.format("UPDATE %s_custom_classes SET name='%s', model='%s', slots=%i, weapons='%s' WHERE id=%i", xStore.Info.Name, xStore.Database.Escape(name), xStore.Database.Escape(model), xStore.Database.Escape(tostring(slots)), util.TableToJSON(weapons), xStore.Database.Escape(tostring(key))))
end
function xStore.Database.GiveClassAccess(key, userid)
	xStore.Database.Query(string.format("INSERT INTO %s_cc_access(id, userid, created) VALUES(%i, '%s', %i)", xStore.Info.Name, xStore.Database.Escape(tostring(key)), xStore.Database.Escape(tostring(userid)), os.time()))
end
function xStore.Database.RemoveClassAccess(key, userid)
	xStore.Database.Query(string.format("DELETE FROM %s_cc_access WHERE id=%i AND userid='%s'", xStore.Info.Name, xStore.Database.Escape(tostring(key)), xStore.Database.Escape(tostring(userid))))
end
function xStore.Database.GetAllCustomClasses(callback)
	xStore.Database.Query(string.format("SELECT * FROM %s_custom_classes", xStore.Info.Name), function(data)
		callback(data)
	end)
end
function xStore.Database.GetCustomClassAccess(id, callback)
	xStore.Database.Query(string.format("SELECT * FROM %s_cc_access WHERE id=%i", xStore.Info.Name, xStore.Database.Escape(tostring(id))), function(data)
		callback(data)
	end)
end


function xStore.Database.GiveUserCredits(ply, amount)
	xStore.Users[ply:SteamID64()].credits = xStore.Users[ply:SteamID64()].credits + amount

	xStore.Database.Query(string.format("INSERT INTO credits(userid, credits) VALUES('%s', %s) ON DUPLICATE KEY UPDATE credits = credits + %s;", ply:SteamID64(), amount, amount))
end
function xStore.Database.GiveIDCredits(id, amount)
	xStore.Database.Query(string.format("INSERT INTO credits(userid, credits) VALUES('%s', %s) ON DUPLICATE KEY UPDATE credits = credits + %s;", id, amount, amount))
end


function xStore.Database.LogCreditChange(id, type, change, cost, nowCredits)
	xStore.Database.Query(string.format("INSERT INTO credit_logs(userid, type, creditchange, cost, netcredits, `date`) VALUES('%s', '%s', %i, %i, %i, '%i');", xStore.Database.Escape(id), xStore.Database.Escape(type), change, cost, nowCredits or xStore.Users[id].credits, os.time()))
end