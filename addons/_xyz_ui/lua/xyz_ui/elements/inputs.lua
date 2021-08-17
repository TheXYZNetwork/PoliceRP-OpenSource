-- Cache
local scrW, scrH = ScrW, ScrH
local vgui_create = vgui.Create
local color = Color
local draw_box = draw.RoundedBox
local surface_setdrawcolor = surface.SetDrawColor
local surface_setmaterial = surface.SetMaterial
local surface_drawtexturedrect = surface.DrawTexturedRect
local surface_drawtexturedrectrotated = surface.DrawTexturedRectRotated
local math_round = math.Round
local math_clamp = math.Clamp
local lerp = Lerp

-- Color cache
local background = color(18, 18, 18)
local backgroundShaded = color(20, 20, 20)
local white = color(255, 255, 255)
local whitePlaceholder = color(155, 155, 155)
local outline = color(31, 31, 31)
local bubble = color(120, 120, 120)
local headerShader = color(0, 0, 0, 55)
local headerDefault = color(2, 108, 254)

-- Material cache
local gradientDown = Material("gui/gradient_down")
local gradientUp = Material("gui/gradient_up")
local gradientMain = Material("gui/gradient")
local gradientCenter = Material("gui/center_gradient")

local gradientSize = 10


local sinCache = {}
local cosCache = {}
for i = 0, 360 do
	sinCache[i] = math.sin(math.rad(i))
	cosCache[i] = math.cos(math.rad(i))
end
function XYZUI.DrawCircle(x, y, r, step)
    local positions = {}

    for i = 0, 360, step do
        table.insert(positions, {
            x = x + cosCache[i] * r,
            y = y + sinCache[i] * r
        })
    end

    return surface.DrawPoly(positions)
end

function XYZUI.TextInput(container, multiline, size)
	if not IsValid(container) then return end

	local inputContainer = vgui_create("DPanel", container)
	if multiline then
		inputContainer:SetHeight(120)
	else
		inputContainer:SetHeight(40)
	end
	inputContainer:Dock(TOP)
	inputContainer:DockPadding(5, 5, 5, 5)

	inputContainer.master = container.master
	inputContainer.headerColor = container.headerColor or headerDefault

	function inputContainer.Paint(self, w, h)
		draw_box(0, 0, 0, w, h, self.headerColor)
		draw_box(0, 0, 0, w, h, headerShader)
		draw_box(0, 2, 2, w-4, h-4, backgroundShaded)


		surface_setdrawcolor(0, 0, 0, 255)
		surface_setmaterial(gradientDown)
		surface_drawtexturedrect(2, 2, w-4, gradientSize)
		surface_setmaterial(gradientUp)
		surface_drawtexturedrect(2, h-gradientSize-2, w-4, gradientSize)
		surface_setmaterial(gradientMain)
		surface_drawtexturedrect(2, 2, gradientSize, h-4)
		surface_drawtexturedrectrotated(w-(gradientSize/2)-2, h/2, gradientSize, h-4, 180)
	end

	local textInput = vgui_create("DTextEntry", inputContainer)
	textInput:Dock(FILL)
	textInput:SetFont("xyz_ui_main_font_"..(size or 20))
	textInput:SetText("")
	if multiline then
		textInput:SetMultiline(true)
	end

	textInput.pulseEffect = {}
	textInput.pulseEffect.size, textInput.pulseEffect.alpha, textInput.pulseEffect.x, textInput.pulseEffect.y = 0, 0, 0, 0

	textInput.headerColor = container.headerColor or headerDefault

	function textInput.Paint(self, w, h)
		self:DrawTextEntryText(white, self.headerColor, white)

		if (self:GetText() == "") and not self:HasFocus() then
			XYZUI.DrawText(self.placeholder or "Type in me :D", size or 20, 5, h/2, whitePlaceholder, TEXT_ALIGN_LEFT)
		end

		if self.pulseEffect.alpha >= 1 then
			draw.NoTexture()
			surface_setdrawcolor(ColorAlpha(outline, self.pulseEffect.alpha))
			XYZUI.DrawCircle(self.pulseEffect.x, self.pulseEffect.y, self.pulseEffect.size, 2)
			self.pulseEffect.size = Lerp(FrameTime()*3, self.pulseEffect.size, w)
			self.pulseEffect.alpha = Lerp(FrameTime()*3, self.pulseEffect.alpha, 0)
		end
	end
	function textInput.OnFocusChanged(isMe)
		if not isMe or isMe:HasFocus() then return end
		textInput.pulseEffect.size, textInput.pulseEffect.alpha, textInput.pulseEffect.x, textInput.pulseEffect.y = 0, 255, textInput:CursorPos()
	end

	return textInput, inputContainer
