hook.Add("HUDPaint", "xyz_admin_debug_menu", function()
	if not XYZSettings.GetSetting("staff_debug_menu", true) then return end
	if XYZShit.Staff.All[LocalPlayer():GetUserGroup()] then
		local w, h = ScrW(), ScrH()
		local target = LocalPlayer():GetEyeTrace().Entity

		if IsValid(target) then
			if target:IsPlayer() then
				XYZUI.DrawShadowedBox(10, 150, 500, 110, 3)

				XYZUI.DrawText("Name: "..target:Name().." ("..target:SteamName()..")".." | Ping: "..target:Ping(), "20", 20, 155, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
				XYZUI.DrawText("Health: "..target:Health().." | Armour: "..target:Armor().." | Weapon: "..(IsValid(target:GetActiveWeapon()) and target:GetActiveWeapon():GetPrintName() or "Dead"), "20", 20, 170, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
				XYZUI.DrawText("Distance: "..math.Round(LocalPlayer():GetPos():Distance(target:GetPos())).." units away", "20", 20, 185, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
				XYZUI.DrawText("Kills: "..target:Frags().." | Deaths: "..target:Deaths().." ("..math.Round(target:Frags()/target:Deaths(),2)..")", "20", 20, 200, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
				XYZUI.DrawText("Props: "..target:GetCount("props").." | Rank: "..target:GetUserGroup().." | Secondary Rank: "..(target:GetSecondaryUserGroup() or "None"), "20", 20, 215, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
				XYZUI.DrawText("Job: "..(target:getDarkRPVar("job") or "Unknown").." | Money: "..DarkRP.formatMoney(target:getDarkRPVar("money")), "20", 20, 230, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
			elseif IsEntity(target) then
				local targetOwner = target:CPPIGetOwner()
				if not targetOwner then return end

				XYZUI.DrawShadowedBox(10, 150, 500, 50, 3)
	
				XYZUI.DrawText("Owner: "..targetOwner:Name().." ("..targetOwner:SteamName()..")".." | Driver: "..((target:IsVehicle() and IsValid(target:GetDriver())) and (target:GetDriver():Name().." ("..target:GetDriver():SteamName()..")") or "None"), "20", 20, 155, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
				XYZUI.DrawText("Distance: "..math.Round(LocalPlayer():GetPos():Distance(target:GetPos())).." units away", "20", 20, 170, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
			end
		end
	end
end)