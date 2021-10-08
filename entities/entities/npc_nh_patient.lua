AddCSLuaFile()

ENT.Base             = "base_nextbot"
ENT.Spawnable        = false
ENT.AdminSpawnable   = false

--Stats--
ENT.Speed = 70
ENT.WalkSpeedAnimation = 0.8
ENT.FlinchSpeed = 0

ENT.IsDead = false
ENT.Gibbed = false
ENT.health = 50
ENT.Damage = 20

ENT.AttackWaitTime = 0.8
ENT.AttackFinishTime = 0.4

ENT.FallDamage = 0

ENT.AttackAnim = (ACT_MELEE_ATTACK1)
ENT.WalkAnim = (ACT_WALK)

ENT.AttackDoorAnim = "WallPound"

--Sounds--
ENT.Attack1 = Sound("npc/nhzombie/nhzo_attack1.wav")
ENT.Attack2 = Sound("npc/nhzombie/nhzo_attack2.wav")

ENT.DoorBreak = Sound("npc/zombie/zombie_pound_door.wav")

ENT.Alert1 = Sound("npc/nhzombie/nhzombie_alert1.wav")
ENT.Alert2 = Sound("npc/nhzombie/nhzombie_alert2.wav")
ENT.Alert3 = Sound("npc/nhzombie/nhzombie_alert3.wav")

ENT.Death1 = Sound("npc/nhzombie/nhzombie_die1.wav")
ENT.Death2 = Sound("npc/nhzombie/nhzombie_die2.wav")
ENT.Death3 = Sound("npc/nhzombie/nhzombie_die3.wav")

ENT.Idle1 = Sound("npc/nhzombie/nhzombie_voice_idle1.wav")
ENT.Idle2 = Sound("npc/nhzombie/nhzombie_voice_idle2.wav")
ENT.Idle3 = Sound("npc/nhzombie/nhzombie_voice_idle3.wav")
ENT.Idle4 = Sound("npc/nhzombie/nhzombie_voice_idle4.wav")
ENT.Idle5 = Sound("npc/nhzombie/nhzombie_voice_idle5.wav")
ENT.Idle6 = Sound("npc/nhzombie/nhzombie_voice_idle6.wav")
ENT.Idle7 = Sound("npc/nhzombie/nhzombie_voice_idle7.wav")
ENT.Idle8 = Sound("npc/nhzombie/nhzombie_voice_idle8.wav")
ENT.Idle9 = Sound("npc/nhzombie/nhzombie_voice_idle9.wav")
ENT.Idle10 = Sound("npc/nhzombie/nhzombie_voice_idle10.wav")

ENT.Pain1 = Sound("npc/nhzombie/nhzombie_pain1.wav")
ENT.Pain2 = Sound("npc/nhzombie/nhzombie_pain2.wav")
ENT.Pain3 = Sound("npc/nhzombie/nhzombie_pain3.wav")
ENT.Pain4 = Sound("npc/nhzombie/nhzombie_pain4.wav")
ENT.Pain5 = Sound("npc/nhzombie/nhzombie_pain5.wav")
ENT.Pain6 = Sound("npc/nhzombie/nhzombie_pain6.wav")

ENT.Hit = Sound("npc/zombie/claw_strike1.wav")
ENT.Miss = Sound("npc/zombie/claw_miss1.wav")

function ENT:Precache()
	--Sounds--	
	util.PrecacheSound(self.Attack1)
	util.PrecacheSound(self.Attack2)

	util.PrecacheSound(self.DoorBreak)

	util.PrecacheSound(self.Death1)
	util.PrecacheSound(self.Death2)
	util.PrecacheSound(self.Death3)

	util.PrecacheSound(self.Alert1)
	util.PrecacheSound(self.Alert2)
	util.PrecacheSound(self.Alert3)

	util.PrecacheSound(self.Idle1)
	util.PrecacheSound(self.Idle2)
	util.PrecacheSound(self.Idle3)
	util.PrecacheSound(self.Idle4)
	util.PrecacheSound(self.Idle5)
	util.PrecacheSound(self.Idle6)
	util.PrecacheSound(self.Idle7)
	util.PrecacheSound(self.Idle8)
	util.PrecacheSound(self.Idle9)
	util.PrecacheSound(self.Idle10)
		
	util.PrecacheSound(self.Pain1)
	util.PrecacheSound(self.Pain2)
	util.PrecacheSound(self.Pain3)
	util.PrecacheSound(self.Pain4)
	util.PrecacheSound(self.Pain5)
	util.PrecacheSound(self.Pain6)
			
	util.PrecacheSound(self.Hit)
	util.PrecacheSound(self.Miss)
