hook.Add("XYZShitDBConnected", "xOrgsDB", function()
	XYZShit.DataBase.Query(string.format("SELECT * FROM orgs;"), function(cb)
		if cb and cb[1] then
			local function genInvite(id)
				local inv = XYZShit:RandomString(6)
				if XYZ_ORGS.Core.Invites[inv] then 
					genInvite(id)
					return
				end
				XYZ_ORGS.Core.Invites[inv] = id
				return inv
			end
			for _, v in pairs( cb ) do
				XYZ_ORGS.Core.Orgs[v.id] = v
				XYZ_ORGS.Core.Orgs[v.id].members = {}
				XYZ_ORGS.Core.Orgs[v.id].inventory = {}
				XYZ_ORGS.Core.Orgs[v.id].upgrades = util.JSONToTable(v.upgrades)
				XYZ_ORGS.Core.Orgs[v.id].roles = util.JSONToTable(v.roles)
				XYZ_ORGS.Core.Orgs[v.id].achievements = util.JSONToTable(v.achievements)
				if XYZ_ORGS.Core.Orgs[v.id].upgrades.cinv ~= 0 then
					XYZ_ORGS.Core.Invites[XYZ_ORGS.Core.Orgs[v.id].upgrades.cinv] = v.id
					XYZ_ORGS.Core.Orgs[v.id].invite = XYZ_ORGS.Core.Orgs[v.id].upgrades.cinv
				else
					XYZ_ORGS.Core.Orgs[v.id].invite = genInvite(v.id)
				end
			end
		end
	end)
	XYZShit.DataBase.Query(string.format("SELECT * FROM orgs_members;"), function(cb)
		if cb and cb[1] then
			for _, v in pairs( cb ) do
				XYZ_ORGS.Core.Orgs[v.orgid].members[v.steamid] = v.role
				XYZ_ORGS.Core.Members[v.steamid] = v.orgid -- This is so you can check if someone is in an org by doing XYZ_ORGS.Core.Members[steamid64]
			end
		end
	end)
	XYZShit.DataBase.Query(string.format("SELECT * FROM orgs_inventories;"), function(cb)
		if cb and cb[1] then
			for _, v in pairs( cb ) do
				table.insert(XYZ_ORGS.Core.Orgs[v.orgid].inventory, {class = v.item, data = util.JSONToTable(v.data)})
			end
		end
	end)
end)

function XYZ_ORGS.Database.CreateOrg(name, creator, callback, callback2)
	local inv = XYZShit:RandomString(6)

	if XYZ_ORGS.Core.Invites[inv] then 
		XYZ_ORGS.Database.CreateOrg(name, creator, callback)
		return -- Invite generated already exists ;(
	end
	
	XYZShit.DataBase.Query(string.format("INSERT INTO orgs (`name`, `upgrades`, `roles`, `achievements`) VALUES ('%s', '%s', '%s', '%s');", XYZShit.DataBase.Escape(name), util.TableToJSON(XYZ_ORGS.Config.Upgrades), util.TableToJSON(XYZ_ORGS.Config.DefaultRoles), util.TableToJSON(XYZ_ORGS.Config.DefaultAchievements)), function(data, q)
		callback(data, q, inv)
		XYZShit.DataBase.Query(string.format("INSERT INTO orgs_members (`steamid`, `orgid`, `role`) VALUES ('%s', '%s', '%s');", creator:SteamID64(), q:lastInsert(), 1), callback2)
	end)
end

function XYZ_ORGS.Database.UpdateFunds(id, newBal, callback)
	XYZShit.DataBase.Query(string.format("UPDATE orgs SET funds = %s WHERE id='%s';", newBal, id), callback)
end

function XYZ_ORGS.Database.UpdateAchievements(id, achievements, callback)
	XYZShit.DataBase.Query(string.format("UPDATE orgs SET achievements = '%s' WHERE id='%s';", util.TableToJSON(achievements), id), callback)
end

function XYZ_ORGS.Database.UpdateXP(id, newXP, callback)
	XYZShit.DataBase.Query(string.format("UPDATE orgs SET xp = %s WHERE id='%s';", newXP, id), callback)
end

function XYZ_ORGS.Database.UpdateUpgrades(id, upgrades, callback)
	XYZShit.DataBase.Query(string.format("UPDATE orgs SET upgrades = '%s' WHERE id='%s';", upgrades, id), callback)
end

function XYZ_ORGS.Database.UpdateMemberRole(id, plyID, role, callback)
	XYZShit.DataBase.Query(string.format("UPDATE orgs_members SET role = %s WHERE steamid='%s' AND orgid='%s';", role, plyID, id), callback)
end

function XYZ_ORGS.Database.LeaveOrg(id, plyID, callback)
	XYZShit.DataBase.Query(string.format("DELETE FROM orgs_members WHERE steamid='%s' AND orgid='%s';", plyID, id), callback)
end

function XYZ_ORGS.Database.InsertItem(id, class, data)
	XYZShit.DataBase.Query(string.format("INSERT INTO orgs_inventories(orgid, item, data) VALUES('%s', '%s', '%s');", id, XYZShit.DataBase.Escape(class), util.TableToJSON(data)))
end

function XYZ_ORGS.Database.RemoveItem(id, class)
	XYZShit.DataBase.Query(string.format("DELETE FROM orgs_inventories WHERE orgid='%s' AND item='%s' LIMIT 1;", id, XYZShit.DataBase.Escape(class)))
end

function XYZ_ORGS.Database.UpdateRoles(id, roles, callback)
	XYZShit.DataBase.Query(string.format("UPDATE orgs SET roles = '%s' WHERE id='%s';", roles, id), callback)
end

function XYZ_ORGS.Database.InsertMember(id, steamid, callback)
	XYZShit.DataBase.Query(string.format("INSERT INTO orgs_members (`steamid`, `orgid`, `role`) VALUES ('%s', '%s', '%s');", steamid, id, 2), callback)
end


function XYZ_ORGS.Database.DisbandOrg(id, callback)
	XYZShit.DataBase.Query(string.format("DELETE FROM orgs WHERE id='%s';", id), callback)
end

function XYZ_ORGS.Database.GetOrgByID(id, callback)
	XYZShit.DataBase.Query(string.format("SELECT * FROM orgs WHERE id='%s';", id), callback)
end