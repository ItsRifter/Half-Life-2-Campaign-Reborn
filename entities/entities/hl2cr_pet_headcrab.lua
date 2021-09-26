AddCSLuaFile()

ENT.Base 			= "base_nextbot"
ENT.Spawnable		= true

function ENT:Initialize()

	self:SetModel( "models/headcrabclassic.mdl" )
	
	self.LoseTargetDist	= 200
	self.SearchRadius 	= 250
	self.BaseSpeed = 30
	self.AttackDist = 175
	self.AttackDMG = 5
	self.NextAttack = 0
	self.followOwner = false
	
	self:SetHealth(100)
	
	self:AddFlags(FL_NPC)
	self:AddFlags(FL_OBJECT)
	self:SetCollisionGroup(COLLISION_GROUP_NPC)
	self:SetCollisionBounds(Vector(-14, -9, (-6 * 2)), Vector(14, 8, (16 * 2)))
end

----------------------------------------------------
-- ENT:Get/SetEnemy()
-- Simple functions used in keeping our enemy saved
----------------------------------------------------
function ENT:SetEnemy(ent)
	self.Enemy = ent
end
function ENT:GetEnemy()
	return self.Enemy
end

----------------------------------------------------
-- ENT:HaveEnemy()
-- Returns true if we have a enemy
----------------------------------------------------
function ENT:HaveEnemy()
	-- If our current enemy is valid
	if ( self:GetEnemy() and IsValid(self:GetEnemy()) ) then
		-- If the enemy is too far
		if ( self:GetRangeTo(self:GetEnemy():GetPos()) > self.LoseTargetDist ) then
			return self:FindEnemy()
		elseif ( !self:GetEnemy():IsFriendly() or self:GetEnemy():GetClass() == "npc_citizen" ) then
			return self:FindEnemy()
		end	
		
		return true
	else
		return self:FindEnemy()
	end
end

----------------------------------------------------
-- ENT:FindEnemy()
-- Returns true and sets our enemy if we find one
----------------------------------------------------
function ENT:FindEnemy()
	local _ents = ents.FindInSphere( self:GetPos(), self.SearchRadius )
	for k,v in ipairs( _ents ) do
		if v:IsNPC() and !v:IsFriendly() then
			self:SetEnemy(v)
			return true
		end
	end	
	self:SetEnemy(nil)
	return false
end

----------------------------------------------------
-- ENT:RunBehaviour()
-- This is where the meat of our AI is
----------------------------------------------------
function ENT:RunBehaviour()
	while ( true ) do
		if ( self:HaveEnemy() ) then
			self.loco:FaceTowards(self:GetEnemy():GetPos())
			self:StartActivity( ACT_RUN )
			self.loco:SetDesiredSpeed( self.BaseSpeed )
			--self.loco:SetAcceleration(900)
			self:ChaseEnemy( )
			--self.loco:SetAcceleration(400)
			--self:PlaySequenceAndWait( "jumpattack_broadcast" )
			self:EmitSound("npc/headcrab/alert1.wav")
			self:StartActivity( ACT_IDLE )
		elseif self.teleport and self:GetOwner():Alive() then
			self:SetPos(self:GetOwner():GetPos())
			self.teleport = false
			self:GetOwner().bringCooldown = 6 + CurTime()
		elseif self.followOwner then
			self:StartActivity( ACT_RUN )
			self.loco:SetDesiredSpeed( self.BaseSpeed )
			self:FollowOwner()
		else
			self:StartActivity( ACT_RUN )
			self.loco:SetDesiredSpeed( self.BaseSpeed )
			self:MoveToPos( self:GetPos() + Vector( math.Rand( -1, 1 ), math.Rand( -1, 1 ), 0 ) * 150 )
			self:StartActivity( ACT_IDLE )
		end
		
		coroutine.wait(2)
		
	end

end	

----------------------------------------------------
-- ENT:ChaseEnemy()
-- Works similarly to Garry's MoveToPos function
--  except it will constantly follow the
--  position of the enemy until there no longer
--  is one.
----------------------------------------------------
function ENT:ChaseEnemy( options )

	local options = options or {}
	local path = Path( "Chase" )
	path:SetMinLookAheadDistance( options.lookahead or 300 )
	path:SetGoalTolerance( options.tolerance or 20 )
	path:Compute( self, self:GetEnemy():GetPos() )

	if ( !path:IsValid() ) then return "failed" end

	while ( path:IsValid() and self:HaveEnemy() ) do
	
		if ( path:GetAge() > 0.1 ) then
			if self:GetPos():Distance( self:GetEnemy():GetPos() ) <= self.AttackDist and self.NextAttack < CurTime() then
				self:EmitSound("npc/headcrab/attack" .. math.random(1, 3)	 .. ".wav")
				self.loco:JumpAcrossGap(self:GetEnemy():GetPos(), self:GetPos())
				self:PlaySequenceAndWait("jumpattack_broadcast")
				
				self:GetEnemy():TakeDamage(self.AttackDMG, self:GetOwner(), self)
				self:GetEnemy():AddEntityRelationship( self, D_HT, 99 )
				self:GetEnemy():EmitSound("npc/headcrab/headbite.wav")
				
				self.NextAttack = CurTime() + 5
				self:StartActivity( ACT_RUN )
			end
		end
		path:Update( self )
		
		if ( options.draw ) then path:Draw() end
		
		if ( self.loco:IsStuck() ) then
			self:HandleStuck()
			return "stuck"
		end

		coroutine.yield()

	end

	return "ok"

end

function ENT:HandleStuck()
	if CLIENT then return end
	self:SetPos(self:GetOwner():GetPos())
	self.loco:ClearStuck()
end

function ENT:FollowOwner( options )

	local options = options or {}
	local path = Path( "Follow" )
	path:SetMinLookAheadDistance( options.lookahead or 300 )
	path:SetGoalTolerance( options.tolerance or 20 )
	path:Compute( self, self:GetOwner():GetPos() )

	if ( !path:IsValid() ) then return "failed" end

	while ( path:IsValid() and self:GetOwner():Alive() ) do
	
		if ( path:GetAge() > 0.1 ) then			
			path:Compute(self, self:GetOwner():GetPos(), function(area)
				if ( !self.loco:IsAreaTraversable(area) ) then
					return -1
				end
			end)
		end
		
		path:Update( self )
		
		if ( options.draw ) then path:Draw() end
		
		if ( self.loco:IsStuck() ) then
			self:HandleStuck()
			return "stuck"
		end

		coroutine.yield()
	end

	return "ok"

end

function ENT:OnInjured( dmginfo )
	local att = dmginfo:GetAttacker()
	
	if att:IsPlayer() then
		return
	end

end

function ENT:OnKilled( dmginfo )
	local att = dmginfo:GetAttacker()
	
	if att:IsPlayer() then
		return
	end
	
	self:GetOwner().pet = nil
	SafeRemoveEntity(self) 
end

list.Set( "NPC", "hl2cr_pet_headcrab", {
	Name = "Headcrab Pet",
	Class = "hl2cr_pet_headcrab",
	Category = "Nextbot"
})