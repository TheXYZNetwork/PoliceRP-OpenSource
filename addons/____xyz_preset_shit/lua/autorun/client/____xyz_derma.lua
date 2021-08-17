XYZShit.Derma = {} 


--===============
-- Blur function
--===============
local blur = Material("pp/blurscreen")
function XYZShit.DermaBlurPanel(panel, amount)
	local x, y = panel:LocalToScreen(0, 0)
	local scrW, scrH = ScrW(), ScrH()
	surface.SetDrawColor(255, 255, 255)
	surface.SetMaterial(blur)
	for i = 1, 6 do
		blur:SetFloat("$blur", (i / 3) * (amount or 6))
		blur:Recompute()
		render.UpdateScreenEffectTexture()
		surface.DrawTexturedRect(x * -1, y * -1, scrW, scrH)
	end
end

--==============
-- Preset frame
--==============
local PANEL = {}

function PANEL:Init()
	self:SetSize(ScrW()*0.85, ScrH()*0.85)
	self:MakePopup()
	self:Center()
	self:SetDraggable(false)
	self:ShowCloseButton(false)
	self:SetTitle("")

	self.innerTint = true
end

function PANEL:SetTint(bool)
	self.innerTint = bool
end

function PANEL:Paint()
	XYZShit.DermaBlurPanel(self, 3)
	draw.RoundedBox(0, 0, 0, self:GetWide(), self:GetTall(), Color( 100, 100, 100, 55 ))
	if self.innerTint then
		draw.RoundedBox(0, 5, 5, self:GetWide()-10, self:GetTall()-10, Color( 0, 0, 0, 100 ))
	end
end

vgui.Register('xyz_frame', PANEL, 'DFrame')


--==============
-- Text input
--==============
local PANEL = {}

function PANEL:Paint()
	draw.RoundedBox(0, 0, 0, self:GetWide(), self:GetTall(), Color(0, 0, 0, 155))
	self:DrawTextEntryText(Color(255, 255, 255), Color(0, 178, 238), Color(255, 255, 255))
end

vgui.Register('xyz_text_input', PANEL, 'DTextEntry')


--==============
-- Check box
--==============
local PANEL = {}

function PANEL:Init()
	self.state = true
	self:SetText("")
end

function PANEL:SetState(bool)
	self.state = bool
end

function PANEL:ToggleState()
	self.state = !self:GetState()
end

function PANEL:GetState()
	return self.state
end

function PANEL:Paint()
	draw.RoundedBox(0, 0, 0, self:GetWide(), self:GetTall(), Color(0, 0, 0, 155))
	if self:GetState() then
		draw.SimpleText("X", "xyz_font_10", self:GetWide()/2, self:GetTall()/2, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end
end

function PANEL:DoClick()
	self:ToggleState()
end

vgui.Register('xyz_checkbox', PANEL, 'DButton')


--==============
-- DRAW BLUR
--==============
-- The blur effect
local blur = Material("pp/blurscreen")
function XYZShit.DermaBlur(x, y, w, h, amount)
	local X, Y = 0,0
	local scrW, scrH = ScrW(), ScrH()

	surface.SetDrawColor(255, 255, 255)
	surface.SetMaterial(blur)

	for i = 1, 3 do
		blur:SetFloat("$blur", (i / 3) * (amount or 6))
		blur:Recompute()

		render.UpdateScreenEffectTexture()

		render.SetScissorRect(x, y, x+w, y+h, true)
			surface.DrawTexturedRect(X * -1, Y * -1, scrW, scrH)
		render.SetScissorRect(0, 0, 0, 0, false)
	end
end