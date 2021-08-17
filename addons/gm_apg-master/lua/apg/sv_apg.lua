util.AddNetworkString("apg_notice_s2c")
APG = APG or {}

local IsValid = IsValid
local table = table
local isentity = isentity

--[[ ENTITY Related ]]

	--[[
		Check if the player can pick up the entity
		@param {entity} ent
		@param {player} ply
		@returns {boolean}
	]]

function APG.canPhysGun( ent, ply )
	-- Predict if the player can pickup an entity.
	if not IsValid(ent) then return false end -- The entity isn't valid, don't pickup.

	if ent:GetPersistent() then
		return false
	end

	if ent.PhysgunDisabled then
		return false
	end -- Check if the entity is physgun disabled.
	
	ent.APG_HeldBy = ent.APG_HeldBy or {}
	ent.APG_HeldBy.plys = ent.APG_HeldBy.plys or {}

	if ply.APG_CantPickup == true or next( ent.APG_HeldBy.plys ) then
		ply:ConCommand("-attack") -- Tell the player to stop physgunning.
		return false
	end -- Is APG blocking the pickup?

	if ent.CPPICanPhysgun then
		return ent:CPPICanPhysgun(ply)
	end -- Let CPPI handle things from here.

	return false -- If everything fails we probably shouldn't be picking this up.
end

function APG.isWhitelistedEnt( ent )

	local class = ent:GetClass()
	for k, v in pairs (APG.cfg["unGhostingWhitelist"].value) do
		if ( v and k == class ) or (not v and string.find( class, k ) ) then
			return true
		end
	end

	return false
end

	--[[
		Check if the entity is a bad entity, as defined in badEnts
		@param {entity} ent
		@returns {boolean}
	]]

function APG.isBadEnt( ent )
	if ent and not ent.GetClass then return false end -- Ignore if we can't read the class.
	if not IsValid(ent) then return false end -- Ignore invalid entities.
	if ent.jailWall == true then return false end -- Ignore ULX jails.
	if Entity(0) == ent or ent:IsWorld() then return false end -- Ignore worldspawn.
	if ent:IsWeapon() then return false end -- Ignore weapons.
	if ent:IsPlayer() then return false end -- Ignore players.
	if ent:IsNPC() then return false end
	if ent.ARCBank_MapEntity then return false end --Ignore ARCBank ents

	local h = hook.Run("APGisBadEnt", ent)
	if isbool(h) then return h end

	local class = ent:GetClass()
	for k, v in pairs (APG.cfg["badEnts"].value) do
		if ( v and k == class ) or (not v and string.find( class, k ) ) then
			return true
		end
	end

	return false
end

	--[[
		Check the props owner
		@return {player} or nil
	]]

function APG.getOwner( ent )
	local owner, _ = ent:CPPIGetOwner() or ent.FPPOwner or nil
	return owner
end

	--[[
		Add's a timer to the module table
		@param {string} module
		@param {string} identifier
		@param {number} delay
		@param {number} repetitions
		@param {function} function
		@void
	]]

local function killVel(phys, freeze)
	local vec = Vector()
	if not IsValid(phys) then return end
	if freeze then phys:EnableMotion(false) return end

	phys:SetVelocity(vec)
	phys:SetVelocityInstantaneous(vec)
	phys:AddAngleVelocity(phys:GetAngleVelocity() * -1)

	phys:Sleep()
end

function APG.killVelocity(ent, extend, freeze, wake_target)
	local vec = Vector()
	if ent.GetClass and ent:GetClass() == "player" then ent:SetVelocity(ent:GetVelocity() * -1) return end
	ent:SetVelocity(vec)

	for i = 0, ent:GetPhysicsObjectCount() do killVel(ent:GetPhysicsObjectNum(i), freeze) end -- Includes self?

	if extend then
		for _,v in next, constraint.GetAllConstrainedEntities(ent) do killVel(v:GetPhysicsObject(), freeze) end
	end

	if wake_target then
		timer.Simple(0, function()
			if not IsValid(ent) then return end
			local phys = ent:GetPhysicsObject()
			if IsValid(phys) then
				phys:Wake()
			end
		end)
	end
end

