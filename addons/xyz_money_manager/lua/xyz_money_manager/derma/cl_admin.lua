net.Receive("MoneyManager:UI", MoneyManager.Core.AdminUI)

function MoneyManager.Core.AdminUI()
    local frame = XYZUI.Frame("Money Manager - Admin Menu", MoneyManager.Config.Color)
    frame:SetSize(ScrH()*0.6, ScrH()*0.8)
    frame:Center()

    local _, shellList = XYZUI.Lists(frame, 1)

    for k, v in ipairs(player.GetAll()) do
    	local card = XYZUI.Card(shellList, 60)
    	card:DockMargin(0, 0, 0, 10)

    	local avatar = vgui.Create("AvatarImage", card)
		avatar:SetSize(60, 60)
		avatar:Dock(LEFT)
		avatar:SetPlayer(v, 64)

		local name = XYZUI.PanelText(card, v:Name(), 60, TEXT_ALIGN_LEFT)
		name:Dock(FILL)

		local giveMoney = XYZUI.ButtonInput(card, "Give Money", function()
			XYZUI.PromptInput("Give "..v:Name().." Money", nil, 1000, function(amount)
				net.Start("MoneyManager:Respose")
					net.WriteEntity(v)
					net.WriteInt(amount, 32)
				net.SendToServer()
			end)
		end)
		giveMoney:Dock(RIGHT)
		giveMoney:SetWide(140)
    end
end