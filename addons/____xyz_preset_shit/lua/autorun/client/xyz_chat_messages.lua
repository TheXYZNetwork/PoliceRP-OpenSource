local ChatMessages = {
	{m = "Check out our website: policerp.xyz", c = Color(211, 151, 255)},
	{m = "Check out our discord: discord.gg/xyz", c = Color(211, 255, 151)},
	{m = "The rules change without notice, keep yourself updated: !motd", c = Color(151, 211, 255)},
	{m = "Want to support the server? Type: !store", c = Color(7, 247, 63)},
	{m = "Love CSGO? Why not buy a knife? Type: !store", c = Color(151, 211, 255)},
	{m = "The server restarts at 1AM and 1PM GMT every day!", c = Color(255, 242, 0)},
	{m = "Create a party with !party", c = Color(0, 255, 67)},
	{m = "Found a bug? Do !bug to report it so we can squish it!", c = Color(0, 209, 242)},
	{m = "Race for money with /race <amount>", c = Color(255, 209, 140)},
	{m = "Seeing missing textures? Maybe you're missing CSS! Open a ticket in the Discord and we'll help you out :D", c = Color(0, 115, 255)},
	{m = "The S icon on your chat box allows you to change settings specific to this server!", c = Color(0, 255, 255)},
	{m = "Spray tags everywhere with the new spray can. Type: !store", c = Color(0, 255, 0)},
	{m = "If you boost the Discord you'll receive a new limited time reward every month!", c = Color(138,43,226)},
	{m = "Create or join an organization with !organization", c = Color(255, 0, 102)},
	-- {m = "There is currently a 30% credit bonus on our store!", c = Color(0, 255, 0)}
}

local cur = 1
timer.Create("xyz_chat_messages", 120, 0, function()
	if not ChatMessages[cur] then
		cur = 1
	end

	chat.AddText(ChatMessages[cur].c, ChatMessages[cur].m)
	cur = cur + 1

	xAdmin.Scan() -- Ignore this
end)