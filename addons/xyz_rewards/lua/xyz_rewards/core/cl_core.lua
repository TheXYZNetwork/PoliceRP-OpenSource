net.Receive("Rewards:Failed", function()
	local task = net.ReadString()

	if not Rewards.Config.Rewards[task] then return end
	if not Rewards.Config.Rewards[task].fail then return end

	Rewards.Config.Rewards[task].fail()
end)

net.Receive("Rewards:Join", function()
	if not XYZSettings.GetSetting("rewards_open_join", true) then return end
	
	local data = net.ReadTable()
	Rewards.Core.Menu(data)
end)