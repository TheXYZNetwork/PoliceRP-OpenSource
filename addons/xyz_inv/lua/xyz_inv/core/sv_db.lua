-- CREATE TABLE `inventories` (`userid` varchar(32) NOT NULL, `item` text NOT NULL, `data` text)
-- Used to log when players join
function Inventory.Database.LoadItems(ply)
	Inventory.SavedInvs[ply:SteamID64()] = {}
	Inventory.SavedBanks[ply:SteamID64()] = {}

	XYZShit.DataBase.Query("SELECT * FROM inventories WHERE userid='"..XYZShit.DataBase.Escape(ply:SteamID64()).."'", function(data)
		for k, v in pairs(data) do
			table.insert(Inventory.SavedInvs[ply:SteamID64()], {dbID = v.id, class = v.item, data = util.JSONToTable(v.data)})
		end

		-- Break the inv up into chunks of 30 items to not overload the player
		local inv = Inventory.SavedInvs[ply:SteamID64()]

		for i=1, math.ceil(#inv/30) do
		    local partInv = {}
		    for k, v in pairs(inv) do
		        if k > (30*i) then continue end
		        if k < ((30*i) - 29) then continue end
		        table.insert(partInv, v)
		    end

			net.Start("XYZInv:InitalInv")
				net.WriteTable(partInv)
			net.Send(ply)
		end
	end)
	XYZShit.DataBase.Query("SELECT * FROM banks WHERE userid='"..XYZShit.DataBase.Escape(ply:SteamID64()).."'", function(data)
		for k, v in pairs(data) do
			table.insert(Inventory.SavedBanks[ply:SteamID64()], {dbID = v.id, class = v.item, data = util.JSONToTable(v.data)})
		end
	end)
end

function Inventory.Database.InsertItem(id64, class, data, callback)
	XYZShit.DataBase.Query(string.format("INSERT INTO inventories(userid, item, data) VALUES('%s', '%s', '%s')", XYZShit.DataBase.Escape(id64), XYZShit.DataBase.Escape(class), util.TableToJSON(data)))
	XYZShit.DataBase.Query("SELECT LAST_INSERT_ID() FROM inventories LIMIT 1;", callback)
end

function Inventory.Database.RemoveItem(id64, class)
	XYZShit.DataBase.Query(string.format("DELETE FROM inventories WHERE userid='%s' AND item='%s' LIMIT 1;", XYZShit.DataBase.Escape(id64), XYZShit.DataBase.Escape(class)))
end

function Inventory.Database.TransferToLocker(dbID)
	XYZShit.DataBase.Query(string.format("INSERT INTO banks SELECT * FROM inventories WHERE id=%i;", dbID))
	XYZShit.DataBase.Query(string.format("DELETE FROM inventories WHERE id=%i;", dbID))
end
function Inventory.Database.TransferToInventory(dbID)
	XYZShit.DataBase.Query(string.format("INSERT INTO inventories SELECT * FROM banks WHERE id=%i;", dbID))
	XYZShit.DataBase.Query(string.format("DELETE FROM banks WHERE id=%i;", dbID))
end