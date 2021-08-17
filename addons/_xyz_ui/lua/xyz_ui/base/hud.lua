-- This is the code that actually disables the drawing.
local hideHUDElements = {
	["DarkRP_LocalPlayerHUD"] = true,
	["DarkRP_EntityDisplay"] = true,
	["CHudSecondaryAmmo"] = true,
	["CHudAmmo"] = true,
	["CHudBattery"] = true,
	["CHudHealth"] = true,
	["DarkRP_LockdownHUD"] = true
	--["DarkRP_HUD"] = true
}
hook.Add("HUDShouldDraw", "HideDefaultDarkRPHud", function(name) if hideHUDElements[name] then return false end end)
hook.Add("HUDDrawTargetID", "HMHUD", function() return end)
hook.Remove("HUDPaint", "DarkRP_Mod_HUDPaint")

-- Cache
local scrw = ScrW
local scrh = ScrH
local localplayer = LocalPlayer
local color = Color
local draw_box = draw.RoundedBox
local getglobalbool = GetGlobalBool
local math_clamp = math.Clamp

-- Colors
local white = color(255, 255, 255)
local headerDefault = color(2, 88, 154)
local headerShader = color(0, 0, 0, 55)
local healthRed = color(200, 0, 55)
local ArmorRed = color(0, 100, 200)
local healthSegments = color(31, 31, 31, 155)

