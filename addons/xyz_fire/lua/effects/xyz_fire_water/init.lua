function EFFECT:Init( data )
	local target = data:GetEntity()
	local emitter = ParticleEmitter(self:GetPos())

	for i = 1, 2 do
		local effect = emitter:Add("effects/splash1", self:GetPos())
		effect:SetVelocity(-target:GetForward() * 500)
		effect:SetDieTime(0.7)
		effect:SetStartAlpha(100)
		effect:SetStartSize(5)
		effect:SetEndSize(40)
		effect:SetRoll(math.Rand(0, 10 ))
		effect:SetRollDelta(math.Rand(-0.2, 0.2))
	end
	emitter:Finish()
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end