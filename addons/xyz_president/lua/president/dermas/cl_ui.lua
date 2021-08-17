net.Receive("XYZ_PRES_OPEN_TAX", function()
	local taxRateI = net.ReadInt(16)

	local frame = XYZUI.Frame("President Computer", Color(0, 155, 100))
	frame:SetSize(ScrW() * 0.85, ScrH() * 0.8)
	frame:Center()

	local shell = XYZUI.Container(frame)
	local navBar = XYZUI.NavBar(frame)

	XYZUI.AddNavBarPage(navBar, shell, "Management", function(shell)
		XYZUI.PanelText(shell, "Tax Rate", 35, TEXT_ALIGN_CENTER)
		:DockMargin(5, 5, 5, 5)
		local taxRate, cont = XYZUI.TextInput(shell)
		cont:DockMargin(10, 0, 10, 5)
		taxRate:SetNumeric(true)
		taxRate:SetText(taxRateI)
		taxRate.OnChange = function(self)
			if self:GetText() == "" then
				self:SetText(0)
			elseif self:GetText() == "-" then
				self:SetText(0)
			elseif tonumber(self:GetText()) > 90 then
				self:SetText(90)
			elseif tonumber(self:GetText()) < 0 then
				self:SetText(0)
			end
		end

		XYZUI.ButtonInput(shell, "Set Rate", function()
			net.Start("XYZ_PRES_UP_TAX")
			net.WriteInt(taxRate:GetValue(), 16)
			net.SendToServer()
			frame:Close()
		end)
		:DockMargin(10, 5, 10, 0)

		XYZUI.PanelText(shell, "Broadcast", 35, TEXT_ALIGN_CENTER)
		:DockMargin(5, 5, 5, 5)
		local broadcast, bcont = XYZUI.TextInput(shell)
		bcont:DockMargin(10, 0, 10, 5)

		XYZUI.ButtonInput(shell, "Broadcast Message", function()
			RunConsoleCommand("say", "/broadcast "..broadcast:GetText())
		end)
		:DockMargin(10, 5, 10, 0)

		XYZUI.PanelText(shell, "Lottery", 35, TEXT_ALIGN_CENTER)
		:DockMargin(5, 5, 5, 5)
		local lottery, lcont = XYZUI.TextInput(shell)
		lcont:DockMargin(10, 0, 10, 5)
		lottery:SetNumeric(true)
		lottery:SetText(1000)
		lottery.OnChange = function(self)
			if self:GetText() == "" then
				self:SetText(0)
			elseif self:GetText() == "-" then
				self:SetText(0)
			elseif tonumber(self:GetText()) < 0 then
				self:SetText(1000)
			end
		end

		XYZUI.ButtonInput(shell, "Start Lottery", function()
			RunConsoleCommand("DarkRP", "lottery", lottery:GetValue())
		end)
		:DockMargin(10, 5, 10, 0)

		local payout = XYZUI.ButtonInput(shell, "(Un)lockdown", function()
			if GetGlobalBool("DarkRP_LockDown") then
				RunConsoleCommand("DarkRP", "unlockdown")
			else 
				RunConsoleCommand("DarkRP", "lockdown")
			end
		end)
		payout:Dock(BOTTOM)
		payout:DockMargin(10, 5, 10, 10)

		local payout = XYZUI.ButtonInput(shell, "Payout Funds", function()
			net.Start("tax_office_payout")
			net.SendToServer()
			frame:Close()
		end)
		payout:Dock(BOTTOM)
		payout:DockMargin(10, 5, 10, 10)

		local chosenPlayer = nil
		XYZUI.PanelText(shell, "License Management", 35, TEXT_ALIGN_CENTER)
		:DockMargin(5, 5, 5, 5)
		local dropdown = XYZUI.DropDownList(shell, "Select a player to give/revoke license", function(name, value)
			chosenPlayer = value
		end)
		dropdown:DockMargin(10, 0, 10, 5)

		for k, v in pairs(player.GetAll()) do
			if v == LocalPlayer() then continue end
			if v:getDarkRPVar("HasGunlicense") then
				XYZUI.AddDropDownOption(dropdown, v:Nick().." (has license)", v)
			else
				XYZUI.AddDropDownOption(dropdown, v:Nick(), v)
			end
		end

		local licenseBtn = XYZUI.ButtonInput(shell, "Give/Revoke License", function()
			net.Start("XYZ_PRES_MANAGE_LICENSE")
			net.WriteEntity(chosenPlayer)
			net.SendToServer()
			frame:Close()
		end)
		licenseBtn:DockMargin(10, 5, 10, 10)
	end)
	XYZUI.AddNavBarPage(navBar, shell, "Laws", function(shell)
		local _, contList = XYZUI.Lists(shell, 1)
		contList:DockPadding(5, 5, 5, 5)

		XYZUI.PanelText(contList, "Add Law", 35, TEXT_ALIGN_CENTER)
		:DockMargin(5, 5, 5, 5)
		local addlaw, alcont = XYZUI.TextInput(contList)
		alcont:DockMargin(10, 0, 10, 5)
		XYZUI.ButtonInput(contList, "Add", function()
			RunConsoleCommand("DarkRP", "addlaw", addlaw:GetValue())
			frame:Close()
		end)
		:DockMargin(10, 5, 10, 0)

		for k, v in pairs(DarkRP.getLaws()) do
			local card = XYZUI.Card(contList, 80)
			card:DockMargin(0, 0, 0, 5)

			local law = XYZUI.PanelText(card, v, 30, TEXT_ALIGN_CENTER)
			law:Dock(FILL)

			local removeLaw = XYZUI.ButtonInput(card, "X", function()
				RunConsoleCommand("DarkRP", "removelaw", k)
				frame:Close()
			end)
			removeLaw:Dock(RIGHT)
			removeLaw:SetWide(frame:GetWide() * 0.04)
			removeLaw:DockMargin(10, 10, 10, 10)
		end
	end)
		XYZUI.AddNavBarPage(navBar, shell, "Wanted", function(shell)
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
	end)
end)