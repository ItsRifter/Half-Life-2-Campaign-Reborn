local hl2cr_player = FindMetaTable( "Player" )

local XP_BASE_RANDOM = {
	["npc_headcrab"] = {xpMin = 1, xpMax = 10},
	["npc_headcrab_fast"] = {xpMin = 3, xpMax = 15},
	["npc_headcrab_black"] = {xpMin = 5, xpMax = 20},
	["npc_headcrab_poison"] = {xpMin = 5, xpMax = 20},
	["npc_zombie_torso"] = {xpMin = 10, xpMax = 40},
	["npc_zombie"] = {xpMin = 25, xpMax = 75},
	["npc_fastzombie"] = {xpMin = 35, xpMax = 80},
	["npc_poisonzombie"] = {xpMin = 45, xpMax = 95},
	["npc_zombine"] = {xpMin = 50, xpMax = 85},
	["npc_cscanner"] = {xpMin = 15, xpMax = 30},
	["npc_metropolice"] = {xpMin = 30, xpMax = 80},
	["npc_manhack"] = {xpMin = 25, xpMax = 70},
	["npc_combine_s"] = {xpMin = 40, xpMax = 135},
	["npc_antlionguard"] = {xpMin = 125, xpMax = 275},
	["npc_antlionguardian"] = {xpMin = 125, xpMax = 275},
	["npc_barnacle"] = {xpMin = 1, xpMax = 25},
	["npc_turret_ground"] = {xpMin = 5, xpMax = 25},
	["npc_vortigaunt"] = {xpMin = 25, xpMax = 50},
	["npc_antlion"] = {xpMin = 30, xpMax = 55},
	["npc_antlion_worker"] = {xpMin = 35, xpMax = 60},
}

function hl2cr_player:AddXP(XP)

	self.hl2cr.Exp = self.hl2cr.Exp + (XP * GetConVar("hl2cr_difficulty"):GetInt())
	
	local notifyLevelUp = false

	while self.hl2cr.Exp >= self.hl2cr.ReqExp do
			
		self.hl2cr.Exp = self.hl2cr.Exp - self.hl2cr.ReqExp
		self.hl2cr.Level = self.hl2cr.Level + 1
		self.hl2cr.SkillPoints = self.hl2cr.SkillPoints + 1
		self.hl2cr.ReqExp = self.hl2cr.ReqExp + (750 * self.hl2cr.Level)
		
		notifyLevelUp = true
	end

	if notifyLevelUp then			
        self:BroadcastMessage(HL2CR_LevelupColour, translate.Get("Player_Levelup"), self.hl2cr.Level)
		self:BroadcastSound("hl2cr/levelup.wav")
	end
end

hook.Add( "OnNPCKilled", "HL2CR_GiveXP", function( npc, attacker, inflictor )
	if attacker:IsPlayer() then
		attacker:AddXP(math.random(XP_BASE_RANDOM[npc:GetClass()].xpMin, XP_BASE_RANDOM[npc:GetClass()].xpMax))
	end
end)