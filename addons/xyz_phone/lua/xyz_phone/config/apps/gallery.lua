local APP = {}

-- Base data
APP.name = "Gallery"
APP.id = "gallery"
APP.desc = "View your photos" -- Used in the app store
APP.appStore = false -- Can be installed from the app store
APP.show = true -- Show the app on the home

-- Background
APP.Icon = function(w, h)
	surface.SetMaterial(XYZShit.Image.GetMat("phone_app_gallery"))
	surface.SetDrawColor(255, 255, 255, 255)
	surface.DrawTexturedRect(0, 0, w, h)
end

-- Functionality
local transWhite = Color(255, 255, 255, 170)
APP.Function = function(shell)
	local header = vgui.Create("DPanel", shell)
	header:Dock(TOP)
	header:SetTall(50)
	header:DockMargin(0, 0, 0, 5)
	header.Paint = function(self, w, h)
		XYZUI.DrawScaleText("Gallery", 13, w*0.5, h*0.5, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		draw.RoundedBox(0, 0, h-2, w, 2, transWhite)
	end

	local grid = vgui.Create("ThreeGrid", shell)
	grid:Dock(FILL)
	grid:InvalidateParent(true)
	grid:SetColumns(4)
	grid:SetVerticalMargin(2)
	grid:SetHorizontalMargin(2)
	grid:GetVBar():SetWide(0)
	grid:DockMargin(6, 6, 6, 6)
	grid:SetVerticalScrollbarEnabled(true)

	local images = file.Find("xyz/phone/snapper/*.jpg", "DATA")
	grid.PerformLayout = function(self, width, height)
		grid:Clear()
		for k, v in ipairs(images) do
			local imageMat = Material("data/xyz/phone/snapper/"..v)

			local pnl = vgui.Create("DButton")
			pnl:SetTall((width/4) - 8)
			pnl:DockMargin(0, 0, 5, 0)
			pnl:SetText("")
			grid:AddCell(pnl)
			pnl.Paint = function(self, w, h)
				surface.SetMaterial(imageMat)
				surface.SetDrawColor(255, 255, 255, 255)
				surface.DrawTexturedRect(0, h*-0.75, w, h*2.5)
			end
			pnl.DoClick = function()
				shell:Clear()

				local view = vgui.Create("DPanel", shell)
				view:Dock(FILL)
				view.Paint = function(self, w, h)
					surface.SetMaterial(imageMat)
					surface.SetDrawColor(255, 255, 255, 255)
					surface.DrawTexturedRect(0, 0, w, h)
				end
	
				local controls = vgui.Create("DPanel", view)
				controls:SetSize(shell:GetWide(), shell:GetTall()*0.1)
				controls:SetPos(0, shell:GetTall()-(shell:GetTall()*0.1))
				controls.Paint = function(self, w, h)
					draw.RoundedBox(0, 0, 0, w, h, transWhite)
				end

					local back = vgui.Create("DButton", controls)
					back:Dock(LEFT)
					back:SetWide(shell:GetWide()/3)
					back:SetText("")
					back.Paint = function(self, w, h)
						XYZUI.DrawScaleText("<", 9, w*0.5, h*0.5)
					end
					back.DoClick = function()
						shell:Clear()
						APP.Function(shell)
					end

					local share = vgui.Create("DButton", controls)
					share:Dock(LEFT)
					share:SetWide(shell:GetWide()/3)
					share:SetText("")
					share.Paint = function(self, w, h)
						XYZUI.DrawScaleText("Share", 9, w*0.5, h*0.5)
					end
					share.DoClick = function()
						local imageTag = string.Split(v, ".")[1]
						local imageData = file.Read("xyz/phone/snapper/"..imageTag.."_data.txt")
						if not imageData then
							XYZShit.Msg("Phone", Phone.Config.Color, "There seems to be an error with this image...")
							return
						end
						imageData = util.JSONToTable(imageData)

						if not imageData.code then
							XYZShit.Msg("Phone", Phone.Config.Color, "There seems to be an error with this image...")
							return
						end
						SetClipboardText("http://media.ntwrk.xyz/"..imageData.code..".jpg")
						XYZShit.Msg("Phone", Phone.Config.Color, "A link to the image has been saved to your clipboard")
					end

					local delete = vgui.Create("DButton", controls)
					delete:Dock(LEFT)
					delete:SetWide(shell:GetWide()/3)
					delete:SetText("")
					delete.Paint = function(self, w, h)
						XYZUI.DrawScaleText("Delete", 9, w*0.5, h*0.5)
					end
					delete.DoClick = function()
						file.Delete("xyz/phone/snapper/"..v)
						back.DoClick()
					end
			end
		end
	end
end

Phone.App.Register(APP)