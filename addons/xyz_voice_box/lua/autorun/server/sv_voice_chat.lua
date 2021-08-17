util.AddNetworkString("xyz_voice_chat_leave_net")

hook.Add("PlayerDisconnected", "xyz_voice_chat_leave", function(ply)
	net.Start("xyz_voice_chat_leave_net")
		net.WriteString(ply:SteamID64())
	net.Broadcast()
end)