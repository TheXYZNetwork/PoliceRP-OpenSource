-- XYZShit.DataBase.Query(string.format("INSERT INTO meeting_logs VALUES('%s', '%s', '%s', %s, %s)", ply:SteamID64(), XYZShit.DataBase.Escape(dep), XYZShit.DataBase.Escape(reason), length, tostring(crime) ))
-- ERPStaffTracker.Database.Query("CREATE TABLE IF NOT EXISTS st_session_logs(id INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY, userid VARCHAR(32) NOT NULL, connect INT(11) NOT NULL, disconnect INT(11), sits INT(11) NOT NULL)")

hook.Add("InitPostEntity", "PDTimeTrackerLoad", function()
	if ISDEV then 
		print("[SERVER]", "Blocked resolving pending Job Tracker sessions as Developer mode is active!")
		return
	end

	XYZShit.DataBase.Query("CREATE TABLE IF NOT EXISTS job_tracker(id INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY, userid VARCHAR(32) NOT NULL, `join` INT(11) NOT NULL, `leave` INT(11), job VARCHAR(32) NOT NULL)")
	XYZShit.DataBase.Query(string.format("UPDATE job_tracker SET `leave`=%i WHERE `leave` IS NULL", os.time()))
	XYZShit.DataBase.Query("CREATE TABLE IF NOT EXISTS job_tracker_promo(id INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY, userid VARCHAR(32) NOT NULL, promoter VARCHAR(32) NOT NULL, `time` INT(11), job VARCHAR(32) NOT NULL, state VARCHAR(10) NOT NULL)")
end)

-- Used to log when players join
function XYZTracker.Database.LogSessionStart(id64, jobName, jobType)
	XYZShit.DataBase.Query(string.format("INSERT INTO job_tracker(userid, `join`, job, jobType) VALUES('%s', %i, '%s', '%s')", id64, os.time(), XYZShit.DataBase.Escape(jobName), jobType), function(query)
		print("[Job Tracker]" ,"Started "..id64.."'s session on "..jobName)
	end)
end
-- Used to log when a player leaves
function XYZTracker.Database.LogSessionEnd(id64, jobName)
	XYZShit.DataBase.Query(string.format("UPDATE job_tracker SET `leave`=%i WHERE `leave` IS NULL AND job='%s' AND userid='%s' ORDER BY `job_tracker`.`id` DESC", os.time(), XYZShit.DataBase.Escape(jobName), id64), function()
		print("[Job Tracker]" ,"Stopped "..id64.."'s session on "..jobName)
	end)
end

-- Pull a SteamID's data
function XYZTracker.Database.GetSessionsByID(id64, jobType, callback)
	print(id64, jobType)
	XYZShit.DataBase.Query("SELECT * FROM job_tracker WHERE userid='"..XYZShit.DataBase.Escape(id64).."' AND jobType='"..XYZShit.DataBase.Escape(jobType).."' ORDER BY `job_tracker`.`id` DESC LIMIT 365", function(data)
		if data[1] then
			callback(data)
		else
		    callback(nil, "No data found")
		end
	end)
end

-- Pull a SteamID's data
function XYZTracker.Database.LogPromo(id64, promoterName, jobName, jobType, state)
	XYZShit.DataBase.Query(string.format("INSERT INTO job_tracker_promo(userid, promoter, `time`, job, jobType, state) VALUES('%s', '%s', %i, '%s', '%s', '%s')", id64, XYZShit.DataBase.Escape(promoterName), os.time(), XYZShit.DataBase.Escape(jobName), jobType, state), function(query)
		print("[Job Tracker]" ,"Logged "..id64.."'s promotion to "..jobName)
	end)
end

-- Pull a SteamID's data
function XYZTracker.Database.GetLogsByID(id64, jobType, callback)
	XYZShit.DataBase.Query("SELECT * FROM job_tracker_promo WHERE userid='"..XYZShit.DataBase.Escape(id64).."' AND jobType='"..XYZShit.DataBase.Escape(jobType).."' ORDER BY `job_tracker_promo`.`id` DESC", function(data)
		if data[1] then
			callback(data)
		else
		    callback(nil, "No data found")
		end
	end)
end