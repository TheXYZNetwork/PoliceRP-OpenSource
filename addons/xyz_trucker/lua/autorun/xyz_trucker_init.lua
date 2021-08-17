XYZTrucker = {}
XYZTrucker.Config = {}
XYZTrucker.Translate = {}
XYZTrucker.Core = {}
XYZTrucker.UI = {}

-- Loads
XYZTrucker.Core.Loads = {}

--XYZTrucker.Core.Loads[1] = {}
--XYZTrucker.Core.Loads[1].name = "Small load"
--XYZTrucker.Core.Loads[1].price = 1000
--XYZTrucker.Core.Loads[1].loads = {"singleaxleboxtrailertdm"}

XYZTrucker.Core.Loads[1] = {}
XYZTrucker.Core.Loads[1].name = "Medium load"
XYZTrucker.Core.Loads[1].price = 8000
XYZTrucker.Core.Loads[1].loads = {"reefer3000r_tdm", "aerodyntdm", "dumptdm"}

XYZTrucker.Core.Loads[2] = {}
XYZTrucker.Core.Loads[2].name = "Large load"
XYZTrucker.Core.Loads[2].price = 12000
XYZTrucker.Core.Loads[2].loads = {"reefer3000r_longtdm"}

-- Spawn positions
XYZTrucker.Core.TrailerSpawns = {}
XYZTrucker.Core.TrailerSpawns[1] =  Vector(-2113.593994, 4253.187744, 600.031250)

-- Trucks
XYZTrucker.Core.Trucks = {}
--XYZTrucker.Core.Trucks[1] = "scania09jigtdm"
XYZTrucker.Core.Trucks[1] = "volvofh16shorttdm"
XYZTrucker.Core.TruckSpawn = Vector(-2116.159912, 4581.021973, 600.031250)
XYZTrucker.Platforms = {}

 
print("Loading XYZ Trucker")

local path = "xyz_trucker/"
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

print("Loaded XYZ Trucker")