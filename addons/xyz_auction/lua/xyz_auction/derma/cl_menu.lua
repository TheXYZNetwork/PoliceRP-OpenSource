function AuctionHouse.Core.UI(npc)
    local frame = XYZUI.Frame("Auction House", AuctionHouse.Config.Color)
    frame:SetSize(ScrH()*0.8, ScrH()*0.7)
    frame:Center()

    local navBar = XYZUI.NavBar(frame)
    local _, shell = XYZUI.Lists(frame, 1)
    shell.Paint = nil
    shell:DockPadding(10, 5, 10, 10)

    XYZUI.AddNavBarPage(navBar, shell, "Active Auctions", function(shell)
        net.Start("AuctionHouse:RequestListings")
        net.SendToServer()

        local loading = XYZUI.PanelText(shell, "Loading Listings...", 50)

        net.Receive("AuctionHouse:RequestListings", function()
            if not IsValid(frame) then return end
            
            loading:Remove()
            local listings = net.ReadTable()

            if table.IsEmpty(listings) then
                XYZUI.PanelText(shell, "There are currently no listings...", 50)
                return
            end

            local sortedListings = {}
            for k, v in pairs(listings) do
                if tobool(v.server) then
                    table.insert(sortedListings, 1, v)
                else
                    table.insert(sortedListings, v)
                end
            end

            for k, v in ipairs(sortedListings) do
                local card = XYZUI.Card(shell, 80)
                card:DockMargin(0, 0, 0, 5)

                local model = vgui.Create("DModelPanel", card)
                model:SetSize(card:GetTall(), card:GetTall())
                model:Dock(LEFT)
                model:SetModel(v.model)
                --function b.model:LayoutEntity( Entity ) return end
                    -- *|* Credit: https://wiki.garrysmod.com/page/DModelPanel/SetCamPos
                    local mn, mx = model.Entity:GetRenderBounds()
                    local size = 0
                    size = math.max( size, math.abs( mn.x ) + math.abs( mx.x ) )
                    size = math.max( size, math.abs( mn.y ) + math.abs( mx.y ) )
                    size = math.max( size, math.abs( mn.z ) + math.abs( mx.z ) )
                    model:SetFOV(40)
                    model:SetCamPos( Vector( size+4, size+4, size+4 ) )
                    model:SetLookAt( ( mn + mx ) * 0.5 )
                    -- *|*
                    if AuctionHouse.Config.Types[v.itemType].modelMods then
                        AuctionHouse.Config.Types[v.itemType].modelMods(model, v.data)
                    end

                local title = XYZUI.Title(card, v.name..(v.quantity > 1 and (" x"..v.quantity) or ""), "Ends in "..string.NiceTime(v.started + v.duration - os.time()))
                if v.server then
                    title.titleColor = Color(212, 175, 55)
                end
                title:Dock(LEFT)
                title:SetWide(shell:GetWide()/2)

                local price = XYZUI.Title(card, DarkRP.formatMoney(v.currentBid), "Current Bid", nil, nil, true)
                price.titleColor = Color(55, 212, 55)
                price:Dock(FILL)

                local bid = XYZUI.ButtonInput(card, "BID", function(self)
                    local _, _, entry = XYZUI.PromptInput("Place Bid", AuctionHouse.Config.Color, v.currentBid + 10000, function(amount)
                        amount = tonumber(amount)
                        if not isnumber(amount) then XYZShit.Msg("Auction House", AuctionHouse.Config.Color, "Please enter a valid amount") return end
                        if amount < (v.currentBid + 10000) then XYZShit.Msg("Auction House", AuctionHouse.Config.Color, "You must bid a minimum of: "..DarkRP.formatMoney(v.currentBid + 10000)) return end

                        net.Start("AuctionHouse:PlaceBid")
                            net.WriteEntity(npc)
                            net.WriteUInt(v.key, 32)
                            net.WriteUInt(amount, 32)
                        net.SendToServer()

                        AuctionHouse.Core.UI(npc)
                        frame:Close()
                    end)
                    entry:SetNumeric(true)
                end)
                bid:Dock(RIGHT)
                bid:DockMargin(10, 10, 10, 10)
            end
        end)
    end)
    XYZUI.AddNavBarPage(navBar, shell, "Create Auction", function(shell)
        if AuctionHouse.Config.DisablePlayerAuctions then
            XYZUI.PanelText(shell, "Player auctions are current disabled by an admin...", 30)
            return
        end

        XYZUI.PanelText(shell, "Item Type:", 35, TEXT_ALIGN_LEFT)
        local existingListables = {}
        local typeDropdown = XYZUI.DropDownList(shell, "Select a Type", function(name, value)
            -- Clear the listing area
            for k, v in pairs(existingListables) do
                if IsValid(v) then
                    v:Remove()
                end
            end

            local listable = AuctionHouse.Config.Types[value].getListable(LocalPlayer())
            for k, v in pairs(listable) do
                local card = XYZUI.Card(shell, 80)
                card:DockMargin(0, 0, 0, 5)
                table.insert(existingListables, card)

                local oldPaint = card.Paint

                function card.Paint(...)
                    oldPaint(...)
                    if not IsValid(card.model) then
                        local model = vgui.Create("DModelPanel", card)
                        card.model = model
                        model:SetSize(card:GetTall(), card:GetTall())
                        model:Dock(LEFT)
                        model:SetModel(v.model)
                        --function b.model:LayoutEntity( Entity ) return end
                        if model.Entity then
                            -- *|* Credit: https://wiki.garrysmod.com/page/DModelPanel/SetCamPos
                            local mn, mx = model.Entity:GetRenderBounds()
                            local size = 0
                            size = math.max( size, math.abs( mn.x ) + math.abs( mx.x ) )
                            size = math.max( size, math.abs( mn.y ) + math.abs( mx.y ) )
                            size = math.max( size, math.abs( mn.z ) + math.abs( mx.z ) )
                            model:SetFOV(40)
                            model:SetCamPos( Vector( size+4, size+4, size+4 ) )
                            model:SetLookAt( ( mn + mx ) * 0.5 )
                            -- *|
                        end
                        if AuctionHouse.Config.Types[value].modelMods then
                            AuctionHouse.Config.Types[value].modelMods(model, v.data)
                        end
                    end
                end

                local text = XYZUI.PanelText(card, v.name..(v.quantity > 1 and (" x"..v.quantity) or ""), 40, TEXT_ALIGN_CENTER)
                text:Dock(FILL)

                local create = XYZUI.ButtonInput(card, "LIST", function(self)
                    AuctionHouse.Core.ListingUI(npc, value, k)

                    frame:Close()
                end)
                create:Dock(RIGHT)
                create:DockMargin(10, 10, 10, 10)
            end
        end)
        typeDropdown:DockMargin(0, 0, 0, 5)
        for k, v in pairs(AuctionHouse.Config.Types) do
            if v.adminOnly then continue end
            XYZUI.AddDropDownOption(typeDropdown, v.name, k)
        end
    end)
    XYZUI.AddNavBarPage(navBar, shell, "Your Auction Activity", function(shell)
        net.Start("AuctionHouse:RequestActivity")
        net.SendToServer()

        local loading = XYZUI.PanelText(shell, "Loading Activity...", 50)

        net.Receive("AuctionHouse:RequestActivity", function()
            loading:Remove()

            local activity = net.ReadTable()

            if table.IsEmpty(activity) then
                XYZUI.PanelText(shell, "There are currently no listings...", 50)
                return
            end

            for k, v in ipairs(table.Reverse(activity)) do
                local card = XYZUI.Card(shell, 40)
                card:DockMargin(0, 0, 0, 5)
                card:DockPadding(5, 0, 5, 0)
            
                XYZUI.PanelText(card, v.message, 20, TEXT_ALIGN_LEFT):Dock(FILL)
                local date = XYZUI.PanelText(card, os.date("%d/%m/%Y" , v.created), 20, TEXT_ALIGN_RIGHT)
                date:Dock(RIGHT)
                date:SetWidth(80)
            end

        end)
    end)
