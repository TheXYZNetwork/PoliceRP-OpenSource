hook.Add("PlayerSay", "xyz_911_command", function(ply, msg)
	if string.sub(msg, 1, 4) == "/911" or string.sub(msg, 1, 4) == "/999" or string.sub(msg, 1, 4) == "!911" or string.sub(msg, 1, 4) == "!999" then
		if XYZShit.CoolDown.Check("XYZ911:Call", 60, ply) then
			XYZShit.Msg("Emergency Services", Color(200, 40, 30), "Seems you just requested some assistance. Please wait before requesting it again", ply)
			return ""
		end

		if ply:XYZIsArrested() or ply:XYZIsZiptied() then
			XYZShit.Msg("Emergency Services", Color(200, 40, 30), "You cannot call 911 while your hands are behind your back...", ply)
			return
		end

		if PrisonSystem.IsArrested(ply) then
			XYZShit.Msg("Emergency Services", Color(200, 40, 30), "You cannot call 911 while in jail...", ply)
			return
		end

		if XYZShit.IsGovernment(ply:Team(), true) then
			XYZShit.Msg("Emergency Services", Color(200, 40, 30), "You are already government, use your radio/panic button instead.", ply)
			return ""
		end

		local reason = string.sub(msg, 6)
		reason = (reason == "") and "No reason given" or reason 

		XYZShit.Msg("Emergency Services", Color(200, 40, 30), "Your request has been logged. Someone will be with your shortly.", ply)

		local govPlys = {}
		for k, v in pairs(player.GetAll()) do
			if XYZShit.IsGovernment(v:Team(), true) then
				table.insert(govPlys, v)
			end
		end


		XYZ911.Database.Log(ply, reason, function(responseData)
			if not IsValid(ply) then return end
			if not responseData[1] then return end
			if not responseData[1]["LAST_INSERT_ID()"] then return end

			local callID = responseData[1]["LAST_INSERT_ID()"]

			net.Start("XYZ911:StartCall")
				net.WriteEntity(ply)
				net.WriteUInt(callID, 32)
				net.WriteString(reason)
			net.Send(govPlys)

			XYZ911.ActiveCalls[callID] = {}
			XYZ911.ActiveCalls[callID].ply = ply
			XYZ911.ActiveCalls[callID].pos = ply:GetPos()
			XYZ911.ActiveCalls[callID].reason = reason
			XYZ911.ActiveCalls[callID].responders = {}

			timer.Simple(XYZ911.Config.ClaimTime, function()
				-- Log claimers
				if not table.IsEmpty(XYZ911.ActiveCalls[callID].responders) then
					XYZ911.Database.UpdateResponders(callID, XYZ911.ActiveCalls[callID].responders)
				end
				XYZ911.ActiveCalls[callID] = nil
			end)
		end)

		return ""
	end
end)

net.Receive("XYZ911:Respond", function(_, ply)
	if XYZShit.CoolDown.Check("XYZ911:Respond", 1, ply) then return end
	if not XYZShit.IsGovernment(ply:Team(), true) then return end

	local callID = net.ReadUInt(32)
	if not XYZ911.ActiveCalls[callID] then return end
	if table.HasValue(XYZ911.ActiveCalls[callID].responders, ply) then return end
	if not IsValid(XYZ911.ActiveCalls[callID].ply) then return end

	table.insert(XYZ911.ActiveCalls[callID].responders, ply)

	net.Start("XYZ911:Marker")
		net.WriteUInt(callID, 32)
		net.WriteVector(XYZ911.ActiveCalls[callID].pos)
	net.Send(ply)

	XYZShit.Msg("Emergency Services", Color(200, 40, 30), "You are responding to "..XYZ911.ActiveCalls[callID].ply:Name().."'s emergency call!", ply)

	XYZShit.Msg("Emergency Services", Color(200, 40, 30), ply:Name().." is responding to your emergency call!", XYZ911.ActiveCalls[callID].ply)

	Quest.Core.ProgressQuest(ply, "boys_in_blue", 5)
end)