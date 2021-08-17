-- Cache
local scrW, scrH = ScrW, ScrH
local vgui_create = vgui.Create
local draw_box = draw.RoundedBox
local color = Color
local surface_setdrawcolor = surface.SetDrawColor
local surface_setmaterial = surface.SetMaterial
local surface_drawtexturedrect = surface.DrawTexturedRect
local surface_drawtexturedrectrotated = surface.DrawTexturedRectRotated

-- Color cache
local background = color(18, 18, 18)
local outline = color(31, 31, 31)
local white = color(222, 222, 222)
local whiteShaded = color(155, 155, 155)
local black = color(0, 0, 0)
local blackShaded = color(55, 55, 55)
local headerDefault = color(2, 108, 254)
local headerShader = color(0, 0, 0, 55)
local headerCloseShader = color(0, 0, 0, 100)

-- Material cache
local gradientDown = Material("gui/gradient_down")
local gradientUp = Material("gui/gradient_up")
local gradientMain = Material("gui/gradient")
function XYZUI.Frame(title, frameColor, noClose, noHeader, noPopup)
	-- Base frame
	local frame = vgui_create("DFrame")
	frame:SetSize(scrW()*0.5, scrH()*0.5)
	frame:Center()
	if not noPopup then
		frame:MakePopup()
	end
	frame:SetTitle("")
	frame:SetDraggable(false)
	frame:ShowCloseButton(false)
	frame:DockPadding(10, 10, 10, 10)

	frame.header = string.upper(title or "Set my title please :P")
	frame.headerColor = frameColor or headerDefault
	frame.master = frame

	function frame:SetHeader(header)
		frame.header = header
	end

	function frame.Paint(self, w, h)
		draw_box(0, 0, 0, w, h, background)
	end

	if not noHeader then
		-- Header
		local header = vgui_create("DPanel", frame)
		frame._header = header
		header:Dock(TOP)
		header:DockMargin(0, 0, 0, 10)
		header:SetTall(35)
	
		local halfHeight = nil
		function header.Paint(self, w, h)
			draw_box(0, 0, 0, w, h, frame.headerColor)
			draw_box(0, 0, self:GetTall()/2, w, self:GetTall()/2, headerShader)
	
			XYZUI.DrawText(frame.header, 28, 10, h/2, white, TEXT_ALIGN_LEFT)
		end

		-- Close
		if not noClose then
			local close = vgui_create("DButton", header)
			frame._close = close
			close:Dock(RIGHT)
			close:SetWide(header:GetTall())
			close:SetText("")
		
			function close.Paint(self, w, h)
				draw_box(0, 0, 0, w, h, headerCloseShader)
				if self:IsHovered() then
					XYZUI.DrawText("X", 35, w/2, h/2, white)
				else
					XYZUI.DrawText("X", 35, w/2, h/2, whiteShaded)
				end
			end
		
			function close.DoClick()
				frame:Close()
			end
		end
	end

	return frame
end

local gradientSize = 20
function XYZUI.Container(frame)
	if not IsValid(frame) then return end

	local shell = vgui_create("DPanel", frame)
	shell:Dock(FILL)
	shell:DockPadding(2, 2, 2, 2)
	frame.container = shell
	shell.headerColor = frame.headerColor or headerDefault
	shell.master = frame.master

	function shell.Paint(self, w, h)
		draw_box(0, 0, 0, w, h, background)
		
		surface_setdrawcolor(0, 0, 0, 255)
		surface_setmaterial(gradientDown)
		surface_drawtexturedrect(0, 0, w, gradientSize)
		surface_setmaterial(gradientUp)
		surface_drawtexturedrect(0, h-gradientSize, w, gradientSize)
		surface_setmaterial(gradientMain)
		surface_drawtexturedrect(0, 0, gradientSize, h)
		surface_drawtexturedrectrotated(w-(gradientSize/2), h/2, gradientSize, h, 180)
	
		draw_box(0, 0, 0, w, 2, outline)
		draw_box(0, w-2, 0, 2, h, outline)
		draw_box(0, 0, h-2, w, 2, outline)
		draw_box(0, 0, 0, 2, h, outline)
	end

	return shell
end

function XYZUI.Confirm(action, frameColor, btnAction)
	local background = vgui.Create("DFrame")
	background:SetSize(ScrW(), ScrH())
	background:MakePopup()
	background:SetTitle("")
	background:SetDraggable(false)
	background:ShowCloseButton(false)
	background.Paint = function(self, w, h)
		 XYZUI.DrawBlur(0, 0, w, h, 3)
	end
	
	local confirmFrame = XYZUI.Frame(action, frameColor)
	confirmFrame:SetSize(background:GetWide()/4, 120)
	confirmFrame:Center()
	confirmFrame:SetParent(background)
	confirmFrame.OnClose = function()
		background:Remove()
	end
	function confirmFrame:Think()
		self:MoveToFront()
	end
	-- Detour the btnAction func to automatically close background
	local old_btnAction = btnAction
	btnAction = function() old_btnAction() background:Close() end 
	local confirmBtn = XYZUI.ButtonInput(confirmFrame, "Confirm", btnAction)
	confirmBtn:Dock(FILL)

	return background, confirmFrame, confirmBtn
end

function XYZUI.PromptInput(action, frameColor, placeholder, btnAction)
	local background = vgui.Create("DFrame")
	background:SetSize(ScrW(), ScrH())
	background:MakePopup()
	background:SetTitle("")
	background:SetDraggable(false)
	background:ShowCloseButton(false)
	background.Paint = function(self, w, h)
		 XYZUI.DrawBlur(0, 0, w, h, 3)
	end
	
	local confirmFrame = XYZUI.Frame(action, frameColor)
	confirmFrame:SetSize(background:GetWide()/4, 155)
	confirmFrame:Center()
	confirmFrame:SetParent(background)
	confirmFrame.OnClose = function()
		background:Remove()
	end
	function confirmFrame:Think()
		self:MoveToFront()
	end


	local confirmEntry, cont = XYZUI.TextInput(confirmFrame)
	if placeholder then
		confirmEntry.placeholder = placeholder
	end

	-- Detour the btnAction func to automatically close background
	local old_btnAction = btnAction
	btnAction = function() old_btnAction(confirmEntry:GetText()) background:Close() end 
	local confirmBtn = XYZUI.ButtonInput(confirmFrame, "Confirm", btnAction)
	confirmBtn:Dock(BOTTOM)

	return background, confirmFrame, confirmEntry, confirmBtn
end 
