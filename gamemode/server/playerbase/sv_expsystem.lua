--Exp amount determining code

--harder npcs have better multiplier
local NPC_XPMul = {
	["npc_headcrab"] = 3,
	["npc_headcrab_fast"] = 3,
	["npc_headcrab_black"] = 3,
	["npc_headcrab_poison"] = 3,
	["npc_zombie_torso"] = 3,
	["npc_zombie"] = 3,
	["npc_fastzombie"] = 3,
	["npc_poisonzombie"] = 2,
	["npc_zombine"] = 5,
	["npc_cscanner"] = 1,
	["npc_metropolice"] = 5,
	["npc_manhack"] = 3,
	["npc_combine_s"] = 5,
	["npc_antlionguardian"] = 2.5,
	["npc_barnacle"] = 1.5,
	["npc_turret_ground"] = 2,
	["npc_vortigaunt"] = 5,
	["npc_antlion"] = 3,
	["npc_antlion_worker"] = 4,
	["npc_hunter"] = 5,
	
	["prop_vehicle_apc"]=0.75,
	
	["npc_combinegunship"] = 1.5,
    ["npc_strider"] = 0.5,
    ["npc_antlionguard"] = 2.5,
    ["npc_helicopter"] = 0.3
}

local Diff_Mul = {
	[1] = 1.5,
	[2] = 2.0,
	[3] = 2.5,
	[4] = 3.0,
	[5] = 3.5
}

function CanPlayerTarget(class)
	if NPC_XPMul[class] then return true end
	return false
end

--give 1 exp for every amount of exp_division, IE 117 turns to 11 xp if exp_division is 10
local exp_division = 10
if XPFARM_MAPS[game.GetMap()] then exp_division = 25 end	--Make farming maps require more damage to be done

function hl2cr_player:AddDamageExp(damage,class)
	local amount = damage
	if NPC_XPMul[class] then amount = amount * NPC_XPMul[class] end
	
	amount = amount * Diff_Mul[GetConVar("hl2cr_difficulty"):GetInt()]
	self.damagexp = self.damagexp + amount
end

if timer.Exists( "Exp_Tick" ) then timer.Remove( "Exp_Tick" ) end
timer.Create( "Exp_Tick", 5, 0, function() 
	for _, p in pairs(player.GetAll()) do
		if p.damagexp >= exp_division then
			local exptogive  = math.floor(p.damagexp/exp_division)
			--p.damagexptotal = p.damagexptotal + exptogive
			
			p:AddXP(exptogive)
			
			p.damagexp = math.fmod(p.damagexp,exp_division)	
		end
	end
end )