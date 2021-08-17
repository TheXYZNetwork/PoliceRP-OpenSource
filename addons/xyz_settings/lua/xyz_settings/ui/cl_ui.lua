concommand.Add("xyz_settings_menu", function()
	XYZSettings.UI()
end)
hook.Add("XYZOnPlayerChat", "xyz_settings_command", function(ply, msg)
	if not (ply == LocalPlayer()) then return end
	if not (string.lower(msg) == "!settings") then return end

	XYZSettings.UI()
end)


function XYZSettings.UI()
	Quest.Core.NetworkProgress("new_comer", 2)

	local frame = XYZUI.Frame("Settings Menu") 
	frame:SetSize(ScrH()*0.5, ScrH()*0.8)
	frame:Center()

	local shell = XYZUI.Container(frame)

	local _, contList = XYZUI.Lists(shell, 1)
	contList:DockPadding(5, 5, 5, 5)

	for k, v in pairs(XYZSettings.RegisteredSettings) do
		--XYZUI.Title(contList, k, nil, nil, nil, true)
		local body, card, mainContainer = XYZUI.ExpandableCard(contList, k, 40)
		mainContainer:DockMargin(5, 5, 5, 5)

		for n, m in pairs(v) do
			local card = XYZUI.Card(body, 90)
			card.Paint = function() end
    		XYZUI.AddToExpandableCardBody(mainContainer, card)

			local title = XYZUI.Title(card, m.name, m.desc, 30, 18)
			title:SetTall(50)
	
			if m.type == 1 then
			elseif m.type == 2 then
				local box, cont = XYZUI.TextInput(card)
				cont:DockMargin(5, 3, 0, 0)
				cont:SetTall(31)
				box:SetText(XYZSettings.GetSetting(m.setting, m.default))
				box:SetNumeric(true)
				function box.OnValueChange()
    				XYZSettings.SetSetting(m.setting, box:GetText())
				end
			elseif m.type == 3 then
				local dropdown = XYZUI.DropDownList(card, "Choose setting", function(name, value)
					XYZSettings.SetSetting(m.setting, name)

				end)
				dropdown:DockMargin(5, 3, 0, 0)
				dropdown:SetTall(31)
				
				for k, v in pairs(m.options) do
					XYZUI.AddDropDownOption(dropdown, v)
				end

			elseif m.type == 4 then
				local box, cont = XYZUI.ToggleInput(card)
				cont:DockMargin(5, 3, 0, 0)
    			box.state = XYZSettings.GetSetting(m.setting, m.default)
    			box.oldDoClick = box.DoClick
    			function box.DoClick()
    				box.oldDoClick()

    				XYZSettings.SetSetting(m.setting, box.state)
    			end
			end
		end
	end
end
