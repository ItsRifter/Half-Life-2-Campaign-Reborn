local hl2cr_npc = FindMetaTable( "Entity" )

FRIENDLY_NPCS = {
	["npc_kleiner"] = true,
	["npc_dog"] = true,
	["npc_eli"] = true,
	["npc_monk"] = true,
	["npc_alyx"] = true,
	["npc_barney"] = true,
	["npc_fisherman"] = true,
	["npc_mossman"] = true,
	["npc_gman"] = true,
	["npc_breen"] = true
}


FRIENDLY_HARMABLE_NPCS = {
    ["npc_citizen"] = true,
}

MAPS_VORT_HOSTILE = {

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

function hl2cr_npc:IsFriendly()
	if self:IsValid() and self:IsNPC() and (FRIENDLY_NPCS[self:GetClass()] or FRIENDLY_HARMABLE_NPCS[self:GetClass()]) then
		return true
	else
		return false
	end
end

function hl2cr_npc:IsHostile()
	if self:IsValid() and self:IsNPC() and HOSTILE_NPCS[self:GetClass()] then
		return true
	else
		return false
	end
end

function GM:ScaleNPCDamage(npc, hitgroup, dmgInfo )
    dmgInfo:ScaleDamage(1)
end

function GM:EntityTakeDamage( npc, dmgInfo )
 
    if npc:IsPlayer() then
        return false
    end

    local attacker = dmgInfo:GetAttacker()

    if npc:GetClass() == "npc_vortigaunt" and not MAPS_VORT_HOSTILE[game.GetMap()] then
        return true
    end

    if (FRIENDLY_NPCS[npc:GetClass()] or (FRIENDLY_HARMABLE_NPCS[npc:GetClass()]) and attacker:IsPlayer()) then
        return true
    end


end