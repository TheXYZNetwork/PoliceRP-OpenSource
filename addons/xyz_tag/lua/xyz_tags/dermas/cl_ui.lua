net.Receive("xyz_tag_open", function()
	local existingName = LocalPlayer():GetNWString("xyz_tag_string", "Cool Tag")
	local existingColor = LocalPlayer():GetNWVector("xyz_tag_Color", Vector(30, 100, 160))
	existingColor = Color(existingColor.x, existingColor.y, existingColor.z)


	local frame = XYZUI.Frame("Custom Tag", Color(160, 130, 40))
	frame:SetSize(ScrH()*0.5, ScrH()*0.5)
	frame:Center()

	local _, shell = XYZUI.Lists(frame, 1)


	XYZUI.PanelText(shell, "Preview", 35, TEXT_ALIGN_LEFT)
	:DockMargin(5, 5, 5, 5)

	local previewText = vgui.Create("DPanel", shell)
	previewText:Dock(TOP)
	previewText:SetTall(40)
	previewText:DockMargin(5, 5, 5, 5)
	previewText.Paint = function(self, w, h)
		XYZUI.DrawText("["..existingName.."]", 45, w/2, h/2, existingColor)
	end

	XYZUI.PanelText(shell, "Title", 35, TEXT_ALIGN_LEFT)
	:DockMargin(5, 5, 5, 5)
	local titleEntry, cont = XYZUI.TextInput(shell)
	cont:DockMargin(10, 5, 10, 5)
	titleEntry:SetText(existingName)
	titleEntry.OnChange = function()
		if string.len(titleEntry:GetText()) > 15 then return false end
		existingName = titleEntry:GetText()
	end

	-- Color
	XYZUI.PanelText(shell, "Color", 35, TEXT_ALIGN_LEFT)
	:DockMargin(5, 5, 5, 5)
	local settingColorPallet = vgui.Create("DColorMixer", shell)
	settingColorPallet:SetTall(120)
	settingColorPallet:Dock(TOP)
	settingColorPallet:DockMargin(10, 5, 10, 5)
	settingColorPallet:SetPalette(false)
	settingColorPallet:SetAlphaBar(false)
	settingColorPallet:SetWangs(true)
	settingColorPallet:SetColor(existingColor)
	settingColorPallet.ValueChanged = function(newColor)
		existingColor = settingColorPallet:GetColor()
	end

	local set = XYZUI.ButtonInput(frame, "Set", function()
		if string.len(existingName) <= 0 then return end
		net.Start("xyz_tag_set")
			net.WriteString(existingName)
			net.WriteColor(Color(existingColor.r, existingColor.g, existingColor.b))
		net.SendToServer()
		frame:Close()
	end)
	set:DockMargin(0, 5, 0, 0)
	set:Dock(BOTTOM)
end)