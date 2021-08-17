local prisonerTransport = {}

net.Receive( "xyz_pnc_select", function( _, ply ) 
    XYZShit.Msg("PNC", PNC.Config.Color, "You have selected a vehicle. Check your PNC")
    PNC.SelectedVehicle = net.ReadEntity()
    PNC.SelectedVehicleHasLicense = net.ReadBool()
end )


net.Receive( "xyz_pnc_open", function(_, ply)
    local match
    local tablet = net.ReadBool() or false

    local frame = XYZUI.Frame("National Police Database", PNC.Config.Color)
    frame:SetSize(ScrW() * 0.7, ScrH() * 0.75)
    frame:Center()

    local shell = XYZUI.Container(frame)
    shell.Paint = function() end -- Make the shell invs, we only need it for padding 
    local navBar = XYZUI.NavBar(frame)


    local lookupBtn = nil
    if IsValid(PNC.SelectedVehicle) then
        local carInfo = list.Get("Vehicles")[PNC.SelectedVehicle:GetVehicleClass()]
        local owner = PNC.SelectedVehicle:getDoorOwner()
        XYZUI.AddNavBarPage(navBar, shell, "Vehicle", function(shell)
            local carInfoShell = XYZUI.Container(shell)
            carInfoShell:Dock(LEFT)
            carInfoShell:SetWidth((shell:GetWide()/2)-8)
            carInfoShell:DockMargin(0, 0, 0, 0)

                -- Information header
                XYZUI.PanelText(carInfoShell, "Vehicle Information", 30, TEXT_ALIGN_LEFT)
                -- Owner
                XYZUI.PanelText(carInfoShell, "Owner: "..(owner and owner:Name() or "None"), 20, TEXT_ALIGN_LEFT)
                -- Vehicle
                XYZUI.PanelText(carInfoShell, "Vehicle: "..carInfo.Name, 20, TEXT_ALIGN_LEFT)
                if owner then
                    -- Wanted Status
                    XYZUI.PanelText(carInfoShell, "Wanted Status: "..(owner:isWanted() and owner:getWantedReason() or "No"), 20, TEXT_ALIGN_LEFT)
                    -- Has a license
                    XYZUI.PanelText(carInfoShell, "Drivers License: "..((PNC.SelectedVehicleHasLicense == "error") and "Unknown (Requires manual search)" or (PNC.SelectedVehicleHasLicense and "Yes" or "No")), 20, TEXT_ALIGN_LEFT)
                end
    
                local lookupOwner = XYZUI.ButtonInput(carInfoShell, "Lookup Owner", function(self)
                    lookupBtn.DoClick()
                    net.Start("xyz_pnc_search")
                        net.WriteString(owner:Name())
                    net.SendToServer()
                end)
                lookupOwner:CenterHorizontal()
                lookupOwner:Dock(BOTTOM)
                lookupOwner:DockMargin(5, 0, 5, 5)

            local carModelShell = XYZUI.Container(shell)
            carModelShell:Dock(RIGHT)
            carModelShell:SetWidth((shell:GetWide()/2)-8)
            carModelShell:DockPadding(5, 5, 5, 5)

                local modelPnl = vgui.Create("DModelPanel", carModelShell)
                modelPnl:SetSize(h, h)
                modelPnl:Dock(FILL)
                modelPnl:SetModel(PNC.SelectedVehicle:GetModel())
                --function b.model:LayoutEntity( Entity ) return end
                
                -- *|* Credit: https://wiki.garrysmod.com/page/DModelPanel/SetCamPos
                local mn, mx = modelPnl.Entity:GetRenderBounds()
                local size = 0
                size = math.max( size, math.abs( mn.x ) + math.abs( mx.x ) )
                size = math.max( size, math.abs( mn.y ) + math.abs( mx.y ) )
                size = math.max( size, math.abs( mn.z ) + math.abs( mx.z ) )
                modelPnl:SetFOV(50)
                modelPnl:SetCamPos( Vector( size+4, size+4, size+4 ) )
                modelPnl:SetLookAt( ( mn + mx ) * 0.5 )
                -- *|*
        end)
    end

    lookupBtn = XYZUI.AddNavBarPage(navBar, shell, "Lookup", function(shell)
        local plySearchShell = XYZUI.Container(shell)
        plySearchShell:Dock(LEFT)
        plySearchShell:SetWidth((shell:GetWide()/2)-8)
        plySearchShell.Paint = function() end -- Again, we don't need the visuals of it
        plySearchShell:DockMargin(0, 0, 0, 0)
        plySearchShell:DockPadding(0, 0, 0, 0)

        -- Search SteamID64
            local searhUserDock = vgui.Create("DPanel", plySearchShell)
            searhUserDock:SetText("")
            searhUserDock:Dock(TOP)
            searhUserDock:DockMargin(0, 0, 0, 5)
            searhUserDock:SetTall(40)
            searhUserDock.Paint = function() end

            local entry, entryPad

            local btn = XYZUI.ButtonInput(searhUserDock, "Search ID", function()
                if string.len(entry:GetText()) < 3 then return end

                net.Start("xyz_pnc_search")
                    net.WriteString(entry:GetText())
                net.SendToServer()
            end)
            btn:Dock(RIGHT)
            btn:SetWide(120)
            btn.headerColor = PNC.Config.Color

            entry, entryPad = XYZUI.TextInput(searhUserDock)
            entry:Dock(FILL)
            entryPad.headerColor = PNC.Config.Color

        local _, plysList = XYZUI.Lists(plySearchShell, 1)
        plysList:DockPadding(0, 0, 0, 0)
        plysList:Dock(FILL)


        for k, v in pairs(player.GetAll()) do
            local plyButton = vgui.Create("DPanel", plysList)
            plyButton:SetText("")
            plyButton:Dock(TOP)
            plyButton:DockMargin(0, 0, 0, 5)
            plyButton:SetTall(50)
            plyButton.Paint = function() end
            plyButton.headerColor = team.GetColor(v:Team())

            plyButton.icon = vgui.Create("DModelPanel", plyButton)
            plyButton.icon:SetSize(plyButton:GetTall(), plyButton:GetTall())
            plyButton.icon:Dock(LEFT)
            plyButton.icon:SetFOV(35)
            plyButton.icon:SetModel(v:GetModel())
            
            function plyButton.icon:LayoutEntity( ent )
                if !IsValid(ent) then
                    self:SetModel(v:GetModel())
                end
    
                if ent:LookupBone("ValveBiped.Bip01_Head1") != nil then
                    local eyepos = ent:GetBonePosition( ent:LookupBone( "ValveBiped.Bip01_Head1" ) )
                    self:SetLookAt( eyepos )
                    self:SetCamPos( eyepos+Vector( 35, 0, -4 ) )
                else 
                    eyepos = ent:GetPos()+ Vector(0,0,70)
                    self:SetLookAt( eyepos )
                    self:SetCamPos( eyepos+Vector( 35, 0, -4 ) )
                end
                return
            end

            local button = XYZUI.ButtonInput(plyButton, v:Name(), function()
                net.Start("xyz_pnc_search")
                    net.WriteString(v:Name())
                net.SendToServer()
            end)
            button:Dock(FILL)
        end


        local actionShell = XYZUI.Container(shell)
        actionShell:Dock(RIGHT)
        actionShell:SetWidth((shell:GetWide()/2)-8)
        actionShell:DockPadding(5, 5, 5, 5)

        net.Receive("xyz_pnc_search", function()
            -- Clear the past data and rebuild
            actionShell:Clear()

            local target = net.ReadEntity()
            local licensed = net.ReadBool()
            local vehicle = net.ReadEntity()
            local vstolen = net.ReadTable()
            local points = net.ReadUInt(10)
            local markedBy

            local stolen = vstolen[1]
            if stolen then
                markedBy = vstolen[2] 
            end

            -- Information header
            XYZUI.PanelText(actionShell, "Information", 30, TEXT_ALIGN_LEFT)
            
            -- Name
            XYZUI.PanelText(actionShell, "Name: "..target:Name(), 20, TEXT_ALIGN_LEFT)
            -- Drivers License Status
            XYZUI.PanelText(actionShell, "Drivers License: "..(licensed and "Yes" or "No"), 20, TEXT_ALIGN_LEFT)
            -- Gun License Status
            XYZUI.PanelText(actionShell, "Gun License: "..(target:getDarkRPVar("HasGunlicense") and "Yes" or "No"), 20, TEXT_ALIGN_LEFT)
            -- Wanted Status
            XYZUI.PanelText(actionShell, "Wanted Status: "..(target:isWanted() and target:getWantedReason() or "No"), 20, TEXT_ALIGN_LEFT)
            -- Total Points
            XYZUI.PanelText(actionShell, "Total Points: "..points, 20, TEXT_ALIGN_LEFT) 
            -- Current Vehicle
            local text = (IsValid(vehicle) and CarDealer.Config.Cars[vehicle:GetVehicleClass()].name or "None")
            XYZUI.PanelText(actionShell, "Current Vehicle: "..text, 20, TEXT_ALIGN_LEFT)
            if stolen then
                local stolentext = "Stolen, marked by "..((IsValid(markedBy) and markedBy:Nick()) or "Unknown")
                XYZUI.PanelText(actionShell, stolentext, 20, TEXT_ALIGN_LEFT)
            end

            if IsValid(vehicle) then
                local markVehicleStolenBtn = XYZUI.ButtonInput(actionShell, "Mark as (un)stolen", function(self)
                    if not IsValid(target) then return end
                    XYZUI.Confirm("Mark vehicle as (un)stolen?", PNC.Config.Color, function()
                        net.Start("xyz_pnc_markstolen")
                            net.WriteEntity(target)
                        net.SendToServer()
                    end)
                end)
            end

            -- Button Shell

            local otherBtnPanel = XYZUI.Card(actionShell, 30)
            otherBtnPanel:Dock(BOTTOM)
            otherBtnPanel:DockMargin(5, 5, 5, 5)
            otherBtnPanel.Paint = nil
    
                local viewArrestsBtn = XYZUI.ButtonInput(otherBtnPanel, "View Arrests", function(self)
                    if not IsValid(target) then return end
                    net.Start("xyz_pnc_arrests")
                        net.WriteEntity(target)
                    net.SendToServer()
                end)
                viewArrestsBtn:SetWide(115)
                viewArrestsBtn:CenterHorizontal()
                viewArrestsBtn:Dock(LEFT)
                viewArrestsBtn:DockMargin(0, 0, 5, 0)
    
                local viewTicketsBtn = XYZUI.ButtonInput(otherBtnPanel, "View Tickets", function(self)
                    if not IsValid(target) then return end
                    net.Start("xyz_pnc_tickets")
                        net.WriteEntity(target)
                    net.SendToServer()
                end)
                viewTicketsBtn:SetWide(115)
                viewTicketsBtn:CenterHorizontal()
                viewTicketsBtn:Dock(LEFT)
                viewTicketsBtn:DockMargin(0, 0, 5, 0)

                local viewVehiclesBtn = XYZUI.ButtonInput(otherBtnPanel, "View Vehicles", function(self)
                    if not IsValid(target) then return end
                    net.Start("xyz_pnc_vehicles")
                        net.WriteEntity(target)
                    net.SendToServer()
                end)
                viewVehiclesBtn:SetWide(115)
                viewVehiclesBtn:CenterHorizontal()
                viewVehiclesBtn:Dock(LEFT)
                viewVehiclesBtn:DockMargin(0, 0, 5, 0)

            local pointBtnPanel = XYZUI.Card(actionShell, 30)
            pointBtnPanel:Dock(BOTTOM)
            pointBtnPanel:DockMargin(5, 5, 5, 5)
            pointBtnPanel.Paint = nil
    
                local addPointsBtn = XYZUI.ButtonInput(pointBtnPanel, "Add Point", function(self)
                    if not IsValid(target) then return end
                    net.Start("xyz_dmv_addpoint")
                        net.WriteEntity(target)
                    net.SendToServer()
                end)
                addPointsBtn:SetWide(115)
                addPointsBtn:CenterHorizontal()
                addPointsBtn:Dock(LEFT)
                addPointsBtn:DockMargin(0, 0, 5, 0)
    
                local remPointsBtn = XYZUI.ButtonInput(pointBtnPanel, "Remove Point", function(self)
                    if not IsValid(target) then return end
                    net.Start("xyz_dmv_rempoint")
                        net.WriteEntity(target)
                    net.SendToServer()
                end)
                remPointsBtn:SetWide(115)
                remPointsBtn:CenterHorizontal()
                remPointsBtn:Dock(LEFT)
                remPointsBtn:DockMargin(0, 0, 5, 0)
               
            if tablet then
                local extraBtnPanel = XYZUI.Card(actionShell, 30)
                extraBtnPanel:Dock(BOTTOM)
                extraBtnPanel:DockMargin(5, 5, 5, 5)
                extraBtnPanel.Paint = nil

                    if LocalPlayer():GetPos():DistToSqr(target:GetPos()) < 12500 then
                        local giveTicket = XYZUI.ButtonInput(extraBtnPanel, "Give Ticket", function(self)
                            if not IsValid(target) then return end
                            frame:Close()
                            TicketBook.MainMenu(target)
                        end)
                        giveTicket:SetWide(115)
                        giveTicket:CenterHorizontal()
                        giveTicket:Dock(LEFT)
                        giveTicket:DockMargin(0, 0, 5, 0)
                    end

                    local makeWantedBtn = XYZUI.ButtonInput(extraBtnPanel, target:isWanted() and "Make Unwanted" or "Make Wanted", function(self)
                        if not IsValid(target) then return end
                        if target:isWanted() then
                            LocalPlayer():ConCommand("say /unwanted "..target:Name())
                            XYZShit.Msg("PNC", PNC.Config.Color, "You have made "..target:Name().." unwanted!")
    
                        else
                            XYZUI.PromptInput("Want "..target:Name(), PNC.Config.Color, "Specify the reason for making them wanted", function(reason)
                                if reason == "" then return end
                                LocalPlayer():ConCommand("say /wanted \""..target:Name().."\" "..reason)
                                XYZShit.Msg("PNC", PNC.Config.Color, "You have made "..target:Name().." wanted!")
                            end)
                        end
                    end)
                    makeWantedBtn:SetWide(115)
                    makeWantedBtn:CenterHorizontal()
                    makeWantedBtn:Dock(LEFT)
                    makeWantedBtn:DockMargin(0, 0, 5, 0)

                    local makeWarrantBtn = XYZUI.ButtonInput(extraBtnPanel, "Start Warrant", function(self)
                        XYZUI.PromptInput("Warrant "..target:Name(), PNC.Config.Color, "Specify the reason for starting a warrant", function(reason)
                            if reason == "" then return end
                            LocalPlayer():ConCommand("say /warrant \""..target:Name().."\" "..reason)
                            XYZShit.Msg("PNC", PNC.Config.Color, "You have started a warrant on "..target:Name().."!")
                        end)
                    end)
                    makeWarrantBtn:SetWide(115)
                    makeWarrantBtn:CenterHorizontal()
                    makeWarrantBtn:Dock(LEFT)
                    makeWarrantBtn:DockMargin(0, 0, 5, 0)
            end
        end)
    end)
    
    XYZUI.AddNavBarPage(navBar, shell, "BOLO's", function(shell)
        local _, wantedList = XYZUI.Lists(shell, 1)
        for _, v in pairs(player.GetAll()) do
            if not IsValid(v) then continue end
            if not v:isWanted() then continue end 

            local body, header, mainContainer = XYZUI.ExpandableCard(wantedList, v:Nick())
            mainContainer:DockMargin(0, 0, 0, 5)

            local btnCnt = vgui.Create("DPanel", body)
            btnCnt.ply = v
            btnCnt.Paint = function() end
            btnCnt:Dock(TOP)
            btnCnt:DockMargin(0, 0, 0, 0)
            btnCnt:SetTall(90)

            XYZUI.AddToExpandableCardBody(mainContainer, btnCnt)

            local mdl = vgui.Create("DModelPanel", btnCnt)
            mdl:SetHeight(btnCnt:GetTall())
            mdl:SetModel(v:GetModel())

            function mdl:LayoutEntity() return end
            mdl.Entity:SetSequence(0)

            if mdl.Entity:LookupBone("ValveBiped.Bip01_Head1") then 
                local headpos = mdl.Entity:GetBonePosition(mdl.Entity:LookupBone("ValveBiped.Bip01_Head1"))
                mdl:SetLookAt(headpos)
                mdl:SetCamPos(headpos-Vector(-12.2, 0, -0.7))
                mdl.Entity:SetEyeTarget(headpos-Vector(-15, 0, 0))
            end
            
            local wanted = XYZUI.Title(btnCnt, "Wanted for", v:getWantedReason(), 30, 25, true)
            wanted:SetWide(btnCnt:GetWide())
        end

        net.Start("xyz_pnc_request_stolen_vehicles")
        net.SendToServer()

        net.Receive("xyz_pnc_request_stolen_vehicles", function()
            local vehicles = net.ReadTable()
            for k, v in pairs(vehicles) do
                if not IsValid(Entity(k)) then continue end
                if not Entity(k):IsVehicle() then continue end
                if not CarDealer.Config.Cars[Entity(k):GetVehicleClass()] then continue end
                local body, header, mainContainer = XYZUI.ExpandableCard(wantedList, CarDealer.Config.Cars[Entity(k):GetVehicleClass()].name)
                mainContainer:DockMargin(0, 0, 0, 5)

                local btnCnt = vgui.Create("DPanel", body)
                btnCnt.Paint = function() end
                btnCnt:Dock(TOP)
                btnCnt:DockMargin(0, 0, 0, 0)
                btnCnt:SetTall(240)
                btnCnt:DockPadding(shell:GetWide()*0.2, 0, shell:GetWide()*0.2, 0)

                XYZUI.AddToExpandableCardBody(mainContainer, btnCnt)

                local mdl = vgui.Create("DModelPanel", btnCnt)
                mdl:Dock(FILL)
                mdl:SetModel(Entity(k):GetModel())

                //function mdl:LayoutEntity() return end
                //mdl.Entity:SetSequence(0)
            end
        end)
    end)

    XYZUI.AddNavBarPage(navBar, shell, "Patrol", function(shell)
        if not PNC.Core.ActivePatrol then
            local startPatrol = XYZUI.ButtonInput(shell, "Start a Patrol", function()
                net.Start("xyz_pnc_patrol_start")
                net.SendToServer()
                frame:Close()
            end)
            startPatrol:Dock(BOTTOM)

            return
        else
            local endPatro = XYZUI.ButtonInput(shell, "Stop Current Patrol", function()
                net.Start("xyz_pnc_patrol_stop")
                net.SendToServer()
                frame:Close()
            end)
            endPatro:Dock(BOTTOM)

            local sharePatrol = XYZUI.ButtonInput(shell, "Share Patrol With Partner", function()
                net.Start("xyz_pnc_patrol_share")
                net.SendToServer()
            end)
            sharePatrol:Dock(BOTTOM)
            sharePatrol:DockMargin(0, 0, 0, 5)
        end

        for k, v in pairs(PNC.Core.ActivePatrol.pads) do
            local card = XYZUI.Container(shell)
            card:Dock(TOP)
            card:SetTall(45)
            card:DockMargin(0, 0, 0, 5)

            local text = XYZUI.PanelText(card, (k == PNC.Core.ActivePatrol.current and "--> " or "")..v.name, 30, TEXT_ALIGN_CENTER)
            text:Dock(FILL)
        end
    end)

    if tablet then
        XYZUI.AddNavBarPage(navBar, shell, "Panic Button", function(shell)
            frame:Close()
            PanicButtonUI()
        end)
    end

    XYZUI.AddNavBarPage(navBar, shell, "Prisoner Transport", function(shell)
        frame:Close()
        net.Start("xyz_pnc_request_prisonert")
        net.SendToServer()
    end)

    XYZUI.AddNavBarPage(navBar, shell, "Reports", function(shell)
        local addReportButton = XYZUI.ButtonInput(shell, "Add Report", function()
            local arframe = XYZUI.Frame("Add Report", PNC.Config.Color)
            arframe:SetSize(ScrW() * 0.3, ScrH() * 0.34)
            arframe:Center()
            local arshell = XYZUI.Container(arframe)

            XYZUI.Title(arshell, "Report Title", nil, 40)
            local titleEntry = XYZUI.TextInput(arshell)

            XYZUI.Title(arshell, "Report Body", nil, 40)
            local bodyEntry = XYZUI.TextInput(arshell, true)
            bodyEntry:Dock(FILL)

            XYZUI.ButtonInput(arshell, "Submit", function()
                if titleEntry:GetValue() == "" or bodyEntry:GetValue() == "" then return end
                net.Start("xyz_pnc_add_report")
                net.WriteString(titleEntry:GetValue())
                net.WriteString(bodyEntry:GetValue())
                net.SendToServer()
                arframe:Close()
            end):Dock(BOTTOM)
        end)

        addReportButton.headerColor = Color(120,20,60)
        addReportButton:DockMargin(0, 0, 0, 5)

        local _, reportLists = XYZUI.Lists(shell, 1)

        net.Start("xyz_pnc_reports")
        net.SendToServer()
        net.Receive( "xyz_pnc_reports", function(_, ply)
            local reports = net.ReadTable()

            for k, v in ipairs(reports) do
                XYZUI.ButtonInput(reportLists, v.title, function()
                    local reportframe = XYZUI.Frame(v.title, PNC.Config.Color)
                    local report, cr = XYZUI.TextInput(reportframe, true)
                    cr:Dock(FILL)
                    report:SetValue(v.body)
                    report:SetDisabled(true)
                end):DockMargin(0, 0, 0, 5)
            end
        end)
    end)
end)


