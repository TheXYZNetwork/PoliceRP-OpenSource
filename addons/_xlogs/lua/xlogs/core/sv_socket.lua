require("gwsockets")
xLogs.Socket.SecretKey = "secretkey :)"

local retry = false
function xLogs.Socket.StartConnection()
	print("[xLogs]", "Starting connection")
	if retry then
		print("[xLogs]", "Aborting connection request as retry attempt already failed. Resorting to manual use until instructed otherwise.")
		xLogs.Socket.Connection = nil
		return
	end

	if xLogs.Socket.Connection then
		xLogs.Socket.Connection:closeNow()
	end

	xLogs.Socket.Connection = GWSockets.createWebSocket("wss://socket.policerp.xyz/", false)

	function xLogs.Socket.Connection:onMessage(txt)
		--print("[xLogs Socket]", "Received: ", txt)
	end
	
	function xLogs.Socket.Connection:onError(txt)
		print("[xLogs Socket]", "Error: ", txt)
	end
	
	function xLogs.Socket.Connection:onConnected()
		print("[xLogs Socket]", "Connection made")
		retry = false
	end
	function xLogs.Socket.Connection:onDisconnected()
		print("[xLogs Socket]", "WebSocket disconnected")
		xLogs.Socket.StartConnection()
		retry = true
	end
	
	function xLogs.Socket.Send(query, cat)
		local tbl = {}
		tbl.key = xLogs.Socket.SecretKey
		tbl.server = xLogs.Info.FullName
		tbl.log = xLogs.Database.Escape(query)
		tbl.category = cat
	    
		xLogs.Socket.Connection:write(util.TableToJSON(tbl))
	end

	xLogs.Socket.Connection:open()
end

xLogs.Socket.StartConnection()

concommand.Add("xlogs_socket_manual_trigger", function(ply)
	if not (ply == NULL) then return end
	
	print("[xLogs]", "Making forced connection attempt")
	retry = false
	xLogs.Socket.StartConnection()
end)