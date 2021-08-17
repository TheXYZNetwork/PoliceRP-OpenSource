local draw_box = draw.RoundedBox
local headerShader = Color(0, 0, 0, 55)
local headerDefault = Color(2, 108, 254)
local backgroundColor = Color(18, 18, 18)

local PANEL = {}

AccessorFunc(PANEL, "horizontalMargin", "HorizontalMargin", FORCE_NUMBER)
AccessorFunc(PANEL, "verticalMargin", "VerticalMargin", FORCE_NUMBER)
AccessorFunc(PANEL, "columns", "Columns", FORCE_NUMBER)

function PANEL:Init()
	self:SetHorizontalMargin(0)
	self:SetVerticalMargin(0)

	self.Rows = {}
	self.Cells = {}
end

function PANEL:AddCell(pnl)
	local cols = self:GetColumns()
	local idx = math.floor(#self.Cells/cols)+1
	self.Rows[idx] = self.Rows[idx] || self:CreateRow()

	local margin = self:GetHorizontalMargin()
	
	pnl:SetParent(self.Rows[idx])
	pnl:Dock(LEFT)
	pnl:DockMargin(0, 0, #self.Rows[idx].Items+1 < cols && self:GetHorizontalMargin() || 0, 0)
	pnl:SetWide((self:GetWide()-margin*(cols-1))/cols)

	table.insert(self.Rows[idx].Items, pnl)
	table.insert(self.Cells, pnl)
	self:CalculateRowHeight(self.Rows[idx])
end

function PANEL:CreateRow()
	local row = self:Add("DPanel")
	row:Dock(TOP)
	row:DockMargin(0, 0, 0, self:GetVerticalMargin())
	row.Paint = nil
	row.Items = {}
	return row
end

function PANEL:CalculateRowHeight(row)
	local height = 0

	for k, v in pairs(row.Items) do
		height = math.max(height, v:GetTall())
	end

	row:SetTall(height)
end

function PANEL:Skip()
	local cell = vgui.Create("DPanel")
	cell.Paint = nil
	self:AddCell(cell)
end

function PANEL:Clear()
	for _, row in pairs(self.Rows) do
		for _, cell in pairs(row.Items) do
			cell:Remove()
		end
		row:Remove()
	end

	self.Cells, self.Rows = {}, {}
end

PANEL.OnRemove = PANEL.Clear

vgui.Register("ThreeGrid", PANEL, "DScrollPanel")

local headerShader = Color(0, 0, 0, 55)
local saleRed = Color(200, 0, 0)
local draw_box = draw.RoundedBox

function xStore.Core.BuildCard(card, item)
	card:Dock(TOP)
	card:SetSize(card.parent:GetWide(), 110)

	if item.sale then
		local saleBanner = vgui.Create("DPanel", card)
		saleBanner:Dock(TOP)
		saleBanner:SetTall(26)

		local msg = "ON SALE, "..(100*item.sale).."% OFF"
		surface.SetFont("xyz_ui_main_font_18")
		local textSize, _ = surface.GetTextSize(msg)

		saleBanner.Paint = function(self, w, h)
			draw_box(0, 0, 0, w, h, saleRed)
			draw_box(0, 0, 0, w, 5, headerShader)
			draw_box(0, 0, h-5, w, 5, headerShader)

			XYZUI.DrawText(msg, 18, (w+(textSize) - (CurTime()*20)%(w+(textSize))) - (textSize/2), h/2, white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end
	end

	local a = XYZUI.Title(card, item.name, string.Comma((isfunction(item.price) and item.price(ply)) or item.price).." credits", 27, 23, true)
	a:DockMargin(5, 0, 5, 0)
	a:Dock(TOP)
	a:SetTall(50)

	if item.sale then
		a.subTitle = "[-"..100*item.sale.."%] "..string.Comma(((isfunction(item.price) and item.price(ply)) or item.price)*(1-item.sale)).." credits"
	end

	if item.model or item.image then
		card:SetSize(card.parent:GetWide(), card.parent:GetTall())
		local cardOldPaint = card.Paint
		card.Paint = function(self, w, h)
			cardOldPaint(self, w, h)

			if not IsValid(self.model) then
				self.model = vgui.Create("DModelPanel", card)
				self.model:SetSize(w, card.parent:GetTall()-110)
				self.model:Dock(FILL)
				self.model:DockMargin(2, 2, 2, 2)
				self.model:SetModel(item.model)
				--function b.model:LayoutEntity( Entity ) return end
			
				-- *|* Credit: https://wiki.garrysmod.com/page/DModelPanel/SetCamPos
				local mn, mx = self.model.Entity:GetRenderBounds()
				local size = 0
				size = math.max( size, math.abs( mn.x ) + math.abs( mx.x ) )
				size = math.max( size, math.abs( mn.y ) + math.abs( mx.y ) )
				size = math.max( size, math.abs( mn.z ) + math.abs( mx.z ) )
				self.model:SetFOV(60)
				self.model:SetCamPos( Vector( size+4, size+4, size+4 ) )
				self.model:SetLookAt( ( mn + mx ) * 0.5 )
				-- *|*
			end
		end
	elseif item.desc then
		card:SetSize(card.parent:GetWide(), card.parent:GetTall())
		local desc = vgui.Create("DHTML", card)
		desc:Dock(FILL)
		desc:SetHTML([[
<head>
<style>
body::-webkit-scrollbar {
  width: 5px;
}
 
body::-webkit-scrollbar-track {
  box-shadow: inset 0 0 6px rgba(0, 0, 0, 0.3);
}
 
body::-webkit-scrollbar-thumb {
  background-color: rgba(55, 55, 55, 1);
}
p {
	color: white;
	font-family:Roboto;
	font-weight: 100;
	font-size: 15px;
	white-space: pre-line;
}
</style>
</head>
<body><p>]]..item.desc..[[</p></body]])
		desc:DockMargin(5, 5, 5, 5)

--		local desc = XYZUI.WrappedText(card, item.desc, 25)
--		desc:Dock(TOP)
--		desc:SizeToContents()

--		local desc = vgui.Create("RichText", card)
--		desc:Dock(FILL)
--		desc:AppendText(item.desc)
--		desc:DockMargin(5, 5, 5, 5)
--		desc:SetVerticalScrollbarEnabled(true)
--		function desc:PerformLayout()
--			self:SetFontInternal("xyz_ui_main_font_15")
--			self:SetFGColor(Color(255, 255, 255))
--		end
	end

	local buy = XYZUI.ButtonInput(card, "Purchase", function()
		--xStore.Core.ConfirmPurchase(item)
		XYZUI.Confirm("Purchase "..item.name, Color(0, 155, 0), function()
			net.Start("xStorePurchaseItem")
				net.WriteString(item.id)
			net.SendToServer()
		end)
	end)
	buy:Dock(BOTTOM)
	buy.headerColor = Color(40, 174, 20)
	card.buyButton = buy

	return card
end

function xStore.Core.CreatListing()
	local background = vgui.Create("DFrame")
	background:SetSize(ScrW(), ScrH())
	background:MakePopup()
	background:SetTitle("")
	background:SetDraggable(false)
	background:ShowCloseButton(false)
	background.Paint = function(self, w, h)
		XYZUI.DrawBlur(0, 0, w, h, 3)
	end
	
	local listingFrame = XYZUI.Frame("Create Listing", Color(100, 0, 200))
	listingFrame:SetSize(background:GetTall()*0.75, background:GetTall()*0.50)
	listingFrame:Center()
	listingFrame:SetParent(background)
	listingFrame.OnClose = function()
		background:Remove()
	end
	function listingFrame:Think()
		self:MoveToFront()
	end

	local cont = XYZUI.Container(listingFrame)
		-- Amount of credits to list
		local amountCreditsTitle = XYZUI.Title(cont, "How many credits to list for sale:", nil, 30)
		local amountCreditsEntry, _ = XYZUI.TextInput(cont)
		amountCreditsEntry:SetNumeric(true)
		amountCreditsEntry:SetText(100)
		_:DockMargin(5, -5, 5, 5)

		local amountMoneyTitle = XYZUI.Title(cont, "How much they should cost (in-game money):", nil, 30)
		local amountMoneyEntry, _ = XYZUI.TextInput(cont)
		amountMoneyEntry:SetNumeric(true)
		amountMoneyEntry:SetText(1000000)
		_:DockMargin(5, -5, 5, 5)
		local amountMoneyAccountedTitle = XYZUI.Title(cont, "There is a 5% commission fee, this is how much you will receive:", nil, 30)
		local amountMoneyAccountedEntry, _ = XYZUI.TextInput(cont)
		amountMoneyAccountedEntry:SetNumeric(true)
		amountMoneyAccountedEntry:SetText(950000)
		amountMoneyAccountedEntry:SetEditable(false)
		_:DockMargin(5, -5, 5, 5)
		amountMoneyEntry.OnChange = function(self)
			if self:GetText() == "" then return end
			amountMoneyAccountedEntry:SetText(math.floor((tonumber(self:GetText()) or 0)*0.95))
		end

		local confirmListingButton = XYZUI.ButtonInput(cont, "Place listing", function(self)
			if tonumber(amountCreditsEntry:GetText()) < 10 then
				XYZShit.Msg("xStore", Color(55, 55, 55), "You must sell at least 10 credits in your listing!")
				return
			end
			if tonumber(amountMoneyEntry:GetText()) < 1000 then
				XYZShit.Msg("xStore", Color(55, 55, 55), "You must charge at least $1,000 for your credits!")
				return
			end
			XYZUI.Confirm("List credits?", Color(0, 155, 0), function()
				if (not IsValid(amountCreditsEntry)) and (not IsValid(amountMoneyEntry)) then return end
				net.Start("xStoreCreateListing")
					net.WriteInt(amountCreditsEntry:GetText(), 32)
					net.WriteInt(amountMoneyEntry:GetText(), 32)
				net.SendToServer()

				background:Close()
				xStore.Core.Frame:Close()
			end)
		end)
		confirmListingButton:DockMargin(5, -5, 5, 5)
		confirmListingButton:Dock(BOTTOM)
end

function xStore.Core.CreateClass(key, data)
	local background = vgui.Create("DFrame")
	background:SetSize(ScrW(), ScrH())
	background:MakePopup()
	background:SetTitle("")
	background:SetDraggable(false)
	background:ShowCloseButton(false)
	background.Paint = function(self, w, h)
		XYZUI.DrawBlur(0, 0, w, h, 3)
	end
	
	local listingFrame = XYZUI.Frame("Create Class", Color(200, 0, 200))
	listingFrame:SetSize(background:GetTall()*0.6, background:GetTall()*0.85)
	listingFrame:Center()
	listingFrame:SetParent(background)
	listingFrame.OnClose = function()
		background:Remove()
	end
	function listingFrame:Think()
		self:MoveToFront()
	end

	local cont = XYZUI.Container(listingFrame)
	cont:Dock(FILL)
		-- The name of the class
		local className = XYZUI.Title(cont, "Name:", nil, 30)
		local classNameEntry, _ = XYZUI.TextInput(cont)
		classNameEntry:SetText(data and data.name or "The Destroyer")
		_:DockMargin(5, -10, 5, 5)

		-- Class model
		local classModel = XYZUI.Title(cont, "Model:", nil, 30)
		local activeModel = nil
		local card = XYZUI.Card(cont, 200)
		card:DockPadding(3, 12, 3, 3)
		card:DockMargin(5, -10, 5, 5)
		local isPremium = false
		timer.Simple(0, function() -- Cus gmod
			local classModelList = vgui.Create("ThreeGrid", card)
				classModelList:Dock(FILL)
				classModelList:InvalidateParent(true)
				classModelList:SetColumns(8)
					local sbar = classModelList:GetVBar()
					sbar:SetWide(sbar:GetWide()/2)
					sbar:SetHideButtons(true)
					function sbar:Paint(w, h)
						draw_box(0, 0, 0, w, h, backgroundColor)
					end
					function sbar.btnGrip:Paint(w, h)
						draw_box(0, 0, 0, w, h, classModelList.headerColor or headerDefault)
						draw_box(0, 0, 0, w, h, headerShader)
					end
			classModelList:DockMargin(5, -5, 5, 5)
	
			local allModel = {} 
			table.Add(allModel, xStore.Config.CC.PremiumModels)
			table.Add(allModel, xStore.Config.CC.Models)
			
			for k, v in pairs(allModel) do
				local card = XYZUI.Card(contList, cont:GetWide()/8)
				card:DockMargin(5, 5, 5, 5)
				card.model = v
				local gold = Color(212, 175, 55)
				card.Paint = function(self, w, h)
					if table.HasValue(xStore.Config.CC.PremiumModels, v) then
						draw_box(0, 0, 0, w, h, gold)
					end
					if self == activeModel then
						draw_box(0, 0, 0, w, 2, listingFrame.headerColor)
						draw_box(0, 0, h-2, w, 2, listingFrame.headerColor)
						draw_box(0, 0, 0, 2, h, listingFrame.headerColor)
						draw_box(0, w-2, 0, 2, h, listingFrame.headerColor)
					end
				end
				
				activeModel = activeModel or card
				if data and data.model then
					if v == data.model then
						activeModel = card
					end
				end

				classModelList:AddCell(card)
					local model = vgui.Create("DModelPanel", card)
					model:SetSize(card:GetTall(), card:GetTall())
					model:Dock(FILL)
					model:SetModel(v)
					model:DockMargin(2, 2, 2, 2)
					model:SetFOV(70)
						-- *|* Credit: https://wiki.facepunch.com/gmod/DModelPanel:SetCamPos
						function model:LayoutEntity(ent)
							--if not model.animation then
							--	model.animation = table.Random({"menu_walk", "idle_all_01"})
							--end
							--ent:SetSequence(model.animation)
							--model:RunAnimation()
						end
	
						local eyepos = model.Entity:GetBonePosition(model.Entity:LookupBone("ValveBiped.Bip01_Head1") or 0)
						if not model.Entity:LookupBone("ValveBiped.Bip01_Head1") then
							eyepos = eyepos + Vector(0, 0, 25)
						end
						model:SetLookAt(eyepos)
						model:SetCamPos(eyepos-Vector(-17, 0, 0))	-- Move cam in front of eyes
						model.Entity:SetEyeTarget(eyepos-Vector(-12, 0, 0))
						-- *|*
					model.DoClick = function()
						activeModel = card
						if table.HasValue(xStore.Config.CC.PremiumModels, v) then
							isPremium = true
						else
							isPremium = false
						end
					end
			end
		end)

		-- Max slots
		local classSlots = XYZUI.Title(cont, "Slots:", nil, 30)
		local classSlotsEntry = XYZUI.DropDownList(cont, "How many slots?")
		classSlotsEntry:DockMargin(5, -10, 5, 5)

		if data and data.slots then
			XYZUI.AddDropDownOption(classSlotsEntry, data.slots.." Slot", data.slots) -- 1 slot is free
			classSlotsEntry.selected = classSlotsEntry.options[1]
			local count = 0
			for i=data.slots+1, xStore.Config.CC.MaxSlots do
				count = count + 1
				XYZUI.AddDropDownOption(classSlotsEntry, i.." Slots - "..string.Comma(xStore.Config.CC.SlotPrice * count).." Credits", i)
			end
		else
			XYZUI.AddDropDownOption(classSlotsEntry, "1 Slot", 1) -- 1 slot is free
			for i=2, xStore.Config.CC.MaxSlots do
				XYZUI.AddDropDownOption(classSlotsEntry, i.." Slots - "..string.Comma(xStore.Config.CC.SlotPrice * (i-1)).." Credits", i)
			end
		end

		-- Weapons
		local wepList = {}
		local _, classWeaponsList
		local classWeapons = XYZUI.Title(cont, "Weapons:", nil, 30)
		local classWeaponsEntry = XYZUI.DropDownList(cont, "Choose wisely!", function(name, value)
			if wepList[value] then return end

			wepList[value] = true
    		local pnl = vgui.Create("DPanel", classWeaponsList)
			pnl:Dock(TOP)
			pnl:SetTall(40)
			pnl.Paint = function(self, w, h)
				XYZUI.DrawText(name, 35, 5, h*0.5, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
			end
			local btn = XYZUI.ButtonInput(pnl, "X", function(self)
				pnl:Remove()
				wepList[value] = nil
			end)
			btn:Dock(RIGHT)
			btn:DockMargin(0, 5, 5, 0)
			btn:SetWide(30)
			btn.headerColor = Color(150, 0, 0)
			btn.usable = true
		end)
		classWeaponsEntry:DockMargin(5, -10, 5, 5)
		for k, v in pairs(xStore.Config.CC.Weapons) do
			local wep = weapons.Get(k)
			if not wep then continue end
			XYZUI.AddDropDownOption(classWeaponsEntry, wep.PrintName.." - "..string.Comma(v).." Credits", k)
		end
		_, classWeaponsList = XYZUI.Lists(cont, 1)
		classWeaponsList:Dock(FILL)
		classWeaponsList:DockMargin(5, 0, 5, 10)

		local originalWeps = {}
		if data and data.weps then
			for k, v in pairs(data.weps) do
				originalWeps[v] = true
				local wep = weapons.Get(v)
				if not wep then continue end


				wepList[v] = true
    			local pnl = vgui.Create("DPanel", classWeaponsList)
				pnl:Dock(TOP)
				pnl:SetTall(40)
				pnl.Paint = function(self, w, h)
					XYZUI.DrawText(wep.PrintName, 35, 5, h*0.5, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
				end
				local btn = XYZUI.ButtonInput(pnl, "X", function(self)
					pnl:Remove()
					wepList[v] = nil
				end)
				btn:Dock(RIGHT)
				btn:DockMargin(0, 5, 5, 0)
				btn:SetWide(30)
				btn.headerColor = Color(150, 0, 0)
				btn.usable = true
			end
		end


		local confirmButton = XYZUI.ButtonInput(cont, "Create Class", function(self)
			if key then
				XYZUI.Confirm("Edit Class?", Color(0, 155, 0), function()
					net.Start("xStoreEditClass")
						net.WriteUInt(key, 10)
						net.WriteString(classNameEntry:GetText())
						net.WriteString(activeModel.model)
						net.WriteUInt(classSlotsEntry.selected and classSlotsEntry.selected.value or 1, 3)
						net.WriteTable(wepList)
					net.SendToServer()
					background:Close()
					xStore.Core.Frame:Close()
				end)
			else
				XYZUI.Confirm("Purchase Class?", Color(0, 155, 0), function()
					net.Start("xStoreCreateClass")
						net.WriteString(classNameEntry:GetText())
						net.WriteString(activeModel.model)
						net.WriteUInt(classSlotsEntry.selected and classSlotsEntry.selected.value or 1, 3)
						net.WriteTable(wepList)
					net.SendToServer()

					background:Close()
					xStore.Core.Frame:Close()
				end)
			end
		end)
		confirmButton:DockMargin(5, -5, 5, 5)
		confirmButton:Dock(BOTTOM)
		confirmButton.Think = function()
			if not activeModel then return end
			
			if key then 
				local grandTotal = 0

				if classSlotsEntry.selected then
					grandTotal = grandTotal + ((classSlotsEntry.selected.value - data.slots) * xStore.Config.CC.SlotPrice)
				end

				if (not (data.model == activeModel.model)) and isPremium then
					grandTotal = grandTotal + xStore.Config.CC.PremiumCost
				end

				for k, v in pairs(wepList) do
					if originalWeps[k] then continue end
					grandTotal = grandTotal + xStore.Config.CC.Weapons[k]
				end

				if (grandTotal > 0) or not (classNameEntry:GetText() == data.name) or not (activeModel.model == data.model) then
					grandTotal = grandTotal + xStore.Config.CC.EditFee -- Edit fee
				end

				confirmButton.disText = "Edit Class - "..string.Comma(grandTotal).." Credits"
				grandTotal = nil
			else
				local grandTotal = xStore.Config.CC.BasePrice
				
				if classSlotsEntry.selected then
					grandTotal = grandTotal + ((classSlotsEntry.selected.value - 1) * xStore.Config.CC.SlotPrice)
				end

				if isPremium then
					grandTotal = grandTotal + xStore.Config.CC.PremiumCost
				end
				
				for k, v in pairs(wepList) do
					grandTotal = grandTotal + xStore.Config.CC.Weapons[k]
				end
	
				confirmButton.disText = "Create Class - "..string.Comma(grandTotal).." Credits"
				grandTotal = nil
			end
		end
end



function xStore.Core.ClassAccess(key, data)
	local background = vgui.Create("DFrame")
	background:SetSize(ScrW(), ScrH())
	background:MakePopup()
	background:SetTitle("")
	background:SetDraggable(false)
	background:ShowCloseButton(false)
	background.Paint = function(self, w, h)
		XYZUI.DrawBlur(0, 0, w, h, 3)
	end
	
	local listingFrame = XYZUI.Frame("Class Access", Color(200, 0, 200))
	listingFrame:SetSize(background:GetTall()*0.6, background:GetTall()*0.85)
	listingFrame:Center()
	listingFrame:SetParent(background)
	listingFrame.OnClose = function()
		background:Remove()
	end
	function listingFrame:Think()
		self:MoveToFront()
	end

	local cont = XYZUI.Container(listingFrame)
	cont:Dock(FILL)
		-- The name of the class
		local steamID = XYZUI.Title(cont, "SteamID To Add:", nil, 30)
		local steamIDEntry, _ = XYZUI.TextInput(cont)
		_:DockMargin(5, -10, 5, 5)
		local steamIDButton = XYZUI.ButtonInput(cont, "Add User", function(self)
			if steamIDEntry:GetText() == "" then return end
			if table.Count(data.access) >= (data.slots - 1) then
				XYZShit.Msg("xStore", Color(55, 55, 55), "There are currently no free slots for this custom class!")
				return
			end
			local id64 = xStore.Core.ValidateToID64(steamIDEntry:GetText())
			if not id64 then return end

			steamworks.RequestPlayerInfo(id64, function(name)
				XYZUI.Confirm("Add "..name.."?", Color(0, 155, 0), function()
					net.Start("xStoreGiveClassAccess")
						net.WriteUInt(key, 10)
						net.WriteString(id64)
					net.SendToServer()
		
					background:Close()
					xStore.Core.Frame:Close()
				end)
			end)
		end)
		steamIDButton:DockMargin(5, 0, 5, 5)

		local _, currentAccess = XYZUI.Lists(cont, 1)
		currentAccess:Dock(FILL)
		currentAccess:DockMargin(5, 0, 5, 5)

		for k, v in pairs(data.access) do
    		local pnl = vgui.Create("DPanel", currentAccess)
			pnl:Dock(TOP)
			pnl:SetTall(40)
			pnl.name = k
			pnl.Paint = function(self, w, h)
				XYZUI.DrawText(self.name, 35, 5, h*0.5, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
			end
			steamworks.RequestPlayerInfo(k, function(name)
				pnl.name = name
			end)
			local btn = XYZUI.ButtonInput(pnl, "Remove", function(self)
				XYZUI.Confirm("Remove "..pnl.name.." for "..xStore.Config.CC.RemoveAccessFee.." credits?", Color(155, 0, 0), function()
					net.Start("xStoreRemoveClassAccess")
						net.WriteUInt(key, 10)
						net.WriteString(k)
					net.SendToServer()

					background:Close()
					xStore.Core.Frame:Close()
				end)
			end)
			btn:Dock(RIGHT)
			btn:DockMargin(0, 5, 5, 0)
			btn:SetWide(70)
			btn.headerColor = Color(150, 0, 0)
			btn.usable = true
		end
end

function xStore.Core.UI()
	if IsValid(xStore.Core.Frame) then
		xStore.Core.Frame:Close()
	end

	local credits = net.ReadInt(32)
	local myItems = net.ReadTable()
	local activeListings = net.ReadTable()
	local myClasses = net.ReadTable()

	local quickItems = {}
	for k, v in pairs(myItems) do
		quickItems[v.item] = true
	end

	-- Core creation
	xStore.Core.Frame = XYZUI.Frame("xStore", Color(55, 55, 55))
	local frame = xStore.Core.Frame
	frame:SetSize(ScrH()*0.9, ScrH()*0.9)
	frame:Center()

	-- If no credits (attempt to) open store in steam overlay
	if credits == 0 then gui.OpenURL("https://store.thexyznetwork.xyz") end

	-- Credits
	local header = XYZUI.Container(frame)
	header:Dock(TOP)
	header:SetTall(40)
	header.Paint = function() end


    local navBar = XYZUI.NavBar(header)
    navBar:Dock(FILL)
    navBar:DockMargin(0, 0, 0, 0)


    local creditPadder = vgui.Create("DPanel", header)
	creditPadder:Dock(RIGHT)
	creditPadder:SetWide(frame:GetWide()/5)
	creditPadder.Paint = function() end
	
	local reloadCredits = vgui.Create("DButton", creditPadder)
	--reloadCredits:SetImage("icon16/disconnect.png")
	reloadCredits:SetText("")
	reloadCredits:Dock(RIGHT)
	reloadCredits:SetSize(35, 35)
	reloadCredits.DoClick = function()
		net.Start("xStoreRefreshCredits")
		net.SendToServer()
	end
	reloadCredits.icon = Material("data/xyzcommunity/refresh.png")
	reloadCredits.rotate = 1
	reloadCredits.Paint = function(self, w, h)
		surface.SetMaterial(self.icon)
		surface.SetDrawColor(color_white)

		if self:IsHovered() then
			self.rotate = Lerp(0.07, self.rotate, 2)
		else
			self.rotate = 1
		end

		surface.DrawTexturedRectRotated(w*0.5, h*0.5, w-10, h-10, -360*reloadCredits.rotate)
	end
	local creditPnl = XYZUI.PanelText(creditPadder, "Credits: "..string.Comma(credits), 30, TEXT_ALIGN_RIGHT)


	-- The main container
	local shell = XYZUI.Container(frame)
    shell.Paint = function() end


    XYZUI.AddNavBarPage(navBar, shell, "Home", function(shell)
    	-- Featured items
    	if xStore.Config.Featured[1] then
			local textFeatured = XYZUI.PanelText(shell, "Featured Items", 40, TEXT_ALIGN_LEFT)

    		local gridFeatured = vgui.Create("ThreeGrid", shell)
			gridFeatured:Dock(TOP)
			gridFeatured:SetTall((shell:GetTall()*0.4)-40)
			gridFeatured:InvalidateParent(true)
			gridFeatured:SetColumns(3)
			gridFeatured:SetHorizontalMargin(2)

			for i=1, 3 do
				local pnl = vgui.Create("DPanel")
				gridFeatured:AddCell(pnl)
				pnl:SetTall(gridFeatured:GetTall())
				pnl.Paint = function() end


				local item = xStore.Config.Featured[i]
				if not item then continue end
				item = xStore.Config.Items[item]
				if not item then continue end


    			--if item.canPurchase and not item.canPurchase(LocalPlayer(), quickItems) then continue end
    			--if item.canSee and not item.canSee(LocalPlayer(), quickItems) then continue end

				local itemPnl = XYZUI.Container(pnl)
				itemPnl.parent = pnl
				local card = xStore.Core.BuildCard(itemPnl, item)

				if card.buyButton then
					if item.canPurchase and not item.canPurchase(LocalPlayer(), quickItems) then
						card.buyButton.headerColor = Color(50, 50, 50)
						card.buyButton.disText = "Unpurchasable"
						card.buyButton.DoClick = function()
							card.buyButton.pulseEffect.size, card.buyButton.pulseEffect.alpha, card.buyButton.pulseEffect.x, card.buyButton.pulseEffect.y = 0, 255, card.buyButton:CursorPos()
						end
					end
				end
			end
		end

		-- 8 random items
		local randomItems = {}

		for i=1, 8 do
			local selectedItem = nil
			local attempt = 0

			while ((selectedItem == nil) or randomItems[selectedItem.id]) or (selectedItem.canPurchase and not selectedItem.canPurchase(LocalPlayer(), quickItems)) or (selectedItem.canSee and not selectedItem.canSee(LocalPlayer(), quickItems)) do
				if attempt > table.Count(xStore.Config.Items) then break end
				attempt = attempt + 1

				-- Retest the loop
				selectedItem = table.Random(xStore.Config.Items)
			end

			randomItems[selectedItem.id] = selectedItem
		end

		local textRandom = XYZUI.PanelText(shell, "Random Items", 40, TEXT_ALIGN_LEFT)

    	local gridRandom = vgui.Create("ThreeGrid", shell)
		gridRandom:Dock(TOP)
		gridRandom:SetTall((shell:GetTall()*0.6)-40)
		gridRandom:InvalidateParent(true)
		gridRandom:SetColumns(4)
		gridRandom:SetHorizontalMargin(2)
		gridRandom:SetVerticalMargin(2)


		for k, v in pairs(randomItems) do
			local pnl = vgui.Create("DPanel")
			gridRandom:AddCell(pnl)
			pnl:SetTall((gridRandom:GetTall()/2)-2)
			pnl.Paint = function() end

			local itemPnl = XYZUI.Container(pnl)
			itemPnl.parent = pnl
			xStore.Core.BuildCard(itemPnl, v)
		end
    end)

    local categories = {}
    for k, v in pairs(xStore.Config.Items) do
    	if not categories[v.category or "Other"] then
    		categories[v.category or "Other"] = {}
    	end
    	table.insert(categories[v.category or "Other"], v)
    end
    XYZUI.AddNavBarPage(navBar, shell, "Store", function(shell)

    	-- The search stuff
		local card = XYZUI.Card(shell, 40)
		card:InvalidateParent(true)
		card:DockMargin(0, 0, 0, 5)
		local searchTag = XYZUI.Title(card, "Search the store:", "", 30)
		local searchInput, searchContainer = XYZUI.TextInput(card)
		searchContainer:SetWide(card:GetWide()/3)
		searchTag:SetWide(400)
		searchTag:Dock(LEFT)
		searchContainer:Dock(RIGHT)

		-- The items list shell
    	local _, shellList = XYZUI.Lists(shell, 1)
    	shellList.Paint = function(self, w, h)
    	end

    	-- On each input, clear the list of items and reapply them with the search
		searchInput.OnChange = function(text)
			shellList:Clear()
			local searchWord = text:GetText()

			for k, v in pairs(categories) do
	    		local seeableCount = 0 
	    		for n, m in pairs(v) do
	    			--if m.canPurchase and not m.canPurchase(LocalPlayer(), quickItems) then continue end -- Instead show the button as unbuyable
	    			if m.canSee and not m.canSee(LocalPlayer(), quickItems) then continue end
	    			if m.legacy then continue end

	    			-- There is a search word we need to match
	    			if not (searchWord == "") then
	    				if not string.find(string.lower(m.name), string.lower(searchWord)) then continue end
	    			end

	    			seeableCount = seeableCount + 1
	    		end

	    		if #v == 0 then continue end
	    		if seeableCount == 0 then continue end
				local body, header, mainCont = XYZUI.ExpandableCard(shellList, k)
				mainCont:InvalidateParent(true)
				mainCont:DockMargin(0, 0, 0, 5)

	    		local itemsGrid = vgui.Create("ThreeGrid", body)
				itemsGrid:Dock(TOP)
				itemsGrid:SetTall(math.ceil(seeableCount/3)*222)
				itemsGrid:SetWide(body:GetWide())
				itemsGrid:InvalidateParent(true)
				itemsGrid:SetColumns(3)
				itemsGrid:SetHorizontalMargin(2)
				itemsGrid:SetVerticalMargin(2)

	    		timer.Simple(0, function()
	    			if not IsValid(itemsGrid) then return end
					for n, m in pairs(v) do
	    				--if m.canPurchase and not m.canPurchase(LocalPlayer(), quickItems) then continue end -- Instead show the button as unbuyable
	    				if m.canSee and not m.canSee(LocalPlayer(), quickItems) then continue end
	    				if m.legacy then continue end
		    			if not (searchWord == "") then
		    				if not string.find(string.lower(m.name), string.lower(searchWord)) then continue end
		    			end

						local pnl = vgui.Create("DPanel")
						pnl:SetTall(220)
						pnl.Paint = function() end
						itemsGrid:AddCell(pnl)
						--pnl:SetWide(itemsGrid:GetWide()/3-4) -- Used to drop the scroll bar from blocking it, not gonna use for now
			
						local itemPnl = XYZUI.Container(pnl)
						itemPnl.parent = pnl
						local card = xStore.Core.BuildCard(itemPnl, m)
						if card.buyButton then
							if m.canPurchase and not m.canPurchase(LocalPlayer(), quickItems) then
								card.buyButton.headerColor = Color(50, 50, 50)
								card.buyButton.disText = "Unpurchasable"
								card.buyButton.DoClick = function()
									card.buyButton.pulseEffect.size, card.buyButton.pulseEffect.alpha, card.buyButton.pulseEffect.x, card.buyButton.pulseEffect.y = 0, 255, card.buyButton:CursorPos()
								end
							end
						end
					end
	    		end)


				XYZUI.AddToExpandableCardBody(mainCont, itemsGrid)
	    	end
		end
		searchInput.OnChange(searchInput)
    end)

    XYZUI.AddNavBarPage(navBar, shell, "Credit Market", function(shell)
    	local _, shellList = XYZUI.Lists(shell, 1)

    	local headers = vgui.Create("DPanel", shell)
		headers:Dock(TOP)
		headers:SetTall(40)
		headers.Paint = function(self, w, h)
			XYZUI.DrawText("Credits Offered", 35, 5, h*0.5, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
			XYZUI.DrawText("Price (In-game money)", 35, w*0.5, h*0.5, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			--XYZUI.DrawText("Date Listed (d/m/y)", 35, w*0.66, h*0.5, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			XYZUI.DrawText("Action", 35, w-5, h*0.5, color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
		end

		--xStore.Listings
		for k, v in pairs(activeListings) do
    		local pnl = vgui.Create("DPanel", shellList)
			pnl:Dock(TOP)
			pnl:SetTall(40)
			pnl.Paint = function(self, w, h)
				XYZUI.DrawText(string.Comma(v.credits) or v.item, 35, 5, h*0.5, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
				XYZUI.DrawText("$"..string.Comma(v.cost), 35, w*0.5, h*0.5, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				--XYZUI.DrawText(os.date("%d/%m/%Y" , v.created), 35, w*0.66, h*0.5, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			end

			if (v.lister == LocalPlayer():SteamID64()) then
				local remove = XYZUI.ButtonInput(pnl, "Remove", function(self)
					XYZUI.Confirm("Remove Listing?", Color(200, 0, 0), function()
						net.Start("xStoreRemoveListing")
							net.WriteInt(k, 32)
						net.SendToServer()
						pnl:Remove()
					end)
				end)
				remove:Dock(RIGHT)
				remove:DockMargin(0, 5, 5, 0)
				remove:SetWide(80)
				remove.headerColor = Color(200, 0, 0)
			else
				local purchase = XYZUI.ButtonInput(pnl, "Purchase", function(self)
					if not ply:canAfford(v.cost) then
						XYZShit.Msg("xStore", Color(55, 55, 55), "You can't afford this!")
						return
					end
					XYZUI.Confirm("Purchase Listing?", Color(0, 200, 0), function()
						net.Start("xStorePurchaseListing")
							net.WriteInt(k, 32)
						net.SendToServer()
	
						frame:Close()
					end)
				end)
				purchase:Dock(RIGHT)
				purchase:DockMargin(0, 5, 5, 0)
				purchase:SetWide(80)
			end
		end

    	local extra = vgui.Create("DPanel", shell)
		extra:Dock(BOTTOM)
		extra:SetTall(40)
		extra.Paint = function(self, w, h)
		end
		local addListing = XYZUI.ButtonInput(extra, "Add Listing", function(self)
			xStore.Core.CreatListing()
		end)
		addListing:Dock(RIGHT)
		addListing:DockMargin(0, 5, 5, 0)
		addListing:SetWide(100)
    end)

    XYZUI.AddNavBarPage(navBar, shell, "Custom Class", function(shell)
    	local _, shellList = XYZUI.Lists(shell, 1)

    	local headers = vgui.Create("DPanel", shell)
		headers:Dock(TOP)
		headers:SetTall(40)
		headers.Paint = function(self, w, h)
			XYZUI.DrawText("Name", 35, 5, h*0.5, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
			XYZUI.DrawText("Slots", 35, w*0.5, h*0.5, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			XYZUI.DrawText("Action", 35, w-5, h*0.5, color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
		end

		for k, v in pairs(myClasses) do
    		local pnl = vgui.Create("DPanel", shellList)
			pnl:Dock(TOP)
			pnl:SetTall(40)
			pnl.Paint = function(self, w, h)
				XYZUI.DrawText(v.name or "Unknown Name", 35, 5, h*0.5, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
				XYZUI.DrawText(((v.access and table.Count(v.access) or 0) + 1).."/"..v.slots, 35, w*0.5, h*0.5, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			end

			if (v.owner == LocalPlayer():SteamID64()) then
				local edit = XYZUI.ButtonInput(pnl, "Edit", function(self)
					xStore.Core.CreateClass(k, v)
				end)
				edit:Dock(RIGHT)
				edit:DockMargin(0, 5, 5, 0)
				edit:SetWide(45)
				edit.headerColor = Color(200, 100, 0)

				local access = XYZUI.ButtonInput(pnl, "Access", function(self)
					xStore.Core.ClassAccess(k, v)
				end)
				access:Dock(RIGHT)
				access:DockMargin(0, 5, 5, 0)
				access:SetWide(65)
				access.headerColor = Color(216, 132, 200)
			end
			local active = XYZUI.ButtonInput(pnl, "Set Active", function(self)
				net.Start("xStoreActiveClass")
					net.WriteUInt(k, 10)
				net.SendToServer()
				self.headerColor = Color(50, 50, 50)
				self.disText = "Done"
			end)
			active:Dock(RIGHT)
			active:DockMargin(0, 5, 5, 0)
			active:SetWide(85)
			active.headerColor = Color(64, 146, 64)
		end

    	local extra = vgui.Create("DPanel", shell)
		extra:Dock(BOTTOM)
		extra:SetTall(40)
		extra.Paint = function(self, w, h)
		end
		local createClass = XYZUI.ButtonInput(extra, "Create Class", function(self)
			xStore.Core.CreateClass()
		end)
		createClass:Dock(RIGHT)
		createClass:DockMargin(0, 5, 5, 0)
		createClass:SetWide(120)
    end)

    XYZUI.AddNavBarPage(navBar, shell, "My Items", function(shell)
    	local _, shellList = XYZUI.Lists(shell, 1)

    	local headers = vgui.Create("DPanel", shell)
		headers:Dock(TOP)
		headers:SetTall(40)
		headers.Paint = function(self, w, h)
			XYZUI.DrawText("Item", 35, 5, h*0.5, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
			XYZUI.DrawText("Credits Paid", 35, w*0.5, h*0.5, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			XYZUI.DrawText("Date (d/m/y)", 35, w*0.75, h*0.5, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			XYZUI.DrawText("Action", 35, w-5, h*0.5, color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
		end

		for k, v in pairs(table.Reverse(myItems)) do
			local item = xStore.Config.Items[v.item] or {}
    		local pnl = vgui.Create("DPanel", shellList)
			pnl:Dock(TOP)
			pnl:SetTall(40)
			pnl.Paint = function(self, w, h)
				XYZUI.DrawText(item.name or v.item, 35, 5, h*0.5, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
				XYZUI.DrawText(string.Comma(v.paid), 35, w*0.5, h*0.5, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				XYZUI.DrawText(os.date("%d/%m/%Y" , v.created), 35, w*0.75, h*0.5, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			end

			if item.disabable then
				local btn = XYZUI.ButtonInput(pnl, "", function(self)
					if not self.usable then return end

					if self.active then
						self.headerColor = Color(50, 50, 50)
						self.disText = "Done"
					end

					net.Start("xStoreToggleItem")
						net.WriteString(v.item)
						net.WriteBool(not self.active)
					net.SendToServer()
					
					self.usable = false
				end)
				btn:Dock(RIGHT)
				btn:DockMargin(0, 5, 5, 0)
				btn.usable = true

				if v.active then
					btn.headerColor = Color(200, 0, 0)
					btn.disText = "Disable"
					btn.active = true
				else
					btn.headerColor = Color(0, 200, 0)
					btn.disText = "Enable"
					btn.active = false
				end
			end
		end
    end)

	-- Real time update net-messages
	net.Receive("xStoreRefreshCreditsReturn", function()
		if not IsValid(frame) then return end

		credits = net.ReadInt(32)
		creditPnl.text = "Credits: "..string.Comma(credits)
		if credits == 0 then gui.OpenURL("https://store.thexyznetwork.xyz") end
	end)
end

net.Receive("xStoreOpenMenu", function()
	xStore.Core.UI()
end)

--[[
	
grid:Dock(FILL)
grid:DockMargin(4, 4, 4, 4)
grid:InvalidateParent(true)

grid:SetColumns(3)
grid:SetHorizontalMargin(2)
grid:SetVerticalMargin(2)

for i=1, 10 do
	local pnl = vgui.Create("DPanel")
	pnl:SetTall(100)
	grid:AddCell(pnl)
end
]]--