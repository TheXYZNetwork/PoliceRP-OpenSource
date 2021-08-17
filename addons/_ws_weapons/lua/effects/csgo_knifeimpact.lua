function EFFECT:Init( data )
  local vOffset = data:GetOrigin() -- + Vector( 0, 0, 0.2 )
  -- local vAngle = data:GetAngles()
  local emitter = ParticleEmitter( vOffset ) -- there was false
    for i=0, 5 do
      local particle = emitter:Add( "particle/particle_smokegrenade", vOffset )
      if particle then
        -- particle:SetAngles( vAngle )
        particle:SetVelocity( math.random(12,16) * math.sqrt(i) * data:GetNormal() * 3 + 2 * VectorRand() )
        particle:SetColor( 135, 135, 135 )
        particle:SetLifeTime( 0 )
        particle:SetDieTime( math.Rand( 0.5, 1.5 ) )
        particle:SetStartAlpha( 255 )
        particle:SetEndAlpha( 0 )
        particle:SetStartSize( math.Rand( 5, 8 ) *math.Clamp(i,1,4) * 0.166 )
        --particle:SetStartLength( 1 )
        particle:SetEndSize( math.Rand( 16, 24 ) * math.sqrt(math.Clamp(i,1,4)) * 0.166 )
        --particle:SetEndLength( 4 )
        particle:SetRoll( math.Rand( -25, 25 ) )
        particle:SetRollDelta( math.Rand( -0.05, 0.05 ) )
      end
    end
  emitter:Finish()
end

function EFFECT:Think()
  return false
end

function EFFECT:Render()
end