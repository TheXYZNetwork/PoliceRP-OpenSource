local meta = FindMetaTable("Player")

--[[---------------------------------------------------------------------------
Pooled networking strings
---------------------------------------------------------------------------]]
util.AddNetworkString("DarkRP_InitializeVars")
util.AddNetworkString("DarkRP_PlayerVar")
util.AddNetworkString("DarkRP_PlayerVarRemoval")
util.AddNetworkString("DarkRP_DarkRPVarDisconnect")

--[[---------------------------------------------------------------------------
Player vars
---------------------------------------------------------------------------]]

--[[---------------------------------------------------------------------------
Remove a player's DarkRPVar
---------------------------------------------------------------------------]]
function meta:removeDarkRPVar(var, target)
    local vars = self.DarkRPVars
    hook.Call("DarkRPVarChanged", nil, self, var, (vars and vars[var]) or nil, nil)
    target = target or player.GetAll()
    vars = vars or {}
    vars[var] = nil

    net.Start("DarkRP_PlayerVarRemoval")
        net.WriteUInt(self:UserID(), 16)
        DarkRP.writeNetDarkRPVarRemoval(var)
    net.Send(target)
end

--[[---------------------------------------------------------------------------
Set a player's DarkRPVar
---------------------------------------------------------------------------]]
function meta:setDarkRPVar(var, value, target)
    target = target or player.GetAll()

    if value == nil then return self:removeDarkRPVar(var, target) end
    local vars = self.DarkRPVars
    hook.Call("DarkRPVarChanged", nil, self, var, (vars and vars[var]) or nil, value)

    vars = vars or {}
    vars[var] = value

    net.Start("DarkRP_PlayerVar")
        net.WriteUInt(self:UserID(), 16)
        DarkRP.writeNetDarkRPVar(var, value)
    net.Send(target)
end

--[[---------------------------------------------------------------------------
Set a private DarkRPVar
---------------------------------------------------------------------------]]
function meta:setSelfDarkRPVar(var, value)
    local vars = self.privateDRPVars

    vars = vars or {}
    vars[var] = true

    self:setDarkRPVar(var, value, self)
end

--[[---------------------------------------------------------------------------
Get a DarkRPVar
---------------------------------------------------------------------------]]
function meta:getDarkRPVar(var)
    local vars = self.DarkRPVars

    vars = vars or {}
    return vars[var]
end

--[[---------------------------------------------------------------------------
Send the DarkRPVars to a client
---------------------------------------------------------------------------]]
function meta:sendDarkRPVars()
    if self:EntIndex() == 0 then return end

    local plys = player.GetAll()

    net.Start("DarkRP_InitializeVars")
        net.WriteUInt(#plys, 8)
        for _, target in ipairs(plys) do
            net.WriteUInt(target:UserID(), 16)

            local DarkRPVars = {}
            for var, value in pairs(target.DarkRPVars) do
                if self ~= target and (target.privateDRPVars or {})[var] then continue end
                table.insert(DarkRPVars, var)
            end

            local vars_cnt = #DarkRPVars
            net.WriteUInt(vars_cnt, DarkRP.DARKRP_ID_BITS + 2) -- Allow for three times as many unknown DarkRPVars than the limit
            for i = 1, vars_cnt, 1 do
                DarkRP.writeNetDarkRPVar(DarkRPVars[i], target.DarkRPVars[DarkRPVars[i]])
            end
        end
    net.Send(self)
end
concommand.Add("_sendDarkRPvars", function(ply)
    if ply.DarkRPVarsSent and ply.DarkRPVarsSent > (CurTime() - 3) then return end -- prevent spammers
    ply.DarkRPVarsSent = CurTime()
    ply:sendDarkRPVars()
end)

local function RPName(ply, args)
    if ply.LastNameChange and ply.LastNameChange > (CurTime() - 5) then
        DarkRP.notify(ply, 1, 4, DarkRP.getPhrase("have_to_wait", math.ceil(5 - (CurTime() - ply.LastNameChange)), "/rpname"))
        return ""
    end

    if not GAMEMODE.Config.allowrpnames then
        DarkRP.notify(ply, 1, 6, DarkRP.getPhrase("disabled", "/rpname", ""))
        return ""
    end

    args = args:find"^%s*$" and '' or args:match"^%s*(.*%S)"

    local canChangeName, reason = hook.Call("CanChangeRPName", GAMEMODE, ply, args)
    if canChangeName == false then
        DarkRP.notify(ply, 1, 4, DarkRP.getPhrase("unable", "/rpname", reason or ""))
        return ""
    end

    ply:setRPName(args)
    ply.LastNameChange = CurTime()
    return ""
end
DarkRP.defineChatCommand("rpname", RPName)
DarkRP.defineChatCommand("name", RPName)
DarkRP.defineChatCommand("nick", RPName)

--[[---------------------------------------------------------------------------
Setting the RP name
---------------------------------------------------------------------------]]
function meta:setRPName(name, firstRun)
    -- Make sure nobody on this server already has this RP name
    local lowername = string.lower(tostring(name))
    DarkRP.retrieveRPNames(name, function(taken)
        if not IsValid(self) or string.len(lowername) < 2 and not firstrun then return end
        -- If we found that this name exists for another player
        if taken then
            if firstRun then
                -- If we just connected and another player happens to be using our steam name as their RP name
                -- Put a 1 after our steam name
                DarkRP.storeRPName(self, name .. " 1")
                DarkRP.notify(self, 0, 12, DarkRP.getPhrase("someone_stole_steam_name"))
            else
                DarkRP.notify(self, 1, 5, DarkRP.getPhrase("unable", "/rpname", DarkRP.getPhrase("already_taken")))
                return ""
            end
        else
            if not firstRun then -- Don't save the steam name in the database
                DarkRP.notifyAll(2, 6, DarkRP.getPhrase("rpname_changed", self:SteamName(), name))
                DarkRP.storeRPName(self, name)
            end
        end
    end)
end

--[[---------------------------------------------------------------------------
Maximum entity values
---------------------------------------------------------------------------]]
local maxEntities = {}
function meta:addCustomEntity(entTable)
    maxEntities[self] = maxEntities[self] or {}
    maxEntities[self][entTable.cmd] = maxEntities[self][entTable.cmd] or 0
    maxEntities[self][entTable.cmd] = maxEntities[self][entTable.cmd] + 1
end

function meta:removeCustomEntity(entTable)
    maxEntities[self] = maxEntities[self] or {}
    maxEntities[self][entTable.cmd] = maxEntities[self][entTable.cmd] or 0
    maxEntities[self][entTable.cmd] = maxEntities[self][entTable.cmd] - 1
end

function meta:customEntityLimitReached(entTable)
    maxEntities[self] = maxEntities[self] or {}
    maxEntities[self][entTable.cmd] = maxEntities[self][entTable.cmd] or 0
    local max = entTable.getMax and entTable.getMax(self) or entTable.max

    return max ~= 0 and maxEntities[self][entTable.cmd] >= max
end

function meta:customEntityCount(entTable)
    local entities = maxEntities[self]
    if entities == nil then return 0 end

    entities = entities[entTable.cmd]
    if entities == nil then return 0 end

    return entities
end

hook.Add("PlayerDisconnected", "removeLimits", function(ply)
    maxEntities[ply] = nil
    net.Start("DarkRP_DarkRPVarDisconnect")
        net.WriteUInt(ply:UserID(), 16)
    net.Broadcast()
end)
