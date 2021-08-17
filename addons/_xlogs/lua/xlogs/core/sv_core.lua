function xLogs.Core.Player(ply)
	if not IsValid(ply) then
		return "{#P|NULL|Unknown|#}"
	end
	if not ply:IsPlayer() then
		return "{#P|NULL|Not Player|#}"
	end

	return string.format("{#P|%s|%s|#}{#W|%s|#} [{#J|%s|#}]", ply:SteamID64() or "NULL", ply:Name() or "Unknown", (IsValid(ply:GetActiveWeapon()) and ply:GetActiveWeapon():GetClass()) or "None", team.GetName(ply:Team()) or "Unknown")
end

function xLogs.Core.Color(data, color)
	if not data then
		return "nil"
	end

	return string.format("{#C|%s|%i,%i,%i|#}", data, color.r, color.g, color.b)
end

function xLogs.Log(query, category)
	if not query then return end
	if xLogs.Socket.Connection and xLogs.Socket.Connection:isConnected() then
		xLogs.Socket.Send(query, category or "Other")
	else
		xLogs.Database.LogEvent(query, category or "Other")
	end
end

function xLogs.RegisterCategory(category, parent, name)
	if not category then return end
	xLogs.Database.CreateCategory(category, parent or "Misc", name or category)
end


for _, files in SortedPairs(file.Find("xlogs/pre_logs/*.lua", "LUA"), true) do
	print("Loading log file:", files)
    include("xlogs/pre_logs/" .. files)
end

util.AddNetworkString("xLogsOpenMenu")
hook.Add("PlayerSay", "xLogsMenuCommand", function(ply, msg)
	if string.lower(msg) == "!xlogs" then
		if not ply:HasPower(30) then return end

		net.Start("xLogsOpenMenu")
		net.Send(ply)
	end
end)