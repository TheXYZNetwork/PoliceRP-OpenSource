XYZTag = {}
XYZTag.Core = {}
XYZTag.UI = {}

print("Loading XYZ Tag System")

local path = "xyz_tags/"
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

	hook.Add("PlayerInitialSpawn", "xyz_tag_ply", function(ply)
		print("tag data", "PlayerInitialSpawn")
		XYZShit.DataBase.Query(string.format("SELECT * FROM user_tags WHERE userid='%s'", ply:SteamID64()), function(data)
			print("tag data", data)
			PrintTable(data)
			if data[1] then
				local color = util.JSONToTable(data[1].color)
				ply:SetNWString("xyz_tag_string", data[1].tag)
				ply:SetNWVector("xyz_tag_Color", Vector(color.r, color.g, color.b))
			end
		end)
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

print("Loaded XYZ Tag System")