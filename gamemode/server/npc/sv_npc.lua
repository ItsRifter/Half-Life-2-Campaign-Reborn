local meta = FindMetaTable( "Entity" )
if not meta then return end

FRIENDLY_NPCS = {
	["npc_kleiner"] = true,
	["npc_dog"] = true,
	["npc_eli"] = true,
	["npc_monk"] = true,
	["npc_alyx"] = true,
	["npc_barney"] = true,
	--["npc_citizen"] = true,
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
	if not npc:IsNPC() then return end
	
	if GetConVar("hl2cr_difficulty"):GetInt() == 1 then
		npc.level = math.random(1, 3)
	elseif GetConVar("hl2cr_difficulty"):GetInt() == 2 then
		npc.level = math.random(3, 7)
	elseif GetConVar("hl2cr_difficulty"):GetInt() == 3 then
		npc.level = math.random(6, 15)
	elseif GetConVar("hl2cr_difficulty"):GetInt() == 4 then
		npc.level = math.random(15, 25)
	elseif GetConVar("hl2cr_difficulty"):GetInt() == 5 then
		npc.level = math.random(30, 50)
	end
	
	npc:SetNWInt("HL2CR_NPC_Level", npc.level)
	npc:SetHealth(npc:Health() + (npc.level * 15) )
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

hook.Add("EntityTakeDamage", "HL2CR_PlayerToNPCDmgMisc", function(ent, dmgInfo)
	local dmg = dmgInfo:GetDamage()
	local att = dmgInfo:GetAttacker()
	
	if att:IsPlayer() and att:GetActiveWeapon():GetClass() == "weapon_stunstick" and not (ent:IsFriendly() or ent:GetClass() == "npc_citizen") then
		if att.hl2cr.StunDamage and not ent:IsPlayer() then
			local totalStun = dmg + att.hl2cr.StunDamage
			dmgInfo:SetDamage(totalStun)
		end
	end	
end)

hook.Add("EntityTakeDamage", "HL2CR_FriendlyOrHostile", function(ent, dmgInfo)
	local att = dmgInfo:GetAttacker()
	
	if ent:IsFriendly() or (ent:GetClass() == "npc_citizen" and att:IsPlayer()) then
		dmgInfo:SetDamage(0)
		return
	end
	
	if ent:GetClass() == "npc_citizen" and att:GetClass() == "prop_vehicle_jeep" then
		dmgInfo:SetDamage(0)
		return
	end
	
	if ent:GetClass() == "npc_vortigaunt" and att:IsPlayer() and HOSTILE_VORTS == false then
		dmgInfo:SetDamage(0)
		return
	end
	
	if att:GetClass() == "sent_controllable_drone" or att:GetClass() == "sent_controllable_manhack" then
		if ent:IsPlayer() then
			dmgInfo:SetDamage(0)
			return
		elseif ent:IsNPC() then
			if not (ent:IsFriendly() or ent:GetClass() == "npc_citizen") then
				if ent:Disposition(att) ~= D_HT then
					ent:AddEntityRelationship(att, D_HT, 99)
				end
			else
				dmgInfo:SetDamage(0)
				return
			end
		end
	end	
end)

hook.Add("OnEntityCreated", "HL2CR_NPCCreated", function(ent)
	SetNPCTraits(ent)
end)

--[[
hook.Add( "ScaleNPCDamage", "HL2CR_PlayerToNPCDMG", function( npc, hitgroup, dmgInfo )
	
	if npc:IsFriendly() or npc:GetClass() == "npc_citizen" then return end
	
	local hitDivide = GetConVar("hl2cr_difficulty"):GetInt()
	
	if hitgroup == HITGROUP_HEAD then
		hitDivide = hitDivide + 0.75
	elseif hitgroup == HITGROUP_CHEST or hitgroup == HITGROUP_STOMACH then
		hitDivide = hitDivide + 1
	elseif hitgroup == HITGROUP_LEFTARM or hitgroup == HITGROUP_RIGHTARM then
		hitDivide = hitDivide + 1.25
	elseif hitgroup == HITGROUP_LEFTLEG or hitgroup == HITGROUP_RIGHTLEG then
		hitDivide = hitDivide + 1.50
	end
	
	local finalDMG = dmgInfo:GetDamage() / hitDivide
	dmgInfo:SetDamage(finalDMG)
end)
--]]