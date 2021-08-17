include("shared.lua")


function ENT:Draw()
	self:DrawModel()
  	if self:GetPos():DistToSqr(LocalPlayer():GetPos()) > 1000000 then return end

	local Pos = self:GetPos()
	local Ang = self:GetAngles()
	Ang:RotateAroundAxis(Ang:Up(), 90)
	Ang:RotateAroundAxis(Ang:Forward(), 90)

	-- Header
	cam.Start3D2D(Pos + Ang:Up()*28, Ang, 0.07)
		draw.SimpleText(self:GetHead(), "xyz_font_160_static", 0, -520, Color(255, 255, 0), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

		XYZUI.DrawLineBreakText(self:GetBody(), 60, 0, -120, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	cam.End3D2D()
end

net.Receive("xyz_police_sign_open", function()
	local sign = net.ReadEntity()


	local frame = XYZUI.Frame("Edit Sign")
	frame:SetSize(ScrH()*0.67, ScrH()*0.6)
	frame:Center()

	local shell = XYZUI.Container(frame)


	XYZUI.PanelText(shell, "Header", nil, TEXT_ALIGN_LEFT)
	local header, cont = XYZUI.TextInput(shell)
	cont:DockMargin(5, 0, 5, 0)
	header:SetText(sign:GetHead())


	local bodyText = XYZUI.PanelText(shell, "Body (32 char limit per line)", nil, TEXT_ALIGN_LEFT)
	bodyText:DockPadding(5, 5, 5, 0)

	local lines = {}
	local _, body = XYZUI.Lists(shell, 1)
	body:DockMargin(5, 5, 5, 5)

	local addButton, _ = XYZUI.ButtonInput(bodyText, "+", function()
		if #lines >= 11 then return end

		local line, cont = XYZUI.TextInput(body)
		cont:DockMargin(5, 5, 5, 5)
		XYZUI.ButtonInput(cont, "-", function()
			cont:Remove()
			lines[cont.key] = nil
		end)
		:Dock(RIGHT)

		cont.key = table.insert(lines, line) 
	end)
	addButton:Dock(RIGHT)

	local text = string.Split(sign:GetBody(), "\n")
	for k, v in pairs(text) do
		addButton.DoClick()
		lines[k]:SetText(v)
	end




	local submit = XYZUI.ButtonInput(frame, "Submit", function()
		local text = {}
		for k, v in pairs(lines) do
			table.insert(text, v:GetText())
		end
		net.Start("xyz_police_sign_update")
			net.WriteString(header:GetText())
			net.WriteTable(text)
			net.WriteEntity(sign)
		net.SendToServer()

		frame:Close()
	end)
	submit:Dock(BOTTOM)
	submit:DockMargin(0, 5, 0, 0)
end)