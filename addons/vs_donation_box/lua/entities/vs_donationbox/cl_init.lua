include("shared.lua")

function ENT:Draw()
	self:DrawModel()
	local ang = self:GetAngles() --+ Angle(0, 180, 0)--LocalPlayer():EyeAngles()
	local pos = self:GetPos() + (self:GetUp()*6) + (self:GetForward()*12.3)-- + (self:GetRight()*-1) + (self:GetForward()) --Vector(0, 0, 10)

	if pos:Distance(LocalPlayer():GetPos()) > 500 then return end

	ang:RotateAroundAxis(ang:Forward(), 90)
	ang:RotateAroundAxis(ang:Right(), -90)

	cam.Start3D2D(pos, ang, 0.07)
		surface.SetFont("VSDB_3d_Static")
		local ply = self:Getowning_ent()
		ply = (IsValid(ply) and ply:Nick()) or "No User Fround"

		local txt = ply.."'s"
		local amount = "Currently Holding: "..DarkRP.formatMoney(self:GetCurMoney())
		local tw, _ = surface.GetTextSize(txt)
		local aw, _ = surface.GetTextSize(amount)
		local w = 0
		if tw > aw then
			w = tw
		else
			w = aw
		end

		draw.RoundedBox(0, -330, 15, w+10, 70, Color(0, 0, 0, 200))
		draw.SimpleTextOutlined(txt, "VSDB_3d_Static", -325, 30, team.GetColor(self:Getowning_ent()), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 1, Color(0, 0, 0, 155))
		draw.SimpleTextOutlined("Donation Box", "VSDB_3d_Static", -325, 50, Color(155, 155, 155), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 1, Color(0, 0, 0, 155))
		draw.SimpleTextOutlined("Currently Holding: "..DarkRP.formatMoney(self:GetCurMoney()), "VSDB_3d_Static", -325, 70, Color(155, 155, 155), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 1, Color(0, 0, 0, 155))
	cam.End3D2D()
end

-- The function for blur panels
local blur = Material("pp/blurscreen")
local function Blur(panel, amount)
	local x, y = panel:LocalToScreen(0, 0)
	local scrW, scrH = ScrW(), ScrH()
	surface.SetDrawColor(255, 255, 255)
	surface.SetMaterial(blur)
	for i = 1, 6 do
		blur:SetFloat("$blur", (i / 3) * (amount or 6))
		blur:Recompute()
		render.UpdateScreenEffectTexture()
		surface.DrawTexturedRect(x * -1, y * -1, scrW, scrH)
	end
end


