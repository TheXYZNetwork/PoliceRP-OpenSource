CarRadio.Menu = nil
function CarRadio.OpenMenu(car)
    if IsValid(CarRadio.Menu) then return end
    if not car then return end
    if not IsValid(car) then return end

    CarRadio.Menu = XYZUI.Frame("Radio", CarRadio.Config.Color)
    CarRadio.Menu:SetSize(ScrH()*0.4, ScrH()*0.6)
    CarRadio.Menu:Center()

    local shell = XYZUI.Container(CarRadio.Menu)
    shell.Paint = nil
    shell:Dock(FILL)

    local navBar = XYZUI.NavBar(CarRadio.Menu)

    XYZUI.AddNavBarPage(navBar, shell, "Radio", function(shell)
	    local _, channelList = XYZUI.Lists(shell, 1)
	    channelList.Paint = nil
	    channelList:Dock(FILL)

	    for k, v in ipairs(CarRadio.Config.Channels) do
	        local channel = XYZUI.Container(channelList)
	        channel:Dock(TOP)
	        channel:DockMargin(0, 0, 0, 5)
	        channel:SetTall(70)

	        local btn = XYZUI.ButtonInput(channel, "Select Station", function(self)
	            net.Start("CarRadio:ChangeChannel")
	                if not car:IsVehicle()then
	                    net.WriteEntity(car)
	                end
	                net.WriteUInt(k, 5)
	            net.SendToServer()
	        end)
	        btn:Dock(RIGHT)
	        btn:DockMargin(0, 5, 5, 5)
	        btn:SetWide(110)

	        XYZUI.PanelText(channel, v.name, 40, TEXT_ALIGN_LEFT):Dock(FILL)
	    end
	

    local toggle = XYZUI.ButtonInput(shell, "Toggle Radio", function(self)
        net.Start("CarRadio:ToggleRadio")
            if not car:IsVehicle()then
                net.WriteEntity(car)
            end
        net.SendToServer()
    end)
    toggle:Dock(BOTTOM)


    local volume = XYZUI.Container(shell)
    volume:SetTall(40)
    volume:DockMargin(0, 0, 0, 5)
    volume:Dock(BOTTOM)

    local vol = car:GetNWInt("CarRadio:Volume", 10)
    local curVal = XYZUI.PanelText(volume, vol, 40)
    curVal:Dock(FILL)

    XYZUI.ButtonInput(volume, "<", function()
        if vol <= 1 then return end
        vol = vol - 1

        net.Start("CarRadio:ChangeVolume")
            if not car:IsVehicle()then
                net.WriteEntity(car)
            end
            net.WriteUInt(vol, 5)
        net.SendToServer()

        curVal.text = vol
    end):Dock(LEFT)
    XYZUI.ButtonInput(volume, ">", function()
        if vol >= 30 then return end
        vol = vol + 1


        net.Start("CarRadio:ChangeVolume")
            if not car:IsVehicle()then
                net.WriteEntity(car)
            end
            net.WriteUInt(vol, 5)
        net.SendToServer()

        curVal.text = vol
    end):Dock(RIGHT)


    XYZUI.PanelText(shell, "Volume", 40, TEXT_ALIGN_CENTER):Dock(BOTTOM)
    end)

    if car:GetClass() == "xyz_dj_set" then
    	XYZUI.AddNavBarPage(navBar, shell, "DJ Control", function(shell)
    		local entry, cont = XYZUI.TextInput(shell)
            entry.placeholder = "YouTube URL"

    		local addToQueueBtn = XYZUI.ButtonInput(shell, "Add to Queue", function(self)
    			net.Start("DJSet:AddToQueue")
    				net.WriteEntity(car)
    				net.WriteString(entry:GetValue())
    			net.SendToServer()
    			print(entry:GetValue())
    		end)


    		local play = XYZUI.ButtonInput(shell, "Play Queue", function(self)
    			net.Start("DJSet:Play")
    				net.WriteEntity(car)
    			net.SendToServer()
    		end)
    		play:Dock(BOTTOM)
    	end)
    end
end