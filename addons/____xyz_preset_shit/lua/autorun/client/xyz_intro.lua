XYZShit = XYZShit or {}
XYZShit.Intro = {}

XYZShit.Intro.Messages = {
    "Digging up your data",
    "Asking the gmod gods to transfer us your info",
    "Fighting off evil computer aliens",
    "Hacking the mainframe",
    "Loading xServers",
    "Starting bitcoin miner",
    "Harvesting your brain",
    "Transmitting mind control ability",
    "Questioning reality itself",
    "Wait, are we in a simulation?",
    "Throwing away all the Lua files, who needs 'em?"
}

function XYZShit.Intro.UI()
    local frame = vgui.Create("DFrame")
    frame:SetSize(ScrW(), ScrH())
    frame:Center()
    frame:MakePopup()
    frame:SetDraggable(false)
    frame:ShowCloseButton(false)
    frame:SetTitle("")
    function frame:Think()
        self:MoveToFront()
    end
    local logoSize = 0
    frame.Paint = function(self, w, h)
        surface.SetDrawColor(255, 255, 255, 255)
        surface.SetMaterial(XYZShit.Image.GetMat("main_background"))
        surface.DrawTexturedRect(0, 0, w, h)

        --print(125+(125*math.sin(CurTime())))
        surface.SetDrawColor(255, 255, 255, 255+(200*math.sin(CurTime())))
        surface.SetMaterial(XYZShit.Image.GetMat("main_logo"))
        logoSize = h*0.6
        surface.DrawTexturedRect(w*0.5-(logoSize*0.5), h*0.45-(logoSize*0.5), logoSize, logoSize)
    end

    local loading = XYZUI.PanelText(frame, "", 40, TEXT_ALIGN_CENTER)
    loading:Dock(BOTTOM)
    loading:DockMargin(0, 0, 0, 10)
    loading.nextChange = 0
    loading.Think = function()
        if loading.nextChange > CurTime() then return end
        loading.text = table.Random(XYZShit.Intro.Messages)
        loading.nextChange = CurTime() + 3
    end

    local dots = 0
    local state = XYZUI.PanelText(frame, "Loading into the server", 60, TEXT_ALIGN_CENTER)
    state:Dock(BOTTOM)
    state.nextThink = 0
    state.Think = function()
        if state.nextThink > CurTime() then return end
        state.nextThink = CurTime() + 0.4
        dots = (dots >= 3) and 0 or (dots + 1)
        state.text = "Loading into the server"
        for i=1, dots do
            state.text = state.text.."."
        end
    end

    timer.Simple(20, function()
        if not IsValid(frame) then return end

        loading:Remove()
        state:Remove()

        local buttonShell = vgui.Create("DPanel", frame)
        buttonShell:SetSize(frame:GetWide(), 40)
        buttonShell:Dock(BOTTOM)
        buttonShell.Paint = function() end

        local confirm = XYZUI.ButtonInput(buttonShell, "Let's go", function()
            frame:Close()
        end)
        confirm.headerColor = Color(25, 155, 25)
        confirm:Dock(NODOCK)
        confirm:SetWide(240)

        local rules = XYZUI.ButtonInput(buttonShell, "Show me the rules", function()
            local pad = vgui.Create("DPanel", frame)
            local grey = Color(35, 35, 35)
            pad.Paint = function(self, w, h)
                draw.RoundedBox(0, 0, 0, w, h, grey)
            end
            pad:Dock(FILL)
                local html = vgui.Create("DHTML", pad)
                html:Dock(FILL)
                html:DockMargin(5, 5, 5, 5)
                html:OpenURL("https://thexyznetwork.xyz/rules/policerp")
        end)
        rules:Dock(NODOCK)
        rules:SetWide(145)

        local spaceNeeded = rules:GetWide() + confirm:GetWide() + 5

        -- Big brain math to make the buttons centered. They call me Dr.OfMathsOwain
        local curPos = (frame:GetWide()/2) - (spaceNeeded/2)
        rules:SetPos(curPos, 0)
        curPos = curPos + rules:GetWide() + 5
        confirm:SetPos(curPos, 0)


        local confirm = XYZUI.PanelText(frame, "By playing; you agree to follow the rules!", 40, TEXT_ALIGN_CENTER)
        confirm:Dock(BOTTOM)
        confirm:DockMargin(0, 0, 0, 5)
    end)
end

hook.Add("XYZPostImageLoad", "XYZShit.Intro.Load", function()
    if XYZSettings.GetSetting("intro_toggle_show", true) then -- Idk if this is even gonna load before the settings system lol
        XYZShit.Intro.UI()
    end

    system.FlashWindow()
end)