local APP = {}

-- Base data
APP.name = "Contacts"
APP.id = "contacts"
APP.desc = "Save and edit contacts" -- Used in the app store
APP.appStore = false -- Can be installed from the app store
APP.show = true -- Show the app on the home

-- Background
APP.Icon = function(w, h)
	surface.SetMaterial(XYZShit.Image.GetMat("phone_app_contacts"))
	surface.SetDrawColor(255, 255, 255, 255)
	surface.DrawTexturedRect(0, 0, w, h)
end


-- Create the table and store ourself in it

-- Functionality
local transWhite = Color(255, 255, 255, 170)
local transGreen = Color(204, 204, 0, 255)
local accent = Color(4, 141, 255)
local dark = Color(30, 30, 30)
APP.Function = function(shell)
	if not sql.TableExists("xyz_phone_contact") then
		sql.Query("CREATE TABLE xyz_phone_contact(name TEXT, number TEXT, icon TEXT)")
		sql.Query("INSERT INTO xyz_phone_contact VALUES('Me', "..sql.SQLStr(Phone.Core.GetPhoneNumber(LocalPlayer():SteamID64()))..", '')")
	end

	local header = vgui.Create("DPanel", shell)
	header:Dock(TOP)
	header:SetTall(50)
	header:DockMargin(0, 0, 0, 5)
	header.Paint = function(self, w, h)
		XYZUI.DrawScaleText("Contacts", 13, w*0.5, h*0.5, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		draw.RoundedBox(0, 0, h-2, w, 2, transWhite)
	end

	local grid = vgui.Create("ThreeGrid", shell)
	grid:Dock(FILL)
	grid:InvalidateParent(true)
	grid:SetColumns(2)
	grid:SetVerticalMargin(2)
	grid:SetHorizontalMargin(2)
	grid:GetVBar():SetWide(0)
	grid:DockMargin(6, 6, 6, 6)
	grid:SetVerticalScrollbarEnabled(true)

	grid.PerformLayout = function(self, width, height)
		grid:Clear()

		for k, v in ipairs(APP.GetContacts()) do
			local imageMat = (not (v.icon == "")) and Material("data/xyz/phone/snapper/"..v.icon)

			local pnl = vgui.Create("DButton")
			pnl:SetTall((width/2) - 2)
			pnl:DockMargin(0, 0, 5, 0)
			pnl:SetText("")
			grid:AddCell(pnl)
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
					XYZUI.DrawCircle(w*0.5, h*0.5, h*0.4, 1)
				
					render.SetStencilFailOperation(STENCILOPERATION_ZERO)
					render.SetStencilPassOperation(STENCILOPERATION_REPLACE)
					render.SetStencilZFailOperation(STENCILOPERATION_ZERO)
					render.SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_EQUAL)
					render.SetStencilReferenceValue(1)

						surface.SetMaterial(imageMat)
						surface.SetDrawColor(255, 255, 255, 100)
						surface.DrawTexturedRect(0, h*-0.75, h, h*2.5)
				
					render.SetStencilEnable(false)
					render.ClearStencil()
				end

				XYZUI.DrawScaleText(v.name, 8, w*0.5, h*0.5, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			end
			pnl.DoClick = function()
				shell:Clear()

				local view = vgui.Create("DPanel", shell)
				view:Dock(FILL)
				view.Paint = nil
	
				local name = vgui.Create("DPanel", view)
				name:Dock(TOP)
				name:SetTall(70)
				name.Paint = function(self, w, h)
					XYZUI.DrawScaleText(v.name, 9, w*0.5, h*0.5, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM)
					XYZUI.DrawScaleText(v.number, 6, w*0.5, h*0.5, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
				end


				local backToContacts = vgui.Create("DButton", shell)
				backToContacts:Dock(BOTTOM)
				backToContacts:SetTall(40)
				backToContacts:SetText("")
				backToContacts.Paint = function(self, w, h)
					draw.RoundedBox(0, 0, 0, w, h, transWhite)
					XYZUI.DrawScaleText("<", 9, w*0.5, h*0.5)
				end
				backToContacts.DoClick = function()
					shell:Clear()
					APP.Function(shell)
				end
				backToContacts:DockMargin(0, 5, 0, 0)

				if not (Phone.Core.GetPhoneNumber(LocalPlayer():SteamID64()) == v.number) then 
					local deleteContact = vgui.Create("DButton", shell)
					deleteContact:Dock(BOTTOM)
					deleteContact:SetTall(40)
					deleteContact:SetText("")
					deleteContact.Paint = function(self, w, h)
						draw.RoundedBox(0, 0, 0, w, h, transWhite)
						XYZUI.DrawScaleText("Delete", 9, w*0.5, h*0.5)
					end
					deleteContact.DoClick = function()
						APP.DeleteContact(v.number)
						shell:Clear()
						APP.Function(shell)
					end
					deleteContact:DockMargin(0, 5, 0, 0)
				end
				local sendText = vgui.Create("DButton", shell)
				sendText:Dock(BOTTOM)
				sendText:SetTall(40)
				sendText:SetText("")
				sendText.Paint = function(self, w, h)
					draw.RoundedBox(0, 0, 0, w, h, transWhite)
					XYZUI.DrawScaleText("Send Text", 9, w*0.5, h*0.5)
				end
				sendText.DoClick = function()
					local bubble = Phone.App.GetApp("bubble")
					local texts = bubble.GetTexts(v.number)
					if table.IsEmpty(texts) then
						bubble.SaveText(v.number, true, "This is the start of the conversation")
					end

					Phone.App.SetApp("bubble")
				end
				sendText:DockMargin(0, 5, 0, 0)

				local call = vgui.Create("DButton", shell)
				call:Dock(BOTTOM)
				call:SetTall(40)
				call:SetText("")
				call.Paint = function(self, w, h)
					draw.RoundedBox(0, 0, 0, w, h, transWhite)
					XYZUI.DrawScaleText("Call", 9, w*0.5, h*0.5)
				end
				call.DoClick = function()
					local callApp = Phone.App.GetApp("call")
					Phone.App.SetApp("call")
					timer.Simple(0, function()
						callApp.SetNumber(v.number)
						--callApp.Call()
					end)
				end
				call:DockMargin(0, 5, 0, 0)

				local copyNumber = vgui.Create("DButton", shell)
				copyNumber:Dock(BOTTOM)
				copyNumber:SetTall(40)
				copyNumber:SetText("")
				copyNumber.Paint = function(self, w, h)
					draw.RoundedBox(0, 0, 0, w, h, transWhite)
					XYZUI.DrawScaleText("Copy Number", 9, w*0.5, h*0.5)
				end
				copyNumber.DoClick = function()
					SetClipboardText(v.number)
				end
				copyNumber:DockMargin(0, 5, 0, 0)
			end
		end
	end

	local addContact = vgui.Create("DButton", shell)
	addContact:Dock(BOTTOM)
	addContact:SetTall(40)
	addContact:SetText("")
	addContact.Paint = function(self, w, h)
		draw.RoundedBox(0, 0, 0, w, h, transWhite)
		XYZUI.DrawScaleText("New Contact", 9, w*0.5, h*0.5)
	end
	addContact.DoClick = function()
		shell:Clear()

		local view = vgui.Create("DPanel", shell)
		view:Dock(FILL)
		view.Paint = nil
		view:DockPadding(10, 0, 10, 0)

		local name = vgui.Create("DPanel", view)
		name:Dock(TOP)
		name:SetTall(45)
		name.Paint = function(self, w, h)
			XYZUI.DrawScaleText("Name", 9, 0, 0, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
		end
			name.entry = vgui.Create("DTextEntry", name)
			name.entry:Dock(BOTTOM)
			name.entry.Paint = function(self, w, h)
				draw.RoundedBox(5, 0, 0, w, h, dark)
				self:DrawTextEntryText(color_white, accent, color_white)
			end
			name.entry.OnGetFocus = function()
				Phone.Menu:MakePopup()
			end
			name.entry.OnLoseFocus = function()
				Phone.Menu:SetKeyboardInputEnabled(false)
			end

		local number = vgui.Create("DPanel", view)
		number:Dock(TOP)
		number:SetTall(45)
		number.Paint = function(self, w, h)
			XYZUI.DrawScaleText("Number", 9, 0, 0, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
		end
			number.entry = vgui.Create("DTextEntry", number)
			number.entry:Dock(BOTTOM)
			number.entry:SetNumeric(true)
			number.entry.Paint = function(self, w, h)
				draw.RoundedBox(5, 0, 0, w, h, dark)
				self:DrawTextEntryText(color_white, accent, color_white)
			end
			number.entry.OnGetFocus = function()
				Phone.Menu:MakePopup()
			end
			number.entry.OnLoseFocus = function()
				Phone.Menu:SetKeyboardInputEnabled(false)
			end

		local icon = vgui.Create("DPanel", view)
		icon:Dock(TOP)
		icon:SetTall(150)
		icon.Paint = function(self, w, h)
			XYZUI.DrawScaleText("Icon", 9, 0, 0, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
		end
			icon.grid = vgui.Create("ThreeGrid", icon)
			icon.grid:Dock(BOTTOM)
			icon.grid:SetTall(120)
			icon.grid:InvalidateParent(true)
			icon.grid:SetColumns(4)
			icon.grid:SetVerticalMargin(2)
			icon.grid:SetHorizontalMargin(2)
			icon.grid:GetVBar():SetWide(0)
			icon.grid:DockMargin(6, 6, 6, 6)
			icon.grid:SetVerticalScrollbarEnabled(true)
	
			local images = file.Find("xyz/phone/snapper/*.jpg", "DATA")
			local selectedImage
			icon.grid.PerformLayout = function(self, width, height)
				icon.grid:Clear()
				for k, v in ipairs(images) do
					local imageMat = Material("data/xyz/phone/snapper/"..v)
		
					local pnl = vgui.Create("DButton")
					pnl:SetTall((width/4) - 6)
					pnl:DockMargin(0, 0, 5, 0)
					pnl:SetText("")
					icon.grid:AddCell(pnl)
					pnl.Paint = function(self, w, h)
						surface.SetMaterial(imageMat)
						surface.SetDrawColor(255, 255, 255, 255)
						surface.DrawTexturedRect(0, h*-0.75, w, h*2.5)

						if selectedImage == v then
							draw.RoundedBox(0, 0, 0, w, 2, transGreen)
							draw.RoundedBox(0, 0,  h-2, w, 2, transGreen)
							draw.RoundedBox(0, 0, 0, 2, h-2, transGreen)
							draw.RoundedBox(0, w-2, 0, 2, h-2, transGreen)
						end
					end
					pnl.DoClick = function()
						if not (selectedImage == v) then
							selectedImage = v
						else
							selectedImage = nil
						end
					end
				end
			end

		local createContact = vgui.Create("DButton", shell)
		createContact:Dock(BOTTOM)
		createContact:SetTall(40)
		createContact:SetText("")
		createContact.Paint = function(self, w, h)
			draw.RoundedBox(0, 0, 0, w, h, transWhite)
			XYZUI.DrawScaleText("Create Contact", 9, w*0.5, h*0.5)
		end
		createContact.DoClick = function()
			local name = name.entry:GetText()
			if (not name) or (name == "") then return end
			local number = tonumber(number.entry:GetText())
			if (not number) or (number < 0) then return end


			sql.Query("INSERT INTO xyz_phone_contact VALUES("..sql.SQLStr(name)..", "..sql.SQLStr(number)..","..sql.SQLStr(selectedImage or "")..")")

			shell:Clear()
			APP.Function(shell)
		end
	end
end

APP.GetContact = function(number)
	local contact = sql.Query("SELECT * FROM xyz_phone_contact WHERE number="..sql.SQLStr(number).." LIMIT 1")
	if not contact then return end

	return contact[1]
end
APP.DeleteContact = function(number)
	sql.Query("DELETE FROM xyz_phone_contact WHERE number="..sql.SQLStr(number))
end
APP.GetContacts = function()
	return sql.Query("SELECT * FROM xyz_phone_contact") or {}
end
Phone.App.Register(APP)