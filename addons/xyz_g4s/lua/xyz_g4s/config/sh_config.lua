G4S.Config.Color = Color(46, 204, 113)
G4S.Config.MoneyCutOnDeposit = .35 -- 10%, counts the total of all money bags.
hook.Add("loadCustomDarkRPItems", "G4SConfig", function()
	G4S.Config.Job = TEAM_G4SDRIVER
end)

G4S.Config.TruckSpawnPos = Vector(-3137.131104, -1290.693359, 64.031250)