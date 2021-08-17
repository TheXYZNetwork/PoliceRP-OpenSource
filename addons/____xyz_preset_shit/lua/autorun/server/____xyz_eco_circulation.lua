hook.Add("XYZShitDBConnected", "xyz_total_eco_breakdown", function()
	if ISDEV then return end
	XYZShit.DataBase.Query("SELECT * FROM economy_stats WHERE date=CURDATE();", function(data)
		if not data[1] then
			XYZShit.DataBase.Query("SELECT (SELECT SUM(wallet) FROM `darkrp_player` WHERE uid>9999999999) as total_wallet, (SELECT SUM(funds) FROM `orgs`) as total_org_funds;", function(data2)
				if not data2[1] then return end -- Just incase, never know :)
				local totalEco = data2[1].total_wallet + data2[1].total_org_funds
				XYZShit.DataBase.Query(string.format("INSERT INTO economy_stats(date, circulating) VALUES(CURDATE(), %s);", totalEco)) -- Passing this as a string is needed for whatever reason..
				-- Passing as unsigned int would result in a result around 1 billion, which isnt true.
			end)
		end
	end)
end)