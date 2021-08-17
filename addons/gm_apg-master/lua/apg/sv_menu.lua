util.AddNetworkString("apg_settings_c2s")
util.AddNetworkString("apg_menu_s2c")
util.AddNetworkString("apg_context_c2s")

local function saveSettings( json )
	if not file.Exists("apg", "DATA") then file.CreateDir( "apg" ) end
	file.Write("apg/settings.txt", json)
end

local function recSettings( len, ply)
	if not ply:IsSuperAdmin() then return end

	len = net.ReadUInt( 32 )
	if len == 0 then return end

	local settings = net.ReadData( len )
	settings = util.Decompress( settings )

	saveSettings( settings )

	settings = util.JSONToTable( settings )
	APG.cfg = settings.cfg
	table.Merge(APG, settings)
	APG.reload()
end
net.Receive( "apg_settings_c2s", recSettings)

local function sendToClient( ply )
local settings = {}
	settings.cfg = APG.cfg or {}
	settings.modules = APG.modules or {}

	settings = util.TableToJSON( settings )
	settings = util.Compress( settings )
	net.Start("apg_menu_s2c")
		net.WriteUInt( settings:len(), 32 ) -- Write the length of the data
		net.WriteData( settings, settings:len() ) -- Write the data
	net.Send(ply)
end

hook.Add( "PlayerSay", "openAPGmenu", function( ply, text, public )
	text = string.lower( text )
	if ply:IsSuperAdmin() and text == "!apg" then
		sendToClient( ply )
		return ""
	end
end)

local function checkOwner(owner, ply)
	if ( IsValid(owner) and owner:IsPlayer() ) then
		return true
	else
		APG.notification("The owner of this entity is NOT a Player. (Owner: " .. type(owner) .. ")", ply)
		return false
	end
end


-- TODO: Revamp this, really don't like how it looks, would rather have a function for each
-- it's too clustered.

local function contextCMD(_,ply)
	if not ply:IsSuperAdmin() then return end

	local cmd = net.ReadString()
	local ent = net.ReadEntity()

	ent = IsValid(ent) and ent or ply:GetEyeTraceNoCursor().Entity or nil

	local class = IsValid(ent) and ent.GetClass and ent:GetClass() or nil
	if not class then return end

	local owner = APG.getOwner(ent)

	if cmd == "addghost" then
		if not APG.cfg.badEnts.value[class] then
			APG.cfg.badEnts.value[class] = true
			APG.notify( false, 0, ply, "\"", class, "\" added to Ghost List!" )
		else
			APG.notify( false, 0, ply, "This class is already listed!" )
		end
	elseif cmd == "remghost" then
		APG.cfg.badEnts.value[class] = nil
		APG.notify( false, 0, ply, "\"", class, "\" removed from Ghost List!" )
	elseif cmd == "clearowner" then
		if not checkOwner(owner, ply) then return end
		cleanup.CC_Cleanup(owner,"gmod_cleanup",{})
	elseif cmd == "clearunfrozen" then
		if not checkOwner(owner, ply) then return end

		local count = 0
		for _,v in next, ents.GetAll() do
			if not (IsValid(v) and APG.getOwner(v) == owner) then continue end
			if not APG.isBadEnt(v) then continue end
			if not v.APG_Frozen then
				SafeRemoveEntity(v)
				count = count + 1
			end
		end

		APG.notify( false, 0, ply, count, "entities have been removed!" )
	elseif cmd == "getownercount" then
		if not checkOwner(owner, ply) then return end

		local count = 0

		for _,v in next, ents.GetAll() do
			if IsValid(v) and APG.getOwner(v) == owner then
				count = count + 1
			end
		end

		APG.notify( false, 0, ply, owner:Nick(), "[", owner:SteamID(), "]", "has", count, (count == 1 and "entity." or "entities.") )
	elseif cmd == "freezeclass" then
		local count = 0

		for _,v in next, ents.FindByClass(class) do
			if IsValid(v) and not v.APG_Frozen then
				count = count + 1
				APG.killVelocity(v, false, true, false)
			end
		end

		APG.notify( false, 0, ply, (count or 0), (count == 1 and "Entity" or "Entities"), "Frozen" )
	elseif cmd == "sleepclass" then
		local count = 0

		for _,v in next, ents.FindByClass(class) do
			if IsValid(v) and not v.APG_Frozen then
				count = count + 1
				APG.killVelocity(v, false, false, false)
			end
		end

		APG.notify( false, 0, ply, (count or 0), (count == 1 and "Entity is" or "Entities are"), "now Sleeping!" )
	elseif cmd == "ghost" then
		APG.entGhost(ent)
		APG.notify( false, 0, ply, ent, " was ghosted." )
	end

	if cmd == "addghost" or cmd == "remghost" then
		local settings = {}
		settings.cfg = APG.cfg or {}
		settings.modules = APG.modules or {}

		saveSettings( util.TableToJSON( settings ) )
		APG.reload()
	end
end
net.Receive("apg_context_c2s", contextCMD)
