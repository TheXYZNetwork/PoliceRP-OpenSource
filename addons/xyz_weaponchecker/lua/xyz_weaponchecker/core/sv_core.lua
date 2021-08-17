net.Receive("xyz_weaponchecker_strip", function(_, ply)
	if not XYZShit.IsGovernment(ply:Team()) then XYZShit.Msg("Weapon Checker", WeaponChecker.Config.Color, "You cannot strip weapons", ply) return end
	local wep = net.ReadString()
	local weapon = WeaponChecker.Config.Weapons[wep]
	if not weapon then return end
	if weapon.blockStrip then return end

	local target = net.ReadEntity()
	if not target:IsPlayer() then return end
	if ply:GetPos():Distance(target:GetPos()) > 95 then return end

	local invItem = net.ReadBool()

	if invItem then
		Inventory.Core.RemoveItemFromInv(target, wep)
	elseif target:XYZIsArrested() then
		if not target.arrestedWeapons[wep] then return end
		target.arrestedWeapons[wep] = nil
	else
		if not target:HasWeapon(wep) then return end
		target:StripWeapon(wep)
	end
	XYZShit.Msg("Weapon Checker", WeaponChecker.Config.Color, "You have stripped a "..weapon.name.." from "..target:Nick().." adding "..DarkRP.formatMoney(weapon.reward).." to the government funds", ply)
	XYZShit.Msg("Weapon Checker", WeaponChecker.Config.Color, "Your "..weapon.name.." has been stripped by "..ply:Nick(), target)

	local clamped = math.Clamp(XYZPresident.TotalMoney + weapon.reward, 0, XYZPresident.Config.HoldCap)
	local thrownaway = 0

	if clamped ~= (XYZPresident.TotalMoney + weapon.reward) then
		thrownaway = ((XYZPresident.TotalMoney + weapon.reward) - XYZPresident.Config.HoldCap)
		XYZPresident.Stats.ThrownAwayCap = XYZPresident.Stats.ThrownAwayCap + thrownaway
	end
	XYZPresident.Stats.AddedToFunds = XYZPresident.Stats.AddedToFunds + (weapon.reward - thrownaway or 0)
	XYZPresident.Stats.Seizures = XYZPresident.Stats.Seizures + (weapon.reward - thrownaway or 0)

	XYZPresident.TotalMoney = clamped

	xLogs.Log(xLogs.Core.Player(ply).." stripped a "..weapon.name.." from "..xLogs.Core.Player(target), "Weapon Checker")
	XYZShit.DataBase.Query(string.format("INSERT INTO pnc_confiscated(userid, username, officerid, officername, class, name, time) VALUES('%s', '%s', '%s', '%s', '%s', '%s', %i);", target:SteamID64(), XYZShit.DataBase.Escape(target:Name()), ply:SteamID64(), XYZShit.DataBase.Escape(ply:Name()), XYZShit.DataBase.Escape(wep), XYZShit.DataBase.Escape(weapon.name), os.time()))

end )

