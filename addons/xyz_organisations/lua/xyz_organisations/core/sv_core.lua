function XYZ_ORGS.Core.CheckIfOwnsItem(org, class)
	for k, v in pairs(org.inventory) do
		if v.class == class then
			return k
		end
	end

	return false
end

function XYZ_ORGS.Core.CheckAchievements(orgID)
	local update = false
	for k, v in pairs(XYZ_ORGS.Core.Orgs[orgID].achievements) do
		if not v then
			if XYZ_ORGS.Config.Achievements[k].check(XYZ_ORGS.Core.Orgs[orgID]) then
				update = true
				XYZ_ORGS.Core.Orgs[orgID].xp = XYZ_ORGS.Core.Orgs[orgID].xp + XYZ_ORGS.Config.Achievements[k].xp
				XYZ_ORGS.Core.Orgs[orgID].achievements[k] = true
			end
		end
	end
	XYZ_ORGS.Database.UpdateAchievements(orgID, XYZ_ORGS.Core.Orgs[orgID].achievements, function(data)
		XYZ_ORGS.Database.UpdateXP(orgID, XYZ_ORGS.Core.Orgs[orgID].xp)
	end)
end

hook.Add("PlayerSay","xyz_org_open",function ( ply, text )
	if XYZ_ORGS.Config.ChatCommands[text] then
		local isInOrg = XYZ_ORGS.Core.Members[ply:SteamID64()] or false
		net.Start("xyz_orgs_menu")
		net.WriteBool(isInOrg)
		net.Send(ply)
		return ""
	end
end)

