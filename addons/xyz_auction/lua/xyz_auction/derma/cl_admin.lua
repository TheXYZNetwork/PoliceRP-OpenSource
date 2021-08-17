function AuctionHouse.Core.AdminUI()
    local frame = XYZUI.Frame("Auction House - Admin Menu", AuctionHouse.Config.Color)
    frame:SetSize(ScrH()*0.6, ScrH()*0.8)
    frame:Center()

    local shell = XYZUI.Container(frame)
    shell:DockPadding(10, 10, 10, 10)

    -- Title
	local title = XYZUI.Title(shell, "Create an Auction House Listing", nil, 50, 0, TEXT_ALIGN_CENTER)
	title:SetTall(50)

	-- Listing name
    XYZUI.PanelText(shell, "Item Name:", 35, TEXT_ALIGN_LEFT)
    local nameEntry, cont = XYZUI.TextInput(shell)

	-- Listing name
    XYZUI.PanelText(shell, "Item Model:", 35, TEXT_ALIGN_LEFT)
    local modelEntry, cont = XYZUI.TextInput(shell)

	-- Listing quantity
    XYZUI.PanelText(shell, "Item Starting Price:", 35, TEXT_ALIGN_LEFT)
    local priceEntry, cont = XYZUI.TextInput(shell)
    priceEntry:SetNumeric(true)

	-- Listing quantity
    XYZUI.PanelText(shell, "Item Quantity (For this single listing):", 35, TEXT_ALIGN_LEFT)
    local quantityEntry, cont = XYZUI.TextInput(shell)
    quantityEntry:SetNumeric(true)

    -- Listing type
    XYZUI.PanelText(shell, "Item Type:", 35, TEXT_ALIGN_LEFT)
    local typeDropdown = XYZUI.DropDownList(shell, "Select a Type")
    for k, v in pairs(AuctionHouse.Config.Types) do
    	XYZUI.AddDropDownOption(typeDropdown, v.name, k)
    end

    -- Listing class
    XYZUI.PanelText(shell, "Item Class (SWEP/Vehicle Class):", 35, TEXT_ALIGN_LEFT)
    local classEntry, cont = XYZUI.TextInput(shell)


	-- Listing Time
    XYZUI.PanelText(shell, "Item Listing Time:", 35, TEXT_ALIGN_LEFT)
    local timeCard = XYZUI.Card(shell, 40)
    timeCard.Paint = nil

    local timeEntry, cont = XYZUI.TextInput(timeCard)
    timeEntry:SetNumeric(true)
    cont:Dock(FILL)

    local timeDropdown = XYZUI.DropDownList(timeCard, "Length")
    timeDropdown:Dock(RIGHT)
    timeDropdown:SetWidth(frame:GetWide()/4)
    XYZUI.AddDropDownOption(timeDropdown, "Minutes", 60)
    XYZUI.AddDropDownOption(timeDropdown, "Hours", 60*60)
    XYZUI.AddDropDownOption(timeDropdown, "Days", 60*60*24)
    XYZUI.AddDropDownOption(timeDropdown, "Weeks", 60*60*24*7)

    -- Create listing
	local btn = XYZUI.ButtonInput(shell, "Create Listing", function(self)
		local name = nameEntry:GetText()
		if name == "" then return end

		local model = modelEntry:GetText()
		if model == "" then return end

		local price = priceEntry:GetText()
		if price == "" then return end
		if tonumber(price) <= 0 then return end

		local quantity = quantityEntry:GetText()
		if quantity == "" then return end
		if tonumber(quantity) <= 0 then return end

		local _, itemType = typeDropdown:GetSelected()
		if not itemType then return end

		local class = classEntry:GetText()
		if class == "" then return end

		local time = timeEntry:GetText()
		if time == "" then return end
		time = tonumber(time)
		local _, timeType = timeDropdown:GetSelected()
		if not timeType then return end
		time = time * timeType
		if time <= 0 then return end

		net.Start("AuctionHouse:Create:Admin")
			net.WriteString(name)
			net.WriteString(model)
			net.WriteUInt(quantity, 7)
			net.WriteUInt(price, 32)
			net.WriteString(itemType)
			net.WriteString(class)
			net.WriteUInt(time, 32)
		net.SendToServer()

		frame:Close()
	end)
	btn:Dock(BOTTOM)
end

net.Receive("AuctionHouse:UI:Admin", AuctionHouse.Core.AdminUI)