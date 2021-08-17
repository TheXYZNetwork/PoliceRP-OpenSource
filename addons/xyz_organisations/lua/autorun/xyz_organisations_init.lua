XYZ_ORGS = {}
XYZ_ORGS.Config = {}
XYZ_ORGS.Core = {}
XYZ_ORGS.Core.Members = {}
XYZ_ORGS.Core.Orgs = {}
XYZ_ORGS.Core.Invites = {}
XYZ_ORGS.Database = {}


print("Loading Organisations")

local path = "xyz_organisations/"
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

print("Loaded Organisations")