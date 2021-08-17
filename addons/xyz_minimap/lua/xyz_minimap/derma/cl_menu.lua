Minimap.Menu = Minimap.Menu or nil
function Minimap.BuildMinimap()
	if IsValid(Minimap.Menu) then return Minimap.Menu end

	Minimap.Menu = XYZUI.Frame("Minimap", Minimap.Config.Color, true, false, true)
	Minimap.Menu:SetSize(ScrH()*0.9, ScrH()*0.9)
    Minimap.Menu:Center()

	Minimap.Menu.Image = vgui.Create("DImage", Minimap.Menu)
	Minimap.Menu.Image:Dock(FILL)
	Minimap.Menu.Image:SetMaterial(XYZShit.Image.GetMat("rp_rockford_v2b_xyz_v1a_overhead"))


	Minimap.Menu.Waypoints = vgui.Create("DPanel", Minimap.Menu.Image)
	Minimap.Menu.Waypoints:Dock(FILL)
	Minimap.Menu.Waypoints.Paint = function(self, w, h)
		if not XYZSettings.GetSetting("minmap_show_icons", true) then return end

		local adjustH = Minimap.Menu.Image:GetTall()
		local adjustW = Minimap.Menu.Image:GetWide()
		hook.Run("MinimapThink")
		for k, v in pairs(Minimap.Waypoints) do
			surface.SetDrawColor(v.color)
		    surface.SetMaterial(XYZShit.Image.GetMat(v.image))

		    local scale = 20*v.scale
		    surface.DrawTexturedRectRotated(v.pos.x*adjustW, v.pos.y*adjustH, scale, scale, v.ang)
		    XYZUI.DrawTextOutlined(v.name, 20, v.pos.x*adjustW, v.pos.y*adjustH+(5*v.scale), v.color, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1)
		end
	end

	return Minimap.Menu
end


local scrw, scrh = ScrW, ScrH
local ammoW, ammoH =  math.Clamp(scrw()*0.12, 200, 300), scrh()*0.042+15+(scrw() > 1920 and ScreenScale(3) or 0)
local ammoStartW, ammoStartH = scrw()-ammoW-5, scrh()-ammoH-5 
local startPosW, startPosH = ammoStartW, ammoStartH - ammoW-5
local renderSize, renderSizeScissor = ammoW*4, scrh()-ammoH-10
local deadPos = {x = 0, y = 0}
hook.Add("HUDPaint", "Minimap:HUD", function()
	if not XYZSettings.GetSetting("minimap_toggle_hud", true) then return end
	if IsValid(Minimap.Menu) then return end
	if IsValid(LocalPlayer():GetActiveWeapon()) and (LocalPlayer():GetActiveWeapon():GetClass() == "xyz_news_camera") then return end

	renderSize = ammoW*math.Clamp(XYZSettings.GetSetting("minmap_hud_zoom", 4), 1, 8)

	surface.SetDrawColor(color_white)
	surface.SetMaterial(XYZShit.Image.GetMat("rp_rockford_v2b_xyz_v1a_overhead"))

	render.SetScissorRect(startPosW, startPosH, scrw()-5, renderSizeScissor, true) -- Enable the rect
		if not XYZSettings.GetSetting("minmap_show_icons", true) then
			renderSize = ammoW
			plyOffset = deadPos
		else
			plyOffset = Minimap.Waypoints.localplayer.pos
		end

		local offsetX, offsetY = startPosW-(plyOffset.x*renderSize)+(ammoW*0.5), startPosH-(plyOffset.y*renderSize)+(ammoW*0.5)

		offsetX = math.Clamp(offsetX, startPosW - renderSize + ammoW, startPosW)
		offsetY = math.Clamp(offsetY, startPosH - renderSize + ammoW, startPosH)

		surface.DrawTexturedRect(offsetX, offsetY, renderSize, renderSize)

		if XYZSettings.GetSetting("minmap_show_icons", true) then
			hook.Run("MinimapThink")

			for k, v in pairs(Minimap.Waypoints) do
				surface.SetDrawColor(v.color)
			    surface.SetMaterial(XYZShit.Image.GetMat(v.image))
		
			    local scale = 20*v.scale
			    local clampX, clampY = offsetX + (v.pos.x*renderSize), offsetY + (v.pos.y*renderSize)
	
	
				if XYZSettings.GetSetting("minmap_clamp_icons", true) then
			    	clampX = math.Clamp(clampX, scrw()-5-ammoW, scrw()-5)
			    	clampY = math.Clamp(clampY, renderSizeScissor-ammoW, renderSizeScissor)
				end

			    surface.DrawTexturedRectRotated(clampX, clampY, scale, scale, v.ang)
			    XYZUI.DrawTextOutlined(v.name, 20, clampX, clampY+(5*v.scale), v.color, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1)
			end
		end
	render.SetScissorRect(0, 0, 0, 0, false) -- Disable after you are done
end)

net.Receive("Minimap:Sign:UI", function()
	local sign = net.ReadEntity()

	local frame = XYZUI.Frame("Redesign Sign!", Minimap.Config.Color)
	frame:SetSize(648, 324)
	frame:Center()
	local shell = XYZUI.Container(frame)
    shell:DockPadding(10, 5, 10, 10)

    local shellLeft = XYZUI.Container(shell)
    shellLeft.Paint = nil
    shellLeft:Dock(LEFT)
    shellLeft:SetWide(frame:GetWide()/5)
    local shellRight = XYZUI.Container(shell)
    shellRight.Paint = nil

    XYZUI.PanelText(shellRight, "Display Name (30 char limit)", 35, TEXT_ALIGN_LEFT)
    local nameEntry, cont = XYZUI.TextInput(shellRight)
    nameEntry:SetText(sign:GetDisplayName() or "")


	local image = vgui.Create("DImage", shellLeft)
	image:Dock(TOP)
	image:SetSize(shellLeft:GetWide(), shellLeft:GetWide())

    XYZUI.PanelText(shellRight, "Image", 35, TEXT_ALIGN_LEFT)

	local counter = sign:GetDisplayImage() or 1
	image:SetMaterial(XYZShit.Image.GetMat("minimap_sign"..counter))
	local nextBtn = XYZUI.ButtonInput(shellRight, "Next", function()
		counter = counter + 1
	
		if counter > Minimap.Config.SignImageCounter then
			counter = 1
		end
	
		image:SetMaterial(XYZShit.Image.GetMat("minimap_sign"..counter))
	end)
	nextBtn:DockMargin(0, 5, 0, 5)
	local backBtn = XYZUI.ButtonInput(shellRight, "Back", function()
		counter = counter - 1
	
		if counter <= 0 then
			counter = Minimap.Config.SignImageCounter
		end
	
		image:SetMaterial(XYZShit.Image.GetMat("minimap_sign"..counter))
	end)



	local completeBtn = XYZUI.ButtonInput(frame, "Submit", function()
		local txt = nameEntry:GetText()
		txt = string.Trim(txt, " ")
		if string.len(txt) == 0 then return end


		net.Start("Minimap:Sign:Update")
			net.WriteEntity(sign)
			net.WriteString(txt)
			net.WriteInt(counter, 6)
		net.SendToServer()

		frame:Close()
	end)
	completeBtn:Dock(BOTTOM)
end)