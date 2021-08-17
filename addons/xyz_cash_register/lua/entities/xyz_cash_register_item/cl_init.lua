include("shared.lua")

function ENT:Draw()
	self:DrawModel()

	if self:GetPos():DistToSqr(LocalPlayer():GetPos()) > 20000 then return end

	local pos = self:GetPos():ToScreen()
	cam.Start2D()
		XYZUI.DrawTextOutlined(self:GetDisplayName() or "Unknown", 40, pos.x, pos.y, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM, 2, color_black)
		XYZUI.DrawTextOutlined(DarkRP.formatMoney(self:GetPrice()), 30, pos.x, pos.y, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 2, color_black)
	cam.End2D()
end
