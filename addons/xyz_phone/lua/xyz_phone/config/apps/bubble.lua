local APP = {}

-- Base data
APP.name = "Bubble"
APP.id = "bubble"
APP.desc = "Message your friends" -- Used in the app store
APP.appStore = false -- Can be installed from the app store
APP.show = true -- Show the app on the home

-- Background
APP.Icon = function(w, h)
	surface.SetMaterial(XYZShit.Image.GetMat("phone_app_bubble"))
	surface.SetDrawColor(255, 255, 255, 255)
	surface.DrawTexturedRect(0, 0, w, h)
end
-- Functionality
local myTexts = Color(4, 141, 255)
local theirTexts = Color(30, 30, 30)
local header = Color(26, 26, 26)
local dark = Color(30, 30, 30)
local transWhite = Color(255, 255, 255, 170)
APP.Function = function(shell)
	local header = vgui.Create("DPanel", shell)
	header:Dock(TOP)
	header:SetTall(50)
	header:DockMargin(0, 0, 0, 5)
	header.Paint = function(self, w, h)
		XYZUI.DrawScaleText("Bubble", 13, w*0.5, h*0.5, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		draw.RoundedBox(0, 0, h-2, w, 2, transWhite)
	end

	local contacts = vgui.Create("DScrollPanel", shell)
	contacts:Dock(FILL)
	contacts:GetVBar():SetWide(0)

	contacts.PerformLayout = function(self, width, height)
		contacts:Clear()

		local allContacts = {}
		for k, v in pairs(APP.GetNumbers()) do
			local lastText = APP.GetTexts(v.number)
			lastText = lastText[#lastText]

			table.insert(allContacts, {number = v.number, lastText = lastText})
		end
		for k, v in ipairs(allContacts) do
			local contact = Phone.App.GetApp("contacts").GetContact(v.number) or {name = "Unknown", number = v.number, icon = ""}
			local imageMat = (not (contact.icon == "")) and Material("data/xyz/phone/snapper/"..contact.icon)

			local pnl = contacts:Add("DButton")
			pnl:Dock( TOP )
			pnl:SetTall(50)
			pnl:DockMargin(0, 0, 0, 5)
			pnl:SetText("")

			pnl.Paint = function(self, w, h)
				if imageMat then
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
					XYZUI.DrawCircle(h*0.5, h*0.5, h*0.4, 1)
				
					render.SetStencilFailOperation(STENCILOPERATION_ZERO)
					render.SetStencilPassOperation(STENCILOPERATION_REPLACE)
					render.SetStencilZFailOperation(STENCILOPERATION_ZERO)
					render.SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_EQUAL)
					render.SetStencilReferenceValue(1)

						surface.SetMaterial(imageMat)
						surface.SetDrawColor(255, 255, 255, 255)
						surface.DrawTexturedRect(0, h*-0.75, h, h*2.5)
				
					render.SetStencilEnable(false)
					render.ClearStencil()
				end

				if v.lastText and (v.lastText.read == "0") then
					draw.NoTexture()
					surface.SetDrawColor(255, 0, 0, 255)
					XYZUI.DrawCircle(w*0.95, h*0.5, h*0.1, 1)
				end

				XYZUI.DrawScaleText(contact.name, 10, h + 5, h*0.5 + 5, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM)
				XYZUI.DrawScaleText(v.lastText and  XYZUI.CharLimit(v.lastText.message, 20) or "Send them a text!", 7, h + 5, h*0.5, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
			end
			local function loadFeed()
				shell:Clear()

				APP.SetRead(contact.number)
		
				local view = vgui.Create("DPanel", shell)
				view.number = contact.number
				view.loadFeed = loadFeed
				view:Dock(FILL)
				view.Paint = nil
				view:DockPadding(10, 0, 10, 5)

				local name = vgui.Create("DButton", view)
				name:Dock(TOP)
				name:SetTall(50)
				name:SetText("")
				name.Paint = function(self, w, h)
					XYZUI.DrawScaleText(contact.name, 9, w*0.5, h*0.5, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM)
					XYZUI.DrawScaleText(contact.number, 6, w*0.5, h*0.5-2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
				end
				name.DoClick = function()
					SetClipboardText(contact.number)
					XYZShit.Msg("Phone", Phone.Config.Color, "Number copied to clipboard")
				end

				local texts = vgui.Create("DScrollPanel", view)
				texts:Dock(FILL)
				texts:GetVBar():SetWide(0)

				local myNumber = Phone.Core.GetPhoneNumber(LocalPlayer():SteamID64())

				for k, v in ipairs(APP.GetTexts(contact.number)) do
					local bubble = texts:Add("DButton")
					bubble:Dock(TOP)
					bubble:SetTall(0)
					bubble:DockMargin(tobool(v.sentbyme) and 15 or 5, 0, tobool(v.sentbyme) and 5 or 15, 5)
					bubble:DockPadding(5, 5, 5, 5)
					bubble:SetText("")
					bubble.Paint = function(self, w, h)
						draw.RoundedBox(10, 0, 0, w, h, tobool(v.sentbyme) and myTexts or theirTexts)
					end
					bubble.text = vgui.Create("DLabel", bubble)
					bubble.text:Dock(FILL)
					bubble.text:SetWrap(true)
					bubble.text:SetContentAlignment(7)
					bubble.text:SetFont("xyz_ui_main_font_20")
					bubble.text:SetText(v.message)
					bubble.text:SetTextColor(color_white)
					bubble.text.Think = function(self)
						bubble.text:SizeToContentsY()
						bubble:SizeToChildren(false, true)
					end
				end

				local newText = vgui.Create("DPanel", shell)
				newText:Dock(BOTTOM)
				newText:SetTall(30)
				newText:DockPadding(10, 0, 10, 5)
				newText.Paint = function(self, w, h)
				end
					newText.entry = vgui.Create("DTextEntry", newText)
					newText.entry:Dock(FILL)
					newText.entry.OnEnter = function(self, text)
						if text == "" then return end

						APP.SaveText(contact.number, true, text)

						net.Start("Phone:SendText")
							net.WriteString(contact.number)
							net.WriteString(text)
						net.SendToServer()

						loadFeed()
					end
					newText.entry.Paint = function(self, w, h)
						draw.RoundedBox(5, 0, 0, w, h, dark)
						self:DrawTextEntryText(color_white, myTexts, color_white)
					end
					newText.entry.OnGetFocus = function()
						Phone.Menu:MakePopup()
					end
					newText.entry.OnLoseFocus = function()
						Phone.Menu:SetKeyboardInputEnabled(false)
					end

					newText.back = vgui.Create("DButton", newText)
					newText.back:Dock(LEFT)
					newText.back:SetText("")
					newText.back:SetWide(30)
					newText.back:DockMargin(0, 0, 5, 0)
					newText.back.Paint = function(self, w, h)
						draw.RoundedBox(5, 0, 0, w, h, dark)
						XYZUI.DrawScaleText("<", 5, w*0.5, h*0.5, color_white)
					end
					newText.back.DoClick = function()
						shell:Clear()
						APP.Function(shell)
					end

				view.PerformLayout = function(self, width, height)
					local lastText = texts:GetChildren()[1]:GetChildren()[#texts:GetChildren()[1]:GetChildren()]
					if not lastText then return end

					texts:ScrollToChild(lastText)
				end
			end
			pnl.DoClick = loadFeed
		end
	end
end

APP.GetTexts = function(number)
	return sql.Query("SELECT * FROM xyz_phone_texts WHERE number = "..sql.SQLStr(number).." ORDER BY time") or {}
end
APP.GetNumbers = function(number)
	return sql.Query("SELECT DISTINCT number, MAX(time) FROM xyz_phone_texts GROUP BY number ORDER BY MAX(time) DESC, number") or {}
end
APP.SetRead = function(number)
	sql.Query("UPDATE xyz_phone_texts SET read=1 WHERE number = "..sql.SQLStr(number))
end

APP.SaveText = function(number, sentByMe, message)
	if not sql.TableExists("xyz_phone_texts") then
		sql.Query("CREATE TABLE xyz_phone_texts(number TEXT, sentbyme INT(1), message TEXT, read INT(1), time TEXT)")
	end

	if (not number) or (number == "") then return end
	if (not message) or (message == "") then return end

	number = sql.SQLStr(number)
	message = sql.SQLStr(message)


	sql.Query(string.format("INSERT INTO xyz_phone_texts VALUES(%s, %i, %s, %i, %i)", number, sentByMe and 1 or 0, message, sentByMe and 1 or 0, os.time()))
end

Phone.App.Register(APP)