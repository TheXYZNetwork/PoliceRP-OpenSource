--local deals = {
--	
--}

--if deals[warned] then 
--	xAdmin.Database.CreateBan(warned, (IsValid(warnedply) and warnedply:Name()) or "Unknown", 0, "xWarn", "Part of deal with management", 10080 * 60)
--	XYZShit.Webhook.Post("wallofshame", "PoliceRP", string.gsub((warnedply and warnedply:Name()) or warned, "%@", "").." was automatically banned as part of a deal with management")
--	if not warnedply then return end
--	warnedply:Kick(string.format(xAdmin.Config.BanFormat, "xWarn", string.NiceTime(10080 * 60), "Part of deal with management"))
--else

hook.Add("xWarnPlayerWarned", "xWarnHandleWarn", function(warned, warnedply, admin, reason) 
	if IsValid(warnedply) then
		XYZShit.Webhook.Post("wallofshame", "PoliceRP", string.gsub(admin:Name(), "%@", "").." warned "..string.gsub(warnedply:Name(), "%@", "").." ("..warnedply:SteamID64()..") for "..string.gsub(reason, "%@", ""))
		if XYZShit.Staff.All[warnedply:GetUserGroup()] then return end
	else
		XYZShit.Webhook.Post("wallofshame", "PoliceRP", string.gsub(admin:Name(), "%@", "").." warned "..string.gsub(warned, "%@", "").." for "..string.gsub(reason, "%@", ""))
	end
	xWarn.Database.GetWarns(warned, function(warns)
		local totalwarns = 0
		for k, v in pairs(warns) do
			totalwarns = totalwarns + 1
		end
		if totalwarns >= 45 then
			xAdmin.Database.CreateBan(warned, (IsValid(warnedply) and warnedply:Name()) or "Unknown", 0, "xWarn", "Reached warn limit", 0)
			xAdmin.Core.Msg({(IsValid(warnedply) and warnedply:Name()) or warned, " was automatically permanently banned for reaching the warn limit."})
			XYZShit.Webhook.Post("wallofshame", "PoliceRP", string.gsub((warnedply and warnedply:Name()) or warned, "%@", "").." was automatically permanently banned for reaching the warn limit.")
			if not warnedply then return end
			warnedply:Kick(string.format(xAdmin.Config.BanFormat, "xWarn", "Permanent", "Reached warn limit"))
		elseif totalwarns%5 == 0 then
			-- Changing the 2 here will dynammically change the total amount added. Whatever you change the 2 to will be the time added for each 5 warns
			local totalBanHours = 12 + (((totalwarns/5)-1) * 2) -- We remove 1 as we want the inital ban to be 12 hours

			xAdmin.Database.CreateBan(warned, (IsValid(warnedply) and warnedply:Name()) or "Unknown", 0, "xWarn", "Cooldown ban (Warn induced)", 60*60*totalBanHours)
			xAdmin.Core.Msg({(IsValid(warnedply) and warnedply:Name()) or warned, " was banned for "..totalBanHours.." hours because they activated a warn induced cooldown ban."})
			XYZShit.Webhook.Post("wallofshame", "PoliceRP", string.gsub((warnedply and warnedply:Name()) or warned, "%@", "").." was banned for "..totalBanHours.." hours because they activated a warn induced cooldown ban.")
			if not warnedply then return end
			warnedply:Kick(string.format(xAdmin.Config.BanFormat, "xWarn", string.NiceTime(60*60*totalBanHours), "Cooldown ban (Warn induced)"))
		end
	end)
end)

hook.Add("xWarnWarnOnBan", "xWarnHandleWarnOnBan", function(target, targetname, time, banid)
	-- They've already been warned once (by the xWarn feature), this hook will add a max of 3 depending on time.
	local timestowarn = (time/86400)-1
	if timestowarn > 3 then
		timestowarn = 3
	end

	if timestowarn > 0 then 
		for i=1,timestowarn do 
			xWarn.Database.CreateWarn(target, targetname, 0, "xWarn", "Banned - Additional warn to scale", banid)
		end
	end
	
	xWarn.Database.GetWarns(target, function(warns)
		local totalwarns = 0
		for k, v in pairs(warns) do
			totalwarns = totalwarns + 1
		end
		if totalwarns >= 45 then
			xAdmin.Database.CreateBan(target, "Unknown", 0, "xWarn", "Reached warn limit", 0)
			xAdmin.Core.Msg({target, " was automatically permanently banned for reaching the warn limit."})
			XYZShit.Webhook.Post("wallofshame", "PoliceRP", string.gsub(target, "%@", "").." was automatically permanently banned for reaching the warn limit")
		end
	end)
end)

hook.Add("xAdminPlayerKicked", "xAdminHandleKick", function(target, admin, reason) 
	XYZShit.Webhook.Post("wallofshame", "PoliceRP", string.gsub(admin:Name(), "%@", "").." kicked "..string.gsub(target:Name(), "%@", "").." ("..target:SteamID64()..") for "..string.gsub(reason, "%@", ""))
end)

hook.Add("xAdminPlayerBanned", "xAdminHandleBan", function(target, admin, reason, time) 
	if type(target) == "Player" then
		XYZShit.Webhook.Post("wallofshame", "PoliceRP", string.gsub(admin:Name(), "%@", "").." banned "..string.gsub(target:Name(), "%@", "").." ("..target:SteamID64()..") for "..((time==0 and "permanent") or string.NiceTime(time)).." for "..string.gsub(reason, "%@", ""))
	else
		XYZShit.Webhook.Post("wallofshame", "PoliceRP", string.gsub(admin:Name(), "%@", "").." banned "..target.." for "..((time==0 and "permanent") or string.NiceTime(time)).." for "..string.gsub(reason, "%@", ""))
	end
end)