hook.Add( "PlayerInitialSpawn", "Phone:Load", function(ply)
	Phone.Core.GetPhoneNumber(ply:SteamID64())
end)

net.Receive("Phone:SendText", function(_, ply)
	if XYZShit.CoolDown.Check("Phone:SendText", 1, ply) then return end

	local number = net.ReadString()
	local text = net.ReadString()

	local receiver = Phone.Core.GetUserByNumber(number)
	if not receiver then
		XYZShit.Msg("Phone", Phone.Config.Color, "The number your are trying to contact is unavailabe. This is either because the contact number is invalid or the phone is off.", ply)
		return
	end

	if text == "" then return end

	net.Start("Phone:ReceiveText")
		net.WriteString(Phone.Core.GetPhoneNumber(ply:SteamID64()))
		net.WriteString(text)
	net.Send(receiver)
end)

Phone.PendingCalls = {}
net.Receive("Phone:Call", function(_, ply)
	if XYZShit.CoolDown.Check("Phone:Call", 1, ply) then return end

	local number = net.ReadString()
	local receiver = Phone.Core.GetUserByNumber(number)
	if not receiver then
		XYZShit.Msg("Phone", Phone.Config.Color, "The number your are trying to contact is unavailabe. This is either because the contact number is invalid or the phone is off.", ply)
		return
	end

	if Phone.PendingCalls[number] then
		XYZShit.Msg("Phone", Phone.Config.Color, "This phone is already in a call...", ply)
		return
	end


	Phone.PendingCalls[number] = Phone.Core.GetPhoneNumber(ply:SteamID64())
	Phone.PendingCalls[Phone.Core.GetPhoneNumber(ply:SteamID64())] = number

	receiver:EmitSound("xyz/phone_ringtone_long.mp3")

	net.Start("Phone:Call:Send")
		net.WriteString(Phone.Core.GetPhoneNumber(ply:SteamID64()))
	net.Send(receiver)
end)

net.Receive("Phone:Call:Reject", function(_, ply)
	if XYZShit.CoolDown.Check("Phone:Call:Reject", 1, ply) then return end

	local receiverNumber = Phone.Core.GetPhoneNumber(ply:SteamID64())
	local callerNumber = Phone.PendingCalls[receiverNumber]


	local caller = Phone.Core.GetUserByNumber(callerNumber)

	if caller then
		net.Start("Phone:Call:Ended")
		net.Send(caller)
	end

	ply:StopSound("xyz/phone_ringtone_long.mp3")

	if callerNumber then
		Phone.PendingCalls[callerNumber] = nil
	end
	if receiverNumber then
		Phone.PendingCalls[receiverNumber] = nil
	end
end)

net.Receive("Phone:Call:Cancel", function(_, ply)
	if XYZShit.CoolDown.Check("Phone:Call:Cancel", 1, ply) then return end

	local callerNumber = Phone.Core.GetPhoneNumber(ply:SteamID64())
	local receiverNumber = Phone.PendingCalls[callerNumber]

	local receiver = Phone.Core.GetUserByNumber(receiverNumber)

	if receiver then
		net.Start("Phone:Call:Ended")
		net.Send(receiver)

		receiver:StopSound("xyz/phone_ringtone_long.mp3")
	end

	Phone.PendingCalls[receiverNumber or ""] = nil
	Phone.PendingCalls[callerNumber or ""] = nil
end)


Phone.ActiveCalls = {}
net.Receive("Phone:Call:Accept", function(_, ply)
	if XYZShit.CoolDown.Check("Phone:Call:Accept", 1, ply) then return end

	local callerNumber = Phone.Core.GetPhoneNumber(ply:SteamID64())
	local receiverNumber = Phone.PendingCalls[callerNumber]
	local receiver = Phone.Core.GetUserByNumber(receiverNumber)

	-- Ply disconnected or something?
	if not receiver then
		Phone.PendingCalls[Phone.Core.GetPhoneNumber(ply:SteamID64())] = nil
		return
	end

	ply:StopSound("xyz/phone_ringtone_long.mp3")

	Phone.ActiveCalls[receiver:SteamID64()] = ply
	Phone.ActiveCalls[ply:SteamID64()] = receiver

	net.Start("Phone:Call:Started")
		net.WriteString(Phone.Core.GetPhoneNumber(receiver:SteamID64()))
	net.Send(ply)
	net.Start("Phone:Call:Started")
		net.WriteString(Phone.Core.GetPhoneNumber(ply:SteamID64()))
	net.Send(receiver)
end)

net.Receive("Phone:Call:End", function(_, ply)
	if XYZShit.CoolDown.Check("Phone:Call:End", 1, ply) then return end

	local callerNumber = Phone.Core.GetPhoneNumber(ply:SteamID64())
	local receiverNumber = Phone.PendingCalls[callerNumber]
	local receiver = Phone.Core.GetUserByNumber(receiverNumber)


	Phone.PendingCalls[Phone.Core.GetPhoneNumber(ply:SteamID64())] = nil
	Phone.ActiveCalls[ply:SteamID64()] = nil

	if receiver then
		Phone.PendingCalls[Phone.Core.GetPhoneNumber(receiver:SteamID64())] = nil
		Phone.ActiveCalls[receiver:SteamID64()] = nil
		net.Start("Phone:Call:Ended")
		net.Send(receiver)
	end
end)

hook.Add("PlayerCanHearPlayersVoice", "Phone:Call", function(listener, talker)
    if not Phone.ActiveCalls[talker:SteamID64()] then return end
    if not Phone.ActiveCalls[listener:SteamID64()] then return end
    if not (Phone.ActiveCalls[talker:SteamID64()] == listener) then return end
    if not (Phone.ActiveCalls[listener:SteamID64()] == talker) then return end

    return true, false
end)

net.Receive("Phone:Snapper:Take", function(_, ply)
	if XYZShit.CoolDown.Check("Phone:Snapper:Take", 1, ply) then
		xAdmin.Prevent.Post("Photo Upload Smapping", ply, "This user is flooding image uploads", 8070273, true)
		return
	end

	local time = net.ReadUInt(32)
	local chunkCount = net.ReadUInt(6)

	local completeData = ""
	for i=1, chunkCount do
		completeData = completeData..net.ReadString()
	end

	HTTP({
        url = "http://media.ntwrk.xyz/api/upload", 
        method= "POST", 
        headers= { 
            ['Content-Type']= 'application/json',
			['Authorization'] = "SECRETKEY",
        },
        success= function(code, body)
			local data = util.JSONToTable(body)

			if data.error then
				print("[Phone] Image failed to upload, error:", body.error)
				return
			end

			if not data.code then return end

			net.Start("Phone:Snapper:Save")
				net.WriteUInt(time, 32)
				net.WriteString(data.code)
			net.Send(ply)
        end,
        body = util.TableToJSON({
        	['steamid'] = ply:SteamID64(),
			['base64'] = completeData
        }),
        type = "application/json" 
	})

end)