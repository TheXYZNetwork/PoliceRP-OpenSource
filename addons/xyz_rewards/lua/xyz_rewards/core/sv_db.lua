/*
CREATE TABLE `rewards` (
	`userid` VARCHAR(32) NOT NULL,
	`type` VARCHAR(64) NOT NULL,
	`progress` INT(32),
	`updated` INT(32) NOT NULL,
	UNIQUE KEY `unique_index` (`userid`, `type`)
)
*/

function Rewards.Database.LoadPlayer(ply)
	XYZShit.DataBase.Query(string.format("SELECT * FROM rewards WHERE userid='%s'", ply:SteamID64()), function(data)
		for k, v in pairs(Rewards.Config.Rewards) do
			Rewards.Players[ply:SteamID64()][k] = {
				progress = 0,
				updated = 0
			}
			for n, m in pairs(data) do
				if not (m.type == k) then continue end -- Not the data we're looking for

				Rewards.Players[ply:SteamID64()][k].progress = tonumber(m.progress)
				Rewards.Players[ply:SteamID64()][k].updated = tonumber(m.updated)
			end
		end

		net.Start("Rewards:Join")
			net.WriteTable(Rewards.Players[ply:SteamID64()])
		net.Send(ply)
	end)
end

function Rewards.Database.SetProgress(ply, reward, progress)
	Rewards.Players[ply:SteamID64()][reward].progress = progress
	Rewards.Players[ply:SteamID64()][reward].updated = os.time()
	XYZShit.DataBase.Query(string.format("INSERT INTO rewards(userid, type, progress, updated) VALUES('%s', '%s', %i, %i) ON DUPLICATE KEY UPDATE progress=%i, updated=%i", ply:SteamID64(), reward, progress, os.time(), progress, os.time()))
end