end

function XYZUI.ButtonInput(container, text, callback)
	if not IsValid(container) then return end

	local buttonInput = vgui_create("DButton", container)
	buttonInput:Dock(TOP)
	buttonInput:SetTall(40)
	buttonInput:SetText("")

	buttonInput.master = container.master
	buttonInput.headerColor = container.headerColor or headerDefault
	buttonInput.disText = text or nil

	buttonInput.pulseEffect = {}
	buttonInput.pulseEffect.size, buttonInput.pulseEffect.alpha, buttonInput.pulseEffect.x, buttonInput.pulseEffect.y = 0, 0, 0, 0

	function buttonInput.Paint(self, w, h)
		draw_box(0, 0, 0, w, h, self.headerColor)
		draw_box(0, 0, 0, w, 5, headerShader)
		draw_box(0, 0, h-5, w, 5, headerShader)
		draw_box(0, 0, 5, 5, h-10, headerShader)
		draw_box(0, w-5, 5, 5, h-10, headerShader)
		XYZUI.DrawText(self.disText or "Press me ;)", 20, w/2, h/2, white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

		if self.pulseEffect.alpha >= 1 then
			draw.NoTexture()
			surface_setdrawcolor(ColorAlpha(outline, self.pulseEffect.alpha))
			XYZUI.DrawCircle(self.pulseEffect.x, self.pulseEffect.y, self.pulseEffect.size, 2)
			self.pulseEffect.size = Lerp(FrameTime()*3, self.pulseEffect.size, w)
			self.pulseEffect.alpha = Lerp(FrameTime()*3, self.pulseEffect.alpha, 0)
		end
	end

	function buttonInput.DoClick()
		buttonInput.pulseEffect.size, buttonInput.pulseEffect.alpha, buttonInput.pulseEffect.x, buttonInput.pulseEffect.y = 0, 255, buttonInput:CursorPos()
		if callback then
			callback(buttonInput)
		end
	end

	return buttonInput
end

function XYZUI.ToggleInput(container, callback)
	if not IsValid(container) then return end

	local buffer = vgui.Create("DPanel", container)
	buffer:Dock(TOP)
	buffer:SetTall(31)
	buffer.Paint = function() end
	buffer.master = container.master
	buffer.headerColor = container.headerColor or headerDefault
	buffer:InvalidateLayout(true)

	local switch = vgui.Create("DButton", buffer)
	switch:SetSize(buffer:GetTall(), buffer:GetTall())
	switch:SetText("")
	switch:SetPos(0, 0)

	switch.master = container.master
	switch.headerColor = container.headerColor or headerDefault
	switch.state = false

	function switch.Paint(self, w, h)
		draw_box(0, 0, 0, w, h, self.headerColor)
		draw_box(0, 0, 0, w, h, headerShader)
		draw_box(0, 2, 2, w-4, h-4, backgroundShaded)


		surface_setdrawcolor(0, 0, 0, 255)
		surface_setmaterial(gradientDown)
		surface_drawtexturedrect(2, 2, w-4, gradientSize)
		surface_setmaterial(gradientUp)
		surface_drawtexturedrect(2, h-gradientSize-2, w-4, gradientSize)
		surface_setmaterial(gradientMain)
		surface_drawtexturedrect(2, 2, gradientSize, h-4)
		surface_drawtexturedrectrotated(w-(gradientSize/2)-2, h/2, gradientSize, h-4, 180)

		if self.state then
			XYZUI.DrawText(system.IsLinux() and "x" or "✕", 25, w/2, h/2-1, white, TEXT_ALIGN_CENTER)
		end
	end
	function switch.DoClick()
		switch.state = not switch.state
		if callback then
			callback(switch)
		end
	end

	return switch, buffer
end


function XYZUI.DropDownList(container, title, onSelect)
	if not IsValid(container) then return end

	local buttonInput = vgui_create("DButton", container)
	buttonInput:Dock(TOP)
	buttonInput:SetTall(40)
	buttonInput:SetText("")

	buttonInput.master = container.master
	buttonInput.headerColor = container.headerColor or headerDefault
	buttonInput.isDropped = false
	buttonInput.selected = nil
	buttonInput.options = {}

	buttonInput:InvalidateParent(true)

	function buttonInput.Paint(self, w, h)
		draw_box(0, 0, 0, w, h, self.headerColor)
		draw_box(0, 0, 0, w, 5, headerShader)
		if not self.isDropped then
			draw_box(0, 5, h-5, w-10, 5, headerShader)
		end
		draw_box(0, 0, 5, 5, h-5, headerShader)
		draw_box(0, w-5, 5, 5, h-5, headerShader)

		if buttonInput.selected then
			draw_box(0, 5, 5, w-10, h-10, background)
		end
		XYZUI.DrawText((self.selected and self.selected.name) or (title or "I'll drop for you >:)"), 20, 10, h/2, white, TEXT_ALIGN_LEFT)
		if self.isDropped then
			XYZUI.DrawText("▲", 20, w-10, h/2, white, TEXT_ALIGN_RIGHT)
		else
			XYZUI.DrawText("▼", 20, w-10, h/2, white, TEXT_ALIGN_RIGHT)
		end
	end

	function buttonInput.OnRemove()
		if buttonInput.listContainer then
			buttonInput.listContainer:Remove()
			buttonInput.listContainer = nil
		end
	end

	function buttonInput:GetSelected()
		if not buttonInput.selected then
			return false
		end

		return buttonInput.selected.name, buttonInput.selected.value
	end

	buttonInput.cooldown = 0
	function buttonInput.DoClick()
		if buttonInput.cooldown > CurTime() then return end
		buttonInput.cooldown = CurTime() + 0.5

		buttonInput.isDropped = not buttonInput.isDropped

		if not buttonInput.isDropped then
			if IsValid(buttonInput.listContainer) then
				buttonInput.listContainer:Remove()
			end
			return
		end

		if buttonInput.listContainer then
			buttonInput.listContainer:Remove()
			buttonInput.listContainer = nil
		end

		local panelPosX, panelPosY = buttonInput:LocalToScreen(0, buttonInput:GetTall()-5)

		local listContainer = vgui_create("DPanel")
		listContainer:SetPos(panelPosX, panelPosY)
		listContainer:SetSize(buttonInput:GetWide(), 0)
		listContainer:MakePopup()
		listContainer:DockPadding(5, 5, 5, 5)
		listContainer:RequestFocus()
		listContainer.firstFrame = true

		listContainer.master = buttonInput.master
		listContainer.headerColor = buttonInput.headerColor or headerDefault
		listContainer.desiredSize = 400

		function listContainer:Think()
			self:MoveToFront()

			if (not self:HasFocus()) and buttonInput.isDropped then
				-- Focus is not given on the first frame
				if self.firstFrame then self.firstFrame = false return end
				buttonInput.DoClick()
				return
			end

			local containerHeight = self:GetTall()

			--listContainer:SetTall(Lerp(FrameTime()*8, listContainer:GetTall(), math_clamp((#buttonInput.options*50)+15, 0, listContainer.desiredSize) or listContainer.desiredSize))
			self:SetTall(math.Approach(containerHeight, math_clamp((#buttonInput.options*50)+15, 0, self.desiredSize) or self.desiredSize, (ScrH()*0.15) * (5*FrameTime())))

			if panelPosY + containerHeight > ScrH() then
				self:SetPos(panelPosX, ScrH() - containerHeight)
			end

			if containerHeight < 1 and (not buttonInput.isDropped) then
				self:Remove()
				return
			end
		end

		function listContainer.Paint(self, w, h)
			draw_box(0, 0, 0, w, h, self.headerColor)
			draw_box(0, 5, h-5, w-10, 5, headerShader)
			draw_box(0, 0, 0, 5, h, headerShader)
			draw_box(0, w-5, 0, 5, h, headerShader)
		end

		local _, listCont = XYZUI.Lists(listContainer, 1)
		listCont:Dock(FILL)

		for k, v in pairs(buttonInput.options) do
			local b = vgui_create("DButton", listCont)
			b:Dock(TOP)
			b:SetTall(50)
			b:DockMargin(0, 0, 0, 0)
			b:SetText("")
			
			b.master = buttonInput.master
			b.headerColor = buttonInput.headerColor or headerDefault
			b.value = false
		
			function b.Paint(self, w, h)
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
				XYZUI.DrawText(v.name or "Unnamed option", 20, w/2, h/2, white)
			end

			function b.DoClick()
				buttonInput.selected = v
				buttonInput.value = v.value
				listContainer.desiredSize = 0
				buttonInput.isDropped = false
				if onSelect then
					onSelect(v.name or "Unnamed option", v.value)
				end
			end
		end

		buttonInput.listContainer = listContainer
	end

	return buttonInput
end

function XYZUI.AddDropDownOption(dropdown, name, value)
	if not IsValid(dropdown) then return end

	table.insert(dropdown.options, {name = name, value = value})
end
