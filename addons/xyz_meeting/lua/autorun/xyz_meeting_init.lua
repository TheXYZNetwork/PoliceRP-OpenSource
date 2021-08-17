XYZMeeting = {}
XYZMeeting.Config = {}
XYZMeeting.Translate = {}
XYZMeeting.Core = {}
XYZMeeting.UI = {}

XYZMeeting.MeetingData = {}
XYZMeeting.MeetingData.name = "N/A"
XYZMeeting.MeetingData.dep = "N/A"
XYZMeeting.MeetingData.time = 0
XYZMeeting.MeetingData.stopCrime = false
XYZMeeting.MeetingData.host = nil
XYZMeeting.MeetingData.hostName = "N/A"
XYZMeeting.MeetingData.started = 0

XYZMeeting.LastMeeting = 1
XYZMeeting.NextMeeting = 0
XYZMeeting.MeetingCooldown = 5 * 60

print("Loading XYZ Meeting")

local path = "xyz_meeting/"
if SERVER then
	local files, folders = file.Find(path .. "*", "LUA")
	
	for _, folder in SortedPairs(folders, true) do
		print("Loading folder:", folder)
	    for b, File in SortedPairs(file.Find(path .. folder .. "/sh_*.lua", "LUA"), true) do
	    	print("Loading file:", File)
	        AddCSLuaFile(path .. folder .. "/" .. File)
	        include(path .. folder .. "/" .. File)
	    end
	
	    for b, File in SortedPairs(file.Find(path .. folder .. "/sv_*.lua", "LUA"), true) do
	    	print("Loading file:", File)
	        include(path .. folder .. "/" .. File)
	    end
	
	    for b, File in SortedPairs(file.Find(path .. folder .. "/cl_*.lua", "LUA"), true) do
	    	print("Loading file:", File)
	        AddCSLuaFile(path .. folder .. "/" .. File)
	    end
	end

	hook.Add("PlayerInitialSpawn", "xyz_meeting_init_spawn", function(ply)
		net.Start("xyz_meeting_broadcast")
			net.WriteTable(XYZMeeting.MeetingData)
		net.Send(ply)
	end)
end

if CLIENT then
	local files, folders = file.Find(path .. "*", "LUA")
	
	for _, folder in SortedPairs(folders, true) do
		print("Loading folder:", folder)
	    for b, File in SortedPairs(file.Find(path .. folder .. "/sh_*.lua", "LUA"), true) do
	    	print("Loading file:", File)
	        include(path .. folder .. "/" .. File)
	    end

	    for b, File in SortedPairs(file.Find(path .. folder .. "/cl_*.lua", "LUA"), true) do
	    	print("Loading file:", File)
	        include(path .. folder .. "/" .. File)
	    end
	end
end

print("Loaded XYZ Meeting")