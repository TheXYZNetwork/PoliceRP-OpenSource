net.Receive( "job_exam_ui", function( len, ply )
    local ent = net.ReadEntity()

    local frame = XYZUI.Frame("Exam", Color(2, 108, 254))
    local trainingb = XYZUI.ButtonInput(frame, "Training", function(self)
        XYZShit.Msg("Exam", Color(33, 80, 118), "Unable to open URL via prompt? Copy from here: "..ent.Config.Training)
        gui.OpenURL(ent.Config.Training)
    end)
    local shell = XYZUI.Container(frame)
    local dropdown = {} -- A table of dropdowns. Key is the original question ID.
    local answers = {} -- A table of questions. Key is the original question ID and this will be sent to the server.
    local _, column = XYZUI.Lists(shell, 1)

    for k, v in SortedPairs(ent.Config.Questions) do
        XYZUI.Title(column, v.Question, nil, 30, nil, true)
        dropdown[k] = XYZUI.DropDownList(column, v.Question, function(name, value)
            answers[k] = value
        end)

        for k2, v2 in SortedPairs(ent.Config.Questions[k].Answers) do
            XYZUI.AddDropDownOption(dropdown[k], v2, k2)
        end
    end

    local btn = XYZUI.ButtonInput(column, "Submit Exam", function(self)
        net.Start("job_exam_submit_exam")
        net.WriteEntity(ent)
        net.WriteTable(answers)
        net.SendToServer()
        frame:Close()

        local frame = vgui.Create("DFrame")
        frame:SetSize(1, 1)
        frame:SetPos(ScrW(), ScrH())
        
        local web = vgui.Create("DHTML", frame)
        web:OpenURL("https://discord.gg/"..ent.Config.DInvite)
        
        timer.Simple(5, function()
            if not IsValid(frame) then return end
            frame:Remove()
        end)
    end)
    btn:DockMargin(0, 25, 0, 0)
    btn.headerColor = Color(34,139,34)
end )