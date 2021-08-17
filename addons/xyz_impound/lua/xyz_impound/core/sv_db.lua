function Impound.Database.Load(callback)
	XYZShit.DataBase.Query("SELECT * FROM impound", callback)
end

function Impound.Database.Add(vehicleID, clamper)
	vehicleID = tonumber(vehicleID)
	clamper = clamper and XYZShit.DataBase.Escape(clamper) or false

	if clamper then
		XYZShit.DataBase.Query(string.format("INSERT INTO impound (id, impounder) VALUES(%i, '%s')", vehicleID, clamper))
	else
		XYZShit.DataBase.Query(string.format("INSERT INTO impound (id,) VALUES(%i)", vehicleID))
	end
end

function Impound.Database.Remove(vehicleID)
	vehicleID = tonumber(vehicleID)

	XYZShit.DataBase.Query(string.format("DELETE FROM impound WHERE id=%i", vehicleID))
end
