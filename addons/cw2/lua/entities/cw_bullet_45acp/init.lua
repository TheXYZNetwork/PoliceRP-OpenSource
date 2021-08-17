AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

local mats={					// Multipliers for materials
	[MAT_FOLIAGE]			={5},
	[MAT_SLOSH]			={3},
	[MAT_ALIENFLESH]		={2},
	[MAT_ANTLION]			={2},
	[MAT_BLOODYFLESH]		={2},
	[MAT_FLESH]			={2},
	[45]				={2},	// Metrocop heads are a source glitch, they have no enumeration
	[MAT_DIRT]			={2},
	[MAT_WOOD]			={1.5},
	[MAT_SAND]			={1.3},
	[MAT_GLASS]			={1.2},
	[MAT_CLIP]			={1},
	[MAT_COMPUTER]			={1},
	[MAT_PLASTIC]			={1},
	[MAT_TILE]			={1},
	[MAT_CONCRETE]			={1},
	[MAT_GRATE]			={0.8},
	[MAT_VENT]			={0.8},
	[MAT_METAL]			={0.3},
}						// This determines how much the bullet will penetrate in stuff

function ENT:Initialize()   
math.randomseed(CurTime())

self.Owner 		= self:GetOwner()			// Who dun it!
self.Penetrate 		= 6					// How deep Generic Default goes
self.Flightvector 	= self.Entity:GetUp()*((488*40.4)/66)	// Velocity in m/s, FIRST NUMMER is SPEED (FrameTime)
self.Timeleft 		= CurTime() + 5				// How long before auto-remove?
self.Impacted 		= false					// Important for flight continuation, see line 173
self.Splatter 		= false					// Carries blood and AIDS after the round passes through someone
self.EffectSize		= GetConVar("gdcwbulletimpact"):GetFloat()					// How much stuff gets kicked up on impact
self.TissueDamage	= math.Rand(10,18)			// Player damage is multiplied by 2 for some reason
self.BallisticDrag	= 180			// Fraction of velocity lost per tick, higher is less
self.Drift		= 0.5					// How much the bullet will drift in flight (Inaccuracy)

self.Entity:SetModel( "models/led.mdl" )
self.Entity:PhysicsInit( SOLID_VPHYSICS )
self.Entity:SetMoveType( MOVETYPE_NONE )
self.Entity:SetSolid( SOLID_NONE )
       
Trail = ents.Create("env_spritetrail")				// The streak of the tracer
Trail:SetKeyValue("lifetime","0.1")
Trail:SetKeyValue("startwidth","20")
Trail:SetKeyValue("endwidth","5")
Trail:SetKeyValue("spritename","trails/laser.vmt")
Trail:SetKeyValue("rendermode","5")
Trail:SetKeyValue("rendercolor","255 150 100")
Trail:SetPos(self.Entity:GetPos())
Trail:SetParent(self.Entity)
Trail:Spawn()
Trail:Activate()

Glow = ents.Create("env_sprite")				// The ball of the tracer
Glow:SetKeyValue("model","orangecore2.vmt")
Glow:SetKeyValue("rendercolor","255 150 100")
Glow:SetKeyValue("scale","0.05")
Glow:SetPos(self.Entity:GetPos())
Glow:SetParent(self.Entity)
Glow:Spawn()
Glow:Activate()

Shine = ents.Create("env_sprite")
Shine:SetPos(self.Entity:GetPos())
Shine:SetKeyValue("renderfx", "0")
Shine:SetKeyValue("rendermode", "5")
Shine:SetKeyValue("renderamt", "255")
Shine:SetKeyValue("rendercolor", "255 130 100")
Shine:SetKeyValue("framerate12", "20")
Shine:SetKeyValue("model", "light_glow03.spr")
Shine:SetKeyValue("scale", "0.25")
Shine:SetKeyValue("GlowProxySize", "0")
Shine:SetParent(self.Entity)
Shine:Spawn()
Shine:Activate()

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

			if tr.Entity:IsValid() then
			local dmginfo = DamageInfo()
			dmginfo:SetDamage( self.TissueDamage ) 
			hitgroup = tr.HitGroup
