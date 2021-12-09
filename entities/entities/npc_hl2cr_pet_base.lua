AddCSLuaFile()

ENT.Base 			= "base_nextbot"
ENT.Spawnable		= true

function ENT:Initialize()

	self:SetModel( "models/mossman.mdl" )
	
	self.LoseTargetDist	= 200
	self.SearchRadius 	= 250
<<<<<<< Updated upstream:entities/entities/npc_hl2cr_pet_base.lua
	self.NextAttack 	= 0
	self.AttackDelay 	= 0
	self.followOwner 	= false
	
	self.BaseSpeed = 0
	self.AttackDist = 150
=======
	self.NextAttack = 0
	self.followOwner = false
	
	self.BaseSpeed = 0
	self.AttackDist = 175
>>>>>>> Stashed changes:entities/entities/hl2cr_pet_headcrab.lua
	self.AttackDMG = 0
	
	self:SetHealth(1)
	
	self:AddFlags(FL_NPC)
	self:AddFlags(FL_OBJECT)
	self:SetCollisionGroup(COLLISION_GROUP_NPC)
end

function ENT:SetUpStats(stats)
<<<<<<< Updated upstream:entities/entities/npc_hl2cr_pet_base.lua
=======
	
>>>>>>> Stashed changes:entities/entities/hl2cr_pet_headcrab.lua
	self.BaseHealth = stats["health"]
	self.BaseSpeed = stats["speed"]
	self.AttackDMG = stats["damage"]
	
	self:SetHealth(self.BaseHealth)
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
	for k, v in ipairs( _ents ) do
		if v:IsNPC() and not (v:IsFriendly() or v:GetClass() == "npc_citizen") then
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
			self:ChaseEnemy()
			self:EmitSound("npc/headcrab/alert1.wav")
			self:StartActivity( ACT_IDLE )
		elseif self.followOwner then
			self:StartActivity( ACT_RUN )
			self.loco:SetDesiredSpeed( self.BaseSpeed )
			self:FollowOwner()
		else
			self:StartActivity( ACT_RUN )
			self.loco:SetDesiredSpeed( self.BaseSpeed )
			self:Move()
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
				
				if ents.FindInSphere( self:GetPos(), 15 ) then
					self:GetEnemy():TakeDamage(self.AttackDMG, self:GetOwner(), self)
					self:GetEnemy():AddEntityRelationship( self, D_HT, 99 )
					self:GetEnemy():EmitSound("npc/headcrab/headbite.wav")
				end
				
				if self:GetEnemy():Health() <= 0 then
					hook.Call( "OnNPCKilled", "HL2CR_NPCKilled", self:GetEnemy(), self, self:GetOwner() )
				end
				
<<<<<<< Updated upstream:entities/entities/npc_hl2cr_pet_base.lua
				self.NextAttack = CurTime() + self.AttackDelay
=======
				self.NextAttack = CurTime() + 5
>>>>>>> Stashed changes:entities/entities/hl2cr_pet_headcrab.lua
				self:Move()
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

function ENT:Move( options )

	local pos = self:GetPos() + Vector( math.Rand( -1, 1 ), math.Rand( -1, 1 ), 0 ) * 135
	
	local options = options or {}
	local path = Path( "Follow" )
	path:SetMinLookAheadDistance( options.lookahead or 300 )
	path:SetGoalTolerance( options.tolerance or 35 )
	path:Compute( self, pos )
	
	if ( !path:IsValid() ) then return "failed" end
	
	while ( path:IsValid() and not self:HaveEnemy() ) do
		if self.teleport and self:GetOwner():Alive() then
			path:SetGoalTolerance( options.tolerance or 60 )
			path:Compute( self, self:GetOwner():GetPos())
			timer.Simple(0.5, function()
				self.teleport = false
				self:GetOwner().bringCooldown = 6 + CurTime()
			end)
		end
		
		if ( path:GetAge() > 8 ) then			
			path:Compute(self, pos, function( area, fromArea, ladder, elevator, length )
				if not IsValid(fromArea) then
					return -1
				end
				
				if ( !self.loco:IsAreaTraversable( area ) ) then
					return -1
				end

				local deltaZ = fromArea:ComputeAdjacentConnectionHeightChange( area )
				
				if ( deltaZ > self.loco:GetStepHeight() ) then
					return -1
				end

				return cost
			end )
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
	path:SetGoalTolerance( options.tolerance or 35 )
	path:Compute( self, self:GetOwner():GetPos() )

	if ( !path:IsValid() ) then return "failed" end

	while ( path:IsValid() and self:GetOwner():Alive() and self.followOwner == true ) do
	
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
	
	self:GetOwner().petcool = CurTime() + 6
	
	self:SetHealth(self:Health() - dmginfo:GetDamage())
	self:GetOwner():SetNWInt("pet_health", self:Health())
<<<<<<< Updated upstream:entities/entities/npc_hl2cr_pet_base.lua
	
	if self:Health() <= 0 then
		self:OnKilled( dmginfo )
	end
	
=======
>>>>>>> Stashed changes:entities/entities/hl2cr_pet_headcrab.lua
end

function ENT:OnKilled( dmginfo )
	local att = dmginfo:GetAttacker()
	
	if att:IsPlayer() then
		return
	end
	
	net.Start("HL2CR_SpawnPet")
		net.WriteBool(false)
	net.Send(self:GetOwner())
	
	self:GetOwner().spawnCooldown = 5 + CurTime() * GetConVar("hl2cr_difficulty"):GetInt()
	
	self:GetOwner().pet = nil
	SafeRemoveEntity(self)
end

list.Set( "NPC", "hl2cr_pet_base", {
	Name = "Base Pet",
	Class = "hl2cr_pet_base",
	Category = "Nextbot"
})