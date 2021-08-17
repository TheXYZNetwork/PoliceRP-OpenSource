net.Receive("xyz_msg", function()
	XYZShit.Msg(net.ReadString(), net.ReadColor(), net.ReadString())
end)

function XYZShit.Msg(tag, clr, msg)
	chat.AddText(clr, tag.." | ", Color( 255, 255, 255 ), msg)
end