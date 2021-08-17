util.AddNetworkString("xWarnWarningInfo")
function xWarn.msg(msg, target) 
	net.Start("xWarnWarningInfo")
	net.WriteString(msg)
	net.Send(target)
end