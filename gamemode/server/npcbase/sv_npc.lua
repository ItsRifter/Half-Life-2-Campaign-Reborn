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

local poison_npcs = {
    ["npc_headcrab_poison"] = true,
    ["npc_headcrab_black"] = true
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

hook.Add( "EntityTakeDamage", "HL2CR_Hostile_Damage", function( target, dmgInfo )

    if target:IsPlayer() then
    
        local npcAttacker = dmgInfo:GetAttacker()

        if target.hl2cr.CurCosmetic ~= "" then
            for _, c in ipairs(HL2CR_Cosmetics) do
                if c.Class == target.hl2cr.CurCosmetic then
                    if not c.TakeDamageFunc then break end
                    c.TakeDamageFunc(target, npcAttacker, dmgInfo:GetDamageType())
                    break
                end
            end
        end

        if dmgInfo:GetDamageType() == 17 or dmgInfo:GetDamageType() == 1 then 
			dmgInfo:SetDamage(0) 
			return
		end

        if npcAttacker:GetClass() == "npc_rollermine" and game.GetMap() == "d1_eli_02" then
            dmgInfo:SetDamage(0)
        end

        if not npcAttacker:IsNPC() then
            return false
        end

        if npcAttacker:GetCustomDamage() then
            dmgInfo:SetDamage(npcAttacker:GetCustomDamage()) 
        else
            if poison_npcs[npcAttacker:GetClass()] then return false end

            dmgInfo:SetDamage(dmgInfo:GetDamage() * GetConVar("hl2cr_difficulty"):GetInt())
        end

        return false

    elseif target:IsNPC() then
        local playerAtt = dmgInfo:GetAttacker()

        if target:IsPet() then
            return true
        end

        if target:GetClass() == "npc_vortigaunt" and not MAPS_VORT_HOSTILE[game.GetMap()] then
            return true
        end

        if (FRIENDLY_NPCS[target:GetClass()] or (FRIENDLY_HARMABLE_NPCS[target:GetClass()]) and playerAtt:IsPlayer()) then
            return true
        end
    else
        if target:GetClass() == "item_ammo_crate" then
            local playerAtt = dmgInfo:GetAttacker()
            
            if not playerAtt:IsPlayer() then return end

            //Loop this twice in case the player switches between weapons
            timer.Create("hl2cr_itemcrate_wait_" .. playerAtt:EntIndex(), 0.85, 2, function()
                playerAtt:CheckAllAmmo()
            end)
        end
    end
end)