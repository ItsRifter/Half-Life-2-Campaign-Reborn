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
    ["level01_synb2_entryway_of_doom"] = true,
    ["level02_synb2_tricks_and_traps"] = true,
    
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
    ["npc_antlionguard"] = true,
    ["npc_antlionguardian"] = true,
    ["npc_barnacle"] = true,
    ["npc_turret_ground"] = true,
    ["npc_antlion"] = true,
    ["npc_antlion_worker"] = true,
	["npc_hunter"] = true,
    ["npc_turret_floor"] = true,
    ["combine_mine"] = true,
}

local poison_npcs = {
    ["npc_headcrab_poison"] = true,
    ["npc_headcrab_black"] = true
}

local tank_npcs = {
    ["npc_combinegunship"] = true,
    ["npc_strider"] = true,
    ["npc_antlionguard"] = true,
    ["npc_helicopter"] = true
}

function hl2cr_npc:IsFriendly()
	if self:IsValid() and self:IsNPC() then
        if FRIENDLY_NPCS[self:GetClass()] or FRIENDLY_HARMABLE_NPCS[self:GetClass()] then
            return true
        end

        if self:GetClass() == "npc_vortigaunt" and !MAPS_VORT_HOSTILE[game.GetMap()] then
            return true 
        end
    end

    return false
end

function hl2cr_npc:IsHostile()
	if self:IsValid() and self:IsNPC() then
		if HOSTILE_NPCS[self:GetClass()] then
			return true
		elseif self:GetClass() == "npc_vortigaunt" and MAPS_VORT_HOSTILE[game.GetMap()] then
            return true 
        end
    end

    return false
end

local weapon_melees = {
	["weapon_crowbar"] = true
}

function GM:PlayerTick( player, mv )	--Test fix preventing self inflicted physics boosts
	if player.fixvelocity then
		mv:SetVelocity(player.fixvelocity)
		player.fixvelocity = nil
	end
end

hook.Add( "EntityTakeDamage", "HL2CR_Hostile_Damage", function( target, dmgInfo )
    local attacker = dmgInfo:GetAttacker()
    
    --Player taking damage
    if target:IsPlayer() then
        if target.hl2cr.CurCosmetic ~= "" and !attacker:IsPlayer() then
            for _, c in ipairs(HL2CR_Cosmetics) do
                if c.Class == target.hl2cr.CurCosmetic then
                    if not c.TakeDamageFunc then break end
                    c.TakeDamageFunc(target, attacker, dmgInfo:GetDamageType())
                    break
                end
            end
        end

		if attacker == target then	--Test fix preventing self inflicted physics boosts
			target.fixvelocity = target:GetVelocity()
		end

        if dmgInfo:GetDamageType() == 17 or dmgInfo:GetDamageType() == 1 then 
			dmgInfo:SetDamage(0) 
			return
		end

        if attacker:GetClass() == "npc_rollermine" and game.GetMap() == "d1_eli_02" then
            dmgInfo:SetDamage(0)
        end

        if not attacker:IsNPC() then
            return false
        end

		attacker:OnHitPlayer(target)

        if attacker:GetCustomDamage() then
            dmgInfo:SetDamage(attacker:GetCustomDamage()) 
        else
            if poison_npcs[attacker:GetClass()] then return false end

            dmgInfo:SetDamage(dmgInfo:GetDamage() * HL2CR_GetDiff())
        end

        return false

    --NPC taking damage
    elseif target:IsNPC() then
        
        --If its a player pet taking damage, do no harm to it
        if target:IsPet() and attacker:IsPlayer() then
            return true
        end
        
        --Attacker is a player pet
        if attacker:IsPet() then
            local pet = attacker:GetStats()

            dmgInfo:SetDamage(pet.Stats.Damage)
        end
        
        --Attacker is a player
        if attacker:IsPlayer() then
            if tank_npcs[target:GetClass()] then
                net.Start("HL2CR_TankNPC_Display")
                    net.WriteEntity(target)
                net.Send(attacker)
            end
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

local Valid_NPC_Targets = {
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
	["npc_antlionguard"] = true,
	["npc_antlionguardian"] = true,
	["npc_barnacle"] = true,
	["npc_turret_ground"] = true,
	["npc_vortigaunt"] = true,
	["npc_antlion"] = true,
	["npc_antlion_worker"] = true,
	["npc_hunter"] = true
}

hook.Add( "ScaleNPCDamage", "ScaleNPCDamageExample", function( npc, hitgroup, dmginfo )
	npc.LastHitGroup = hitgroup
end )

hook.Add( "EntityTakeDamage", "HL2CR_NPC_TakeDamage", function( target, dmgInfo )
	local attacker = dmgInfo:GetAttacker()

	if attacker:IsVehicle() and attacker:GetDriver() then
		attacker = attacker:GetDriver()
	end
	
    if ( target:IsFriendly() or target:IsPet() ) and attacker:IsPlayer() then return true end

	--if not Valid_NPC_Targets[target:GetClass()] then return end
	if not CanPlayerTarget(target:GetClass()) then return end

	--This moves indicator if damage position isnt real
	if dmgInfo:GetDamagePosition():LengthSqr() < 1 then dmgInfo:SetDamagePosition(target:GetPos() + Vector(0,0,64))end
	
    if attacker:IsPlayer() and attacker:IsConnected() then		
		--if not Valid_NPC_Targets[target:GetClass()] then return end
		local damagedone = dmgInfo:GetDamage()
		local dmgtype = dmgInfo:GetDamageType()
		--print(dmgtype)

		if damagedone > target:Health() then damagedone = target:Health()end
		--print(target:GetClass() )
		--print(target:Health() )
		
		local colour = 1
		if target:GetClass() == "npc_antlion" and game.GetGlobalState("antlion_allied") == GLOBAL_ON then colour = 2 end	--hits turn green if hitting friendly ants
		--antlion_allied
		damagedone = math.Round(damagedone,1)
		
		if damagedone > 0 then	--prevents erronious negatives
			if colour == 1 then
				local sucess = attacker:AddDamageExp(tonumber(damagedone),target,dmgtype) 
				if target.LastHitGroup and target.LastHitGroup == HITGROUP_HEAD then colour = 9 end
				if !sucess then colour = 8 end	--If damage is block hit turns dark grey
			end
			target:OnHit()
			net.Start( "HL2CR_Indicator" )
				--net.WriteString(string.format("%1.1d",damagedone))	--Todo format better
				net.WriteString(damagedone)	--Todo format better
				net.WriteVector(dmgInfo:GetDamagePosition())
					net.WriteUInt(colour,7)	--1=Red Text default
					net.WriteUInt(0,5)		--Indicator Type
            net.Send(attacker)
			
			
		end
    end
end)