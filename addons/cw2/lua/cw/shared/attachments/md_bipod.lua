local att = {}
att.name = "md_bipod"
att.displayName = "Harris Bipod"
att.displayNameShort = "Bipod"

att.statModifiers = {OverallMouseSensMult = -0.1,
DrawSpeedMult = -0.15}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/bipod")
	att.description = {[1] = {t = "When deployed:", c = CustomizableWeaponry.textColors.REGULAR},
	[2] = {t = "Decreases recoil by 70%", c = CustomizableWeaponry.textColors.POSITIVE},
	[3] = {t = "Greatly increases hip fire accuracy", c = CustomizableWeaponry.textColors.POSITIVE}}
end

function att:attachFunc()
	self.BipodInstalled = true
end

function att:detachFunc()
	self.BipodInstalled = false
end

function att:elementRender()
	local model = self.AttachmentModelsVM.md_bipod.ent
	
	if self.dt.BipodDeployed then
		model:SetBodygroup(1, 1)
	else
		model:SetBodygroup(1, 0)
	end
end

CustomizableWeaponry:registerAttachment(att)