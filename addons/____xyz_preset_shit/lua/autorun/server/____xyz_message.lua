-- server
util.AddNetworkString("xyz_msg")

function XYZShit.Msg(tag, clr, msg, ply)
	net.Start("xyz_msg")
		net.WriteString(tag)
		net.WriteColor(clr)
		net.WriteString(msg)
	if not ply then
		net.Broadcast()
	else
		net.Send(ply)
	end
end