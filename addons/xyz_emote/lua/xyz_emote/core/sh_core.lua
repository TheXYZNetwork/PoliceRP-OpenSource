hook.Add("DoAnimationEvent", "Emote:DoAnimation", function(ply, event, data)
	if not (event == PLAYERANIMEVENT_CUSTOM_GESTURE) then return end

	local animationName = ply:GetSequenceInfo(data) or {label = "none"}
	local animationData = Emote.Config.Animations[string.lower(animationName.label)]

	ply:AddVCDSequenceToGestureSlot(GESTURE_SLOT_CUSTOM, data, 0, animationData and (not animationData.loop)) 
	return ACT_INVALID
end)