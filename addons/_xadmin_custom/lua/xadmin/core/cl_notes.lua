net.Receive("xAdminSendNotes", function()
	local notes = net.ReadTable()

	xAdmin.Core.Msg({color_white, Color(46, 170, 200), "[xAdmin] ", color_white, "The following notes were found:"})
	for k, v in pairs(notes) do
		xAdmin.Core.Msg({color_white, tostring(v.id), " - \"", v.note, "\" (Added by ", v.admin, ", ", string.NiceTime(os.time() - v.time), " ago)"})
	end
end)