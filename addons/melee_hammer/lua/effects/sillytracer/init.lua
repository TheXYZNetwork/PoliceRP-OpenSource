EFFECT.Mat = Material( "trails/smoke" )

function EFFECT:Init( data )

	self.texcoord = math.Rand( 0, 20 )/3
	self.Position = data:GetStart()
	self.WeaponEnt = data:GetEntity()
	self.Attachment = data:GetAttachment()
	
	self.StartPos = self:GetTracerShootPos( self.Position, self.WeaponEnt, self.Attachment )
	self.EndPos = data:GetOrigin()

	self.Entity:SetCollisionBounds( self.StartPos -  self.EndPos, Vector( 110, 110, 110 ) )
	self.Entity:SetRenderBoundsWS( self.StartPos, self.EndPos, Vector()*8 )
	
	self.StartPos = self:GetTracerShootPos( self.Position, self.WeaponEnt, self.Attachment )
	
	self.Alpha = 195
	self.FlashA = 255
	
end

function EFFECT:Think( )

	self.FlashA = self.FlashA - 650 * FrameTime()
	if (self.FlashA < 0) then self.FlashA = 0 end

	self.Alpha = self.Alpha - 1150 * FrameTime()
	if (self.Alpha < 0) then return false end
	
	return true

end

function EFFECT:Render( )
	
	self.Length = (self.StartPos - self.EndPos):Length()
	
	local texcoord = self.texcoord
	
		render.SetMaterial( self.Mat )
		render.DrawBeam( self.StartPos,
					 self.EndPos,
					 4,
					 texcoord,													
					 texcoord + self.Length / 256,
					 Color( 255, 255, 255, math.Clamp(self.Alpha, 0,195)) )
					 
end
