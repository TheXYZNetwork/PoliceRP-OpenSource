net.Receive("Minimap:Sign:Update", function(_, ply)
	local sign = net.ReadEntity()
	local txt = net.ReadString()
	local image = net.ReadInt(6)

    if XYZShit.CoolDown.Check("Minimap:Sign:Update", 2, ply) then return end
	if not (sign:GetClass() == "minimap_sign") then return end
	if sign:GetPos():Distance(ply:GetPos()) > 500 then return end
	if not (sign:Getowning_ent() == ply) then return end

	txt = string.Trim(txt, " ")
	txt = string.sub(txt, 0, 32)
	
	if txt == "" then return end

	sign:SetDisplayName(txt)

	if image <= 0 then return end
	if image > Minimap.Config.SignImageCounter then return end

	sign:SetDisplayImage(image)
end)