net.Receive("xyz_pnc_request_prisonert", function()
    if not XYZSettings.GetSetting("pnc_pt_show_minimap", true) then return end

    local pos = net.ReadVector()
    local ply = net.ReadEntity()
    PNC.Core.PrisonerTransportRequests[#PNC.Core.PrisonerTransportRequests + 1] = {pos, ply}
    Minimap.AddWaypoint("prisontransport_"..ply:SteamID64(), "prisonertransport_marker", XYZUI.CharLimit(ply:Name(), 20), Color(169, 169, 169), 1.3, ply:GetPos())
end)

net.Receive("xyz_pnc_cancel_prisonert", function()
    local ply = net.ReadEntity()
    for k, v in pairs(PNC.Core.PrisonerTransportRequests) do
        if v[2] == ply then 
            table.remove(PNC.Core.PrisonerTransportRequests, k)
            break
        end
    end
    
    Minimap.RemoveWaypoint("prisontransport_"..ply:SteamID64())
end)

net.Receive("xyz_pnc_arrests", function()
    local arrests = net.ReadTable()
    local target = net.ReadEntity()

    local frame = XYZUI.Frame("Arrests for "..XYZUI.CharLimit(target:Nick()), PNC.Config.Color)
    frame:SetSize(ScrW()*0.25, ScrH()*0.75)
    frame:Center()


    local arrestshell = XYZUI.Container(frame)
    local _, arrestList = XYZUI.Lists(arrestshell, 1)

    for k, v in pairs(arrests) do
        local body, header, mainContainer = XYZUI.ExpandableCard(arrestList, os.date("%c", k).." - "..table.Count(v).." charge(s)")
        mainContainer:DockMargin(0, 0, 0, 5)
        for _, v2 in pairs(v) do
            local charges = XYZUI.PanelText(body, v2, 35, TEXT_ALIGN_CENTER)

            XYZUI.AddToExpandableCardBody(mainContainer, charges)
        end
    end
end)

net.Receive("xyz_pnc_tickets", function()
    local tickets = net.ReadTable()
    local target = net.ReadEntity()

    local frame = XYZUI.Frame("Tickets for "..XYZUI.CharLimit(target:Nick()), PNC.Config.Color)
    frame:SetSize(ScrW()*0.25, ScrH()*0.75)
    frame:Center()

    local ticketshell = XYZUI.Container(frame)
    local _, ticketList = XYZUI.Lists(ticketshell, 1)

    for k, v in pairs(tickets) do
        local body, header, mainContainer = XYZUI.ExpandableCard(ticketList, os.date("%c", k).." - "..table.Count(v).." charge(s)")
        mainContainer:DockMargin(0, 0, 0, 5)
        for _, v2 in pairs(v) do
            local charges = XYZUI.PanelText(body, v2, 35, TEXT_ALIGN_CENTER)

            XYZUI.AddToExpandableCardBody(mainContainer, charges)
        end
    end
end)

if GetConVar("developer"):GetBool() then
    print('Enabled developer traces')
    hook.Add("PlayerButtonDown", "SeeTraces", function(ply, button)
        if IsFirstTimePredicted() and button == KEY_G then 
            print('Trace1')
            local veh = LocalPlayer():GetVehicle()
            if not IsValid(veh) then return end
            if not PNC.Config.AllowedVehicles[veh:GetVehicleClass()] then return end
            local ltw = veh:LocalToWorld(PNC.Config.TraceStart)
            local tr = util.TraceLine({
                start = ltw,
                endpos = veh:LocalToWorld(PNC.Config.TraceEnd)
            })
            debugoverlay.Line(ltw, tr.HitPos, 7, color_white, true)
            debugoverlay.Sphere(tr.HitPos, 6, 7, color_red)
            if IsValid(tr.Entity) and tr.Entity:IsVehicle() then
                local vn = (CarDealer.Config.Cars[tr.Entity:GetVehicleClass()] and CarDealer.Config.Cars[tr.Entity:GetVehicleClass()].name) or list.Get("Vehicles")[tr.Entity:GetVehicleClass()].Name.." NOT CD VEHICLE"
                debugoverlay.Text(tr.Entity:GetPos(), vn, 8)
            end
        end
    end)
end

net.Receive("xyz_pnc_vehicles", function()
    local vehicles = net.ReadTable()
    local target = net.ReadEntity()

    local frame = XYZUI.Frame("Vehicles for "..XYZUI.CharLimit(target:Nick()), PNC.Config.Color)
    frame:SetSize(ScrW()*0.25, ScrH()*0.75)
    frame:Center()

    local vehicleshell = XYZUI.Container(frame)
    local _, vehicleList = XYZUI.Lists(vehicleshell, 1)

    for k, v in pairs(vehicles) do
        if not CarDealer.Config.Cars[k] then continue end
        local body, header, mainContainer = XYZUI.ExpandableCard(vehicleList, CarDealer.Config.Cars[k].name)
        mainContainer:DockMargin(0, 0, 0, 5)
        local vehicle = vgui.Create("DModelPanel", body)

        vehicle:SetSize(body:GetWide(), 250)
        vehicle:SetColor(v.color or Color(255, 255, 255))
        vehicle:SetModel(CarDealer.Config.Cars[k].model)

        -- *|* Credit: https://wiki.garrysmod.com/page/DModelPanel/SetCamPos
        local mn, mx = vehicle.Entity:GetRenderBounds()
        local size = 0
        size = math.max( size, math.abs( mn.x ) + math.abs( mx.x ) )
        size = math.max( size, math.abs( mn.y ) + math.abs( mx.y ) )
        size = math.max( size, math.abs( mn.z ) + math.abs( mx.z ) )
        vehicle:SetFOV(60)
        vehicle:SetCamPos( Vector( size+4, size+4, size+4 ) )
        vehicle:SetLookAt( ( mn + mx ) * 0.5 )

        for k2, v2 in pairs(v.bodygroups or {}) do
            vehicle.Entity:SetBodygroup(k2, v2)
        end

        XYZUI.AddToExpandableCardBody(mainContainer, vehicle)
    end
end)