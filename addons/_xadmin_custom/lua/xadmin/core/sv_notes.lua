util.AddNetworkString("xAdminSendNotes")

-- Database stuff
hook.Add("xAdminPostInit", "xAdmin:Notes", function()
	xAdmin.Database.Query("CREATE TABLE IF NOT EXISTS "..xAdmin.Info.Name.."_notes(id INTEGER NOT NULL AUTO_INCREMENT primary key, userid VARCHAR(32) NOT NULL, user TEXT NOT NULL, adminid VARCHAR(32) NOT NULL, admin TEXT NOT NULL, note TEXT(64) NOT NULL, time INT(32) NOT NULL);")
	print(xAdmin.Info.Name .. "_notes")
end)

function xAdmin.Database.AddNote(userid, user, adminid, admin, reason)
	xAdmin.Database.Query(string.format("INSERT INTO %s_notes (userid, user, adminid, admin, note, time) VALUES ('%s', '%s', '%s', '%s', '%s', '%s');",
		xAdmin.Info.Name,
		userid,
		xAdmin.Database.Escape(user) or "Unknown",
		adminid,
		xAdmin.Database.Escape(admin) or "Console",
		xAdmin.Database.Escape(reason) or "No note given",
		os.time()
	))
end
function xAdmin.Database.DeleteNote(id)
	xAdmin.Database.Query(string.format("DELETE FROM %s_notes WHERE id='%s';", xAdmin.Info.Name, id))
end
function xAdmin.Database.GetNotes(userid, callback)
	xAdmin.Database.Query(string.format("SELECT * FROM %s_notes WHERE userid='%s';", xAdmin.Info.Name, userid), callback)
end

function xAdmin.Database.GetNotesByID(id, callback)
	xAdmin.Database.Query(string.format("SELECT * FROM %s_notes WHERE id='%s';", xAdmin.Info.Name, id), callback)
end

-- Functions
function xAdmin.Core.GetOnlineStaff()
	local pool = {}
	for k, v in ipairs(player.GetAll()) do
		if not v:HasPower(xAdmin.Config.AdminChat) then continue end
	
		table.insert(pool, v)
	end

	return pool
end

-- Hooks
hook.Add("PlayerInitialSpawn", "xadmin:Notes:Joined", function(ply)
	xAdmin.Database.GetNotes(ply:SteamID64(), function(notes)
		if (not notes) or table.IsEmpty(notes) then return end

		local allStaff = xAdmin.Core.GetOnlineStaff()

		xAdmin.Core.Msg({Color(46, 170, 200), "[xAdmin] ", color_white, ply:Name(), "("..ply:SteamID()..") has joined the server with ", tostring(table.Count(notes)), " notes!"}, allStaff)
	end)
end)