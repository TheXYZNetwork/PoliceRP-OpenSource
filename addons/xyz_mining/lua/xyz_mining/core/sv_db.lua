function Mining.Database.LoadPly(plyID)
	XYZShit.DataBase.Query(string.format("SELECT * FROM mining_inv WHERE userid = %s;", plyID), function(data)
		if (not data) or table.IsEmpty(data) then return end

		Mining.Users[plyID] = {}

		for k, v in pairs(data) do
			Mining.Users[plyID][v.ore] = v.amount
		end
	end)
end

function Mining.Database.GiveOre(plyID, ore, amount)
	XYZShit.DataBase.Query(
		string.format("INSERT INTO mining_inv(userid, ore, amount) VALUES('%s', '%s', %i) ON DUPLICATE KEY UPDATE amount = amount + %i;",
			XYZShit.DataBase.Escape(plyID),
			XYZShit.DataBase.Escape(ore),
			amount,
			amount
		)
	)
end