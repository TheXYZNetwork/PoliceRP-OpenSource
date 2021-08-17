local function dumpStats()
	XYZShit.Webhook.PostEmbed("eco_breakdown", {
		title = "Tax System",
		fields = {
			{
				name = "Total Added",
				value = DarkRP.formatMoney(XYZPresident.Stats.AddedToFunds),
				inline = true,
			},
			{
				name = "% Tax",
				value = math.Round((XYZPresident.Stats.Tax / XYZPresident.Stats.AddedToFunds * 100), 2).."% ("..DarkRP.formatMoney(XYZPresident.Stats.Tax)..")",
				inline = true,
			},
			{
				name = "% Tickets",
				value = math.Round((XYZPresident.Stats.Tickets / XYZPresident.Stats.AddedToFunds * 100), 2).."% ("..DarkRP.formatMoney(XYZPresident.Stats.Tickets)..")",
				inline = true,
			},
			{
				name = "% Seizures",
				value = math.Round((XYZPresident.Stats.Seizures / XYZPresident.Stats.AddedToFunds * 100), 2).."% ("..DarkRP.formatMoney(XYZPresident.Stats.Seizures)..")",
				inline = true,
			},
			{
				name = "Thrown Away",
				value = DarkRP.formatMoney(XYZPresident.Stats.ThrownAwayCap),
				inline = true,
			},
			{
				name = "Paid Out",
				value = DarkRP.formatMoney(XYZPresident.Stats.PaidOut).." ("..math.Round((XYZPresident.Stats.PaidOut / XYZPresident.Stats.AddedToFunds * 100), 2).."%)",
				inline = true,
			},
			{
				name = "Stolen",
				value = DarkRP.formatMoney(XYZPresident.Stats.Stolen).." ("..math.Round((XYZPresident.Stats.Stolen / XYZPresident.Stats.AddedToFunds * 100), 2).."%)",
				inline = true,
			},
			{
				name = "To be thrown away @ restart",
				value = DarkRP.formatMoney(XYZPresident.TotalMoney).." ("..math.Round((XYZPresident.TotalMoney / XYZPresident.Stats.AddedToFunds * 100), 2).."%)",
				inline = true,
			},
			{
				name = "Net Collected",
				value = DarkRP.formatMoney(XYZPresident.Stats.AddedToFunds - XYZPresident.Stats.ThrownAwayCap - XYZPresident.TotalMoney),
				inline = true,
			}
		},
		color = 6729778,
		footer = {
			text = "PoliceRP 1"
		}
	})

end
hook.Add("ShutDown", "Tax:Stats:Discord", dumpStats)
concommand.Add("tax_stats_dump", function() 
	dumpStats()
end)