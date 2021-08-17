function XYZ911.Database.Log(ply, reason, callback)
	local plyID = XYZShit.DataBase.Escape(ply:SteamID64())
	local plyName = XYZShit.DataBase.Escape(ply:Name())
	reason = XYZShit.DataBase.Escape(reason)
	local time = os.time()

	XYZShit.DataBase.Query(string.format("INSERT INTO pnc_911_new(userid, name, reason, time) VALUES('%s', '%s', '%s', %i);", plyID, plyName, reason, time))

	XYZShit.DataBase.Query("SELECT LAST_INSERT_ID() FROM pnc_911_new LIMIT 1;", callback)
end

function XYZ911.Database.UpdateResponders(callID, responders)
	if not isnumber(callID) then return end
	local respondIDs = {}
	for k, v in ipairs(responders) do
		if (not IsValid(v)) or (not v:IsPlayer()) then continue end

		table.insert(respondIDs, v:SteamID64())
	end

	respondIDs = util.TableToJSON(respondIDs)

	XYZShit.DataBase.Query(string.format("UPDATE pnc_911_new SET responders='%s' WHERE id=%i;", respondIDs, callID))
end