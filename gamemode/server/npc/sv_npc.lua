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

HOSTILE_NPCS = {
	["npc_headcrab"] = true,
	["npc_headcrab_fast"] = true,
	["npc_headcrab_black"] = true,
	["npc_headcrab_poison"] = true,
	["npc_zombie_torso"] = true,
	["npc_zombie"] = true,
	["npc_fastzombie"] = true,
	["npc_poisonzombie"] = true,
	["npc_zombine"] = true,
	["npc_cscanner"] = true,
	["npc_metropolice"] = true,
	["npc_manhack"] = true,
	["npc_combine_s"] = true,
	["npc_combine_s"] = true,
	["npc_antlionguard"] = true,
	["npc_antlionguardian"] = true,
	["npc_barnacle"] = true,
	["npc_turret_ground"] = true,
	["npc_antlion"] = true,
	["npc_antlion_worker"] = true
}

function meta:IsFriendly()
	if self:IsValid() and self:IsNPC() and FRIENDLY_NPCS[self:GetClass()] then
		return true
	else
		return false
	end
end

function meta:IsHostile()
	if self:IsValid() and self:IsNPC() and HOSTILE_NPCS[self:GetClass()] then
		return true
	else
		return false
	end
end

function SetNPCTraits(npc)
	if not npc or not npc:IsNPC() or not npc:IsHostile() then return end
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

	timer.Simple(0.15, function()
		if not npc or not npc:IsHostile() then return end
		local newHealth = npc:Health() + (npc.level * 3)
		npc:SetMaxHealth(newHealth)
		npc:SetHealth(newHealth)
	end)
	
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
	
	if att:IsPlayer() and ent:IsValid() then 
		if att:GetActiveWeapon():GetClass() == "weapon_stunstick" and not (ent:IsFriendly() or ent:GetClass() == "npc_citizen") then
			if att.hl2cr.StunDamage and not ent:IsPlayer() then
				local totalStun = dmg + att.hl2cr.StunDamage
				dmgInfo:SetDamage(totalStun)
			end
		end	
	end
end)

hook.Add("EntityTakeDamage", "HL2CR_FriendlyOrHostile", function(ent, dmgInfo)
	local att = dmgInfo:GetAttacker()
	
	if att:IsPlayer() and ent:IsPlayer() then
		dmgInfo:SetDamage(0)
		return
	end
	
	if (ent:IsFriendly() or ent:IsPet() or ent:GetClass() == "npc_citizen") and att:IsPlayer() then
		dmgInfo:SetDamage(0)
		return
	end
	
	if (ent:IsPet() and ent:GetOwner()) and att:IsHostile() then
		ent:GetOwner():SetNWInt("pet_health", ent:Health())
	end
	
	if ent:GetClass() == "npc_citizen" and att:GetClass() == "prop_vehicle_jeep" then
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
				ent:AddEntityRelationship(att, D_LI, 99)
				dmgInfo:SetDamage(0)
				return
			end
		end
	end	
end)

hook.Add("OnEntityCreated", "HL2CR_NPCCreated", function(ent)
	SetNPCTraits(ent)
	if GetConVar("hl2cr_specials"):GetInt() == 1 then
		if ent:IsNPC() then
			if ent:GetName() == "*" or ent.Changed == true then return end
			if ent:GetClass() == "npc_combine_s" or ent:GetClass() == "npc_metropolice" or ent:GetClass() == "npc_combine_prisonguard" then
				local specialChance = math.random(1, 100)
				if specialChance <= 33 and GetConVar("hl2cr_difficulty"):GetInt() >=3 then
					local newNPC = nil
					local NPCKind = math.random(1, 6)
							
					if NPCKind == 1 then
						newNPC = ents.Create("npc_combine_assassin")
					elseif NPCKind == 2 then
						newNPC = ents.Create("npc_combine_support")
					elseif NPCKind == 3 then
						newNPC = ents.Create("npc_combine_medic")
					elseif NPCKind == 4 then
						newNPC = ents.Create("npc_combine_veteran")
					elseif NPCKind == 5 then
						newNPC = ents.Create("npc_combine_grenadier")
					elseif NPCKind == 6 then
						newNPC = ents.Create("npc_combine_hg")
					end
						
						
					timer.Simple(1, function()
						if ent:IsValid() then
							ent:Remove()
							newNPC:SetPos(ent:GetPos() + Vector(0, 0, 30))
							newNPC:Spawn()
							ent.Changed = true
						end
					end)
						
			
				elseif specialChance >= 33 and GetConVar("hl2cr_difficulty"):GetInt() >=3 then 
					ent.Changed = true
				end
			end
		end
	end
end)

hook.Add( "ScaleNPCDamage", "HL2CR_NPCDMGScale", function( npc, hitgroup, dmgInfo )
	
	if npc:IsFriendly() or npc:GetClass() == "npc_citizen" then return end
	
	local damage = dmgInfo:GetDamage()
	
	local finalDMG = math.Clamp(damage, 1, 999)
	dmgInfo:SetDamage(finalDMG)
end)