--[[
CREATE TABLE `advent_doors` (
 `userid` varchar(32) NOT NULL,
 `door` int(11) DEFAULT NULL,
 `reward` varchar(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1
]]

function XYZChristmasAdvent.Core.RegisterDoorOpening(ply, reward)
	XYZShit.DataBase.Query(string.format("INSERT INTO advent_doors(userid, door, reward) VALUE('%s', '%s', '%s')", ply:SteamID64(), XYZChristmasAdvent.CurrentDay, XYZShit.DataBase.Escape(reward)))
end


function XYZChristmasAdvent.Core.GetOpenedDoors(ply, callback)
	XYZShit.DataBase.Query(string.format("SELECT door FROM advent_doors WHERE userid='%s'", ply:SteamID64()), callback)
end