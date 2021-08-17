XYZChat = {}
XYZChat.Core = {}
XYZChat.UI = {}

print("Loading XYZ Chat Box")

local path = "xyz_chat/"
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

	if not GetConVar("xyz_chat_w") then
		CreateClientConVar("xyz_chat_w", ScrW()*0.25, true, false, "The width of the chat box.")
	end
	if not GetConVar("xyz_chat_h") then
		CreateClientConVar("xyz_chat_h", ScrH()*0.25, true, false, "The height of the chat box.")
	end
	if not GetConVar("xyz_chat_x") then
		CreateClientConVar("xyz_chat_x", 5, true, false, "The x position of the chat box.")
	end
	if not GetConVar("xyz_chat_y") then
		CreateClientConVar("xyz_chat_y", ScrH()*0.55, true, false, "The y position of the chat box.")
	end
end

print("Loaded XYZ Chat Box")