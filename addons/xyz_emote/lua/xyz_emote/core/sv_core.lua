function Emote.Core.GiveAnimation(ply, animationID)
	if not Emote.Users[ply:SteamID64()] then
		Emote.Users[ply:SteamID64()] = {}
	end

	if Emote.Users[ply:SteamID64()][animationID] then return end

	Emote.Users[ply:SteamID64()][animationID] = true

	net.Start("Emote:Give")
		net.WriteString(animationID)
	net.Send(ply)
end

function Emote.Core.EndAnimation(ply)
	ply.EmoteActive = nil
	ply:AnimResetGestureSlot(GESTURE_SLOT_CUSTOM)

	net.Start("Emote:Reset")
		net.WriteEntity(ply)
	net.Broadcast()
end  


function Emote.Core.DoAnimation(ply, animationID)
	local animationData = Emote.Config.Animations[animationID]
	local sequenceID, length = ply:LookupSequence(animationData.id)

	local switchWeapon = ply:GetWeapon(Emote.Config.Weapon)
	if not IsValid(switchWeapon) then return end

	ply.EmoteActive = animationID
	ply:DoAnimationEvent(sequenceID)
	ply:SetActiveWeapon(switchWeapon)

	if not animationData.loop then
		timer.Create("Emote:Active:"..ply:SteamID64(), length, 1, function()
			Emote.Core.EndAnimation(ply)
		end)
	end

	net.Start("Emote:Camera")
		net.WriteString(animationID)
	net.Send(ply)

	Quest.Core.ProgressQuest(ply, "new_comer", 3)
end

net.Receive("Emote:Do", function(_, ply)
	if XYZShit.CoolDown.Check("Emote:Do", 1, ply) then return end

	local animationID = net.ReadString()
	if (not Emote.Users[ply:SteamID64()]) or (not Emote.Users[ply:SteamID64()][animationID]) then return end
	
	if ply.EmoteActive then return end
	if not ply:Alive() then return end
	if IsValid(ply:GetActiveWeapon()) and (ply:GetActiveWeapon() == "xyz_suicide_vest") then return end

	Emote.Core.DoAnimation(ply, animationID)
end)

hook.Add("PlayerButtonDown", "Emote:EndLoopingAnimation", function(ply, button)
	if not (button == Emote.Config.MenuKey) then return end
	if not ply.EmoteActive then return end
	local animationData = Emote.Config.Animations[ply.EmoteActive]
	if not animationData then return end
	if not animationData.loop then return end

	Emote.Core.EndAnimation(ply)
end)

hook.Add("Move", "Emote:Movement", function(ply, mv)
	if not ply.EmoteActive then return end

	local animationData = Emote.Config.Animations[ply.EmoteActive]
	if not animationData then return end
	if not animationData.movementSpeed then return end

	mv:SetMaxSpeed(animationData.movementSpeed)
end)

hook.Add("PlayerSwitchWeapon", "Emote:BlockSwitch", function(ply)
	if not ply.EmoteActive then return end

	return true
end)

hook.Add("PlayerSwitchWeapon", "Emote:Reset", function(ply)
	Emote.Core.EndAnimation(ply)
end)