XYZPresident = {}
XYZPresident.Config = {}
XYZPresident.Core = {}
XYZPresident.Stats = {}
XYZPresident.Tax = {}
XYZPresident.Settings = {}

print("Loading President System")

local path = "president/"
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

print("Loaded President System")

if SERVER then
	hook.Add("PostGamemodeLoaded", "replacePlaceLaws", function()
		DarkRP.declareChatCommand{
			command = "placelaws",
			description = "Place a laws board.",
			delay = 1.5
		}

		XYZPresident.Core.numlaws = 0
		local function placeLaws(ply, args)
			local hookCanEditLaws = {canEditLaws = function(_, ply, action, args)
				if IsValid(ply) and (not RPExtraTeams[ply:Team()] or not RPExtraTeams[ply:Team()].mayor) then
					return false, DarkRP.getPhrase("incorrect_job", GAMEMODE.Config.chatCommandPrefix .. action)
				end
				return true
			end}
			local canEdit, message = hook.Call("canEditLaws", hookCanEditLaws, ply, "placeLaws", args)

			if not canEdit then
				DarkRP.notify(ply, 1, 4, message ~= nil and message or DarkRP.getPhrase("unable", GAMEMODE.Config.chatCommandPrefix .. "placeLaws", ""))
				return ""
			end

			if XYZPresident.Core.numlaws >= GAMEMODE.Config.maxlawboards then
				DarkRP.notify(ply, 1, 4, DarkRP.getPhrase("limit", GAMEMODE.Config.chatCommandPrefix .. "placeLaws"))
				return ""
			end

			local trace = {}
			trace.start = ply:EyePos()
			trace.endpos = trace.start + ply:GetAimVector() * 85
			trace.filter = ply

			local tr = util.TraceLine(trace)

			local ent = ents.Create("xyz_president_laws")
			ent:SetPos(tr.HitPos + Vector(0, 0, 100))

			local ang = ply:GetAngles()
			ang:RotateAroundAxis(ang:Up(), 180)
			ent:SetAngles(ang)

			ent:CPPISetOwner(ply)
			ent.SID = ply.SID

			ent:Spawn()
			ent:Activate()

			if IsValid(ent) then
				XYZPresident.Core.numlaws = XYZPresident.Core.numlaws + 1
			end

			ply.lawboards = ply.lawboards or {}
			table.insert(ply.lawboards, ent)

			return ""
		end
		DarkRP.defineChatCommand("placeLaws", placeLaws)
	end)
end