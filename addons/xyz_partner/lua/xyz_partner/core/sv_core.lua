local function checkPrivladge(ply)
	return table.HasValue(XYZShit.Jobs.Government.PoliceMeetings, ply:Team()) or ply:IsAdmin()
end

local function randomPartner(ply)
	if not IsValid(ply) then return end
	--print("[Partner]", ply:Nick().." has been passed through the randomPartner function.")
	ply.currentPartner = nil
	if not table.HasValue(XYZShit.Jobs.Government.Police, ply:Team()) then XYZShit.Msg("Partner", Color(100, 40, 160), "Hey now, seems we're trying to give you a partner when you're not even PD. Sorry about that, contact an admin with this comes up again.", ply) return end
	for k, v in pairs(player.GetAll()) do
		if not table.HasValue(XYZShit.Jobs.Government.Police, v:Team()) then continue end
		if IsValid(v.currentPartner) then continue end
		if v == ply then continue end

		--print("[Partner]", ply:Nick().." has had "..v:Nick().." selected as their partner in the randomPartner function.")

		XYZShit.Msg("Partner", Color(100, 40, 160), "You have been assigned "..v:Nick().." as a partner.", ply)
		XYZShit.Msg("Partner", Color(100, 40, 160), "We noticed you didn't have a partner, we've assigned you "..ply:Nick(), v)
		ply.currentPartner = v
		v.currentPartner = ply
		net.Start("xyz_partner_data")
			net.WriteEntity(v)
			net.WriteEntity(v.JobCarDealerCurCar)
		net.Send(ply)
		net.Start("xyz_partner_data")
			net.WriteEntity(ply)
			net.WriteEntity(ply.JobCarDealerCurCar)
		net.Send(v)
		return
	end
	net.Start("xyz_partner_data_remove")
	net.Send(ply)
	ply.currentPartner = nil
	XYZShit.Msg("Partner", Color(100, 40, 160), "We were unable to find you a partner, we'll let you know when one becomes available.", ply)
	--print("[Partner]", ply:Nick().." was unable to find a partner in the randomPartner function.")
end

hook.Add("PlayerSay", "xyz_partner_chat_command", function(ply, msg)
	if string.lower(msg) == "!partner" then
		if not table.HasValue(XYZShit.Jobs.Government.Police, ply:Team()) then
			XYZShit.Msg("Partner", Color(100, 40, 160), "You need to be a police role to request a partner.", ply)
		else
			--print("[Partner]", ply:Nick().." has used the chat command to open the !partner menu")
			net.Start("xyz_partner_open")
			net.Send(ply)
		end
	elseif string.lower(msg) == "!partners" then
		if not table.HasValue(XYZShit.Jobs.Government.PoliceTrainers, ply:Team()) then
			XYZShit.Msg("Partner", Color(100, 40, 160), "You need to be a police higher-up to view people's partners.", ply)
		else
			net.Start("xyz_partners_open")
				local partners = {}
				for k, v in pairs(player.GetAll()) do
					if not v.currentPartner then continue end
					table.insert(partners, {v, v.currentPartner})
				end
				net.WriteTable(partners)
			net.Send(ply)
		end
	end
end)

net.Receive("xyz_partner_request", function(_, ply)
	if XYZShit.CoolDown.Check("xyz_partner_request", 30, ply) then
		XYZShit.Msg("Partner", Color(100, 40, 160), "Please wait "..math.Round(plyCooldown[ply:SteamID64()]-CurTime(), 0).." seconds before trying to request a new partner", ply)
		return
	end

	local partner = net.ReadEntity()

	if ply == partner then return end

	if not partner then return end
	if not table.HasValue(XYZShit.Jobs.Government.Police, partner:Team()) then return end
	if not table.HasValue(XYZShit.Jobs.Government.Police, ply:Team()) then return end

	ply.requestedPartner = partner
	net.Start("xyz_partner_request_send")
		net.WriteEntity(ply)
	net.Send(partner)

	--print("[Partner]", ply:Nick().." has requested that "..partner:Nick().." become their partner.")
	XYZShit.Msg("Partner", Color(100, 40, 160), "You have requested that "..partner:Nick().." becomes your partner.", ply)
end)

