local function OpenCivMenu()
	local chosenPlayer = nil

	local frame = XYZUI.Frame("Place a bounty", XYZ_HITMAN.Config.Color)
	frame:SetSize( ScrW() * 0.2 , ScrH() * 0.19 )
	frame:Center()

	local shell = XYZUI.Container(frame)
	local dropdown = XYZUI.DropDownList(shell, "Select a player to place a bounty on", function(name, value)
        chosenPlayer = value
    end)

	for k, v in pairs(player.GetAll()) do
		if v == LocalPlayer() then continue end
		XYZUI.AddDropDownOption(dropdown, v:Nick(), v)
	end

	local textEntry, cont = XYZUI.TextInput(shell) 
	textEntry:SetValue(XYZ_HITMAN.Config.MinPrice)
	textEntry:SetNumeric(true)

	local placeButton = XYZUI.ButtonInput(shell, "Place Bounty", function(self)
		net.Start("xyz_hitman_add_hit")
		net.WriteEntity(chosenPlayer)
		net.WriteUInt(textEntry:GetValue(), 32)
		net.SendToServer()
		frame:Close()
    end)
	
   	placeButton:Dock(BOTTOM)
	placeButton:DockMargin(0, 0, 0, 5)
end

local function OpenHitmanMenu()
	local hits = net.ReadTable()
	local chosenBounty = 0

	local frame = XYZUI.Frame("Select a hit", XYZ_HITMAN.Config.Color)
	frame:SetSize( ScrW() * 0.25 , ScrH() * 0.15 )
	frame:Center()

	local shell = XYZUI.Container(frame)
	local claimButton = XYZUI.ButtonInput(shell, "Claim", function(self)
		if chosenBounty == 0 then return end
		net.Start("xyz_hitman_claim_hit")
			net.WriteUInt(chosenBounty, 6)
		net.SendToServer()
		frame:Close()
    end)

	local dropdown = XYZUI.DropDownList(shell, "Select a hit", function(name, value)
        chosenBounty = value
        if hits[value].claims[LocalPlayer():SteamID64()] then 
        	claimButton.disText = "Unclaim bounty"
        else
        	claimButton.disText = "Claim bounty"
        end
    end)

	for k, v in pairs( hits ) do
		if not IsValid(v.target) then continue end
		XYZUI.AddDropDownOption(dropdown, v.target:Nick().." - $"..v.price, k)
	end

    claimButton:Dock(BOTTOM)
end

net.Receive("xyz_hitman_open",function()
	if XYZ_HITMAN.Config.HitmanJobs[LocalPlayer():Team()] then
		OpenHitmanMenu()
	else
		OpenCivMenu()
	end
end)