net.Receive("vs_derma_owner", function()
	local box = net.ReadEntity()
	local topDonators = net.ReadTable() or {}

	-- Creating the base panel
	local frame = vgui.Create("DFrame")
	frame:SetSize(ScrW()*0.5, ScrH()*0.5)
	frame:Center()
	frame:SetTitle("")
	frame:SetVisible(true)
	frame:SetDraggable(true)
	frame:MakePopup()
	frame:ShowCloseButton(false)
	frame.Paint = function( self, w, h )
		Blur(self, 3)
		draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 85))
	end

	local shell = vgui.Create("DPanel", frame)
	shell:SetPos(5, 5)
	shell:SetSize(frame:GetWide()-10, frame:GetTall()-10)
	shell.Paint = function( self, w, h )
	--	draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 100))
	end
	
	local shell_left = vgui.Create("DPanel", shell)
	shell_left:SetPos(0, 0)
	shell_left:SetSize(shell:GetWide()/2-2, shell:GetTall())
	shell_left.Paint = function( self, w, h )
	--	draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 100))
	end
	
	local shell_right = vgui.Create("DPanel", shell)
	shell_right:SetPos(shell:GetWide()/2+2, 0)
	shell_right:SetSize(shell:GetWide()/2-1, shell:GetTall())
	shell_right.Paint = function( self, w, h )
	--	draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 100))
	end

	local topDList = vgui.Create( "DPanelList", shell_left )
	topDList:SetPos(0, 0)
	topDList:SetSize(shell_left:GetWide()+15, shell_left:GetTall())
	topDList:EnableHorizontal(false)
	topDList:EnableVerticalScrollbar(false)
	topDList:SetSpacing(5)
	topDList.Paint = function() end

	local d = vgui.Create("DPanel")
	d:SetSize(topDList:GetWide()-15, (topDList:GetTall()/5)-22)
	d.Paint = function(self, w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 155))
		if #topDonators == 0 then
			draw.SimpleText("No Top Donators", "VSDB_Font_Main", w/2, h/2-2, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		else
			draw.SimpleText("Top "..#topDonators.." Donators", "VSDB_Font_Main", w/2, h/2-2, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

		end
		draw.RoundedBox(0, w/6, h/2+(ScreenScale(12)/2)+2, (w/3)*2, 4, Color(255, 255, 255))
	end
	topDList:AddItem(d)
	local pos = d:GetTall() + 4

	for k, v in pairs(topDonators) do
		local d = vgui.Create("DPanel", topDList)
		d:SetSize(topDList:GetWide()-15, (topDList:GetTall()/5)-22)
		d:SetPos(0, topDList:GetTall()+pos)
		d.Paint = function(self, w, h)
			draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 155))
			draw.SimpleText(v.name, "VSDB_Font_Name", w/2, h/2, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM)
			draw.SimpleText(DarkRP.formatMoney(v.amount), "VSDB_Font_Money", w/2, h/2, Color(155, 255, 155), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
		end

		d:MoveTo(0, pos, 0.25*k, 0.1, 0.25*k)
		pos = pos + d:GetTall() + 5
		--topDList:AddItem(d)
	end


	local options = vgui.Create( "DPanelList", shell_right )
	options:SetPos(0, 0)
	options:SetSize(shell_right:GetWide()+15, shell_right:GetTall())
	options:EnableHorizontal(false)
	options:EnableVerticalScrollbar(false)
	options:SetSpacing(5)
	options.Paint = function() end
	
	local owner = vgui.Create("DPanel", shell)
	owner:SetPos(0, 0)
	owner:SetSize(options:GetWide()-15, (options:GetTall()/6)*2-5)
	owner.Paint = function( self, w, h )
		draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 155))
		draw.SimpleText("Donation Box", "VSDB_Font_Main", w/2, h/2, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM)
		draw.SimpleText("Settings", "VSDB_Font_Main", w/2, h/2, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
	end
	options:AddItem(owner)
	
	local toggleDonations = vgui.Create("DPanel", shell)
	toggleDonations:SetPos(0, 0)
	toggleDonations:SetSize(options:GetWide()-15, (options:GetTall()/6)-5)
	toggleDonations.Paint = function( self, w, h )
		draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 155))
		draw.SimpleText("Toggle Donations", "VSDB_Font_Main", w/2+20, h/2, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end

	local switch = vgui.Create("vs_switch", toggleDonations)
	switch:SetPos(toggleDonations:GetWide()/2-(ScreenScale(15)*3.1), toggleDonations:GetTall()/2-15)
	switch:SetSize(30, 30)
	switch:SetToggle(box:GetOpen())
	switch.DoClick = function()
		switch:Toggle()
		net.Start("vs_toggle_donations")
			net.WriteEntity(box)
			net.WriteBool(switch:GetToggle())
		net.SendToServer()
	end
	options:AddItem(toggleDonations)
	
	local curMoney = vgui.Create("DPanel", shell)
	curMoney:SetPos(0, 0)
	curMoney:SetSize(options:GetWide()-15, (options:GetTall()/6)-5)
	curMoney.Paint = function( self, w, h )
		draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 155))
		draw.SimpleText("Currently Holding:", "VSDB_Font_Main", w/2, h/2, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM)
		draw.SimpleText(DarkRP.formatMoney(box:GetCurMoney()), "VSDB_Font_Main", w/2, h/2-5, Color(155, 255, 155), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
	end
	options:AddItem(curMoney)
	
	local withdrawButton = vgui.Create("DButton", shell)
	withdrawButton:SetPos(0, 0)
	withdrawButton:SetSize(options:GetWide()-15, (options:GetTall()/6)-5)
	withdrawButton:SetText("")
	withdrawButton.Paint = function( self, w, h )
		draw.RoundedBox(0, 0, 0, w, h, Color(0, 75, 0))
		draw.SimpleText("Withdraw", "VSDB_Font_Main", w/2, h/2, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end
	withdrawButton.DoClick = function()
		if box:GetCurMoney() <= 0 then return end
		net.Start("vs_withdraw")
			net.WriteEntity(box)
		net.SendToServer()
		frame:Close()
	end
	options:AddItem(withdrawButton)
	
	local closeButton = vgui.Create("DButton", shell)
	closeButton:SetPos(0, 0)
	closeButton:SetSize(options:GetWide()-15, (options:GetTall()/6)+1)
	closeButton:SetText("")
	closeButton.Paint = function( self, w, h )
		draw.RoundedBox(0, 0, 0, w, h, Color(75, 0, 0))
		draw.SimpleText("Never Mind", "VSDB_Font_Main", w/2, h/2, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end
	closeButton.DoClick = function()
		frame:Close()
	end
	options:AddItem(closeButton)


end)




























net.Receive("vs_derma", function()
	local box = net.ReadEntity()
	local topDonators = net.ReadTable() or {}
	local ply = box:Getowning_ent()
	ply = (IsValid(ply) and ply:Nick()) or "No User Fround"

	-- Creating the base panel
	local frame = vgui.Create("DFrame")
	frame:SetSize(ScrW()*0.5, ScrH()*0.5)
	frame:Center()
	frame:SetTitle("")
	frame:SetVisible(true)
	frame:SetDraggable(true)
	frame:MakePopup()
	frame:ShowCloseButton(false)
	frame.Paint = function( self, w, h )
		Blur(self, 3)
		draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 85))
	end

	local shell = vgui.Create("DPanel", frame)
	shell:SetPos(5, 5)
	shell:SetSize(frame:GetWide()-10, frame:GetTall()-10)
	shell.Paint = function( self, w, h )
	--	draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 100))
	end
	
	local shell_left = vgui.Create("DPanel", shell)
	shell_left:SetPos(0, 0)
	shell_left:SetSize(shell:GetWide()/2-2, shell:GetTall())
	shell_left.Paint = function( self, w, h )
	--	draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 100))
	end
	
	local shell_right = vgui.Create("DPanel", shell)
	shell_right:SetPos(shell:GetWide()/2+2, 0)
	shell_right:SetSize(shell:GetWide()/2-1, shell:GetTall())
	shell_right.Paint = function( self, w, h )
	--	draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 100))
	end



	local topDList = vgui.Create( "DPanelList", shell_left )
	topDList:SetPos(0, 0)
	topDList:SetSize(shell_left:GetWide()+15, shell_left:GetTall())
	topDList:EnableHorizontal(false)
	topDList:EnableVerticalScrollbar(false)
	topDList:SetSpacing(5)
	topDList.Paint = function() end

	local d = vgui.Create("DPanel")
	d:SetSize(topDList:GetWide()-15, (topDList:GetTall()/5)-22)
	d.Paint = function(self, w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 155))
		if #topDonators == 0 then
			draw.SimpleText("No Top Donators", "VSDB_Font_Main", w/2, h/2-2, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		else
			draw.SimpleText("Top "..#topDonators.." Donators", "VSDB_Font_Main", w/2, h/2-2, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

		end
		draw.RoundedBox(0, w/6, h/2+(ScreenScale(12)/2)+2, (w/3)*2, 4, Color(255, 255, 255))
	end
	topDList:AddItem(d)
	local pos = d:GetTall() + 5

	for k, v in pairs(topDonators) do
		local d = vgui.Create("DPanel", topDList)
		d:SetSize(topDList:GetWide()-15, (topDList:GetTall()/5)-22)
		d:SetPos(0, topDList:GetTall()+pos)
		d.Paint = function(self, w, h)
			draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 155))
			draw.SimpleText(v.name, "VSDB_Font_Name", w/2, h/2, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM)
			draw.SimpleText(DarkRP.formatMoney(v.amount), "VSDB_Font_Money", w/2, h/2, Color(155, 255, 155), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
		end

		--d:SetPos(0, pos)
		d:MoveTo(0, pos, 0.25*k, 0.1, 0.25*k)
		pos = pos + d:GetTall() + 5
		--topDList:AddItem(d)
	end


	local options = vgui.Create( "DPanelList", shell_right )
	options:SetPos(0, 0)
	options:SetSize(shell_right:GetWide()+15, shell_right:GetTall())
	options:EnableHorizontal(false)
	options:EnableVerticalScrollbar(false)
	options:SetSpacing(5)
	options.Paint = function() end
	
	local owner = vgui.Create("DPanel", shell)
	owner:SetPos(0, 0)
	owner:SetSize(options:GetWide()-15, (options:GetTall()/6)*2-5)
	owner.Paint = function( self, w, h )
		draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 155))
		draw.SimpleText("Donating to", "VSDB_Font_Main", w/2, h/2, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM)
		draw.SimpleText(ply, "VSDB_Font_Main", w/2, h/2, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
	end
	options:AddItem(owner)
	
	local donateAmount = vgui.Create("DPanel", shell)
	donateAmount:SetPos(0, 0)
	donateAmount:SetSize(options:GetWide()-15, (options:GetTall()/6)*2-5)
	donateAmount.Paint = function( self, w, h )
		draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 155))
		draw.SimpleText("Donation Amount:", "VSDB_Font_Main", w/2, h/2, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM)
		--draw.SimpleText(box:Getowning_ent(), "VSDB_Font_Main", w/2, h/2, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
	end

	local amount = vgui.Create("DTextEntry", donateAmount)
	amount:SetPos(10, donateAmount:GetTall()/2+10)
	amount:SetSize(donateAmount:GetWide()-20, donateAmount:GetTall()/2-30)
	amount:SetNumeric(true)
	amount:SetFont("VSDB_Font_Main")
	amount:SetText("10000")
	amount.Paint = function(self, w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(40, 40, 40))
        self:DrawTextEntryText( Color(255, 255, 255), Color(0, 178, 238), Color(255, 255, 255) )
	end
	options:AddItem(donateAmount)
	
	local donateButton = vgui.Create("DButton", shell)
	donateButton:SetPos(0, 0)
	donateButton:SetSize(options:GetWide()-15, (options:GetTall()/6)-5)
	donateButton:SetText("")
	donateButton.Paint = function( self, w, h )
		draw.RoundedBox(0, 0, 0, w, h, Color(0, 75, 0))
		draw.SimpleText("Donate", "VSDB_Font_Main", w/2, h/2, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end
	donateButton.DoClick = function()
		if !LocalPlayer():canAfford(amount:GetText()) then return end
		net.Start("vs_donate")
			net.WriteEntity(box)
			net.WriteString(amount:GetText())
		net.SendToServer()
		frame:Close()
	end
	options:AddItem(donateButton)
	
	local closeButton = vgui.Create("DButton", shell)
	closeButton:SetPos(0, 0)
	closeButton:SetSize(options:GetWide()-15, (options:GetTall()/6)+1)
	closeButton:SetText("")
	closeButton.Paint = function( self, w, h )
		draw.RoundedBox(0, 0, 0, w, h, Color(75, 0, 0))
		draw.SimpleText("Never Mind", "VSDB_Font_Main", w/2, h/2, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end
	closeButton.DoClick = function()
		frame:Close()
	end
	options:AddItem(closeButton)
end)
