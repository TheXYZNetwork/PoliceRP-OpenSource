function CarDealer.Database.LoadID(id, callback)
	XYZShit.DataBase.Query(string.format("SELECT * FROM vehicles WHERE userid='%s'", id), callback)
end

function CarDealer.Database.GiveID(id, class, color, skin, bodygroups, mods, performance, callback)
	id = XYZShit.DataBase.Escape(id)
	class = XYZShit.DataBase.Escape(class)
	color = XYZShit.DataBase.Escape(color.r..","..color.g..","..color.b)
	skin = isnumber(skin) and skin or 0
	bodygroups = XYZShit.DataBase.Escape(util.TableToJSON(bodygroups))
	mods = XYZShit.DataBase.Escape(util.TableToJSON(mods))
	performance = XYZShit.DataBase.Escape(util.TableToJSON(performance))

	XYZShit.DataBase.Query(string.format("INSERT INTO vehicles(userid, class, color, skin, bodygroups, mods, performance, damage) VALUES('%s', '%s', '%s', %i, '%s', '%s', '%s', '[]');", id, class, color, skin, bodygroups, mods, performance))

	XYZShit.DataBase.Query("SELECT LAST_INSERT_ID() FROM vehicles LIMIT 1;", callback)
end

function CarDealer.Database.TuneVehicleID(vehicleID, color, skin, bodygroups, mods, performance)
	vehicleID = tonumber(vehicleID)
	color = XYZShit.DataBase.Escape(color.r..","..color.g..","..color.b)
	skin = isnumber(skin) and skin or 0
	bodygroups = XYZShit.DataBase.Escape(util.TableToJSON(bodygroups))
	mods = XYZShit.DataBase.Escape(util.TableToJSON(mods))
	performance = XYZShit.DataBase.Escape(util.TableToJSON(performance))

	XYZShit.DataBase.Query(string.format("UPDATE vehicles SET color='%s', skin=%i, bodygroups='%s', mods='%s', performance='%s' WHERE id=%i;", color, skin, bodygroups, mods, performance, vehicleID))
end

function CarDealer.Database.RemoveVehicleID(vehicleID)
	vehicleID = tonumber(vehicleID)

	XYZShit.DataBase.Query(string.format("DELETE FROM `vehicles` WHERE id=%i;", vehicleID))
end

function CarDealer.Database.UpdateDamageVehicleID(vehicleID, damage)
	vehicleID = tonumber(vehicleID)
	damage = XYZShit.DataBase.Escape(util.TableToJSON(damage))

	XYZShit.DataBase.Query(string.format("UPDATE `vehicles` SET damage='%s' WHERE id=%i;", damage, vehicleID))
end