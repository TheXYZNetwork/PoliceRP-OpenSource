print("Loading xWarn")
if not xAdmin then
	print("=========================================")
	print("        xAdmin isn't installed           ")
	print("              Install at:                ")
	print("  https://github.com/OwjoTheGreat/xadmin ")
	print("=========================================")
	return
end
xWarn = {}
xWarn.Config = {}
xWarn.Database = {}
local path = "xwarn/"

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

print("Loaded xWarn")