if hitgroup == HITGROUP_GENERIC 					then 	dmginfo:ScaleDamage( 1 ) 			elseif
   hitgroup == HITGROUP_STOMACH 					then 	dmginfo:ScaleDamage( 1 ) 			elseif
   hitgroup == HITGROUP_GEAR 						then 	dmginfo:ScaleDamage( 1 ) 			elseif
   hitgroup == HITGROUP_CHEST 						then 	dmginfo:ScaleDamage( math.Rand(1,1.5) ) 	elseif
   hitgroup == HITGROUP_LEFTARM || hitgroup == HITGROUP_RIGHTARM  	then 	dmginfo:ScaleDamage( math.Rand(0.3,0.5) ) 	elseif
   hitgroup == HITGROUP_LEFTLEG || hitgroup == HITGROUP_RIGHTLEG  	then 	dmginfo:ScaleDamage( math.Rand(0.3,0.6) ) 	elseif
   hitgroup == HITGROUP_HEAD 						then 	dmginfo:ScaleDamage( 5 ) 			else
   									 	dmginfo:ScaleDamage( 1 ) 			end
		dmginfo:SetDamageType( DMG_BULLET ) 						//Bullet damage
		dmginfo:SetAttacker( self.Owner ) 						//Shooter gets credit
		dmginfo:SetInflictor( self.Entity ) 						//Bullet gets credit
		dmginfo:SetDamageForce( self.Flightvector:GetNormalized()*self.EffectSize*3 )	//A little thump...
		tr.Entity:TakeDamageInfo( dmginfo ) 						//Take damage!
		if (tr.Entity:IsPlayer() || tr.Entity:IsNPC()) then
		self.Splatter = true
		util.Decal("blood", tr.HitPos + tr.HitNormal, tr.HitPos - tr.HitNormal)		//Splat all over them
		end
			end
			///

	// THIS IS BULLET RICOCHET	
		local Dot = self.Entity:GetUp():DotProduct(tr.HitNormal)
		if (Dot*math.Rand(0.04,1)*mats[tr.MatType][1])>-0.04 then		// If it doesnt hit head on,
			self.Flightvector = (self.Flightvector:Length()*(1+Dot*1.2)) * (self.Entity:GetUp()+(tr.HitNormal*Dot*-0.8)+(VectorRand()*0.1))
			self.Entity:SetAngles(self.Flightvector:Angle() + Angle(90,0,0))
			self.Entity:SetPos(tr.HitPos+tr.HitNormal)
			self.Entity:NextThink( CurTime() )
			return true
			end	

				// This part is for realistic bullet penetration
				// Generic Default penetrated your mom......

	self.Mat = math.ceil(tr.MatType)								// Multiplier for materials
	local trace = {}
	trace.start = tr.HitPos + self.Flightvector:GetNormalized()*(self.Penetrate*mats[self.Mat][1])	// Start in front of the bullet
	trace.endpos = tr.HitPos									// Trace back to the impact
	trace.filter = self.Entity 
	trace.mask 	= MASK_SHOT
	local pr = util.TraceLine( trace )

	if pr.StartSolid || tr.Hit and !pr.Hit || self.Penetrate<=0 then	// If you start inside something, it's too thick
	self.Entity:Remove()							// So remove the bullet
	else
	///

	self.Penetrate = self.Penetrate-(tr.HitPos:Distance(pr.HitPos)/mats[self.Mat][1])	// Subtract to get the penetration depth
	if self.Penetrate<=0 then								// If it runs out of inertia, remove it
	self.Entity:Remove()							
	end

	self.Entity:SetPos(pr.HitPos + self.Flightvector:GetNormalized())	// Start at the point of exit + 1
	self.Impacted = true							// This prevents it from moving twice later on

	local effectdata = EffectData()
	effectdata:SetOrigin(pr.HitPos)						// Position of Impact
	effectdata:SetNormal(self.Flightvector:GetNormalized())			// Direction of Impact
	effectdata:SetScale(self.EffectSize)					// Size of explosion
	effectdata:SetRadius(pr.MatType)					// Texture of Impact
	util.Effect( "gdcw_universal_penetrate", effectdata )					// Make some debris
	util.ScreenShake(pr.HitPos, 10, 5, 0.1, 200 )						// Compression in the material
	util.Decal("ExplosiveGunshot", pr.HitPos + pr.HitNormal,pr.HitPos - pr.HitNormal)	// Bullet hole in the exit

	end								// This one ends the penetration code
	end								// This one ends the impact code

	if !self.Impacted then
	self.Entity:SetPos(self.Entity:GetPos() + self.Flightvector)
	end								// This one sets a normal flight path if there is no impact

self.Flightvector = self.Flightvector - self.Flightvector/self.BallisticDrag + (VectorRand():GetNormalized()*self.Drift) + Vector(0,0,-0.111)
self.Entity:SetAngles(self.Flightvector:Angle() + Angle(90,0,0))
self.Entity:NextThink( CurTime() )
return true
end								// Ends the think function and loops the bullet code