net.Receive("Rewards:UI", function()
	local data = net.ReadTable()
	Rewards.Core.Menu(data)
end)

function Rewards.Core.Menu(data)
	local frame = XYZUI.Frame("Rewards", Rewards.Config.Color)
	frame:SetSize(ScrH()*0.5, ScrH()*0.8)
	frame:Center()

	local _, shell = XYZUI.Lists(frame, 1)
	shell.Paint = nil

    for k, v in pairs(Rewards.Config.Rewards) do
		local reward = XYZUI.Container(shell)
		reward:Dock(TOP)
		reward:DockMargin(0, 0, 0, 5)
		reward:SetTall(80)

		if v.icon then
			local icon = vgui.Create("DImage", reward)
			icon:Dock(LEFT)
			icon:SetSize(reward:GetTall(), reward:GetTall())
			icon:SetMaterial(XYZShit.Image.GetMat(v.icon))
		end

		local btn = XYZUI.ButtonInput(reward, "Claim", function(self)
			net.Start("Rewards:Claim")
				net.WriteString(k)
			net.SendToServer()

			frame:Close()
		end)
		btn:Dock(RIGHT)
		btn:DockMargin(0, 5, 5, 5)
		btn:SetWide(100)

		if data[k] and v.claimed and v.claimed(LocalPlayer(), data[k].progress, data[k].updated) then
    		btn.headerColor = Color(155, 0, 0)
    		btn.disText = "Claimed"
    		btn.DoClick = function() end -- Do nothing
		end

		XYZUI.Title(reward, v.name, v.desc, 40, 30)
	end
end