AddCSLuaFile("shared.lua")
include('shared.lua')

ENT.Model = "models/headcrabclassic.mdl" -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want

ENT.MovementType = VJ_MOVETYPE_GROUND
ENT.PlayerFriendly = false

ENT.VJ_NPC_Class = {"CLASS_NH2_CREATURES"}

ENT.HasMeleeAttack = true
ENT.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK1}

ENT.HasLeapAttack = false -- Should the SNPC have a leap attack?
ENT.LeapAttackDamageType = DMG_SLASH -- Type of Damage

ENT.HasDamageByPlayer = false
ENT.IdleAlwaysWander = true

ENT.SoundTbl_FootStep = {}
ENT.SoundTbl_Breath = {}
ENT.SoundTbl_Idle = {}
ENT.SoundTbl_IdleDialogue = {}
ENT.SoundTbl_IdleDialogueAnswer = {}
ENT.SoundTbl_CombatIdle = {}
ENT.SoundTbl_OnReceiveOrder = {}
ENT.SoundTbl_FollowPlayer = {}
ENT.SoundTbl_UnFollowPlayer = {}
ENT.SoundTbl_MoveOutOfPlayersWay = {}
ENT.SoundTbl_MedicBeforeHeal = {}
ENT.SoundTbl_MedicAfterHeal = {}
ENT.SoundTbl_MedicReceiveHeal = {}
ENT.SoundTbl_OnPlayerSight = {}
ENT.SoundTbl_Investigate = {}
ENT.SoundTbl_LostEnemy = {}
ENT.SoundTbl_Alert = {"npc/headcrab/alert1.wav"}
ENT.SoundTbl_CallForHelp = {}
ENT.SoundTbl_BecomeEnemyToPlayer = {}
ENT.SoundTbl_BeforeMeleeAttack = {}
ENT.SoundTbl_MeleeAttack = {}
ENT.SoundTbl_MeleeAttackExtra = {}
ENT.SoundTbl_MeleeAttackMiss = {}
ENT.SoundTbl_MeleeAttackSlowPlayer = {"vj_player/heartbeat.wav"}
ENT.SoundTbl_BeforeRangeAttack = {}
ENT.SoundTbl_RangeAttack = {"npc/headcrab/attack1.wav", "npc/headcrab/attack2.wav", "npc/headcrab/attack3.wav"}
ENT.SoundTbl_BeforeLeapAttack = {}
ENT.SoundTbl_LeapAttackJump = {}
ENT.SoundTbl_LeapAttackDamage = {}
ENT.SoundTbl_LeapAttackDamageMiss = {}
ENT.SoundTbl_OnKilledEnemy = {}
ENT.SoundTbl_AllyDeath = {}
ENT.SoundTbl_Pain = {"npc/headcrab/pain1.wav", "npc/headcrab/pain2.wav", "npc/headcrab/pain3.wav"}
ENT.SoundTbl_Impact = {}
ENT.SoundTbl_DamageByPlayer = {}
ENT.SoundTbl_Death = {}
ENT.SoundTbl_SoundTrack = {}

function ENT:OnInjured( dmginfo )
	local att = dmginfo:GetAttacker()
	
	self:SetHealth(self:Health() - dmginfo:GetDamage())
end

function ENT:OnKilled( dmginfo )
	local att = dmginfo:GetAttacker()

	SafeRemoveEntity(self)
end