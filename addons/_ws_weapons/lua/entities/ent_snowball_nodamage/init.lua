AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('shared.lua')

function ENT:Initialize()
	self.Entity:SetModel("models/weapons/w_snowball_thrown.mdl");
	//self.Entity:PhysicsInit(SOLID_VPHYSICS);
	self.Entity:SetMoveType(MOVETYPE_VPHYSICS);
	self.Entity:SetSolid(SOLID_VPHYSICS);
	self.Entity:SetCollisionGroup( COLLISION_GROUP_PROJECTILE )
	self:PhysicsInitSphere( 30, "ice" )
	local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:Wake()
		phys:EnableGravity(true);
		phys:SetBuoyancyRatio(0);
	end
	self.Trail = util.SpriteTrail(self.Entity, 0, currentcolor, false, 15, 1, 2, 1/(15+1)*0.5, "trails/laser.vmt") 
end

function ENT:Think()
end

function ENT:SpawnFunction(ply, tr)
	if (!tr.Hit) then return end
	local SpawnPos = tr.HitPos + tr.HitNormal * 16;
	local ent = ents.Create("ent_snowball_nodamage");
	ent:SetPos(SpawnPos);
	ent:Spawn();
	ent:Activate();
	ent:SetOwner(ply)
	return ent;
end

function ENT:PhysicsCollide(data)
	local pos = self.Entity:GetPos() --Get the position of the snowball
	local effectdata = EffectData()
	data.HitObject:ApplyForceCenter(self:GetPhysicsObject():GetVelocity() * 40)
	
	//These lines stop the damage, keep commented unless you want to enable it (wood)
	//if(damageactivated == 1) then
	//	data.HitObject:GetEntity():TakeDamage(20000);	
	//end
	effectdata:SetStart( pos )
	effectdata:SetOrigin( pos )
	effectdata:SetScale( 1.5 )
	self:EmitSound("hit.wav")
	//util.Effect( "watersplash", effectdata ) -- effect
	//util.Effect( "inflator_magic", effectdata ) -- effect
	util.Effect( "WheelDust", effectdata ) -- effect
	util.Effect( "GlassImpact", effectdata ) -- effect
	self.Entity:Remove(); --Remove the snowball
end 