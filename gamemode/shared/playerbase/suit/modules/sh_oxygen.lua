--[[------------------------------------------------------------------
  OXYGEN
  Limited underwater time
]]--------------------------------------------------------------------

AddCSLuaFile()

if SERVER then

    -- Parameters
    local DEFAULT_SUPPLY_RATE = 0.14
    local DEFAULT_DROWN_RATE = 0.07
    local DEFAULT_DROWN_DAMAGE_RATE = 1
    local DEFAULT_DROWN_RECOVERY_RATE = 2
    local DEFAULT_DROWN_DAMAGE_AMOUNT = 10
    local DEFAULT_DOWNTIME = 1.2
    local ID, LABEL = "oxygen", "OXYGEN"
  
    --[[
      Damages the player by drowning
      @param {Player} player
    ]]
    local function TakeDrowningDamage(player, damage)
        damage = damage or DEFAULT_DROWN_DAMAGE_AMOUNT
    
        -- Build drowning damage
        local dmginfo = DamageInfo()
        dmginfo:SetDamage(DEFAULT_DROWN_DAMAGE_AMOUNT)
        dmginfo:SetDamageType(DMG_DROWN)
        dmginfo:SetAttacker(player)
        dmginfo:SetInflictor(player)
        dmginfo:SetDamageForce(Vector(0, 0, 0))
    
        -- Take drowning damage
        player:TakeDamageInfo(dmginfo)
    end
  
    --[[
      Regenerates a player's own oxygen reserve
      @param {Player} player
    ]]
    local function RegenerateOxygen(player)
        if (player.HL2CR_AUX.breathe.tick < CurTime()) then
            player.HL2CR_AUX.breathe.oxygen = math.Clamp(player.HL2CR_AUX.breathe.oxygen + 0.03, 0, 1)
            player.HL2CR_AUX.breathe.tick = CurTime() + DEFAULT_SUPPLY_RATE
        end
    end
  
    --[[
      Adds a power expense and drowns the player if it gets depleted
      @param {Player} player
    ]]
    local function PlayerUnderwater(player)
        -- Add expense
        HL2CR_AUX:AddExpense(player, ID, LABEL, DEFAULT_SUPPLY_RATE / 1, nil, DEFAULT_DOWNTIME)
  
        -- If depleted, damage player
        if (not HL2CR_AUX:HasPower(player) or not HL2CR_AUX:IsSuitEquipped(player)) then
            -- Timed loop for oxygen depletion
            if player.HL2CR_AUX.breathe.tick < CurTime() then
                if (player.HL2CR_AUX.breathe.oxygen > 0) then
                    -- Deplete oxygen reserve
                    player.HL2CR_AUX.breathe.oxygen = math.Clamp(player.HL2CR_AUX.breathe.oxygen - 0.01 * HL2CR_AUX:GetOxygenMul(), 0, 1)
                    player.HL2CR_AUX.breathe.tick = CurTime() + DEFAULT_DROWN_RATE
                else
                    -- Damage player
                    TakeDrowningDamage(player)
        
                    -- Accumulate drown damage
                    player.HL2CR_AUX.breathe.health = player.HL2CR_AUX.breathe.health + DEFAULT_DROWN_DAMAGE_AMOUNT
        
                    player.HL2CR_AUX.breathe.tick = CurTime() + DEFAULT_DROWN_DAMAGE_RATE -- Next damage tick
                end
            end
        else
            -- Regenerate oxygen
            RegenerateOxygen(player)
        end
    end
  
    --[[
      Removes expense and regenerates player's oxygen and health
      @param {Player} player
    ]]
    local function PlayerBreathe(player)
      -- Remove expense
      HL2CR_AUX:RemoveExpense(player, ID)
  
      -- Regenerate oxygen
      RegenerateOxygen(player)
  
      -- Regenerate health
      if (player.HL2CR_AUX.breathe.health > 0 and player.HL2CR_AUX.breathe.hTick < CurTime()) then
            local regen = math.min(DEFAULT_DROWN_DAMAGE_AMOUNT, player.HL2CR_AUX.breathe.health)
            local health = player:Health() + regen
            local breathe = math.max(player.HL2CR_AUX.breathe.health - DEFAULT_DROWN_DAMAGE_AMOUNT, 0)
    
            -- Is limit enabled?
            if (HL2CR_AUX:IsOxygenHealthRegenerationLimited()) then
                health = math.Clamp(health, 0, player:GetMaxHealth())
                if (health >= player:GetMaxHealth()) then
                    breathe = 0
                end
            end
  
            -- Make the health exchange
            player:SetHealth(health)
            player.HL2CR_AUX.breathe.health = breathe
    
            player.HL2CR_AUX.breathe.hTick = CurTime() + DEFAULT_DROWN_RECOVERY_RATE
        end
    end
  
    --[[
      Sets up the variables to keep track of oxygen spent and health lost by drowning
    ]]
    hook.Add("HL2CR_AUXInitialize", "HL2CR_AUX_oxygen_spawn", function(player)
      player.HL2CR_AUX.breathe = {oxygen = 1, tick = 0, health = 0, hTick = 0}
    end)
  
    --[[
      Runs the oxygen logic
    ]]
    hook.Add("HL2CR_AUXTick", "HL2CR_AUX_oxygen", function(player)
        
        if (player:WaterLevel() >= 3) then
            PlayerUnderwater(player)
        else
            PlayerBreathe(player)
        end
    end)
end
  