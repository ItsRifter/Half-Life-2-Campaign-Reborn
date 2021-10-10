AddCSLuaFile()
ENT.Base			= "base_ai"
ENT.Type            = "ai"
ENT.Spawnable       = false
ENT.AdminSpawnable  = false

ENT.Gibbed = false

ENT.m_fMaxYawSpeed = 100
ENT.m_iClass = "CLASS_ZOMBIE"

if SERVER then
	local schedule = ai_schedule.New("NH_Zombie_Sch")
	schedule:EngTask("TASK_TARGET_PLAYER", 0)
	schedule:EngTask("TASK_GET_PATH_TO_PLAYER", 0)
	schedule:EngTask("TASK_MOVE_TO_TARGET_RANGE", 15)
	schedule:EngTask("TASK_MELEE_ATTACK1", 0)

	function ENT:SelectSchedule()
		self:StartSchedule(schedule)
	end
end

function ENT:Initialize()
	if CLIENT then return end
	self:SetArrivalSpeed(5)
	self:SetCollisionGroup(COLLISION_GROUP_NPC)
	self:SetHullType(HULL_HUMAN)
	self:SetHullSizeNormal()
	
	self:SetModel("models/nh2zombies/cook.mdl")
	
	self:SetNPCState(NPC_STATE_IDLE)
	self:SetSolid(SOLID_BBOX)
	
	self:DropToFloor()
	
	self:SetHealth(50)
	self:CapabilitiesAdd(CAP_MOVE_GROUND)
	self:CapabilitiesAdd(CAP_WEAPON_MELEE_ATTACK1)
	self:SetBodygroup( 1, 2 )
	
	self:SetMoveType(MOVETYPE_STEP)
	self:SetSchedule(SCHED_AMBUSH)
end

function ENT:Think()
	if CLIENT then return end
	
	if not self:GetEnemy() then
		self:SetSchedule(SCHED_ALERT_WALK)
	end
	
	if self:GetEnemy() then
		self:SetSchedule(SCHED_COMBAT_FACE)
		return
	end
	
	if self:GetEnemy() and self:Distance(self:GetEnemy():GetPos() ) < 5 then
		self:SetSchedule(SCHED_CHASE_ENEMY)
		self:SetSchedule(SCHED_COMBAT_FACE)
		return
	end
	if self:GetSequenceActivity(ACT_MELEE_ATTACK1) or self:GetSequenceActivity(ACT_MELEE_ATTACK2) then
		if timer.Exists("NH_ZombieAttack_" .. self:EntIndex() ) then return end
		timer.Create("NH_ZombieAttack_" .. self:EntIndex(), 2, 1, function()
			
			if not self:GetEnemy() then return end
			
			if self:Distance(self:GetEnemy():GetPos() ) > 5 then return end
			
			if self:GetEnemy():IsValid() and self:GetEnemy():IsPlayer() then
				self:GetEnemy():TakeDamage(20, self, self)
				self:GetEnemy():EmitSound("npc/zombie/zombie_hit.wav")
				self:SetSchedule(SCHED_CHASE_ENEMY)
				self:SetSchedule(SCHED_COMBAT_FACE)
			end
		end)
		
		return
	end
end

function ENT:OnTakeDamage(dmgInfo)
	self:SetHealth(self:Health() - dmgInfo:GetDamage())
	
	self:EmitSound("npc/nhzombie/nhzombie_pain" .. math.random(1, 6) .. ".wav")
	
	if dmgInfo:GetDamage() >= 10 and not self.Gibbed then
		local bleed = ents.Create("info_particle_system")
		bleed:SetKeyValue("effect_name", "blood_impact_red_01")
		bleed:SetPos(self:GetPos() + Vector(0, 0, 60)) 
		bleed:Spawn()
		bleed:Activate() 
		bleed:Fire("Start", "", 0)
		bleed:Fire("Kill", "", 1.2)
		self:EmitSound("physics/flesh/flesh_bloody_break.wav", 100, 100)
		self.Gibbed = true
	end
	
	if self:Health() <= 0 then
		self:OnKilled(dmgInfo)
	end
end

function ENT:OnKilled(dmgInfo)
	hook.Call( "OnNPCKilled", GAMEMODE, self, dmgInfo:GetAttacker(), dmgInfo:GetInflictor() )
	
	self:EmitSound("npc/nhzombie/nhzombie_die" .. math.random(1, 3) .. ".wav")
	
	local body = ents.Create( "prop_ragdoll" )
	body:SetPos( self:GetPos() )
	body:SetAngles(self:GetAngles())
	body:SetModel( self:GetModel() )
	
	if dmgInfo:GetDamage() >= 10 and not self.Gibbed then
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
	--body:Spawn()
	
	if game.GetMap() == "nh2c1_v2" then
		ents.FindByName("kitchen_door")[1]:Fire("Unlock")
		ents.FindByName("zombie_corpse_sound")[1]:Fire("PlaySound")
	end
	
	SafeRemoveEntity(self)
end

function ENT:GetRelationship(entity)
	if entity:IsPlayer() then
		return D_HT
	end
end