--- #
--- # Notes
--- #
xAdmin.Core.RegisterCommand("notes", "Get someone's notes", 30, function(admin, args)
	if not args or (not args[1]) then
		return
	end

	local target, targetPly = xAdmin.Core.GetID64(args[1], admin)

	if not target then
		xAdmin.Core.Msg({Color(46, 170, 200), "[xAdmin] ", color_white, "Please provide a valid target. The following was not recognised: " .. args[1]}, admin)

		return
	end

	xAdmin.Database.GetNotes(target, function(notes)
		if (not notes) or table.IsEmpty(notes) then
			xAdmin.Core.Msg({Color(46, 170, 200), "[xAdmin] ", color_white, "This user has no notes!"}, admin)
			return
		end

	--	xAdmin.Core.Msg({"The following notes were found:"}, admin)
		net.Start("xAdminSendNotes")
			net.WriteTable(notes)
		net.Send(admin)
	--	for k, v in pairs(notes) do
	--		xAdmin.Core.Msg({color_white, tostring(v.id), " - \"", v.note, "\" (Added by ", v.admin, ", ", string.NiceTime(os.time() - v.time), " ago)"}, admin)
	--	end
	end)
end)

--- #
--- # ADDNOTE
--- #
xAdmin.Core.RegisterCommand("addnote", "Add a note to someone", 40, function(admin, args)
	if not args or (not args[1]) then
		return
	end

	local target, targetPly = xAdmin.Core.GetID64(args[1], admin)

	if not target then
		xAdmin.Core.Msg({Color(46, 170, 200), "[xAdmin] ", color_white, "Please provide a valid target. The following was not recognised: " .. args[1]}, admin)

		return
	end

	local reason = args[2]

	if not reason then 
		xAdmin.Core.Msg({Color(46, 170, 200), "[xAdmin] ", color_white, "Please provide a reason."}, admin)
		return
	end

	if args[3] then
		for k, v in pairs(args) do
			if k < 3 then continue end
			reason = reason .. " " .. v
		end
	end

	xAdmin.Database.AddNote(target, (IsValid(targetPly) and targetPly:Name()) or "Unknown", admin:SteamID64(), admin:Name(), reason or "No note given")
	xAdmin.Core.Msg({color_white, admin, " has given ", ((IsValid(targetPly) and targetPly) or target), " the following note: ", Color(100, 200, 255), reason}, xAdmin.Core.GetOnlineStaff())
end)

--- #
--- # DELETENOTE
--- #
xAdmin.Core.RegisterCommand("deletenote", "Delete someone's note", 70, function(admin, args)
	if not args or not args[1] then
		return
	end
	if (not tonumber(args[1])) then
		xAdmin.Core.Msg({Color(46, 170, 200), "[xAdmin] ", color_white, "'" .. args[1] .. "' is not an ID. Please provide a valid ID."}, admin)
		return
	end
	xAdmin.Database.GetNotesByID(args[1], function(note)
		if note and note[1] then
			xAdmin.Database.DeleteNote(args[1])
			local target, targetPly = xAdmin.Core.GetID64(note[1].userid, admin)

			local targetName = IsValid(targetPly) and targetPly or target
			xAdmin.Core.Msg({color_white, admin, " has deleted a note (", args[1], ") from ", targetName, " reading: ", Color(100, 200, 255), note[1].note}, xAdmin.Core.GetOnlineStaff())
		else 
			xAdmin.Core.Msg({Color(46, 170, 200), "[xAdmin] ", color_white, "'" .. args[1] .. "' is not a valid ID. Please provide a valid ID."}, admin)
		end
	end )
end)