net.Receive( "xWarnWarningInfo", function( len, pl )
	if xWarn.Config.PrintMethod == 1 then
		MsgN(net.ReadString())
	elseif xWarn.Config.PrintMethod == 2 then
		chat.AddText(net.ReadString())
	end
end )