end

net.Receive("AuctionHouse:UI", function()
    AuctionHouse.Core.UI(net.ReadEntity())
end)


function AuctionHouse.Core.ListingUI(npc, itemType, key)
    if not itemType then return end
    if not key then return end

    local itemData = AuctionHouse.Config.Types[itemType]
    if not itemData then return end

    local listable = itemData.getListable(LocalPlayer())
    if not listable then return end

    local item = listable[key]
    if not item then return end

    local frame = XYZUI.Frame("Auction House - Create Listing", AuctionHouse.Config.Color)
    frame:SetSize(ScrH()*0.8, ScrH()*0.4)
    frame:Center()


    local model = vgui.Create("DModelPanel", frame)
    model:SetWide(frame:GetWide()/2)
    model:Dock(LEFT)
    model:SetModel(item.model)
    --function b.model:LayoutEntity( Entity ) return end
        -- *|* Credit: https://wiki.garrysmod.com/page/DModelPanel/SetCamPos
        local mn, mx = model.Entity:GetRenderBounds()
        local size = 0
        size = math.max( size, math.abs( mn.x ) + math.abs( mx.x ) )
        size = math.max( size, math.abs( mn.y ) + math.abs( mx.y ) )
        size = math.max( size, math.abs( mn.z ) + math.abs( mx.z ) )
        model:SetFOV(40)
        model:SetCamPos( Vector( size+4, size+4, size+4 ) )
        model:SetLookAt( ( mn + mx ) * 0.5 )
        -- *|
        if itemData.modelMods then
            itemData.modelMods(model, item.data)
        end


    local _, shell = XYZUI.Lists(frame, 1)

    -- Listing name, static
    XYZUI.Title(shell, "Item Name:", item.name, 40, 30, centered)
    :DockMargin(5, 0, 5, 0)

    -- Listing starting price
    XYZUI.PanelText(shell, "Item Starting Price:", 35, TEXT_ALIGN_LEFT)
    :DockMargin(5, 0, 5, 0)
    local priceEntry, cont = XYZUI.TextInput(shell)
    cont:DockMargin(10, 0, 10, 5)
    priceEntry:SetNumeric(true)
    priceEntry.placeholder = "Min: $10,000 | Max: $1,000,000"

    local quantityEntry, cont
    if item.quantity > 1 then
        -- Listing quantity
        XYZUI.PanelText(shell, "Item Quantity:", 35, TEXT_ALIGN_LEFT)
        :DockMargin(5, 0, 5, 0)
        quantityEntry, cont = XYZUI.TextInput(shell)
        cont:DockMargin(10, 0, 10, 5)
        quantityEntry:SetNumeric(true)
        quantityEntry.placeholder = "Max: "..item.quantity
    end


    -- Listing Time
    XYZUI.PanelText(shell, "Item Listing Time:", 35, TEXT_ALIGN_LEFT)
    :DockMargin(5, 0, 5, 0)
    local timeCard = XYZUI.Card(shell, 40)
    timeCard.Paint = nil
    timeCard:DockMargin(10, 0, 10, 10)

    local timeEntry, cont = XYZUI.TextInput(timeCard)
    timeEntry:SetNumeric(true)
    timeEntry.placeholder = "Min: 12h | Max: 3d"
    cont:Dock(FILL)

    local timeDropdown = XYZUI.DropDownList(timeCard, "Length")
    timeDropdown:Dock(RIGHT)
    timeDropdown:SetWidth(frame:GetWide()/4)
    XYZUI.AddDropDownOption(timeDropdown, "Hours", 60*60)
    XYZUI.AddDropDownOption(timeDropdown, "Days", 60*60*24)

    local btn = XYZUI.ButtonInput(shell, "Create Listing", function(self)
        local price = priceEntry:GetText()
        if price == "" then return end
        if tonumber(price) < 10000 then return end
        if tonumber(price) > 1000000 then return end

        local quantity = 1
        if quantityEntry then
            quantity = quantityEntry:GetText()
            if quantity == "" then return end
            if tonumber(quantity) > tonumber(item.quantity) then return end
            if tonumber(quantity) < 1 then return end
        end

        local time = timeEntry:GetText()
        if time == "" then return end
        time = tonumber(time)
        local _, timeType = timeDropdown:GetSelected()
        if not timeType then return end
        time = time * timeType
        if time < 60*60*12 then return end
        if time > 60*60*24*3 then return end

        net.Start("AuctionHouse:Create")
            net.WriteEntity(npc)
            net.WriteString(itemType)
            net.WriteString(item.class)
            net.WriteUInt(price, 32)
            net.WriteUInt(quantity, 32)
            net.WriteUInt(time, 32)
        net.SendToServer()

        frame:Close()
    end)
    btn:DockMargin(10, 0, 10, 0)
end