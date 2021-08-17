function xWhitelist.Core.CanWhitelist(ply, job)
	if ply:IsAdmin() then return true end
	if xWhitelist.Config.WhitelistPermissions[ply:Team()] and xWhitelist.Config.WhitelistPermissions[ply:Team()][job] then return true end

	return false
end
function xWhitelist.Core.CanBlacklist(ply, job)
	if ply:IsSuperAdmin() then return true end
	if xWhitelist.Config.BlacklistedPermissions[ply:Team()] and xWhitelist.Config.BlacklistedPermissions[ply:Team()][job] then return true end

	return false
end

local jobCache = {}
function xWhitelist.Core.GetJobTableByCommand(jobCmd)
	if jobCache[jobCmd] then
		return jobCache[jobCmd]
	end

	for k, v in pairs(RPExtraTeams) do
		if v.command == jobCmd then
			jobCache[jobCmd] = v
			return v
		end
	end

	return false
end


function xWhitelist.Core.ValidateToID64(target)
	if not tonumber(target) then
		target = util.SteamIDTo64(target)
		if target == "0" then return false end
	end
	if not tonumber(target) then return false end
	if tonumber(target) <= 9999999999999999 then return false end

	return string.Trim(target, " ")
end
properties.Add("xWhitelist", {
	MenuLabel = "xWhitelist",
	Order = 0,

	Filter = function(self, ent, ply)
		if not IsValid(ent) then return false end
		if not ent:IsPlayer() then return false end
		if not gamemode.Call("CanProperty", ply, "xWhitelist", ent) then return false end
		if (not xWhitelist.Config.WhitelistPermissions[ply:Team()]) and (not xWhitelist.Config.BlacklistedPermissions[ply:Team()]) and (not ply:IsAdmin()) then return false end

		return true
	end,
	MenuOpen = function(self, option, ent, tr)
		local submenu = option:AddSubMenu()
		net.Start("xWhitelistRequestUserData")
			net.WriteString(ent:SteamID64())
		net.SendToServer()

		local jobsFound = {}
		for k, v in pairs(RPExtraTeams) do
			if (not xWhitelist.Config.WhitelistedJobs[v.command]) and (not xWhitelist.Config.BlacklistedJobs[v.command]) then continue end

			if not jobsFound[v.category] then
				jobsFound[v.category] = {}
			end
			table.insert(jobsFound[v.category], v)
		end
		net.Receive("xWhitelistRequestedUserData", function()
			if not IsValid(submenu) then return end
			local usersJobs = net.ReadTable()
			-- Whitelist submenues		
			local whitelistSubMenu = submenu:AddSubMenu("Whitelist")
			local addToSubMenu = whitelistSubMenu:AddSubMenu("Add Whitelist")
			local catsWhiteAddSubMenu = addToSubMenu:AddSubMenu("Categories")
			local removeToSubMenu = whitelistSubMenu:AddSubMenu("Remove Whitelist")
			local catsWhiteRemoveSubMenu = removeToSubMenu:AddSubMenu("Categories")
	
			-- Blacklist submenus
			local blacklistSubMenu = submenu:AddSubMenu("Blacklist")
			local addToSubMenu = blacklistSubMenu:AddSubMenu("Add Blacklist")
			local catsBlackAddSubMenu = addToSubMenu:AddSubMenu("Categories")
			local removeToSubMenu = blacklistSubMenu:AddSubMenu("Remove Blacklist")
			local catsBlackRemoveSubMenu = removeToSubMenu:AddSubMenu("Categories")
	
			local whiteAddCategory = {}
			local whiteRemoveCategory = {}
			local blackAddCategory = {}
			local blackRemoveCategory = {}
	
	
			for k, v in pairs(jobsFound) do
				-- Add jobs to whitelist section
				for n, m in pairs(v) do
					if (not xWhitelist.Config.WhitelistedJobs[m.command]) then continue end
					if not xWhitelist.Core.CanWhitelist(LocalPlayer(), m.command) then continue end
					if usersJobs.whitelist[m.command] then continue end
	
					if not whiteAddCategory[k] then
						whiteAddCategory[k] = catsWhiteAddSubMenu:AddSubMenu(k)
					end
					whiteAddCategory[k]:AddOption(m.name, function() self:WhitelistUser(ent, m.command) end)
				end
	
				for n, m in pairs(v) do
					if (not xWhitelist.Config.WhitelistedJobs[m.command]) then continue end
					if not xWhitelist.Core.CanWhitelist(LocalPlayer(), m.command) then continue end
					if (not usersJobs.whitelist[m.command]) then continue end
					if not whiteRemoveCategory[k] then
						whiteRemoveCategory[k] = catsWhiteRemoveSubMenu:AddSubMenu(k)
					end
					whiteRemoveCategory[k]:AddOption(m.name, function() self:WhitelistUser(ent, m.command) end)
				end
			
				-- Add jobs to blacklist section
				for n, m in pairs(v) do
					if (not xWhitelist.Config.BlacklistedJobs[m.command]) then continue end
					if not xWhitelist.Core.CanBlacklist(LocalPlayer(), m.command) then continue end
					if usersJobs.blacklist[m.command] then continue end
	
					if not blackAddCategory[k] then
						blackAddCategory[k] = catsBlackAddSubMenu:AddSubMenu(k)
					end
					blackAddCategory[k]:AddOption(m.name, function() self:BacklistUser(ent, m.command) end)
				end
	
				for n, m in pairs(v) do
					if (not xWhitelist.Config.BlacklistedJobs[m.command]) then continue end
					if not xWhitelist.Core.CanBlacklist(LocalPlayer(), m.command) then continue end
					if (not usersJobs.blacklist[m.command]) then continue end
					if not blackRemoveCategory[k] then
						blackRemoveCategory[k] = catsBlackRemoveSubMenu:AddSubMenu(k)
					end
					blackRemoveCategory[k]:AddOption(m.name, function() self:BacklistUser(ent, m.command) end)
				end
			end
		end)
	end,

	Action = function(self, ent)
	end,
	WhitelistUser = function(self, ply, job)
		self:MsgStart()
			net.WriteEntity(ply) -- The player
			net.WriteString(job) -- The job
			net.WriteBool(true) -- true = whitelist, false = blacklist
		self:MsgEnd()
	end,
	BacklistUser = function(self, ply, job)
		self:MsgStart()
			net.WriteEntity(ply)
			net.WriteString(job)
			net.WriteBool(false)
		self:MsgEnd()
	end,
	Receive = function(self, length, ply)
		local ent = net.ReadEntity()
		local job = net.ReadString()
		local whitelist = net.ReadBool()

		local jobTbl = xWhitelist.Core.GetJobTableByCommand(job)
		local jobName = (jobTbl and jobTbl.name) or job

		if whitelist then
			if not xWhitelist.Core.CanWhitelist(ply, job) then return end

			if xWhitelist.Users[ent:SteamID64()].whitelist[job] then
				xWhitelist.Core.RemoveWhitelist(ent:SteamID64(), job)
				XYZShit.Msg("xWhitelist", Color(155, 155, 155), "You have been unwhitelisted from "..jobName, ent)
				XYZShit.Msg("xWhitelist", Color(155, 155, 155), "You have unwhitelisted "..ent:Name().." from "..jobName, ply)
				xLogs.Log(xLogs.Core.Player(ply).." has unwhitelisted "..xLogs.Core.Player(ent).." from "..xLogs.Core.Color(jobName, Color(240,230,140)), "Unwhitelist")
				hook.Run("xWhitelistUnwhitelist", ply, ent:SteamID64(), jobName, jobTbl)
			else
				xWhitelist.Core.AddWhitelist(ent:SteamID64(), job)
				XYZShit.Msg("xWhitelist", Color(155, 155, 155), "You have been whitelisted for "..jobName, ent)
				XYZShit.Msg("xWhitelist", Color(155, 155, 155), "You have whitelisted "..ent:Name().." for "..jobName, ply)
				xLogs.Log(xLogs.Core.Player(ply).." has whitelisted "..xLogs.Core.Player(ent).." for "..xLogs.Core.Color(jobName, Color(240,230,140)), "Whitelist")
				hook.Run("xWhitelistWhitelist", ply, ent:SteamID64(), jobName, jobTbl)
			end
		else
			if not xWhitelist.Core.CanBlacklist(ply, job) then return end

			if xWhitelist.Users[ent:SteamID64()].blacklist[job] then
				xWhitelist.Core.RemoveBlacklist(ent:SteamID64(), job)
				XYZShit.Msg("xWhitelist", Color(155, 155, 155), "You have been unblacklisted from "..jobName, ent)
				XYZShit.Msg("xWhitelist", Color(155, 155, 155), "You have unblacklisted "..ent:Name().." from "..jobName, ply)
				xLogs.Log(xLogs.Core.Player(ply).." has unblacklisted "..xLogs.Core.Player(ent).." from "..xLogs.Core.Color(jobName, Color(240,230,140)), "Unblacklist")
			else
				xWhitelist.Core.AddBlacklist(ent:SteamID64(), job)
				XYZShit.Msg("xWhitelist", Color(155, 155, 155), "You have been blacklisted for "..jobName, ent)
				XYZShit.Msg("xWhitelist", Color(155, 155, 155), "You have blacklisted "..ent:Name().." for "..jobName, ply)
				xLogs.Log(xLogs.Core.Player(ply).." has blacklisted "..xLogs.Core.Player(ent).." for "..xLogs.Core.Color(jobName, Color(240,230,140)), "Blacklist")
			end
		end
	end
} )