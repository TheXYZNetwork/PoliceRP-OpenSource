net.Receive("ticketbook_ticket", function(len, ply)
    if not XYZShit.IsGovernment(ply:Team(), true) and not ply.UCOriginalJob then return end

    local ticketed = net.ReadEntity()
    if ticketed.ticket then XYZShit.Msg("Ticket Book", TicketBook.Config.Color, "This player already has an active ticket", ply) return end
    if ply:GetPos():DistToSqr(ticketed:GetPos()) > 12500 then return end
    if ticketed:isCP() then XYZShit.Msg("Ticket Book", TicketBook.Config.Color, "This user is a Government official", ply) return end
    local reasons = net.ReadTable()

    local amount = 0
    local points = 0
    for k, v in pairs(reasons) do
        if k == "custom" then
            if not v.fine or v.fine < 1 or not v.name or v.name == "" then return end
            if v.fine > 10000 then 
                XYZShit.Msg("Ticket Book", TicketBook.Config.Color, "You can't make your custom ticket that high.", ply)
                return
            end
            amount = amount + v.fine
        else
            amount = amount + TicketBook.Config.Reasons[k].ticket
            points = points + TicketBook.Config.Reasons[k].points
        end
    end
    if amount == 0 then return end
    amount = math.Clamp(amount, 1, TicketBook.Config.MaxTicketTotalSize)

    ticketed.ticket = {}
    ticketed.ticket.reasons = reasons
    ticketed.ticket.amount = amount
    ticketed.ticket.ticketer = ply

    if not PNC.Core.Tickets[ticketed:SteamID64()] then 
        PNC.Core.Tickets[ticketed:SteamID64()] = {}
    end

    -- Completely change table for database
    local nreasons = {}
    for k, v in pairs(reasons) do
        if k == "custom" then
            nreasons[#nreasons+1] = v.name
        else
            nreasons[#nreasons+1] = TicketBook.Config.Reasons[k].name
        end
    end
    PNC.Core.Tickets[ticketed:SteamID64()][os.time()] = nreasons

    XYZShit.DataBase.Query(string.format("INSERT INTO pnc_tickets(userid, ticketby, time, charges) VALUES('%s', '%s', %i, '%s');", ticketed:SteamID64(), ply:SteamID64(), os.time(), util.TableToJSON(nreasons)))
    net.Start("ticketbook_ticket")
    net.WriteTable(ticketed.ticket)
    net.Send(ticketed)
    XYZShit.Msg("Ticket Book", TicketBook.Config.Color, "You have given "..ticketed:Name().." a ticket!", ply)

    Quest.Core.ProgressQuest(ply, "boys_in_blue", 6)

    if points ~= 0 and licensedUsers[ticketed:SteamID64()] then
        XYZShit.DataBase.Query(string.format("UPDATE dmv_license SET points = points + %s WHERE steamid='%s'", points, ticketed:SteamID64()))
        XYZShit.Msg("DMV", DMV.Config.Color, "You have received "..points.." points on your license for this ticket", ticketed)
        hook.Call("TicketBookDMVPoints", nil, ply, ticketed, points)
        XYZShit.DataBase.Query(string.format("SELECT * FROM dmv_license WHERE steamid='%s'", ticketed:SteamID64()), function(data)
            if data[1] then
                licensedUsers[ticketed:SteamID64()] = data[1].points
                if data[1].points < DMV.Config.MaxPoints then return end
                XYZShit.DataBase.Query(string.format("INSERT INTO dmv_revokes (steamid, date) VALUES ('%s', '%s') ON DUPLICATE KEY UPDATE date='%s', total = total + 1;", ticketed:SteamID64(), os.time(), os.time()))
                XYZShit.DataBase.Query(string.format("DELETE FROM dmv_license WHERE steamid='%s'", ticketed:SteamID64()))
                XYZShit.Msg("DMV", DMV.Config.Color, "Your license has been automatically revoked for hitting the maximum points on your license", ticketed)
                XYZShit.Msg("DMV", DMV.Config.Color, ticketed:Nick().."'s license was automatically revoked for hitting the maximum points on their license", ply)
                ticketed:StripWeapon("weapon_drivers_license")
                licensedUsers[ticketed:SteamID64()] = nil
                hook.Call("DMVRevoked", nil, ticketed)
            end
        end )
    end

    hook.Call("TicketBookSendTicket", nil, ply, ticketed, amount)

    ply:GetViewModel():SendViewModelMatchingSequence(ply:GetViewModel():LookupSequence("write"))
end)

net.Receive("ticketbook_decline", function(len, ply)
    if not ply.ticket then return end
    if not IsValid(ply.ticket.ticketer) then ply.ticket = nil return end -- Ticketer left.. Dont bother getting wanted

    XYZShit.Msg("Ticket Book", TicketBook.Config.Color, ply:Name().." has denied the ticket!", ply.ticket.ticketer)

    ply:wanted(nil, "Failure to pay ticket ($"..ply.ticket.amount..")")
    hook.Call("TicketBookDenyTicket", nil, ply, ply.ticket.ticketer)
    ply.ticket = nil
end)

net.Receive("ticketbook_pay", function(len, ply)
    if not ply.ticket then return end
    if not IsValid(ply.ticket.ticketer) then ply.ticket = nil return end -- Ticketer left.. Dont bother paying

    local amount = ply.ticket.amount
    if not ply:canAfford(ply.ticket.amount) then
        ply:wanted(nil, "Failure to pay ticket ($"..ply.ticket.amount..")")
        hook.Call("TicketBookDenyTicket", nil, ply, ply.ticket.ticketer)
        ply.ticket = nil
    return
    end
    ply:addMoney(-amount)

    ply.ticket.ticketer:addMoney(math.Round(amount * TicketBook.Config.Distribute))
    XYZShit.Msg("Ticket Book", TicketBook.Config.Color, ply:Nick() .. " has paid their ticket and you have received " .. DarkRP.formatMoney(math.Round(amount * TicketBook.Config.Distribute)), ply.ticket.ticketer)
        
    local forGovFunds = math.Round(amount - (amount * TicketBook.Config.Distribute))
    local clamped = math.Clamp(XYZPresident.TotalMoney + forGovFunds, 0, XYZPresident.Config.HoldCap)
    local thrownaway = 0

    if clamped ~= (XYZPresident.TotalMoney + forGovFunds) then
        thrownaway = ((XYZPresident.TotalMoney + forGovFunds) - XYZPresident.Config.HoldCap)
        XYZPresident.Stats.ThrownAwayCap = XYZPresident.Stats.ThrownAwayCap + thrownaway
    end
    XYZPresident.Stats.AddedToFunds = XYZPresident.Stats.AddedToFunds + (forGovFunds - thrownaway or 0)
    XYZPresident.Stats.Tickets = XYZPresident.Stats.Tickets + (forGovFunds - thrownaway or 0)

    XYZPresident.TotalMoney = clamped
    
    XYZShit.Msg("Ticket Book", TicketBook.Config.Color, "You have paid your ticket", ply)

    net.Start("ticketbook_pay")
    net.WriteTable(ply.ticket)
    net.Send(ply)

    hook.Call("TicketBookPayTicket", nil, ply, ply.ticket.ticketer)
    ply.ticket = nil
end)