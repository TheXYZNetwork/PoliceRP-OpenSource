local APP = {}

-- Base data
APP.name = "Call"
APP.id = "call"
APP.desc = "Call your friends" -- Used in the app store
APP.appStore = false -- Can be installed from the app store
APP.show = true -- Show the app on the home

-- Background
APP.Icon = function(w, h)
	surface.SetMaterial(XYZShit.Image.GetMat("phone_app_call"))
	surface.SetDrawColor(255, 255, 255, 255)
	surface.DrawTexturedRect(0, 0, w, h)
end

-- Functionality
APP.Function = function(shell)
	local number = vgui.Create("DPanel", shell)
	number.number =""
	number:Dock(TOP)
	number:SetTall(50)
	number.Paint = function(self, w, h)
		XYZUI.DrawScaleText(number.number, 10, w*0.5, h*0.5, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
	end

	local pads = {1, 2, 3, 4, 5, 6, 7, 8, 9, "*", 0, "#"}

	local grid = vgui.Create("ThreeGrid", shell)
	grid:Dock(FILL)
	grid:InvalidateParent(true)
	grid:SetColumns(3)
	grid:SetVerticalMargin(2)
	grid:SetHorizontalMargin(2)
	grid:GetVBar():SetWide(0)
	grid:DockMargin(6, 6, 6, 6)

	grid.PerformLayout = function(self, width, height)
		grid:Clear()
		for k, v in ipairs(pads) do
			local pnl = vgui.Create("DButton")
			pnl:SetTall((width/3) - 6)
			pnl:DockMargin(0, 0, 5, 0)
			pnl:SetText("")
			grid:AddCell(pnl)
			pnl.Paint = function(self, w, h)
				XYZUI.DrawScaleText(v, 10, w*0.5, h*0.5, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
			end
			pnl.DoClick = function()
				if string.len(number.number) >= 11 then return end

				number.number = number.number..v

    			surface.PlaySound("xyz/phone_dial.mp3")
			end
		end

		grid:Skip()
			local call = vgui.Create("DButton")
			call:SetTall((width/3) - 6)
			call:DockMargin(0, 0, 5, 0)
			call:SetText("")
			grid:AddCell(call)
			call.Paint = function(self, w, h)
				XYZUI.DrawScaleText("Call", 10, w*0.5, h*0.5, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
			end
			call.DoClick = function()
				APP.CallPending(shell, number.number)

				net.Start("Phone:Call")
					net.WriteString(number.number)
				net.SendToServer()
			end
			number.call = call

			local delete = vgui.Create("DButton")
			delete:SetTall((width/3) - 6)
			delete:DockMargin(0, 0, 5, 0)
			delete:SetText("")
			grid:AddCell(delete)
			delete.Paint = function(self, w, h)
				XYZUI.DrawScaleText("<", 10, w*0.5, h*0.5, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
			end
			delete.DoClick = function()
				number.number = string.sub(number.number, 0, math.Clamp(#number.number - 1, 0, #number.number-1))
			end
	end
end
local transWhite = Color(255, 255, 255, 170)
APP.CallRequest = function(shell, callerNumber)
	shell:Clear()

	local contact = Phone.App.GetApp("contacts").GetContact(callerNumber)

	local number = vgui.Create("DPanel", shell)
	number:Dock(FILL)
	number:SetTall(50)
	number.Paint = function(self, w, h)
		if contact then
			XYZUI.DrawScaleText(contact.name, 10, w*0.5, h*0.5, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM)
		end
		XYZUI.DrawScaleText(callerNumber, 10, w*0.5, h*0.5, color_white, TEXT_ALIGN_CENTER, contact and TEXT_ALIGN_TOP or TEXT_ALIGN_CENTER)
	end


	local reject = vgui.Create("DButton", shell)
	reject:Dock(BOTTOM)
	reject:SetTall(40)
	reject:SetText("")
	reject.Paint = function(self, w, h)
		draw.RoundedBox(0, 0, 0, w, h, transWhite)
		XYZUI.DrawScaleText("Reject", 9, w*0.5, h*0.5)
	end
	reject.DoClick = function()
		APP.EndCall()

		net.Start("Phone:Call:Reject")
		net.SendToServer()
	end

	local accept = vgui.Create("DButton", shell)
	accept:Dock(BOTTOM)
	accept:SetTall(40)
	accept:SetText("")
	accept.Paint = function(self, w, h)
		draw.RoundedBox(0, 0, 0, w, h, transWhite)
		XYZUI.DrawScaleText("Accept", 9, w*0.5, h*0.5)
	end
	accept.DoClick = function()
		timer.Remove("Phone:AutoReject")
		net.Start("Phone:Call:Accept")
		net.SendToServer()
	end
	accept:DockMargin(0, 0, 0, 5)

	timer.Create("Phone:AutoReject", 30, 1, function()
		if not IsValid(reject) then return end

		--net.Start("")

		reject.DoClick()
	end)
end
APP.CallPending = function(shell, receiverNumber)
	shell:Clear()

	local contact = Phone.App.GetApp("contacts").GetContact(receiverNumber)

	local number = vgui.Create("DPanel", shell)
	number:Dock(FILL)
	number:SetTall(50)
	number.Paint = function(self, w, h)
		if contact then
			XYZUI.DrawScaleText(contact.name, 10, w*0.5, h*0.5, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM)
		end
		XYZUI.DrawScaleText(receiverNumber, 10, w*0.5, h*0.5, color_white, TEXT_ALIGN_CENTER, contact and TEXT_ALIGN_TOP or TEXT_ALIGN_CENTER)
	end

	local reject = vgui.Create("DButton", shell)
	reject:Dock(BOTTOM)
	reject:SetTall(40)
	reject:SetText("")
	reject.Paint = function(self, w, h)
		draw.RoundedBox(0, 0, 0, w, h, transWhite)
		XYZUI.DrawScaleText("Cancel", 9, w*0.5, h*0.5)
	end
	reject.DoClick = function()
		APP.EndCall()

		net.Start("Phone:Call:Cancel")
		net.SendToServer()
	end
end
APP.CallStarted = function(shell, receiverNumber)
	shell:Clear()

	local contact = Phone.App.GetApp("contacts").GetContact(receiverNumber)
	local avatar
	if contact and contact.icon then
		avatar = Material("data/xyz/phone/snapper/"..contact.icon)
	end

	local number = vgui.Create("DPanel", shell)
	number:Dock(FILL)
	number:SetTall(50)
	number.Paint = function(self, w, h)
		if contact then
			if avatar then
				render.ClearStencil()
				render.SetStencilEnable(true)
				
				render.SetStencilWriteMask(1)
				render.SetStencilTestMask(1)
				
				render.SetStencilFailOperation(STENCILOPERATION_REPLACE)
				render.SetStencilPassOperation(STENCILOPERATION_ZERO)
				render.SetStencilZFailOperation(STENCILOPERATION_ZERO)
				render.SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_NEVER)
				render.SetStencilReferenceValue(1)
				
				draw.NoTexture()
				surface.SetDrawColor(255, 255, 255, 255)
				XYZUI.DrawCircle(w*0.5, w*0.5, w*0.3, 1)
				
				render.SetStencilFailOperation(STENCILOPERATION_ZERO)
				render.SetStencilPassOperation(STENCILOPERATION_REPLACE)
				render.SetStencilZFailOperation(STENCILOPERATION_ZERO)
				render.SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_EQUAL)
				render.SetStencilReferenceValue(1)
	
					surface.SetMaterial(avatar)
					surface.SetDrawColor(255, 255, 255, 255)
					surface.DrawTexturedRect(0, w*-0.75, w, w*2.5)
				
				render.SetStencilEnable(false)
				render.ClearStencil()
			end

			XYZUI.DrawScaleText(contact.name, 10, w*0.5, h*0.5, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM)
		end
		XYZUI.DrawScaleText(receiverNumber, 10, w*0.5, h*0.5, color_white, TEXT_ALIGN_CENTER, contact and TEXT_ALIGN_TOP or TEXT_ALIGN_CENTER)
	end

	local reject = vgui.Create("DButton", shell)
	reject:Dock(BOTTOM)
	reject:SetTall(40)
	reject:SetText("")
	reject.Paint = function(self, w, h)
		draw.RoundedBox(0, 0, 0, w, h, transWhite)
		XYZUI.DrawScaleText("End", 9, w*0.5, h*0.5)
	end
	reject.DoClick = function()
		APP.EndCall()

		net.Start("Phone:Call:End")
		net.SendToServer()
	end
end
APP.SetNumber = function(number)
	if not IsValid(Phone.Menu) then return end
	if not (Phone.Menu.App == APP) then return end

	Phone.Menu.shell:GetChild(0).number = number
end
APP.Call = function(number)
	if not IsValid(Phone.Menu) then return end
	if not (Phone.Menu.App == APP) then return end

	Phone.Menu.shell:GetChild(0).call.DoClick()
end
APP.EndCall = function()
	if not IsValid(Phone.Menu) then return end
	if not (Phone.Menu.App == APP) then return end

	timer.Remove("Phone:AutoReject")
	Phone.Menu.shell:Clear()
	APP.Function(Phone.Menu.shell)
end
APP.RequestCall = function(number)
	if not IsValid(Phone.Menu) then
		Phone.Core.Menu()
	end

	Phone.App.SetApp("call")
	APP.CallRequest(Phone.Menu.shell, number)
end
APP.StartCall = function(number)
	if not IsValid(Phone.Menu) then
		Phone.Core.Menu()
	end

	Phone.App.SetApp("call")
	APP.CallStarted(Phone.Menu.shell, number)
end


Phone.App.Register(APP)