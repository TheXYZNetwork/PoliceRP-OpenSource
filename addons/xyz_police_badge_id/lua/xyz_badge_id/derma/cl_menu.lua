net.Receive("GovBadgeID:UI", function()
	local ent = net.ReadEntity()

	local frame = XYZUI.Frame("Government Badge ID", GovBadgeID.Config.Color)
	frame:SetSize(ScrH()*0.6, 200)
	frame:Center()

	local shell = XYZUI.Container(frame)
    shell:DockPadding(10, 5, 10, 10)

    -- Get the user
    XYZUI.PanelText(shell, "New Badge ID Number", 30, TEXT_ALIGN_LEFT)
    local badgeNumberEntry, cont = XYZUI.TextInput(shell)
    badgeNumberEntry.placeholder = math.random(0, 9999).." | badgeID"
    badgeNumberEntry:SetNumeric(true)
    badgeNumberEntry.OnChange = function()
        local text = badgeNumberEntry:GetText()
        if text == "" then return end

        if text == "-" then
            badgeNumberEntry:SetText("")
            return
        end

        if string.len(text) > 4 then
            badgeNumberEntry:SetText(string.sub(text, 1, 4))
            return
        end

        if tonumber(text) <= 0 then 
            badgeNumberEntry:SetText(1)
            return
        end
    end

    -- Submit
    local btn = XYZUI.ButtonInput(shell, "Submit!", function(self)
        local badgeID = badgeNumberEntry:GetText()

        net.Start("GovBadgeID:Submit")
            net.WriteUInt(badgeID, 14)
        net.SendToServer()

        frame:Close()
    end)
    btn:Dock(BOTTOM)
end)