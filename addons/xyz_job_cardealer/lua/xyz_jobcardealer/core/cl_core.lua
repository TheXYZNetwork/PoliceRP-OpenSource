function JobCarDealer.Core.SetCustoms(vehicle, customs)
	if not sql.TableExists("xyz_job_car_customs") then
		sql.Query("CREATE TABLE xyz_job_car_customs(vehicle TEXT PRIMARY KEY, customs TEXT)")
	end

	sql.Query("INSERT OR REPLACE INTO xyz_job_car_customs VALUES("..sql.SQLStr(vehicle)..", '"..util.TableToJSON(customs).."')")
end



function JobCarDealer.Core.GetCustoms(vehicle)
	if not sql.TableExists("xyz_job_car_customs") then
		sql.Query("CREATE TABLE xyz_job_car_customs(vehicle TEXT PRIMARY KEY, customs TEXT)")
	end
	
	local data = sql.Query("SELECT * FROM xyz_job_car_customs WHERE vehicle="..sql.SQLStr(vehicle))
	if not data then return end
	
	local dataTbl = util.JSONToTable(data[1].customs)

	return dataTbl
end

