hook.Add("xWarnLoaded", "xWarnLoadedWOB", function(admin, target) 
	if xWarn.Config.WarnOnBan then
		hook.Add("xAdminPlayerBanned", "xWarnHandleBan", function(target, admin, reason, time, archiveEntryId)
			if time == 0 then return end -- No need to do this for permabans
			xWarn.Database.CreateWarn((type(target) == "Player" and target:SteamID64()) or target, (type(target) == "Player" and target:Name()) or "Unknown", 0, "xWarn", "Banned", archiveEntryId)
			hook.Run("xWarnWarnOnBan", (type(target) == "Player" and target:SteamID64()) or target, (type(target) == "Player" and target:Name()) or "Unknown", time, archiveEntryId)
		end)

		hook.Add("xAdminCanUnBan", "xWarnHandleUnBan", function(admin, target) 
			xAdmin.Database.IsBanned(target, function(data)
				if data[1] then
					xAdmin.Database.LastBan(target, function(lastban)
						if lastban[1] then
							xWarn.Database.DestroyBanWarn(lastban[1].id)
						end
					end)
				end
			end)
		end)

		hook.Add("xWarnCanDeleteWarning", "xWarnHandleDeleteWarn", function(admin, warn) 
			if warn.banid and not admin:IsSuperAdmin() then
				return false, "This is an automatically applied warning due to a ban. It cannot be deleted by you."
			end
		end)
	end
end )