net.Receive("xyz_partner_request_accept", function(_, ply)
	if XYZShit.CoolDown.Check("xyz_partner_request_accept", 1, ply) then return end

	local partner = net.ReadEntity()

	if not partner then return end
	if not table.HasValue(XYZShit.Jobs.Government.Police, partner:Team()) then XYZShit.Msg("Partner", Color(100, 40, 160), "Your partner request has expired", ply) return end
	if not table.HasValue(XYZShit.Jobs.Government.Police, ply:Team()) then XYZShit.Msg("Partner", Color(100, 40, 160), "You are no longer police.", ply) return end

	if not (partner.requestedPartner == ply) then XYZShit.Msg("Partner", Color(100, 40, 160), "Seems the person requesting a partnership has already requested a new partner...", ply) return end

	-- Give the old partner a new partner
	local cachedPartner1 = ply.currentPartner
	local cachedPartner2 = partner.currentPartner

	ply.requestedPartner = nil
	partner.requestedPartner = nil

	ply.currentPartner = partner
	partner.currentPartner = ply
	--print("[Partner]", ply:Nick().." has accepted "..partner:Nick().."'s partner request.")

	if IsValid(cachedPartner1) and IsValid(cachedPartner2) then
		--print("[Partner]", "The old partners: "..cachedPartner1:Nick().." and "..cachedPartner2:Nick().." have been swapped and are now partners.")
		cachedPartner1.currentPartner = cachedPartner2
		cachedPartner2.currentPartner = cachedPartner1
		XYZShit.Msg("Partner", Color(100, 40, 160), "Your partner has transfered to someone else. You have been given their partner.", cachedPartner1)
		XYZShit.Msg("Partner", Color(100, 40, 160), "Your partner has transfered to someone else. You have been given their partner.", cachedPartner2)
		net.Start("xyz_partner_data")
			net.WriteEntity(cachedPartner2)
			net.WriteEntity(cachedPartner2.JobCarDealerCurCar)
		net.Send(cachedPartner1)
		net.Start("xyz_partner_data")
			net.WriteEntity(cachedPartner1)
			net.WriteEntity(cachedPartner1.JobCarDealerCurCar)
		net.Send(cachedPartner2)
	elseif IsValid(cachedPartner1) then
		--print("[Partner]", ply:Nick().."'s old partner "..cachedPartner1:Nick().." will now be found a new partner.")
		cachedPartner1.currentPartner = nil
		XYZShit.Msg("Partner", Color(100, 40, 160), "Your partner has transfered to someone else. We will find you a new partner shortly.", cachedPartner1)
		randomPartner(cachedPartner1)
	elseif IsValid(cachedPartner2) then
		--print("[Partner]", partner:Nick().."'s old partner "..cachedPartner2:Nick().." will now be found a new partner.")
		cachedPartner2.currentPartner = nil
		XYZShit.Msg("Partner", Color(100, 40, 160), "Your partner has transfered to someone else. We will find you a new partner shortly.", cachedPartner2)
		randomPartner(cachedPartner2)
	end

	XYZShit.Msg("Partner", Color(100, 40, 160), "You have accepted the partner request.", ply)
	XYZShit.Msg("Partner", Color(100, 40, 160), ply:Nick().. " has accepted the partner request.", partner)

	net.Start("xyz_partner_data")
		net.WriteEntity(partner)
		net.WriteEntity(partner.JobCarDealerCurCar)
	net.Send(ply)
	net.Start("xyz_partner_data")
		net.WriteEntity(ply)
		net.WriteEntity(ply.JobCarDealerCurCar)
	net.Send(partner)
end)

net.Receive("xyz_partner_request_deny", function(_, ply)
	if XYZShit.CoolDown.Check("xyz_partner_request_deny", 1, ply) then return end
	
	local partner = net.ReadEntity()

	if not partner then return end
	if not (partner.requestedPartner == ply) then return end

	--print("[Partner]", ply:Nick().." has denied "..partner:Nick().."'s partner request.")
	XYZShit.Msg("Partner", Color(100, 40, 160), "You have denied the partner request.", ply)
	XYZShit.Msg("Partner", Color(100, 40, 160), ply:Nick().. " has denied your partner request.", partner)

	partner.requestedPartner = nil
end)

hook.Add("OnPlayerChangedTeam", "xyz_partner_team_change", function(ply, _, newTeam)
	if table.HasValue(XYZShit.Jobs.Government.Police, newTeam) then
		if not ply.currentPartner then
			--print("[Partner]", ply:Nick().." has changed to a police job and does not have a partner.")
			XYZShit.Msg("Partner", Color(100, 40, 160), "Welcome back officer. Make sure that you always stick with your partner. You should ride together, and die together! If you're found driving solo and you have a partner you can be punished! If you wish to change partners, you can type !partner and request a new partner. Have fun!", ply)
			randomPartner(ply)
		end
	else
		if IsValid(ply.currentPartner) then
			--print("[Partner]", ply:Nick().." has left a police job and had "..ply.currentPartner:Nick().." as their partner.")
			XYZShit.Msg("Partner", Color(100, 40, 160), "Your partner has left the police force.", ply.currentPartner)
			ply.currentPartner.currentPartner = nil
			randomPartner(ply.currentPartner)
		end

		ply.currentPartner = nil
		net.Start("xyz_partner_data_remove")
		net.Send(ply)
	end
end)

hook.Add("PlayerDisconnected", "xyz_partner_disconnect", function(ply)
	if ply.currentPartner and IsValid(ply.currentPartner) then
		--print("[Partner]", ply:Nick().." has left the server")
		XYZShit.Msg("Partner", Color(100, 40, 160), "Your partner has went offline.", ply.currentPartner)
		ply.currentPartner = nil
		randomPartner(ply.currentPartner)
	end
end)

hook.Add("PlayerShouldTakeDamage", "xyz_partner_damagedisable", function(ply, attacker)
	if not IsValid(ply) or not ply:IsPlayer() then return end
	if not IsValid(attacker) or not attacker:IsPlayer() then return end

	if !ply:isCP() then return end
	if !attacker:isCP() then return end

	if ply.currentPartner == attacker then
		return false
	end
end)