function APG.freezeIt( ent, extend )
	local obj = ent:GetPhysicsObject()
	if extend then
		for _,v in next, constraint.GetAllConstrainedEntities(ent) do
			killVel(v:GetPhysicsObject(), true)
			v.APG_Frozen = true
		end
	else
		if IsValid(obj) then
			killVel(obj, true)
			ent.APG_Frozen = true
		end
	end
end

function APG.FindWAC(ent)
	if not APG.cfg["vehIncludeWAC"].value then return false end

	local e
	local i = 0
	if ent.wac_seatswitch or ent.wac_ignore then return true end
	for _,v in next, constraint.GetAllConstrainedEntities(ent) do
		if v.wac_seatswitch or v.wac_ignore then e = v break end
		if i > 12 then break end -- Only check up to 12.
		i = i + 1
	end

	return IsValid(e)
end

function APG.IsVehicle(v, basic)
	if not IsValid(v) then return false end

	if v:IsVehicle() then return true end
	if string.find(v:GetClass(), "vehicle") then return true end
	if basic then return false end

	if APG.FindWAC(v) then return true end

	local parent = v:GetParent()
	return APG.IsVehicle(parent, true)
end

function APG.cleanUp( mode, notify, specific )
	mode = mode or "unfrozen"
	for _, v in next, specific or ents.GetAll() do
		APG.killVelocity(v,false)
		if not APG.isBadEnt(v) or not APG.getOwner( v ) or APG.IsVehicle(v) then continue end
		if mode == "unfrozen" and v.APG_Frozen then -- Whether to clean only not frozen ents or all ents
			continue
		else
			v:Remove()
		end
	end

	if notify or APG.cfg["notifyLagFunc"].value then
		APG.notify( false, 2, "all", APG.cfg["notifyLevel"].value, "Cleaned up (mode: ", mode, ")" )
	end
end

function APG.ghostThemAll( notify, callback )
	if not APG.modules[ "ghosting" ] then
		return APG.notify( false, 0, "admins", "[APG] Warning: Tried to ghost props but ghosting is disabled!" )
	end
	for _, v in next, ents.GetAll() do
		if ( not APG.isBadEnt(v) ) or ( not APG.getOwner( v ) ) or APG.IsVehicle(v) or v.APG_Frozen then continue end
		APG.entGhost( v, true, false  )
	end

	if notify or APG.cfg["notifyLagFunc"].value then
	  APG.notify( false, APG.cfg["notifyLevel"].value, "admins", "Some unfrozen entities were ghosted!" )
	end

	if isfunction(callback) then
		callback()
	end
end

function APG.freezeProps( notify, callback )
	for _, v in next, ents.GetAll() do
		if not APG.isBadEnt(v) or not APG.getOwner( v ) then continue end
		APG.freezeIt( v )
	end

	if notify or APG.cfg["notifyLagFunc"].value then
		APG.notify(false, APG.cfg["notifyLevel"].value, "all", "Some entities were frozen!")
	end

	if isfunction(callback) then
		callback()
	end
end

local function GetPhysenv()
	local env = physenv.GetPerformanceSettings()
	local con = {}
	local vars = {
		"phys_upimpactforcescale",
		"phys_impactforcescale",
		"phys_pushscale",
		"sv_turbophysics",
	}

	for _,v in next, vars do
		local var = GetConVar(v)
		con[v] = var and var:GetString() or nil
	end

	return {con = con, env = env}
end

function APG.smartCleanup( notify, callback )
	local defaults = GetPhysenv()
	local phys = table.Copy(defaults.env)

	hook.Add("PlayerSpawnObject", "APG_smartCleanup", function() return false end)

	RunConsoleCommand("phys_upimpactforcescale","0")
	RunConsoleCommand("phys_impactforcescale",  "0")
	RunConsoleCommand("phys_pushscale",         "0")
	RunConsoleCommand("sv_turbophysics",        "1")

	phys.MaxCollisionChecksPerTimestep = 0
	phys.MaxAngularVelocity = 0
	phys.MaxVelocity = 0
	physenv.SetPerformanceSettings(phys)

	local sphere = ents.FindInSphere
	local all = ents.GetAll()
	local bad = {}

	for _, v in next, all do
		if IsValid(v) and v.GetPhysicsObject then
			local phys = v:GetPhysicsObject()
			if IsValid(phys) and phys:IsMotionEnabled() then
				if v.isFadingDoor and APG.isBadEnt(ent) then
					SafeRemoveEntity(v)
				else
					table.insert(bad, {ent = v, phys = phys})
				end
			end
		end
	end

	APG.freezeProps()

	for _, v in next, bad do
		local count = 0

		local owner = APG.getOwner(v.ent)
		local space = sphere(v.ent:GetPos(), 7)
		local cache = {}

		for _, ent in next, space do
			if owner == APG.getOwner(ent) then
				count = count + 1
				table.insert(cache, ent)
			end
		end

		if count > 4 then
			for _, ent in next, cache do
				if APG.isBadEnt(ent) then
					SafeRemoveEntity(ent)
				end
			end
		end
	end

	timer.Simple(1.5, function() -- Give a few seconds for the engine to catch up.
		for k,v in next, defaults.con do
			RunConsoleCommand(k, v)
		end

		physenv.SetPerformanceSettings(defaults.env)
		hook.Remove("PlayerSpawnObject", "APG_smartCleanup")

		if isfunction(callback) then
			callback()
		end
	end)
