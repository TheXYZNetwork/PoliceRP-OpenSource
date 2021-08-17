local plyMeta = FindMetaTable("Player")
local finishWarrantRequest

--[[---------------------------------------------------------------------------
Interface functions
---------------------------------------------------------------------------]]
function plyMeta:warrant(warranter, reason)
    if self.warranted then return end
    local suppressMsg = hook.Call("playerWarranted", GAMEMODE, self, warranter, reason)

    self.warranted = true
    timer.Simple(GAMEMODE.Config.searchtime, function()
        if not IsValid(self) then return end
        self:unWarrant(warranter)
    end)

    if suppressMsg then return end

    local warranterNick = IsValid(warranter) and warranter:Nick() or DarkRP.getPhrase("disconnected_player")
    local centerMessage = DarkRP.getPhrase("warrant_approved", self:Nick(), reason, warranterNick)
    local printMessage = DarkRP.getPhrase("warrant_ordered", warranterNick, self:Nick(), reason)

    for _, b in ipairs(player.GetAll()) do
        b:PrintMessage(HUD_PRINTCENTER, centerMessage)
        b:PrintMessage(HUD_PRINTCONSOLE, printMessage)
    end

    DarkRP.notify(warranter, 0, 4, DarkRP.getPhrase("warrant_approved2"))
end

function plyMeta:unWarrant(unwarranter)
    if not self.warranted then return end

    local suppressMsg = hook.Call("playerUnWarranted", GAMEMODE, self, unwarranter)

    self.warranted = false

    if suppressMsg then return end

    DarkRP.notify(unwarranter, 2, 4, DarkRP.getPhrase("warrant_expired", self:Nick()))
end

function plyMeta:requestWarrant(suspect, actor, reason)
    local question = DarkRP.getPhrase("warrant_request", actor:Nick(), suspect:Nick(), reason)
    DarkRP.createQuestion(question, suspect:EntIndex() .. "warrant", self, 40, finishWarrantRequest, actor, suspect, reason)
end

function plyMeta:wanted(actor, reason, time)
    local suppressMsg = hook.Call("playerWanted", DarkRP.hooks, self, actor, reason)

    self:setDarkRPVar("wanted", true)
    self:setDarkRPVar("wantedReason", reason)

    if time and time > 0 or GAMEMODE.Config.wantedtime > 0 then
        timer.Create(self:SteamID64() .. " wantedtimer", time or GAMEMODE.Config.wantedtime, 1, function()
            if not IsValid(self) then return end
            self:unWanted()
        end)
    end

    if suppressMsg then return end

    local actorNick = IsValid(actor) and actor:Nick() or DarkRP.getPhrase("disconnected_player")
    local centerMessage = DarkRP.getPhrase("wanted_by_police", self:Nick(), reason, actorNick)
    local printMessage = DarkRP.getPhrase("wanted_by_police_print", actorNick, self:Nick(), reason)

    for _, ply in ipairs(player.GetAll()) do
        ply:PrintMessage(HUD_PRINTCENTER, centerMessage)
        ply:PrintMessage(HUD_PRINTCONSOLE, printMessage)
    end

    DarkRP.log(string.Replace(printMessage, "\n", " "), Color(0, 150, 255))
end

function plyMeta:unWanted(actor)
    local suppressMsg = hook.Call("playerUnWanted", GAMEMODE, self, actor)
    self:setDarkRPVar("wanted", nil)
    self:setDarkRPVar("wantedReason", nil)

    timer.Remove(self:SteamID64() .. " wantedtimer")

    if suppressMsg then return end

    local expiredMessage = IsValid(actor) and DarkRP.getPhrase("wanted_revoked", self:Nick(), actor:Nick() or "") or
        DarkRP.getPhrase("wanted_expired", self:Nick())

    DarkRP.log(string.Replace(expiredMessage, "\n", " "), Color(0, 150, 255))

    for _, ply in ipairs(player.GetAll()) do
        ply:PrintMessage(HUD_PRINTCENTER, expiredMessage)
        ply:PrintMessage(HUD_PRINTCONSOLE, expiredMessage)
    end
end

--[[---------------------------------------------------------------------------
Chat commands
---------------------------------------------------------------------------]]
local function warrantCommand(ply, args)
    local target = DarkRP.findPlayer(args[1])
    local reason = table.concat(args, " ", 2)

    local canRequest, message = hook.Call("canRequestWarrant", DarkRP.hooks, target, ply, reason)
    if not canRequest then
        if message then DarkRP.notify(ply, 1, 4, message) end
        return ""
    end

    local Team = ply:Team()
    if not RPExtraTeams[Team] or not RPExtraTeams[Team].mayor then -- No need to search through all the teams if the player is a mayor
        local mayors = {}

        for k, v in pairs(RPExtraTeams) do
            if v.mayor then
                table.Add(mayors, team.GetPlayers(k))
            end
        end

        if not table.IsEmpty(mayors) then -- Request a warrant if there's a mayor
            local mayor = table.Random(mayors)
            mayor:requestWarrant(target, ply, reason)
            DarkRP.notify(ply, 0, 4, DarkRP.getPhrase("warrant_request2", mayor:Nick()))
            return ""
        end
    end

    target:warrant(ply, reason)

    return ""
end
DarkRP.defineChatCommand("warrant", warrantCommand)

local function unwarrantCommand(ply, args)
    local target = DarkRP.findPlayer(args[1])
    local reason = table.concat(args, " ", 2)

    local canRemove, message = hook.Call("canRemoveWarrant", DarkRP.hooks, target, ply, reason)
    if not canRemove then
        if message then DarkRP.notify(ply, 1, 4, message) end
        return ""
    end

    target:unWarrant(ply, reason)

    return ""
end
DarkRP.defineChatCommand("unwarrant", unwarrantCommand)

local function wantedCommand(ply, args)
    local target = DarkRP.findPlayer(args[1])
    local reason = table.concat(args, " ", 2)

    local canWanted, message = hook.Call("canWanted", DarkRP.hooks, target, ply, reason)
    if not canWanted then
        if message then DarkRP.notify(ply, 1, 4, message) end
        return ""
    end

    target:wanted(ply, reason)

    return ""
end
DarkRP.defineChatCommand("wanted", wantedCommand)

local function unwantedCommand(ply, args)
    local target = DarkRP.findPlayer(args)

    local canUnwant, message = hook.Call("canUnwant", DarkRP.hooks, target, ply)
    if not canUnwant then
        if message then DarkRP.notify(ply, 1, 4, message) end
        return ""
    end

    target:unWanted(ply)

    return ""
end
DarkRP.defineChatCommand("unwanted", unwantedCommand)

--[[---------------------------------------------------------------------------
Callback functions
---------------------------------------------------------------------------]]
function finishWarrantRequest(choice, mayor, initiator, suspect, reason)
    if not tobool(choice) then
        DarkRP.notify(initiator, 1, 4, DarkRP.getPhrase("warrant_denied", mayor:Nick()))
        return
    end
    if IsValid(suspect) then
        suspect:warrant(initiator, reason)
    end
end