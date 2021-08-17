hook.Add("XYZShitDBConnected", "xyz_pnc_db", function()
	XYZShit.DataBase.Query("SELECT * FROM pnc_arrests", function(q)
		for k, v in pairs(q) do
			if not PNC.Core.Arrests[v.userid] then 
				PNC.Core.Arrests[v.userid] = {}
			end
			PNC.Core.Arrests[v.userid][v.time] = util.JSONToTable(v.charges)
		end
	end)

	XYZShit.DataBase.Query("SELECT * FROM pnc_tickets", function(q)
		for k, v in pairs(q) do
			if not PNC.Core.Tickets[v.userid] then 
				PNC.Core.Tickets[v.userid] = {}
			end
			PNC.Core.Tickets[v.userid][v.time] = util.JSONToTable(v.charges)
		end
	end)
end)