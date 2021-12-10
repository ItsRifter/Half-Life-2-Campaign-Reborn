AddCSLuaFile("shared.lua")
include('shared.lua')

ENT.Model = "models/classic_torso.mdl" -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want

ENT.MovementType = VJ_MOVETYPE_GROUND
ENT.PlayerFriendly = true

ENT.VJ_NPC_Class = {
["npc_kleiner"] = true,
	["npc_dog"] = true,
	["npc_eli"] = true,
	["npc_monk"] = true,
	["npc_alyx"] = true,
	["npc_barney"] = true,
	["npc_citizen"] = true,
	["npc_vortigaunt"] = true,
	["npc_fisherman"] = true,
	["npc_mossman"] = true,
	["npc_gman"] = true,
	["npc_breen"] = true
}

ENT.VJ_NPC_Class = {"HL2CR_PETS", "CLASS_PLAYER_ALLY"}

ENT.HasMeleeAttack = true
ENT.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK1}

ENT.HasLeapAttack = false -- Should the SNPC have a leap attack?
ENT.LeapAttackDamageType = DMG_SLASH -- Type of Damage

ENT.HasDamageByPlayer = false
ENT.IdleAlwaysWander = true
ENT.FollowPlayer = false

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

function ENT:SetUpStats(stats)
	
	self.StartHealth = stats["health"]
	self.TurningSpeed = stats["speed"]
	self.AA_MoveAccelerate = stats["speed"]
	self.NextMeleeAttackTime = stats["attDelay"]
	self.LeapAttackDamage = stats["damage"]
	self.MeleeAttackDamage = stats["damage"]
end

function ENT:OnInjured( dmginfo )
	local att = dmginfo:GetAttacker()
	
	self:GetOwner().petcool = CurTime() + 6
	
	self:SetHealth(self:Health() - dmginfo:GetDamage())
	self:GetOwner():SetNWInt("pet_health", self:Health())
end

function ENT:OnKilled( dmginfo )
	local att = dmginfo:GetAttacker()
	
	net.Start("HL2CR_SpawnPet")
		net.WriteBool(false)
	net.Send(self:GetOwner())
	
	self:GetOwner().spawnCooldown = 5 + CurTime() * GetConVar("hl2cr_difficulty"):GetInt()
	
	self:GetOwner().pet = nil
	SafeRemoveEntity(self)
end