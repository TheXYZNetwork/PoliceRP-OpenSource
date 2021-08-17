xStore = {}
xStore.Info = {}
xStore.Database = {}
xStore.Config = {}
xStore.Core = {}
xStore.Users = {}
xStore.Listings = {}
xStore.CustomClasses = {}

print("Loading xStore")

xStore.Info.Version = "1"
xStore.Info.Name = "pol1"
xStore.Info.FullName = "PoliceRP 1"

local path = "xstore/"
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

print("Loaded xStore")