net.Receive("xyz_weaponchecker_strip_all", function(_, ply)
	if not XYZShit.IsGovernment(ply:Team()) then XYZShit.Msg("Weapon Checker", WeaponChecker.Config.Color, "You cannot strip weapons", ply) return end
	local target = net.ReadEntity()
	local invItems = net.ReadBool()
	if not target:IsPlayer() then return end
	if ply:GetPos():Distance(target:GetPos()) > 95 then return end


	if invItems then
		local totalTaken = 0
		for k, v in pairs(Inventory.SavedInvs[target:SteamID64()]) do
			local weapon = WeaponChecker.Config.Weapons[v.class]
			if not weapon then continue end
			if weapon.blockStrip then continue end

			totalTaken = totalTaken + weapon.reward

			Inventory.Core.RemoveItemFromInv(target, v.class)
			XYZShit.DataBase.Query(string.format("INSERT INTO pnc_confiscated(userid, username, officerid, officername, class, name, time) VALUES('%s', '%s', '%s', '%s', '%s', '%s', %i);", target:SteamID64(), XYZShit.DataBase.Escape(target:Name()), ply:SteamID64(), XYZShit.DataBase.Escape(ply:Name()), XYZShit.DataBase.Escape(v.class), XYZShit.DataBase.Escape(weapon.name), os.time()))
		end

		XYZShit.Msg("Weapon Checker", WeaponChecker.Config.Color, "You have stripped all weapons from "..target:Nick().."'s inventroy, adding "..DarkRP.formatMoney(totalTaken).." to the government funds", ply)
		XYZShit.Msg("Weapon Checker", WeaponChecker.Config.Color, "All your inventory weapons have been stripped by "..ply:Nick(), target)

		local clamped = math.Clamp(XYZPresident.TotalMoney + totalTaken, 0, XYZPresident.Config.HoldCap)
		local thrownaway = 0

		if clamped ~= (XYZPresident.TotalMoney + totalTaken) then
		    thrownaway = ((XYZPresident.TotalMoney + totalTaken) - XYZPresident.Config.HoldCap)
		    XYZPresident.Stats.ThrownAwayCap = XYZPresident.Stats.ThrownAwayCap + thrownaway
		end
		XYZPresident.Stats.AddedToFunds = XYZPresident.Stats.AddedToFunds + (totalTaken - thrownaway or 0)
		XYZPresident.Stats.Seizures = XYZPresident.Stats.Seizures + (totalTaken - thrownaway or 0)

		XYZPresident.TotalMoney = clamped

		xLogs.Log(xLogs.Core.Player(ply).." stripped all inventory items from "..xLogs.Core.Player(target), "Weapon Checker")
	elseif target:XYZIsArrested() then
		for k, v in pairs(target.arrestedWeapons) do
			local weapon = WeaponChecker.Config.Weapons[k]
			if not weapon then continue end
			if weapon.blockStrip then continue end
			target.arrestedWeapons[k] = nil
			XYZShit.Msg("Weapon Checker", WeaponChecker.Config.Color, "You have stripped a "..weapon.name.." from "..target:Nick().." adding "..DarkRP.formatMoney(weapon.reward).." to the government funds", ply)
			XYZShit.Msg("Weapon Checker", WeaponChecker.Config.Color, "Your "..weapon.name.." has been stripped by "..ply:Nick(), target)

			local clamped = math.Clamp(XYZPresident.TotalMoney + weapon.reward, 0, XYZPresident.Config.HoldCap)
			local thrownaway = 0

			if clamped ~= (XYZPresident.TotalMoney + weapon.reward) then
			    thrownaway = ((XYZPresident.TotalMoney + weapon.reward) - XYZPresident.Config.HoldCap)
			    XYZPresident.Stats.ThrownAwayCap = XYZPresident.Stats.ThrownAwayCap + thrownaway
			end
			XYZPresident.Stats.AddedToFunds = XYZPresident.Stats.AddedToFunds + (weapon.reward - thrownaway or 0)
		 	XYZPresident.Stats.Seizures = XYZPresident.Stats.Seizures + (weapon.reward - thrownaway or 0)

			XYZPresident.TotalMoney = clamped

			XYZShit.DataBase.Query(string.format("INSERT INTO pnc_confiscated(userid, username, officerid, officername, class, name, time) VALUES('%s', '%s', '%s', '%s', '%s', '%s', %i);", target:SteamID64(), XYZShit.DataBase.Escape(target:Name()), ply:SteamID64(), XYZShit.DataBase.Escape(ply:Name()), XYZShit.DataBase.Escape(k), XYZShit.DataBase.Escape(weapon.name), os.time()))

			xLogs.Log(xLogs.Core.Player(ply).." stripped a "..weapon.name .. " from "..xLogs.Core.Player(target), "Weapon Checker")
		end
	else
		for _, v in pairs(target:GetWeapons()) do
			local weapon = WeaponChecker.Config.Weapons[v:GetClass()]
			if not weapon then continue end
			if weapon.blockStrip then continue end
			target:StripWeapon(v:GetClass())
			XYZShit.Msg("Weapon Checker", WeaponChecker.Config.Color, "You have stripped a "..weapon.name.." from "..target:Nick().." adding "..DarkRP.formatMoney(weapon.reward).." to the government funds", ply)
			XYZShit.Msg("Weapon Checker", WeaponChecker.Config.Color, "Your "..weapon.name.." has been stripped by "..ply:Nick(), target)

			local clamped = math.Clamp(XYZPresident.TotalMoney + weapon.reward, 0, XYZPresident.Config.HoldCap)
			local thrownaway = 0

			if clamped ~= (XYZPresident.TotalMoney + weapon.reward) then
			    thrownaway = ((XYZPresident.TotalMoney + weapon.reward) - XYZPresident.Config.HoldCap)
			    XYZPresident.Stats.ThrownAwayCap = XYZPresident.Stats.ThrownAwayCap + thrownaway
			end
			XYZPresident.Stats.AddedToFunds = XYZPresident.Stats.AddedToFunds + (weapon.reward - thrownaway or 0)
		 	XYZPresident.Stats.Seizures = XYZPresident.Stats.Seizures + (weapon.reward - thrownaway or 0)


			XYZPresident.TotalMoney = clamped

			XYZShit.DataBase.Query(string.format("INSERT INTO pnc_confiscated(userid, username, officerid, officername, class, name, time) VALUES('%s', '%s', '%s', '%s', '%s', '%s', %i);", target:SteamID64(), XYZShit.DataBase.Escape(target:Name()), ply:SteamID64(), XYZShit.DataBase.Escape(ply:Name()), XYZShit.DataBase.Escape(v:GetClass()), XYZShit.DataBase.Escape(weapon.name), os.time()))
			
			xLogs.Log(xLogs.Core.Player(ply).." stripped a "..weapon.name .. " from "..xLogs.Core.Player(target), "Weapon Checker")
		end
	end
end )