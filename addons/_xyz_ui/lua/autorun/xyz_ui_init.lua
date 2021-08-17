XYZUI = {}
XYZUI.Config = {}
XYZUI.Core = {}
XYZUI.Elements = {}

print("Loading XYZ UI 1")


local path = "xyz_ui/"
if SERVER then
	local files, folders = file.Find(path .. "*", "LUA")
	
	for _, folder in SortedPairs(folders, true) do 
		print("Loading folder:", folder)
	    for b, File in SortedPairs(file.Find(path .. folder .. "/*.lua", "LUA"), true) do
	    	print("Loading file:", File)
	        AddCSLuaFile(path .. folder .. "/" .. File)
	    end
	end
end

if CLIENT then
	local files, folders = file.Find(path .. "*", "LUA")
	
	for _, folder in SortedPairs(folders, true) do
		print("Loading folder:", folder)
	    for b, File in SortedPairs(file.Find(path .. folder .. "/*.lua", "LUA"), true) do
	    	print("Loading file:", File)
	        include(path .. folder .. "/" .. File)
	    end
	end
end

print("Loaded XYZ UI")