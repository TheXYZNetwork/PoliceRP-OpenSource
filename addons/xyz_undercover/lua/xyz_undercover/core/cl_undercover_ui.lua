net.Receive( "undercover_ui", function( len, ply )
    local frame = XYZUI.Frame("Undercover System", Color(105, 110, 117))
    local shell = XYZUI.Container(frame)
    local selectedJob = {}
    local icon = vgui.Create( "DModelPanel", shell )
	icon:SetModel( LocalPlayer():GetModel() )
	icon:SetFOV(110)
	icon:Dock(FILL)

    local dropdown = XYZUI.DropDownList(shell, "Select a job", function(name, value)
    	if type(RPExtraTeams[value].model) == "table" then -- Some jobs have .model as a table
    		icon:SetModel(RPExtraTeams[value].model[1])
    	else
    		icon:SetModel(RPExtraTeams[value].model)
    	end
    	selectedJob.name = RPExtraTeams[value].name
    	selectedJob.id = value
    end)

    for k, v in SortedPairs( xUndercover.Config.UndercoverJobs ) do
        XYZUI.AddDropDownOption(dropdown, RPExtraTeams[k].name, k )
    end

    XYZUI.ButtonInput(shell, "Go undercover", function(self)
    	if selectedJob.id == nil then return end
        net.Start("undercover_go_undercover")
        net.WriteUInt(selectedJob.id, 16)
        net.SendToServer()
        frame:Close()
    end ):Dock(BOTTOM)
end )

net.Receive("undercover_go_undercover", function(len, ply)
	xUndercover.UCPanel = vgui.Create( "DFrame" ) -- Is using a global var needed? Better way to do this?
	xUndercover.UCPanel:SetTitle("")
	xUndercover.UCPanel:SetSize(200, 100)
	xUndercover.UCPanel:CenterHorizontal()
	xUndercover.UCPanel:SetDraggable(false)
	xUndercover.UCPanel:ShowCloseButton(false)
	
	function xUndercover.UCPanel:Paint()
		return false
	end
	
	local UCEndBtn = XYZUI.ButtonInput(xUndercover.UCPanel, "Go out of undercover", function(self)
        net.Start("undercover_go_off_undercover")
        net.SendToServer()
    end)
    UCEndBtn:Center()
    UCEndBtn.headerColor = Color(105, 110, 117)
end )

net.Receive("undercover_go_off_undercover", function(len, ply)
	xUndercover.UCPanel:Close()
end )