AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

ENT.m_fMaxYawSpeed = 200
ENT.m_iClass = CLASS_PLAYER_ALLY

local schedule = ai_schedule.New("PetSchedule")

schedule:EngTask("TASK_TARGET_PLAYER", 0)
schedule:EngTask("TASK_MOVE_TO_TARGET_RANGE", 60)
schedule:EngTask("TASK_WAIT_FOR_MOVEMENT", 0)

function ENT:SelectSchedule()
	self:StartSchedule(schedule)
end

function ENT:SetAutomaticFrameAdvance( bUsingAnim )
	self.AutomaticFrameAdvance = bUsingAnim
end

function ENT:Initialize()

	self:SetModel( "models/headcrabclassic.mdl" )
	self:SetHullType(HULL_SMALL_CENTERED)
	self:SetHullSizeNormal()
	
	self:SetNPCState(NPC_STATE_IDLE)
	self:SetSolid(SOLID_BBOX)
	self:DropToFloor()
	
	self:SetHealth(25)
	
	self:CapabilitiesAdd(CAP_MOVE_GROUND)	
	self:SetMoveType(MOVETYPE_STEP)
	self:SetSchedule(SCHED_FORCED_GO_RUN)
	self:AutoMovement(self:GetAnimTimeInterval())
end

function ENT:GetRelationship(ent)
	if ent:IsPlayer() or ent:IsFriendly() then
		return D_LI
	else
		return D_HT
	end
end

function ENT:OnTakeDamage(dmgInfo)
	local att = dmgInfo:GetAttacker()
	local dmg = dmgInfo:GetDamage()

	if att:IsPlayer() then
		dmgInfo:SetDamage(0)
		return false
	end
	
end
