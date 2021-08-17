include("shared.lua")
local width = 260
local offset = -width*0.5
local shader = Color(0, 0, 0, 55)
function ENT:Draw()
  	if self:GetPos():DistToSqr(LocalPlayer():GetPos()) > tonumber(XYZSettings.GetSetting("overhead_distance", 400000)) then return end
 	
	if not self:GetIsBroken() then return end

	local pos = self:GetPos() + (self:GetUp()*-15)
	local emitter = ParticleEmitter(pos)

	local part = emitter:Add("effects/spark", pos)
	if (part) then
		part:SetDieTime(1)

		part:SetStartAlpha(255)
		part:SetEndAlpha(0)

		part:SetStartSize(5)
		part:SetEndSize(0)

		part:SetGravity(Vector(0, 0, -100))
		part:SetVelocity(VectorRand() * 50)
	end

	emitter:Finish()

 	if not (LocalPlayer():Team() == PrisonSystem.Config.Prisoner) then return end
 	
 	if self:GetPos():DistToSqr(LocalPlayer():GetPos()) < 100000 then
		local ang = LocalPlayer():EyeAngles();
		ang:RotateAroundAxis(ang:Forward(), 90)
		ang:RotateAroundAxis(ang:Right(), 90)
	
		cam.Start3D2D(self:GetPos() + (self:GetUp()*3), ang, 0.07)
			draw.NoTexture()
			surface.SetDrawColor(color_black)
			XYZUI.DrawCircle(offset + (width*0.5), 37, 60, 10)
			surface.SetDrawColor(PrisonSystem.Config.Color)
			XYZUI.DrawCircle(offset + (width*0.5), 37, 60*(self:GetProgress()/100), 10)
		cam.End3D2D()
 	end

end