end

function APG.ForcePlayerDrop(ply, ent)
	if IsValid(ply) then
		ply:ConCommand("-attack")
	end
	if IsValid(ent) then
		DropEntityIfHeld( ent )
		ent:ForcePlayerDrop()
	end
end

function APG.blockPickup( ply )
	if not IsValid(ply) or ply.APG_CantPickup then return end
	ply.APG_CantPickup = true
	timer.Simple(10, function()
		if IsValid(ply) then
			ply.APG_CantPickup = false
		end
	end)
end

--[[--------------------
	Set when a prop is unfrozen.
]]----------------------
hook.Add("PlayerUnfrozeObject", "APG_PlayerUnfrozeObject", function(ply, ent, object)
	if not APG.isBadEnt( ent ) then return end
	ent.APG_Frozen = false
end)

--[[--------------------
	Physgun Drop & Freeze
]]----------------------
hook.Add( "OnPhysgunFreeze", "APG_OnPhysgunFreeze", function( weap, phys, ent, ply )
	if not APG.isBadEnt( ent ) then return end
	ent.APG_Frozen = true
end)

--[[--------------------
	APG job manager
--]]----------------------
local toProcess = toProcess or {}

function APG.dJobRegister( job, delay, limit, func, onBegin, onEnd )
	local tab = {
		content = {},
		delay = delay,
		limit = limit,
		func = func,
		onBegin = onBegin or nil,
		onEnd = onEnd or nil
	}
	toProcess[job] = tab
end

local function APG_delayedTick( job )
	if toProcess[job].processing and toProcess[job].processing == true then return end
	toProcess[job].processing = true
	if toProcess[job].onBegin then toProcess[job].onBegin() end
	local delay, pLimit = toProcess[job].delay, toProcess[job].limit
	local total = #toProcess[job].content
	local count = math.Clamp(total,0,pLimit)
	for i = 1, count do
		local cur = toProcess[job].content[1]
		timer.Create( "delay_" .. job .. "_" .. i , ( i - 1 ) * delay , 1, function()
			toProcess[job].func( cur )
		end)
		table.remove(toProcess[job].content, 1)
	end
	timer.Create("dJob_" .. job .. "_process", ( count * delay ) + 0.1 , 1, function() toProcess[job].processing = false
		if #toProcess[job].content < 1 and toProcess[job].onEnd then toProcess[job].onEnd() end
	end)
end

function APG.startDJob( job, content )
	if not job or not isstring(job) or not content then return end
	if not toProcess or not toProcess[job] then
		ErrorNoHalt("[APG] No Process Found, Attempting Reload!\n---\nThis Shouldn't Happen Concider Restarting!\n")
		APG.reload()
		return
	end

	if table.HasValue(toProcess[job].content, content) then return end

	-- Is it a problem if there is a same ent being unghosted twice ?
	table.insert( toProcess[job].content, content )
	hook.Add("Tick", "APG_delayed_" .. job, function()
		if #toProcess[job].content > 0 then
			APG_delayedTick( job )
		else
			hook.Remove("Tick", "APG_delayed_" .. job)
		end
	end)
end

hook.Add("InitPostEntity", "APG_Load", function()
	hook.Add("Think", "APG_Load", function()
		APG.initialize()
		hook.Remove("Think", "APG_Load")
	end)
end)