local hudW, hudH = math_clamp(scrw()*0.21, 330, 380), math_clamp(scrh()*0.045+15+(scrw() > 1920 and ScreenScale(5) or 0), 60, 120)
local ammoW, ammoH =  math_clamp(scrw()*0.12, 200, 300), scrh()*0.042+15+(scrw() > 1920 and ScreenScale(3) or 0)
local licenseW, licenseH =  scrw()*0.06, (hudH/2)+10
function XYZUI.BuildHUD()
	if not XYZSettings.GetSetting("hud_show_master", true) then return end

	-- Cache values to optimize
	local _scrw, _scrh = scrw(), scrh()
	local hudStart = _scrh-hudH-30
	local localPly = localplayer()

	-- Base background
	XYZUI.DrawShadowedBox(5, hudStart, hudW, hudH+25)
	draw_box(0, 10, hudStart+5, hudW-10, 16, headerDefault)
	draw_box(0, 10, hudStart+12, hudW-10, 8, headerShader)

	-- Base text info
		-- Display name
		XYZUI.DrawScaleText(XYZUI.CharLimit(localPly:GetName(), 20), 8, 10, hudStart+22, white, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
		-- Wallet
		XYZUI.DrawScaleText(DarkRP.formatMoney(localPly:getDarkRPVar("money")), 8, hudW-5, hudStart+22, white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP)
		-- Job
		XYZUI.DrawScaleText(localPly:getDarkRPVar("job"), 7, 10, hudStart+hudH, white, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM)
		-- Salary
		XYZUI.DrawScaleText(DarkRP.formatMoney(localPly:getDarkRPVar("salary")), 7, hudW-5, hudStart+hudH, white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM)

	-- Base bar in
	draw_box(0, 10, _scrh-25, (hudW-10) * math_clamp(localPly:Health(), 0, 100)/100, 15, healthRed)
	draw_box(0, 10, _scrh-30, (hudW-10) * math_clamp(localPly:Armor(), 0, 100)/100, 5, ArmorRed)

	for i=1, 3 do
		draw_box(0, 5+(i*((hudW-10)*0.25))-1, _scrh-25, 2, 15, healthSegments)
	end

	-- Ammo Cache
	local ammoStartW, ammoStartH = _scrw-ammoW-5, _scrh-ammoH-5 

	-- Ammo backgound
	XYZUI.DrawShadowedBox(ammoStartW, ammoStartH, ammoW, ammoH)
	draw_box(0, ammoStartW+5, ammoStartH+5, ammoW-10, 16, headerDefault)
	draw_box(0, ammoStartW+5, ammoStartH+13, ammoW-10, 8, headerShader)

	local activeWep = localPly:GetActiveWeapon()
	if not (activeWep == NULL) then
		local activeWepClip = activeWep:Clip1()

		local ammoinclip = "∞"
		local extraammo = ""
		
		if localPly:GetActiveWeapon():Clip1() > -1 then
			ammoinclip = activeWep:Clip1()
			extraammo = "/"..localPly:GetAmmoCount(activeWep:GetPrimaryAmmoType())
		end 

		XYZUI.DrawScaleText(activeWep:GetPrintName(), 7, ammoStartW+(ammoW*0.5), ammoStartH+20, white, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
		XYZUI.DrawScaleText(ammoinclip..extraammo, 7, ammoStartW+(ammoW*0.5), ammoStartH+ammoH-2, white, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM)
	else
		XYZUI.DrawScaleText("You are dead", 9, ammoStartW+(ammoW*0.5), ammoStartH+20, white, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
	end


	if localPly:getDarkRPVar("HasGunlicense") and XYZSettings.GetSetting("hud_show_license", true) then
		local licenseStartW, licenseStartH = hudW+10, hudStart
		XYZUI.DrawShadowedBox(licenseStartW, licenseStartH, licenseW, licenseH)

		XYZUI.DrawScaleText("Gun License", 7, licenseStartW+(licenseW*0.5), licenseStartH+(licenseH*0.5), white, TEXT_ALIGN_CENTER)
	end

	if localPly:isWanted() and XYZSettings.GetSetting("hud_show_wanted", true) then
		local wantedStartW, wantedStartH = hudW+10, hudStart+licenseH+6
		XYZUI.DrawShadowedBox(wantedStartW, wantedStartH, licenseW, licenseH)

		XYZUI.DrawScaleText("Wanted", 7, wantedStartW+(licenseW*0.5), wantedStartH+(licenseH*0.5), white, TEXT_ALIGN_CENTER)
	end

	if getglobalbool("DarkRP_LockDown") and XYZSettings.GetSetting("hud_show_lockdown", true) then
		local lockdownStartW, loackdownStartH = (_scrw*0.3)-(licenseW*0.5), _scrh-licenseH-5
		XYZUI.DrawShadowedBox(lockdownStartW, loackdownStartH, licenseW, licenseH)

		XYZUI.DrawScaleText("Lockdown", 7, lockdownStartW+(licenseW*0.5), loackdownStartH+(licenseH*0.5), white, TEXT_ALIGN_CENTER)
	end

end
hook.Add("HUDPaint", "XYZHUD", XYZUI.BuildHUD)


local licenseW, licenseH =  100, 37
local function DrawEntityDisplay()
	if not XYZSettings.GetSetting("hud_show_others", true) then return end

    local shootPos = LocalPlayer():GetShootPos()
    local aimVec = LocalPlayer():GetAimVector()

    for _, ply in ipairs( players or player.GetAll() ) do
        if not IsValid( ply ) or ply == LocalPlayer() or not ply:Alive() or ply:GetNoDraw() or ply:IsDormant() then continue end
        local hisPos = ply:GetShootPos()

        -- Draw when you're (almost) looking at him
    	if hisPos:DistToSqr( shootPos ) < 160000 then
            local pos = hisPos - shootPos
            local unitPos = pos:GetNormalized()
            if unitPos:Dot( aimVec ) > 0.95 then
                local trace = util.QuickTrace( shootPos, pos, LocalPlayer() )
                if trace.Hit and trace.Entity ~= ply then break end

                local pos = ply:EyePos()
				pos.z = pos.z + 8 --The position we want is a bit above the position of the eyes
				pos = pos:ToScreen()
				pos.y = pos.y - 85

				local plyName = (ply:MaskedName() or ply:Name() or "Unknown")
				local plyJob = (ply:getDarkRPVar("job") or "Unknown")

				-- Info
				surface.SetFont("xyz_ui_main_font_30")
				local n_w, n_h = surface.GetTextSize(XYZUI.CharLimit(plyName))
				local j_w, j_h = surface.GetTextSize(XYZUI.CharLimit(plyJob, 20))

				local w, h = n_w, n_h

				if j_w > n_w then
					w, h = j_w, j_h
				end

				local baseW = pos.x-((w+20)/2)
				-- Base background
				XYZUI.DrawShadowedBox(baseW, pos.y-10, (w+20), 77)
				draw_box(0, baseW+5, pos.y-5, (w+10), 10, headerDefault)
				draw_box(0, baseW+5, pos.y, (w+10), 5, headerShader)

				-- Text
				XYZUI.DrawText(XYZUI.CharLimit(plyName), 30, pos.x, pos.y+20, white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				XYZUI.DrawText(XYZUI.CharLimit(plyJob, 20), 30, pos.x, pos.y+48, white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)


				if ply:getDarkRPVar( "HasGunlicense" ) then
					local licenseStartW, licenseStartH = baseW+w+22, pos.y-10
					XYZUI.DrawShadowedBox(licenseStartW, licenseStartH, licenseW, licenseH)
			
					XYZUI.DrawText("Gun License", 20, licenseStartW+(licenseW*0.5), licenseStartH+(licenseH*0.5)-1, white, TEXT_ALIGN_CENTER)
				end
				
				if ply:getDarkRPVar( "wanted" ) then
					local licenseStartW, licenseStartH = baseW+w+22, pos.y+licenseH-8
					XYZUI.DrawShadowedBox(licenseStartW, licenseStartH, licenseW, licenseH)
			
					XYZUI.DrawText("Wanted", 20, licenseStartW+(licenseW*0.5), licenseStartH+(licenseH*0.5)-1, white, TEXT_ALIGN_CENTER)
				end

				if ply:IsMuted() then
					XYZUI.DrawShadowedBox(baseW, pos.y-45, w+20, licenseH)
			
					XYZUI.DrawText("Muted", 20, baseW+((w+20)*0.5), (pos.y-45)+(licenseH*0.5), white, TEXT_ALIGN_CENTER)
				end
            end
        end
    end

    local tr = LocalPlayer():GetEyeTrace()

    if IsValid( tr.Entity ) and tr.Entity:isKeysOwnable() and tr.Entity:GetPos():DistToSqr( LocalPlayer():GetPos() ) < 40000 then
        tr.Entity:drawOwnableInfo()
    end
end
hook.Add("HUDPaint", "XYZOverhead", DrawEntityDisplay)