print("[Log netmessages]", "Loading")
--CreateConVar("xyz_netmessage_logger", 0)

function net.Incoming(len, client)
	local i = net.ReadHeader()
	local strName = util.NetworkIDToString( i )
	
	if not strName then return end
	
	local func = net.Receivers[strName:lower()]
	if not func then return end

	--
	-- len includes the 16 bit int which told us the message name
	--
	len = len - 16
	
	--if GetConVar("xyz_netmessage_logger"):GetBool() then
		if not string.find(strName:lower(), "vc_") then
			if client then
				if not client.netMessageLastWipe then
					client.netMessageLastWipe = 0
					print("[Log NetMessage]", "New user being registered to the system: "..client:Name())
				end
				if client.netMessageLastWipe < CurTime() - 1 then
					client.netMessageCount = 0
					client.netMessageLastWipe = CurTime()
					print("[Log NetMessage]", "Reset: "..client:Name().."'s message counter")
				end
				local C = client.netMessageCount or 0

				client.netMessageCount = C + 1

				if (C) and (C > 100) then
					if client.netMessageKicked then return end
					xAdmin.Prevent.Post("Netmessage Spamming", client, "Has been kicked for netmessage spamming. **Last message sent: "..strName.."**")
					print("[Log NetMessage]", "Kicking "..client:Name().." ("..client:SteamID()..") for suspected net message spamming")
					client:Kick("Suspected Exploiting")
					client.netMessageKicked = true
					return
				end

				print("[Log NetMessage]", "Message received from "..client:Name().." ("..client:SteamID().."). The net message was '"..strName.."'. Their current count is: "..client.netMessageCount)
			else
				print("[Log NetMessage]", "Message received from Unknown user. The net message was '"..strName.."'")
			end
		end
	--end
	func( len, client )
end