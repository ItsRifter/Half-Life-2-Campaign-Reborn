local meta = FindMetaTable( "Entity" )
if not meta then return end

function meta:IsPlayerPet()
	if self:IsValid() and self:IsNextBot() and self.Pet then
		return true
	else
		return false
	end
end

local FRIENDLY_NPCS = {
	["npc_kleiner"] = true,
	["npc_dog"] = true,
	["npc_eli"] = true,
	["npc_monk"] = true,
	["npc_alyx"] = true,
	["npc_barney"] = true,
	--["npc_vortigaunt"] = true,
	["npc_fisherman"] = true,
	["npc_mossman"] = true,
	["npc_gman"] = true,
	["npc_breen"] = true
}

function meta:IsFriendly()
	if self:IsValid() and self:IsNPC() and FRIENDLY_NPCS[self:GetClass()] then
		return true
	else
		return false
	end
end

function SetNPCTraits(npc)
	if GetConVar("hl2cr_difficulty"):GetInt() == 1 then
		npc.level = math.random(1, 3)
	elseif GetConVar("hl2cr_difficulty"):GetInt() == 2 then
		npc.level = math.random(3, 7)
	elseif GetConVar("hl2cr_difficulty"):GetInt() == 3 then
		npc.level = math.random(6, 15)
	elseif GetConVar("hl2cr_difficulty"):GetInt() == 4 then
		npc.level = math.random(15, 25)
	elseif GetConVar("hl2cr_difficulty"):GetInt() == 5 then
		npc.level = 30
	end
	
	npc:SetNWInt("HL2CR_NPC_Level", npc.level)
	
	--npc:SetNWBool("HL2CR_Special", true)
	--npc:SetNWString("HL2CR_NPC_Name", "Riot Shield Cop")
end

--[[
	["npc_metropolice"] = "Riot Shield Cop",
	["npc_combine_assassin"] = "Assassin",
	["npc_combine_medic"] = "Field Medic",
	["npc_combine_commander"] = "Commander",
	["npc_combine_engineer"] = "Field Engineer",
	["npc_combine_veteran"] = "Veteran",
	["npc_combine_support"] = "Field Supporter",
	["npc_combine_burner"] = "Flamethrower",
	["npc_combine_grenadier"] = "Grenadier",
	["npc_combine_synth"] = "Synth",
--]]

hook.Add("EntityTakeDamage", "HL2CR_SharedXPDmg", function(ent, dmgInfo)
	local dmg = dmgInfo:GetDamage()
	local att = dmgInfo:GetAttacker()
	
	if ent:IsNPC() and not (ent:IsFriendly() or ent:IsPlayerPet() or ent:GetClass() == "npc_citizen") then
		ent.attacker = ent.attacker or {}
		ent.totalDMG = ent.totalDMG or 0
		if not table.HasValue(ent.attacker, att) then
			table.insert(ent.attacker, att)
		end
		
		ent.totalDMG = ent.totalDMG + dmg
	end
	
end)

hook.Add("EntityTakeDamage", "HL2CR_FriendlyOrHostile", function(ent, dmgInfo)
	local att = dmgInfo:GetAttacker()
	
	if string.find(tostring(ent:GetPhysicsObject()), "models/props_c17/doll01.mdl") then
		dmgInfo:SetDamageForce(Vector(100, 0, 0))
		ent:SetName("BabyStrike")
	end
	
	if game.GetMap() == "d1_trainstation_05" and (att:GetName("BabyStrike") and file.Exists("hl2cr_data/babycheck.txt", "DATA")) and not att:IsPlayer() then
		for k, v in pairs(player.GetAll()) do
			GrantAchievement(v, "HL2", "Red_Letter_Baby")
			file.Delete("hl2cr_data/babycheck.txt")
		end
		ent:Remove()
	end
	
	if ent:IsFriendly() or (att:IsPlayer() and ent:GetClass() == "npc_citizen") then
		dmgInfo:SetDamage(0)
	end
	
	if ent:GetClass() == "npc_citizen" and att:GetClass() == "prop_vehicle_jeep" then
		dmgInfo:SetDamage(0)
	end
	
	if ent:GetClass() == "npc_vortigaunt" and HOSTILE_VORTS == false then
		dmgInfo:SetDamage(0)
	end
	
end)

hook.Add("OnEntityCreated", "HL2CR_NPCCreated", function(ent)
	SetNPCTraits(ent)
end)