end

function ENT:Initialize()

	--Stats--
	self:SetCollisionGroup(COLLISION_GROUP_NPC)
	
	self:SetModel("models/nh2zombies/patient0" .. math.random(1, 3) .. ".mdl")
	self:SetBodygroup( 1, 2 )	
	self:SetHealth(self.health)
	
	self.LoseTargetDist	= 4000 -- How far the enemy has to be before we lose them
	self.SearchRadius 	= 3000	-- How far to search for enemies
	
	self.IsAttacking = false
	self.HasNoEnemy = false
	
	if SERVER then
		--Misc--
		self:Precache()
		self.loco:SetStepHeight(35)
		self.loco:SetAcceleration(900)
		self.loco:SetDeceleration(400)
	end
end

function ENT:Think()
	if !IsValid(self) then return end

	if self.IsAttacking then
		self.loco:FaceTowards( self.Enemy:GetPos() )
	end
 
end

function ENT:SetEnemy()
	ent = player.GetAll()[math.random(1,#player.GetAll())]
	self.Enemy = ent
end

function ENT:GetEnemy()
	return self.Enemy
end

function ENT:HaveEnemy()
	if ( self:GetEnemy() and IsValid( self:GetEnemy() ) ) then
		if ( self:GetRangeTo( self:GetEnemy():GetPos() ) > self.LoseTargetDist ) then
			return self:FindEnemy()
		elseif ( self:GetEnemy():IsPlayer() and !self:GetEnemy():Alive() ) then
			return self:FindEnemy()
		end	
		return true
	else
		return self:FindEnemy()
	end
end

function ENT:FindEnemy()
	local _ents = ents.FindInSphere( self:GetPos(), self.SearchRadius )
	for k,v in pairs( _ents ) do
		if ( v:IsPlayer() ) then
			self:SetEnemy( v )
			return true
		end
	end	
	self:SetEnemy( nil )
	return false
end

function ENT:IdleSounds()
	if SERVER then
	if math.random(1,3) == 1 then
	local sounds = {}
	sounds[1] = self.Idle1
	sounds[2] = self.Idle2
	sounds[3] = self.Idle3
	sounds[4] = self.Idle4
	sounds[5] = self.Idle5
	sounds[6] = self.Idle6
	sounds[7] = self.Idle7
	sounds[8] = self.Idle8
	sounds[9] = self.Idle9
	sounds[10] = (self.Idle10)
		self:EmitSound( sounds[math.random(1,10)], math.random(95,115), math.random(95,115))
	end
	end
end
function ENT:RunBehaviour()
	while ( true ) do
		if ( self:HaveEnemy() ) then
			self.HasNoEnemy = false
			self:StartActivity(self.WalkAnim)
			self:SetPoseParameter("move_x",self.WalkSpeedAnimation)
			self.loco:SetDesiredSpeed(self.Speed)
			self:ChaseEnemy() 
		else
			self.HasNoEnemy = true
			self:StartActivity(self.WalkAnim)
			self:SetPoseParameter("move_x",self.WalkSpeedAnimation)
			self.loco:SetDesiredSpeed(self.Speed)
			self:IdleSounds()
			self:MoveToPos( self:GetPos() + Vector( math.Rand( -1, 1 ), math.Rand( -1, 1 ), 0 ) * 400 )
			self:SetPoseParameter("move_x", 0)
		end
		coroutine.wait( 0.55 )
	end
end	

function ENT:ChaseEnemy( options )
	local options = options or {}
	local path = Path( "Follow" )
	path:SetMinLookAheadDistance( options.lookahead or 300 )
	path:SetGoalTolerance( options.tolerance or 20 )
	path:Compute( self, self:GetEnemy():GetPos() )
	if (  !path:IsValid() ) then return "failed" end
	while ( path:IsValid() and self:HaveEnemy() ) do

		if ( path:GetAge() > 0.1 ) then	
			path:Compute( self, self:GetEnemy():GetPos() )
		end
		path:Update( self )	
		if ( options.draw ) then path:Draw() end
		if ( self.loco:IsStuck() ) then
			self:HandleStuck()
			return "stuck"
		end
	
	if (self:GetPos():Distance(self.Enemy:GetPos()) < 1000) then	
		if math.random(1, 500) == 5 then
			self:IdleSounds()
		end
	end
	
	local ent = ents.FindInSphere(self:GetPos(),45)
	for k,v in pairs( ent ) do
		if (v:IsPlayer() && v:Alive()) then
			self.Enemy = v
		
			if SERVER then
				local sounds = {}
				sounds[1] = (self.Attack1)
				sounds[2] = (self.Attack2)
				self:EmitSound( sounds[math.random(1,2)], math.random(95,105), math.random(95,115) )
			end
				
			self.Enemy = self.Enemy	
			self.IsAttacking = true
			self:StartActivity(self.AttackAnim)
			coroutine.wait(self.AttackWaitTime)
			
			if !self:IsValid() then return end
			if self:Health() < 0 then return end
			
			if !self.Enemy:IsValid() then 
				self:StartActivity( self.WalkAnim )
				self:EmitSound(self.Miss)
				return 
			end
			
			if self.Enemy:Health() < 0 then 
				self:StartActivity( self.WalkAnim )
				self:EmitSound(self.Miss)
				return 
			end
			
			if (self:GetRangeTo(self.Enemy) < 55) then
				
				self:EmitSound(self.Hit)
				self.Enemy:TakeDamage( self.Damage, self)	
				self.Enemy:ViewPunch(Angle(math.random(-1, 1)*self.Damage, math.random(-1, 1)*self.Damage, math.random(-1, 1)*self.Damage))
				
				local bleed = ents.Create("info_particle_system")
				bleed:SetKeyValue("effect_name", "blood_impact_red_01")
				bleed:SetPos(self.Enemy:GetPos() + Vector(0,0,60)) 
				bleed:Spawn()
				bleed:Activate() 
				bleed:Fire("Start", "", 0)
				bleed:Fire("Kill", "", 0.2)
					
				local moveAdd=Vector(0,0,150)
				if not self.Enemy:IsOnGround() then
					moveAdd=Vector(0,0,0)
				end
				self.Enemy:SetVelocity(moveAdd+((self.Enemy:GetPos()-self:GetPos()):GetNormal()*0)) -- apply the velocity
			end
			self:EmitSound(self.Miss)
		
			coroutine.wait(self.AttackFinishTime)
			self.IsAttacking = false
			self:StartActivity(self.WalkAnim)
			self:SetPoseParameter("move_x",self.WalkSpeedAnimation)
			end
		
		end
	
		coroutine.yield()
	return "ok"
	end
end

function ENT:AttackProp()
	local entstoattack = ents.FindInSphere(self:GetPos(), 25)
	for _,v in pairs(entstoattack) do
	
		if (v:GetClass() == "prop_physics") then
		
		if SERVER then
		local sounds = {}
	sounds[1] = (self.Attack1)
	sounds[2] = (self.Attack2)
		self:EmitSound( sounds[math.random(1,2)], math.random(95,105), math.random(95,115) )
		end
	
		self:StartActivity(self.AttackAnim)  
		self:SetPoseParameter("move_x",0)
		coroutine.wait(self.AttackWaitTime)
		self:EmitSound(self.Miss)
		
		if !self:IsValid() then return end
		if self:Health() < 0 then return end
		
		if !v:IsValid() then 
		self:StartActivity( self.WalkAnim )
		self:SetPoseParameter("move_x",self.WalkSpeedAnimation)
		self:EmitSound(self.Miss)
		return end
		
		if v:Health() < 0 then 
		self:StartActivity( self.WalkAnim )
		self:SetPoseParameter("move_x",self.WalkSpeedAnimation)
		self:EmitSound(self.Miss)
		return end
		
		if (self:GetRangeTo(v) < 60) then

		local phys = v:GetPhysicsObject()
			if (phys != nil && phys != NULL && phys:IsValid()) then
			phys:ApplyForceCenter(self:GetForward():GetNormalized()*30000 + Vector(0, 0, 2))
			v:EmitSound(self.DoorBreak)
			v:TakeDamage( self.Damage, self)	
			end
			
		end
		coroutine.wait(self.AttackFinishTime)	
		self:SetPoseParameter("move_x",self.WalkSpeedAnimation)
		self:StartActivity( self.WalkAnim )
			return true
		end
	end
	return false
end

function ENT:AttackBreakable()
	local entstoattack = ents.FindInSphere(self:GetPos(), 25)
	for _,v in pairs(entstoattack) do
	
	if (v:GetClass() == "func_breakable") then
	
	if SERVER then
		local sounds = {}
		sounds[1] = (self.Attack1)
		sounds[2] = (self.Attack2)
		self:EmitSound( sounds[math.random(1,2)], math.random(95,105), math.random(95,115) )
		end
	
		self:StartActivity(self.AttackAnim)  
		self:SetPoseParameter("move_x",0)
		coroutine.wait(self.AttackWaitTime)
		self:EmitSound(self.Miss)
		
		if !self:IsValid() then return end
		if self:Health() < 0 then return end
		
		if !v:IsValid() then 
		self:StartActivity( self.WalkAnim )
		self:SetPoseParameter("move_x",self.WalkSpeedAnimation)
		self:EmitSound(self.Miss)
		return end
		
		if v:Health() < 0 then 
		self:StartActivity( self.WalkAnim )
		self:SetPoseParameter("move_x",self.WalkSpeedAnimation)
		self:EmitSound(self.Miss)
		return end
		
			v:EmitSound(self.DoorBreak)
			v:TakeDamage( self.Damage, self)	
			
		coroutine.wait(self.AttackFinishTime)
		self:SetPoseParameter("move_x",self.WalkSpeedAnimation)		
		self:StartActivity( self.WalkAnim )
			return true
		end
	end
	return false
end

function ENT:OnKilled( dmginfo )

	if self.IsDead then return end
	
	hook.Call( "OnNPCKilled", GAMEMODE, self, dmginfo:GetAttacker(), dmginfo:GetInflictor() )

	local painsounds = {}
	painsounds[1] = self.Death1
	painsounds[2] = self.Death2
	painsounds[3] = self.Death3
	
	self:EmitSound(painsounds[math.random(1,3)], math.random(90,100), math.random(95,115))
	
	local body = ents.Create( "prop_ragdoll" )
	body:SetPos( self:GetPos() )
	body:SetAngles(self:GetAngles())
	body:SetModel( self:GetModel() )
	if dmginfo:GetDamage() >= 10 and not self.Gibbed then
		local bleed = ents.Create("info_particle_system")
		bleed:SetKeyValue("effect_name", "blood_impact_red_01")
		bleed:SetPos(self:GetPos() + Vector(0, 0, 60)) 
		bleed:Spawn()
		bleed:Activate() 
		bleed:Fire("Start", "", 0)
		bleed:Fire("Kill", "", 1.2)
		body:SetBodygroup( 1, math.random(0, 1) )
		self:EmitSound("physics/flesh/flesh_bloody_break.wav", 100, 100)
	elseif not self.Gibbed then
		body:SetBodygroup( 1, 2 )
	end
	body:Spawn()
	body:GetPhysicsObject():ApplyForceCenter(dmginfo:GetDamageForce())
	
	self:Remove()
	self.IsDead = true
	
	if game.GetMap() == "nh2c1_v2" then
		ents.FindByName("kitchen_door")[1]:Fire("Unlock")
		ents.FindByName("zombie_corpse_sound")[1]:Fire("PlaySound")
	end
	
	timer.Simple( 10, function()
		body:Remove()
	end )

end

function ENT:OnInjured( dmginfo )
	local curHealth = self:Health()
	local attacker = dmginfo:GetAttacker()
	if ( attacker:IsPlayer() and dmginfo:IsBulletDamage() ) then
		
		self:SetHealth(curHealth - dmginfo:GetDamage())
		if dmginfo:GetDamage() >= 10 and not self.Gibbed then
			local bleed = ents.Create("info_particle_system")
			bleed:SetKeyValue("effect_name", "blood_impact_red_01")
			bleed:SetPos(self:GetPos() + Vector(0, 0, 60)) 
			bleed:Spawn()
			bleed:Activate() 
			bleed:Fire("Start", "", 0)
			bleed:Fire("Kill", "", 1.2)
			self:SetBodygroup( 1, math.random(0, 1) )
			self:EmitSound("physics/flesh/flesh_bloody_break.wav", 100, 100)
			self.Gibbed = true
		end
	end

	if self:Health() <= 0 then
		self:OnKilled(dmginfo)
	end

	if math.random(1,3) == 1 then
		local painsounds = {}
		painsounds[1] = self.Pain1
		painsounds[2] = self.Pain2
		painsounds[3] = self.Pain3
		painsounds[4] = self.Pain4
		painsounds[5] = self.Pain5
		painsounds[6] = self.Pain6
		self:EmitSound(painsounds[math.random(1,6)], math.random(90,100), math.random(95,115))
	end
	
end