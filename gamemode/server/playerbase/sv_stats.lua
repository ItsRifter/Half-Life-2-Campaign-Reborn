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

local ALLOWED_ANTLIONS_XP = {
	["ep2_outland_01"] = true,
	["ep2_outland_01a"] = true,
	["ep2_outland_02"] = true,
	["ep2_outland_03"] = true,
	["ep2_outland_04"] = true
}

local barnacleKilled = 0

local MAP_ACHS = {
	["d1_canals_01a"] = function(ply, npcKilled)

		if ply:HasAchievement("Barnacle Bowling") then return end
		
		barnacleKilled = barnacleKilled + 1

		if barnacleKilled >= 5 then
			ply:GrantAchievement("Barnacle Bowling")
		end

		timer.Create("hl2cr_ach_barnacle_" .. ply:EntIndex(), 0.25, 1, function()
			barnacleKilled = 0
		end)
	end
}

function hl2cr_player:AddXP(XP)

	self.hl2cr.Exp = self.hl2cr.Exp + (XP * GetConVar("hl2cr_difficulty"):GetInt())
	
	self:UpdateXPClient(XP)

	self.MapStats.TotalXP = self.MapStats.TotalXP + XP

	local notifyLevelUp = false

	while self.hl2cr.Exp >= self.hl2cr.ReqExp do

		self.hl2cr.Exp = self.hl2cr.Exp - self.hl2cr.ReqExp
		self.hl2cr.Level = self.hl2cr.Level + 1
		self.hl2cr.SkillPoints = self.hl2cr.SkillPoints + 1
		self.hl2cr.ReqExp = self.hl2cr.ReqExp + (375 * self.hl2cr.Level)
		
		notifyLevelUp = true
	end

	if notifyLevelUp then	
		self:SetNWInt("hl2cr_stat_level", self.hl2cr.Level)
		self:SetNWInt("hl2cr_stat_expreq", self.hl2cr.ReqExp)	
		self:SetNWInt("hl2cr_stat_skillpoints", self.hl2cr.SkillPoints)
		
        self:BroadcastMessage(HL2CR_LevelupColour, translate.Get("Player_Levelup"), HL2CR_LevelColour, tostring(self.hl2cr.Level))
		self:BroadcastSound("hl2cr/levelup.wav")
	end

	self:SetNWInt("hl2cr_stat_exp", self.hl2cr.Exp)
end

hook.Add( "OnNPCKilled", "HL2CR_GiveXP", function( npc, attacker, inflictor )
	if attacker:IsPlayer() then
		if MAP_ACHS[game.GetMap()] then
			MAP_ACHS[game.GetMap()](attacker, npc)
		end
		
		if npc:GetClass() == "npc_antlion" and not ALLOWED_ANTLIONS_XP[game.GetMap()] then return end

		if not XP_BASE_RANDOM[npc:GetClass()] then return end

		attacker.MapStats.Kills = attacker.MapStats.Kills + 1
		local gainXP = math.random(XP_BASE_RANDOM[npc:GetClass()].xpMin, XP_BASE_RANDOM[npc:GetClass()].xpMax)
		
		attacker:AddXP(gainXP)
	end
end)