hook.Add("PlayerSay", "xyz_org_chat", function(ply, msg)
	if string.sub(msg, 1, 5) == "!org " and XYZ_ORGS.Core.Members[ply:SteamID64()] then
		local onlineOrgMembers = {}
		for k, _ in pairs( XYZ_ORGS.Core.Orgs[XYZ_ORGS.Core.Members[ply:SteamID64()]].members ) do
			if player.GetBySteamID64(k) then 
				onlineOrgMembers[#onlineOrgMembers + 1] = player.GetBySteamID64(k)
			end
		end
		XYZShit.Msg(XYZ_ORGS.Core.Orgs[XYZ_ORGS.Core.Members[ply:SteamID64()]].name, XYZ_ORGS.Config.Color, string.sub(msg, 6), onlineOrgMembers)
		return false
	end
end)

net.Receive("xyz_orgs_create", function(_, ply)
	if not ply:canAfford(XYZ_ORGS.Config.CreatePrice) then XYZShit.Msg("Organizations", XYZ_ORGS.Config.Color, "You can't afford this.", ply) return end
	local orgName = net.ReadString()
	if #orgName < 4 then XYZShit.Msg("Organizations", XYZ_ORGS.Config.Color, "Organization name cannot be less than 4 characters.", ply) return end
	if #orgName > 32 then XYZShit.Msg("Organizations", XYZ_ORGS.Config.Color, "Organization name cannot be more than 32 characters.", ply) return end
	ply:addMoney(-XYZ_ORGS.Config.CreatePrice)

	XYZ_ORGS.Database.CreateOrg(orgName, ply, function(data, q, inv)
		local id = q:lastInsert()
		XYZ_ORGS.Database.GetOrgByID(id, function(data2)
			if data2 and data2[1] then
				XYZ_ORGS.Core.Orgs[id] = {
					name = orgName,
					invite = inv,
					xp = 1000,
					funds = 0,
					members = {[ply:SteamID64()] = 1},
					upgrades = util.JSONToTable(data2[1].upgrades),
					inventory = {},
					roles = util.JSONToTable(data2[1].roles),
					achievements = util.JSONToTable(data2[1].achievements)
				}
				XYZShit.Msg("Organizations", XYZ_ORGS.Config.Color, "You created the "..orgName.." organization.", ply)
				XYZ_ORGS.Core.Invites[inv] = data2[1].id
				XYZ_ORGS.Core.Members[ply:SteamID64()] = data2[1].id
				xLogs.Log(xLogs.Core.Player(ply).." created the "..orgName.."  organization", "Organizations")

				Quest.Core.ProgressQuest(ply, "gang_warfare", 5)
			end
		end)
	end)
end)

net.Receive("xyz_orgs_join", function(_, ply)
	if not ply:canAfford(XYZ_ORGS.Config.JoinPrice) then XYZShit.Msg("Organizations", XYZ_ORGS.Config.Color, "You can't afford this.", ply) return end
	local orgInv = net.ReadString()
	if #orgInv > 16 then XYZShit.Msg("Organizations", XYZ_ORGS.Config.Color, "Organization invite cannot be more than 16 characters.", ply) return end

	local org = XYZ_ORGS.Core.Orgs[XYZ_ORGS.Core.Invites[orgInv]]

	if not org then return end

	if table.Count(org.members) >= org.upgrades.memberLimit then
		XYZShit.Msg("Organizations", XYZ_ORGS.Config.Color, "Organization is full!", ply)
		return
	end
	ply:addMoney(-XYZ_ORGS.Config.JoinPrice)
	XYZ_ORGS.Database.InsertMember(XYZ_ORGS.Core.Invites[orgInv], ply:SteamID64(), function(data)
		XYZ_ORGS.Core.Members[ply:SteamID64()] = XYZ_ORGS.Core.Invites[orgInv]
		XYZ_ORGS.Core.Orgs[XYZ_ORGS.Core.Invites[orgInv]].members[ply:SteamID64()] = 2
		XYZShit.Msg("Organizations", XYZ_ORGS.Config.Color, "You joined the "..org.name.." organization.", ply)

		Quest.Core.ProgressQuest(ply, "gang_warfare", 1)
		xLogs.Log(xLogs.Core.Player(ply).." joined the "..org.name.." organization", "Organizations")
		XYZ_ORGS.Core.CheckAchievements(XYZ_ORGS.Core.Invites[orgInv])
	end)
end)

net.Receive("xyz_orgs_leave", function(_, ply)
	if not XYZ_ORGS.Core.Members[ply:SteamID64()] then return end
	local orgid = XYZ_ORGS.Core.Members[ply:SteamID64()]
	local plyorg = XYZ_ORGS.Core.Orgs[orgid]
	if not plyorg then return end

	if plyorg.members[ply:SteamID64()] == 1 then XYZShit.Msg("Organizations", XYZ_ORGS.Config.Color, "You have to disband the organization or transfer ownership.", ply) return end

	XYZ_ORGS.Database.LeaveOrg(orgid, ply:SteamID64(), function(data)
		XYZShit.Msg("Organizations", XYZ_ORGS.Config.Color, "You left the organization.", ply)
		xLogs.Log(xLogs.Core.Player(ply).." left the organization "..plyorg.name.." organization", "Organizations")

		XYZ_ORGS.Core.Members[ply:SteamID64()] = nil
		XYZ_ORGS.Core.Orgs[orgid].members[ply:SteamID64()] = nil
	end)
end)

net.Receive("xyz_orgs_deposit", function(_, ply)
	if not XYZ_ORGS.Core.Members[ply:SteamID64()] then return end
	local orgid = XYZ_ORGS.Core.Members[ply:SteamID64()]
	local plyorg = XYZ_ORGS.Core.Orgs[orgid]
	if not plyorg then return end

	if not XYZ_ORGS.Core.HasPerms(plyorg.roles[plyorg.members[ply:SteamID64()]].perms, 'DEPOSIT', ply) then return end

	local depositAmount = net.ReadUInt(32)
	if (depositAmount + plyorg.funds) > plyorg.upgrades.balanceLimit then 
		XYZShit.Msg("Organizations", XYZ_ORGS.Config.Color, "You can't deposit this much.", ply)
		return
	end
	if depositAmount < 1000 then return end
	
	if not ply:canAfford(depositAmount) then XYZShit.Msg("Organizations", XYZ_ORGS.Config.Color, "You can't afford this.", ply) return end
	ply:addMoney(-depositAmount)

	XYZ_ORGS.Core.Orgs[orgid].funds = plyorg.funds + depositAmount
	XYZShit.Msg("Organizations", XYZ_ORGS.Config.Color, "You deposited "..DarkRP.formatMoney(depositAmount).." into your organization.", ply)
	xLogs.Log(xLogs.Core.Player(ply).." deposited "..DarkRP.formatMoney(depositAmount).." into organization "..plyorg.name, "Organizations")

	XYZ_ORGS.Database.UpdateFunds(XYZ_ORGS.Core.Members[ply:SteamID64()], XYZ_ORGS.Core.Orgs[orgid].funds)
	XYZ_ORGS.Core.CheckAchievements(orgid)

	Quest.Core.ProgressQuest(ply, "gang_warfare", 3)
end)

net.Receive("xyz_orgs_withdraw", function(_, ply)
	if not XYZ_ORGS.Core.Members[ply:SteamID64()] then return end
	local orgid = XYZ_ORGS.Core.Members[ply:SteamID64()]
	local plyorg = XYZ_ORGS.Core.Orgs[orgid]
	if not plyorg then return end

	if not XYZ_ORGS.Core.HasPerms(plyorg.roles[plyorg.members[ply:SteamID64()]].perms, 'WITHDRAW', ply) then return end

	local withdrawAmount = net.ReadUInt(32)
	if plyorg.funds < withdrawAmount then return end
	ply:addMoney(withdrawAmount)

	XYZ_ORGS.Core.Orgs[orgid].funds = plyorg.funds - withdrawAmount
	XYZShit.Msg("Organizations", XYZ_ORGS.Config.Color, "You withdrew "..DarkRP.formatMoney(withdrawAmount).." from your organization.", ply)
	xLogs.Log(xLogs.Core.Player(ply).." withdrew "..DarkRP.formatMoney(withdrawAmount).." from organization "..plyorg.name, "Organizations")

	XYZ_ORGS.Database.UpdateFunds(XYZ_ORGS.Core.Members[ply:SteamID64()], XYZ_ORGS.Core.Orgs[orgid].funds)
end)

net.Receive("xyz_orgs_withdraw_inv", function(_, ply)
	if not XYZ_ORGS.Core.Members[ply:SteamID64()] then return end
	local orgid = XYZ_ORGS.Core.Members[ply:SteamID64()]
	local plyorg = XYZ_ORGS.Core.Orgs[orgid]
	if not plyorg then return end

	if not XYZ_ORGS.Core.HasPerms(plyorg.roles[plyorg.members[ply:SteamID64()]].perms, 'WITHDRAW', ply) then return end
	
	local closeToLocker = false
	for k, v in pairs(Inventory.BankEnts) do
		if not IsValid(v) then continue end

		if v:GetPos():DistToSqr(ply:GetPos()) > 20000 then continue end

		closeToLocker = true
	end

	if not closeToLocker then
		XYZShit.Msg("Inventory", Color(2, 108, 254), "You need to be closer to a Bank Locker before you can transfer it!", ply)
		return
	end

	if table.Count(Inventory.SavedInvs[ply:SteamID64()]) >= (Inventory.Config.MaxSpace[ply:GetUserGroup()] or Inventory.Config.MaxSpace['default']) then
		XYZShit.Msg("Inventory", Color(2, 108, 254), "Your inventory is full!", ply)
		return
	end

	local class = net.ReadString()
	local ownsItem = XYZ_ORGS.Core.CheckIfOwnsItem(plyorg, class)
	if not ownsItem then return end

	local tblInfo = plyorg.inventory[ownsItem]

	Inventory.Core.GiveItem(ply:SteamID64(), class, tblInfo.data)
	
	plyorg.inventory[ownsItem] = nil
	XYZ_ORGS.Database.RemoveItem(orgid, class)

	XYZShit.Msg("Organizations", XYZ_ORGS.Config.Color, "You withdrew an item from your organization.", ply)
	xLogs.Log(xLogs.Core.Player(ply).." withdrew an item from organization "..plyorg.name, "Organizations")
end)

net.Receive("xyz_orgs_disband", function(_, ply)
	if not XYZ_ORGS.Core.Members[ply:SteamID64()] then return end
	local orgid = XYZ_ORGS.Core.Members[ply:SteamID64()]
	local plyorg = XYZ_ORGS.Core.Orgs[orgid]
	if not plyorg then return end

	if plyorg.members[ply:SteamID64()] ~= 1 then XYZShit.Msg("Organizations", XYZ_ORGS.Config.Color, "Only the owner can do that.", ply) return end

	XYZ_ORGS.Database.DisbandOrg(XYZ_ORGS.Core.Members[ply:SteamID64()], function(data)
		XYZShit.Msg("Organizations", XYZ_ORGS.Config.Color, "The "..plyorg.name.." organization was disbanded.")
		xLogs.Log(xLogs.Core.Player(ply).." disbanded the "..plyorg.name.." organization", "Organizations")
		XYZ_ORGS.Core.Orgs[orgid] = nil
		XYZ_ORGS.Core.Members[ply:SteamID64()] = nil
	end)
end)

net.Receive("xyz_orgs_transfer", function(_, ply)
	if not XYZ_ORGS.Core.Members[ply:SteamID64()] then return end
	local orgid = XYZ_ORGS.Core.Members[ply:SteamID64()]
	local plyorg = XYZ_ORGS.Core.Orgs[orgid]
	if not plyorg then return end

	local plyID = net.ReadString()
	if XYZ_ORGS.Core.Members[plyID] ~= orgid then return end

	if plyorg.members[ply:SteamID64()] ~= 1 then XYZShit.Msg("Organizations", XYZ_ORGS.Config.Color, "Only the owner can do that.", ply) return end

	XYZ_ORGS.Database.UpdateMemberRole(orgid, ply:SteamID64(), 2, function(data)
		XYZ_ORGS.Core.Orgs[orgid].members[ply:SteamID64()] = 2

		XYZ_ORGS.Database.UpdateMemberRole(orgid, plyID, 1, function(data)
			XYZShit.Msg("Organizations", XYZ_ORGS.Config.Color, "You transfered ownership to "..plyID..".", ply)
			xLogs.Log(xLogs.Core.Player(ply).." transfered ownership to "..plyID.." for the "..plyorg.name.." organization", "Organizations")
			XYZ_ORGS.Core.Orgs[orgid].members[plyID] = 1
		end)
	end)
end)

net.Receive("xyz_orgs_updatemember", function(_, ply)
	if not XYZ_ORGS.Core.Members[ply:SteamID64()] then return end
	local orgid = XYZ_ORGS.Core.Members[ply:SteamID64()]
	local plyorg = XYZ_ORGS.Core.Orgs[orgid]
	if not plyorg then return end

	if not XYZ_ORGS.Core.HasPerms(plyorg.roles[plyorg.members[ply:SteamID64()]].perms, 'MANAGE_PERMISSIONS', ply) then return end

	local plyID = net.ReadString()
	if XYZ_ORGS.Core.Orgs[XYZ_ORGS.Core.Members[plyID]].members[plyID] == 1 then XYZShit.Msg("Organizations", XYZ_ORGS.Config.Color, "You can't manage the owner.", ply) return end
	local role = net.ReadUInt(16)
	if role == 1 then return end
	
	XYZ_ORGS.Database.UpdateMemberRole(orgid, plyID, role, function(data)
		XYZShit.Msg("Organizations", XYZ_ORGS.Config.Color, "You updated "..plyID.."'s role to "..plyorg.roles[role].name..".", ply)
		xLogs.Log(xLogs.Core.Player(ply).." updated "..plyID.."'s role to "..plyorg.roles[role].name.." for the "..plyorg.name.." organization", "Organizations")
		XYZ_ORGS.Core.Orgs[XYZ_ORGS.Core.Members[ply:SteamID64()]].members[plyID] = role

		local updatee = player.GetBySteamID64(plyID)
		if updatee then
			Quest.Core.ProgressQuest(updatee, "gang_warfare", 2)
		end
	end)
end)

net.Receive("xyz_orgs_discipline", function(_, ply)
	if not XYZ_ORGS.Core.Members[ply:SteamID64()] then return end
	local orgid = XYZ_ORGS.Core.Members[ply:SteamID64()]
	local plyorg = XYZ_ORGS.Core.Orgs[orgid]
	if not plyorg then return end

	local action = net.ReadString()
	local plyID = net.ReadString()

	if not XYZ_ORGS.Core.HasPerms(plyorg.roles[plyorg.members[ply:SteamID64()]].perms, 'KICK', ply) then return end
	
	local actions = {
		["kick"] = function() 
			XYZ_ORGS.Database.LeaveOrg(XYZ_ORGS.Core.Members[ply:SteamID64()], plyID, function(data)
				XYZShit.Msg("Organizations", XYZ_ORGS.Config.Color, "You kicked "..plyID..".", ply)
				xLogs.Log(xLogs.Core.Player(ply).." kicked "..plyID.." from the "..plyorg.name.." organization", "Organizations")

				XYZ_ORGS.Core.Members[plyID] = nil
				XYZ_ORGS.Core.Orgs[XYZ_ORGS.Core.Members[ply:SteamID64()]].members[plyID] = nil
			end)
		end
	}
	actions[action]()
end)

net.Receive("xyz_orgs_upgrade", function(_, ply)
	if not XYZ_ORGS.Core.Members[ply:SteamID64()] then return end
	local orgid = XYZ_ORGS.Core.Members[ply:SteamID64()]
	local plyorg = XYZ_ORGS.Core.Orgs[orgid]
	if not plyorg then return end

	if not XYZ_ORGS.Core.HasPerms(plyorg.roles[plyorg.members[ply:SteamID64()]].perms, 'MANAGE_UPGRADES', ply) then return end

	local upgrade = net.ReadString()
	local upgv = XYZ_ORGS.Config.UpgradeValues[upgrade]
	
	local actions = {
		["balanceLimit"] = function() 
			XYZ_ORGS.Core.Orgs[orgid].upgrades.balanceLimit = plyorg.upgrades.balanceLimit + upgv[3]
		end,
		["storageLimit"] = function() 
			XYZ_ORGS.Core.Orgs[orgid].upgrades.storageLimit = plyorg.upgrades.storageLimit + upgv[3]
		end,
		["memberLimit"] = function() 
			XYZ_ORGS.Core.Orgs[orgid].upgrades.memberLimit = plyorg.upgrades.memberLimit + upgv[3]
		end,
		["cinv"] = function() 
			local cinv = net.ReadString()
			if #cinv < 4 or #cinv > 16 then return false end
			if string.match(cinv, "[^%w_]") ~= nil then return false end
			if XYZ_ORGS.Core.Invites[cinv] then
				XYZShit.Msg("Organizations", XYZ_ORGS.Config.Color, "This invite already exists.", ply)
				return false
			end
			XYZ_ORGS.Core.Invites[plyorg.invite] = nil
			XYZ_ORGS.Core.Invites[cinv] = orgid
			XYZ_ORGS.Core.Orgs[orgid].upgrades.cinv = cinv
			XYZ_ORGS.Core.Orgs[orgid].invite = cinv
			
			xLogs.Log(xLogs.Core.Player(ply).." set the custom invite to "..cinv.." for the "..plyorg.name.." organization", "Organizations")
		end
	}

	if plyorg.funds < upgv[2] then
		XYZShit.Msg("Organizations", XYZ_ORGS.Config.Color, "You need "..DarkRP.formatMoney(upgv[2]-plyorg.funds).." more in your organization.", ply)
		return
	end

	if actions[upgrade]() == nil then
		local upgrades = util.TableToJSON(XYZ_ORGS.Core.Orgs[XYZ_ORGS.Core.Members[ply:SteamID64()]].upgrades)
		XYZ_ORGS.Database.UpdateUpgrades(XYZ_ORGS.Core.Members[ply:SteamID64()], upgrades, function(data)
			XYZ_ORGS.Core.Orgs[orgid].funds = XYZ_ORGS.Core.Orgs[orgid].funds - upgv[2]

			XYZ_ORGS.Database.UpdateFunds(orgid, XYZ_ORGS.Core.Orgs[XYZ_ORGS.Core.Members[ply:SteamID64()]].funds, function(data2)
				XYZShit.Msg("Organizations", XYZ_ORGS.Config.Color, "You upgraded "..upgv[1].." by "..upgv[3].." for "..DarkRP.formatMoney(upgv[2]), ply)
				xLogs.Log(xLogs.Core.Player(ply).." upgraded "..upgv[1].." by "..upgv[3].." for the "..plyorg.name.." organization", "Organizations")
			end)
		end)
	end
end)

net.Receive("xyz_orgs_createrole", function(_, ply)
	if not XYZ_ORGS.Core.Members[ply:SteamID64()] then return end
	local orgid = XYZ_ORGS.Core.Members[ply:SteamID64()]
	local plyorg = XYZ_ORGS.Core.Orgs[orgid]
	if not plyorg then return end
	if not XYZ_ORGS.Core.HasPerms(plyorg.roles[plyorg.members[ply:SteamID64()]].perms, 'MANAGE_PERMISSIONS', ply) then return end

	local roleName = net.ReadString()
	if #roleName < 3 or #roleName > 16 then return end
	local perms = net.ReadUInt(32)
	
	XYZ_ORGS.Core.Orgs[orgid].roles[#XYZ_ORGS.Core.Orgs[orgid].roles + 1] = {name = roleName, perms = perms}

	local roles = util.TableToJSON(plyorg.roles)

	XYZ_ORGS.Database.UpdateRoles(orgid, roles, function(data)
		XYZShit.Msg("Organizations", XYZ_ORGS.Config.Color, "You created the role "..roleName, ply)
		xLogs.Log(xLogs.Core.Player(ply).." created the role "..roleName.." with perms "..perms.." for the "..plyorg.name.." organization", "Organizations")
	end)
end)

net.Receive("xyz_orgs_managerole", function(_, ply)
	if not XYZ_ORGS.Core.Members[ply:SteamID64()] then return end
	local orgid = XYZ_ORGS.Core.Members[ply:SteamID64()]
	local plyorg = XYZ_ORGS.Core.Orgs[orgid]
	if not plyorg then return end

	local roleID = net.ReadUInt(32)
	local perms = net.ReadUInt(32)
	
	if roleID == 1 then return end
	if not XYZ_ORGS.Core.HasPerms(plyorg.roles[plyorg.members[ply:SteamID64()]].perms, 'MANAGE_PERMISSIONS', ply) then return end

	XYZ_ORGS.Core.Orgs[orgid].roles[roleID].perms = perms

	local roles = util.TableToJSON(plyorg.roles)

	XYZ_ORGS.Database.UpdateRoles(orgid, roles, function(data)
		XYZShit.Msg("Organizations", XYZ_ORGS.Config.Color, "You updated the permissions for "..plyorg.roles[roleID].name, ply)
		xLogs.Log(xLogs.Core.Player(ply).." set the permissions for role "..plyorg.roles[roleID].name.." to "..perms.." for the "..plyorg.name.." organization", "Organizations")
	end)
end)


net.Receive("xyz_orgs_info", function(_, ply)
	if not XYZ_ORGS.Core.Members[ply:SteamID64()] then return end
	local orgid = XYZ_ORGS.Core.Members[ply:SteamID64()]
	local plyorg = XYZ_ORGS.Core.Orgs[orgid]
	if not plyorg then return end
	local request = net.ReadString()
	local requests = {
		["dashboard"] = function() 
			net.Start("xyz_orgs_info")
			local tbl = {mCount = table.Count(plyorg.members), bal = plyorg.funds, xp = plyorg.xp, name = plyorg.name}
			if XYZ_ORGS.Core.HasPerms(plyorg.roles[plyorg.members[ply:SteamID64()]].perms, 'INVITE', ply, true) then 
				tbl.invite = plyorg.invite
			end
			net.WriteTable(tbl)
			net.Send(ply)
		end,
		["members"] = function() 
			net.Start("xyz_orgs_info")
			net.WriteTable(plyorg.members)
			net.WriteTable(plyorg.roles)
			net.Send(ply)
		end,
		["upgrades"] = function() 
			net.Start("xyz_orgs_info")
			net.WriteTable(plyorg.upgrades)
			net.Send(ply)
		end,
		["achievements"] = function() 
			net.Start("xyz_orgs_info")
			net.WriteTable(plyorg.achievements)
			net.Send(ply)
		end,
		["inventory"] = function() 
			net.Start("xyz_orgs_info")
			net.WriteTable(plyorg.inventory)
			net.Send(ply)
		end,
		["roles"] = function() 
			net.Start("xyz_orgs_info")
			net.WriteTable(plyorg.roles)
			net.Send(ply)
		end,
	}
	

	if not requests[request] then return end
	requests[request]()
end)