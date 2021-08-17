local function CW2_GetLaserQualityText(level)
	if level <= 1 then
		return " Normal"
	end
	
	return " High"
end

CustomizableWeaponry.renderTargetSizes = {[1] = {size = 256, text = "Low (256x256)"},
	[2] = {size = 512, text = "Medium (512x512)"},
	[3] = {size = 768, text = "High (768x768)"},
	[4] = {size = 1024, text = "Very high (1024x1024)"}}
	
function CustomizableWeaponry:clampRenderTargetLevel(level)
	return math.Clamp(level, 1, #self.renderTargetSizes)
end

function CustomizableWeaponry:getRenderTargetData(level)
	return self.renderTargetSizes[self:clampRenderTargetLevel(level)]
end

function CustomizableWeaponry:getRenderTargetText(level)
	return self.renderTargetSizes[self:clampRenderTargetLevel(level)].text
end

function CustomizableWeaponry:getRenderTargetSize(level)
	return self.renderTargetSizes[self:clampRenderTargetLevel(level)].size
end

local function CW2_ClientsidePanel(panel)
	panel:ClearControls()
	
	panel:AddControl("Label", {Text = "HUD Control"})
	
	panel:AddControl("CheckBox", {Label = "Use custom HUD?", Command = "cw_customhud"})
	panel:AddControl("CheckBox", {Label = "HUD: use 3D2D ammo display?", Command = "cw_customhud_ammo"})
	panel:AddControl("CheckBox", {Label = "Display crosshair?", Command = "cw_crosshair"})
	
	panel:AddControl("Label", {Text = "Visual effects control"})
	
	panel:AddControl("CheckBox", {Label = "BLUR: On reload?", Command = "cw_blur_reload"})
	panel:AddControl("CheckBox", {Label = "BLUR: On customize?", Command = "cw_blur_customize"})
	panel:AddControl("CheckBox", {Label = "BLUR: On aim?", Command = "cw_blur_aim_telescopic"})
	panel:AddControl("CheckBox", {Label = "Use simple telescopics?", Command = "cw_simple_telescopics"})
	
	panel:AddControl("CheckBox", {Label = "FREE AIM: activate?", Command = "cw_freeaim"})
	panel:AddControl("CheckBox", {Label = "FREE AIM: use auto-center?", Command = "cw_freeaim_autocenter"})
	panel:AddControl("CheckBox", {Label = "FREE AIM: auto-center while aiming?", Command = "cw_freeaim_autocenter_aim"})
	
	-- autocenter time slider
	local slider = vgui.Create("DNumSlider", panel)
	slider:SetDecimals(2)
	slider:SetMin(0.1)
	slider:SetMax(2)
	slider:SetConVar("cw_freeaim_autocenter_time")
	slider:SetValue(GetConVarNumber("cw_freeaim_autocenter_time"))
	slider:SetText("AUTO-CENTER: time")
	
	panel:AddItem(slider)
	
	local slider = vgui.Create("DNumSlider", panel)
	slider:SetDecimals(2)
	slider:SetMin(0)
	slider:SetMax(0.9)
	slider:SetConVar("cw_freeaim_center_mouse_impendance")
	slider:SetValue(GetConVarNumber("cw_freeaim_center_mouse_impendance"))
	slider:SetText("FREE AIM: mouse impendance")
	
	panel:AddItem(slider)
	
	local slider = vgui.Create("DNumSlider", panel)
	slider:SetDecimals(3)
	slider:SetMin(0)
	slider:SetMax(0.05)
	slider:SetConVar("cw_freeaim_lazyaim")
	slider:SetValue(GetConVarNumber("cw_freeaim_lazyaim"))
	slider:SetText("FREE AIM: 'lazy aim'")
	
	panel:AddItem(slider)
	
	-- pitch limit
	local slider = vgui.Create("DNumSlider", panel)
	slider:SetDecimals(1)
	slider:SetMin(5)
	slider:SetMax(15)
	slider:SetConVar("cw_freeaim_pitchlimit")
	slider:SetValue(GetConVarNumber("cw_freeaim_pitchlimit"))
	slider:SetText("FREE AIM: pitch freedom")
	
	panel:AddItem(slider)
	
	local slider = vgui.Create("DNumSlider", panel)
	slider:SetDecimals(1)
	slider:SetMin(5)
	slider:SetMax(30)
	slider:SetConVar("cw_freeaim_yawlimit")
	slider:SetValue(GetConVarNumber("cw_freeaim_yawlimit"))
	slider:SetText("FREE AIM: yaw freedom")
	
	panel:AddItem(slider)
	
	local laserQ = vgui.Create("DComboBox", panel)
	laserQ:SetText("Laser quality:" .. CW2_GetLaserQualityText(GetConVarNumber("cw_laser_quality")))
	laserQ.ConVar = "cw_laser_quality"
	
	laserQ:AddChoice("Normal")
	laserQ:AddChoice("High")
	
	laserQ.OnSelect = function(panel, index, value, data)
		laserQ:SetText("Laser quality:" .. CW2_GetLaserQualityText(tonumber(index)))
		RunConsoleCommand(laserQ.ConVar, tonumber(index))
	end
	
	panel:AddItem(laserQ)
	
	local rtScope = vgui.Create("DComboBox", panel)
	rtScope:SetText("RT scope quality: " .. CustomizableWeaponry:getRenderTargetText(GetConVarNumber("cw_rt_scope_quality")))
	rtScope.ConVar = "cw_rt_scope_quality"
	
	for key, data in ipairs(CustomizableWeaponry.renderTargetSizes) do
		rtScope:AddChoice(data.text)
	end
	
	rtScope.OnSelect = function(panel, index, value, data)
		index = tonumber(index)
		
		rtScope:SetText("RT scope quality: " .. CustomizableWeaponry:getRenderTargetText(index))
		local prevQuality = GetConVarNumber(rtScope.ConVar)
		
		RunConsoleCommand(rtScope.ConVar, index)
		local wepBase = weapons.GetStored("cw_base")
		
		if prevQuality ~= tonumber(index) then -- only re-create the render target in case we changed the quality
			wepBase:initRenderTarget(CustomizableWeaponry:getRenderTargetSize(index))
		end
	end
	
	panel:AddItem(rtScope)
	
	panel:AddControl("Label", {Text = "Misc"})
	
	panel:AddControl("CheckBox", {Label = "Custom weapon origins?", Command = "cw_alternative_vm_pos"})
	
	panel:AddControl("Button", {Label = "Drop CW 2.0 weapon", Command = "cw_dropweapon"})
end

local function CW2_AdminPanel(panel)
	if not LocalPlayer():IsAdmin() then
		panel:AddControl("Label", {Text = "Not an admin - don't look here."})
		return
	end
	
	local checkBox = "CheckBox"
	local baseText = "ON SPAWN: Give "
	local questionMark = "?"
	
	panel:AddControl(checkBox, {Label = "Keep attachments after dying?", Command = "cw_keep_attachments_post_death"})
	
	for k, v in ipairs(CustomizableWeaponry.registeredAttachments) do
		if v.displayName and v.clcvar then
			panel:AddControl(checkBox, {Label = baseText .. v.displayName .. questionMark, Command = v.clcvar})
		end
	end
	
	panel:AddControl("Button", {Label = "Apply Changes", Command = "cw_applychanges"})
end

local function CW2_PopulateToolMenu()
	spawnmenu.AddToolMenuOption("Utilities", "CW 2.0 SWEPs", "CW 2.0 Client", "Client", "", "", CW2_ClientsidePanel)
	spawnmenu.AddToolMenuOption("Utilities", "CW 2.0 SWEPs", "CW 2.0 Admin", "Admin", "", "", CW2_AdminPanel)
end

hook.Add("PopulateToolMenu", "CW2_PopulateToolMenu", CW2_PopulateToolMenu)