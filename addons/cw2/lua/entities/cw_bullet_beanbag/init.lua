AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()   
	math.randomseed(CurTime())

self.Owner 		= self:GetOwner()			// Who dun it!
self.Penetrate 		= 1					// How deep Generic Default goes
self.Flightvector 	= self.Entity:GetUp()*90	// Velocity in m/s, FIRST NUMMER is SPEED (FrameTime)
self.Timeleft 		= CurTime() + 5				// How long before auto-remove?
self.Impacted 		= false					// Important for flight continuation, see line 173
self.Splatter 		= false					// Carries blood and AIDS after the round passes through someone
self.EffectSize		= 1					// How much stuff gets kicked up on impact
self.TissueDamage	= math.Rand(0,1)			// Player damage is multiplied by 2 for some reason
self.BallisticDrag	= 180			// Fraction of velocity lost per tick, higher is less
self.Drift		= 0.01					// How much the bullet will drift in flight (Inaccuracy)

self.Entity:SetModel( "models/weapons/w_models/w_baseball.mdl" )
self.Entity:PhysicsInit( SOLID_VPHYSICS )
self.Entity:SetMoveType( MOVETYPE_NONE )
self.Entity:SetSolid( SOLID_NONE )


self:Think()
end   


function ENT:Think()

	if self.Impacted  then self.Impacted = false end	// Reset this part so it can tell at the end

		if self.Timeleft < CurTime() then		// In case of an error, all rounds will self-remove after a few seconds
			self.Entity:Remove()			
		end

	Table		={} 					//Table name is table name
	Table[1]	=self.Owner 				//The person holding the gat
	Table[2]	=self.Entity 				//The cap
	local trace 	= {}
	trace.start 	= self.Entity:GetPos()
	trace.endpos 	= self.Entity:GetPos() + self.Flightvector	// Trace to where it will be next tick
	trace.filter 	= Table
	trace.mask 	= MASK_SHOT + MASK_WATER			// Trace for stuff that bullets would normally hit
	local tr = util.TraceLine( trace )
	

	if tr.Hit then
		if tr.HitSky then
			self.Entity:Remove()
			return true
		end
				if tr.MatType==83 then				//83 is wata
					local effectdata = EffectData()
					effectdata:SetOrigin( tr.HitPos )
				effectdata:SetNormal( tr.HitNormal )		// In case you hit sideways water?
				effectdata:SetScale( 15*self.EffectSize )	// Big splash for big bullets
				util.Effect( "watersplash", effectdata )
				self.Entity:Remove()
				return true
			end

			local effectdata = EffectData()
			effectdata:SetOrigin(tr.HitPos)				// Position of Impact
			effectdata:SetNormal(tr.HitNormal)			// Direction of Impact
			effectdata:SetStart(self.Flightvector:GetNormalized())	// Direction of Round
			effectdata:SetScale(self.EffectSize)			// Size of explosion
			effectdata:SetRadius(tr.MatType)			// Texture of Impact
			util.Effect("gdcw_universal_impact",effectdata)
			util.ScreenShake(tr.HitPos, 10, 5, 0.1, 200 )
			util.Decal("ExplosiveGunshot", tr.HitPos + tr.HitNormal, tr.HitPos - tr.HitNormal)
				if self.Splatter then 				// If the bullet has hit blood, make it splat on walls
					util.Decal("blood", tr.HitPos + tr.HitNormal, tr.HitPos - tr.HitNormal)
				end

				if tr.Entity:IsValid() and tr.Entity:IsPlayer() then
					tr.Entity:SetRunSpeed(160)
					timer.Simple(6, function()
						tr.Entity:SetRunSpeed(240)
					end)
					local dmginfo = DamageInfo()
					dmginfo:SetDamage( self.TissueDamage ) 
					hitgroup = tr.HitGroup
					if hitgroup == HITGROUP_GENERIC 					then 	dmginfo:ScaleDamage( 1 ) 			elseif
						hitgroup == HITGROUP_STOMACH 					then 	dmginfo:ScaleDamage( 1 ) 			elseif
						hitgroup == HITGROUP_GEAR 						then 	dmginfo:ScaleDamage( 1 ) 			elseif
						hitgroup == HITGROUP_CHEST 						then 	dmginfo:ScaleDamage( math.Rand(1,1.5) ) 	elseif
						hitgroup == HITGROUP_LEFTARM || hitgroup == HITGROUP_RIGHTARM  	then 	dmginfo:ScaleDamage( math.Rand(0.3,0.5) ) 	elseif
						hitgroup == HITGROUP_LEFTLEG || hitgroup == HITGROUP_RIGHTLEG  	then 	dmginfo:ScaleDamage( math.Rand(0.3,0.6) ) 	elseif
						hitgroup == HITGROUP_HEAD 						then 	dmginfo:ScaleDamage( 50 ) 			else
						dmginfo:ScaleDamage( 1 ) 			end
		dmginfo:SetDamageType( DMG_BULLET ) 						//Bullet damage
		dmginfo:SetAttacker( self.Owner ) 						//Shooter gets credit
		dmginfo:SetInflictor( self.Entity ) 						//Bullet gets credit
		dmginfo:SetDamageForce( self.Flightvector:GetNormalized()*self.EffectSize*3 )	//A little thump...

		tr.Entity:TakeDamageInfo( dmginfo ) 						//Take damage!
		if (tr.Entity:IsPlayer()) then
			self.Splatter = true
			util.Decal("blood", tr.HitPos + tr.HitNormal, tr.HitPos - tr.HitNormal)		//Splat all over them

		end
	end
			///

	end								// This one ends the impact code

	if !self.Impacted then
		self.Entity:SetPos(self.Entity:GetPos() + self.Flightvector)
	end								// This one sets a normal flight path if there is no impact

	self.Flightvector = self.Flightvector - self.Flightvector/self.BallisticDrag + (VectorRand():GetNormalized()*self.Drift) + Vector(0,0,-0.111)
	self.Entity:SetAngles(self.Flightvector:Angle() + Angle(90,0,0))
	self.Entity:NextThink( CurTime() )
	return true
end								// Ends the think function and loops the bullet code