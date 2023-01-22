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
	["npc_metropolice"] = 2.5,
	["npc_manhack"] = 3,
	["npc_combine_s"] = 3,
	["npc_antlionguardian"] = 2.5,
	["npc_barnacle"] = 1.5,
	--["npc_turret_ground"] = 2,
	["npc_vortigaunt"] = 5,
	["npc_antlion"] = 3,
	["npc_antlion_worker"] = 4,
	["npc_hunter"] = 5,
	
	--["prop_vehicle_apc"]=0.75,
	
	--["npc_combinegunship"] = 1.5,
    --["npc_strider"] = 0.5,
    ["npc_antlionguard"] = 2.5,
    ["npc_helicopter"] = 0.3
}

--better weapons gives better multiplier
local NPC_WeaponXP ={
	["weapon_stunstick"] = 1.2,
	["weapon_pistol"] = 1.4,
	["weapon_smg1"] = 1.5,
	["weapon_shotgun"] = 1.7,
	["weapon_ar2"] = 1.8

}

local function NPCWeapon_Mul(amount, npc)	--gives bonus exp depending on npcs weapon
	if npc:GetActiveWeapon():IsValid() then
		local weapon = npc:GetActiveWeapon():GetClass()
		--print (npc:GetClass() .. "  "..weapon)
		if NPC_WeaponXP[weapon] then return amount * NPC_WeaponXP[weapon] end
	end
	return amount
end

--Special functions for certain npc's
local NPC_XPFunc={
	["npc_strider"] = function(amount,npc,dmgtype)
		if dmgtype !=64 and  dmgtype !=2112 then return 0 end	--only give exp for blast/ball damage dealt
		return 180		--180=27/36/45/54/63
	end,
	["npc_combinedropship"] = function(amount,npc,dmgtype)
		if dmgtype !=64 then return 0 end	--only give exp for blast damage dealt
		return 80		--180=27/36/45/54/63
	end,
	["npc_combinegunship"] = function(amount,npc)
		return 220		--220=33/44/55/66/77
	end,
	["prop_vehicle_apc"] = function(amount,npc)
		if npc:GetDriver():IsValid() then
			return amount * 0.75
		end
		return 0
	end,
	
	
	["npc_metropolice"] = function(amount,npc)
		return NPCWeapon_Mul(amount,npc)		
	end,
	["npc_combine_s"] = function(amount,npc)
		return NPCWeapon_Mul(amount,npc)
	end,
	["npc_turret_floor"] = function(amount,npc)	--Normal turrets -- I dont want to give exp but do want to allow it to be hit
		return 0
	end,
	["npc_turret_ground"] = function(amount,npc,dmgtype)  --Floor turrets in c17 assault
		if dmgtype !=64 then return 0 end
		return 120
	end,
}

--Difficulty multiplier
local Diff_Mul = {
	[1] = 1.5,
	[2] = 2.0,
	[3] = 2.5,
	[4] = 3.0,
	[5] = 3.5
}

function CanPlayerTarget(class)
	if NPC_XPMul[class] then return true end
	if NPC_XPFunc[class] then return true end
	return false
end

--give 1 exp for every amount of exp_division, IE 117 turns to 11 xp if exp_division is 10
local exp_division = 10
if XPFARM_MAPS[game.GetMap()] then exp_division = 25 end	--Make farming maps require more damage to be done
if Custom_ExpMul then exp_division = exp_division * Custom_ExpMul end	--Allows custom map exp setting

function hl2cr_player:AddDamageExp(damage,npc,dmgtype)
	local amount = damage
	local class = npc:GetClass()
	if NPC_XPMul[class] then amount = amount * NPC_XPMul[class] end			--Does exp mul based on enemy class
	if NPC_XPFunc[class] then amount = NPC_XPFunc[class](amount,npc,dmgtype) end	--Does extra function for special enemies
	
	amount = amount * Diff_Mul[HL2CR_GetDiff()]		--Increased exp based on difficulty
	if amount > 0 then
		self.damagexp = self.damagexp + amount
		return true
	end
	return false
end

--Constant timer every 5 seconds, calculates exp players earned from damage and gives exp periodically instead of on every damage hit which would spam them.
if timer.Exists( "Exp_Tick" ) then timer.Remove( "Exp_Tick" ) end	
timer.Create( "Exp_Tick", 5, 0, function() 
	for _, p in pairs(player.GetAll()) do
		if p:IsBot() then continue end
		if p.damagexp >= exp_division then
			local exptogive  = math.floor(p.damagexp/exp_division)
			--p.damagexptotal = p.damagexptotal + exptogive
			
			p:AddXP(exptogive)
			
			p.damagexp = math.fmod(p.damagexp,exp_division)	
		end
	end
end )