--[[
CREATE TABLE `christmas_credits` (
 `userid` varchar(32) NOT NULL,
 `credits` text,
 PRIMARY KEY (`userid`)
)
]]

XYZChristmasCredits.Core.PlyCredits = XYZChristmasCredits.Core.PlyCredits or {}
hook.Add("PlayerInitialSpawn", "ChristmasCredits:LoadPlayer", function(ply)
	XYZChristmasCredits.Database.GetCredits(ply)
end)

function XYZChristmasCredits.Database.GetCredits(ply)
	XYZShit.DataBase.Query(string.format("SELECT * FROM christmas_credits WHERE userid='%s';", ply:SteamID64()), function(data)
		if not data[1] then
			XYZShit.DataBase.Query(string.format("INSERT INTO christmas_credits(userid, credits) VALUE('%s', '%s');", ply:SteamID64(), 0))
			XYZChristmasCredits.Core.PlyCredits[ply:SteamID64()] = 0
		else
			XYZChristmasCredits.Core.PlyCredits[ply:SteamID64()] = data[1].credits
		end
	end)
end

function XYZChristmasCredits.Database.GiveCredits(ply, amount)
	XYZChristmasCredits.Core.PlyCredits[ply:SteamID64()] = XYZChristmasCredits.Core.PlyCredits[ply:SteamID64()] + amount
	XYZShit.DataBase.Query(string.format("UPDATE christmas_credits SET credits='%s' WHERE userid='%s';", XYZChristmasCredits.Core.PlyCredits[ply:SteamID64()], ply:SteamID64()))
end