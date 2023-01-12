--[[------------------------------------------------------------------
  FLASHLIGHT
  Limited flashlight use
]]--------------------------------------------------------------------

AddCSLuaFile()

if SERVER then
    -- Parameters
    local DEFAULT_FLASHLIGHT_RATE = 0.4
    local DEFAULT_DOWNTIME = 0.5
    local DEFAULT_RATE = 0.01
    local DEFAULT_RECOVERY_RATE = 0.01
    local ID, LABEL = "flashlight", "FLASHLIGHT"

    --[[
    Returns the amount of flashlight power a player has
    @param {Player} player
    ]]
    function HL2CR_AUX:GetFlashlightPower(player)
        return player.HL2CR_AUX.flashlight.power
    end

    --[[
    Returns whether the player's flashlight has power
    @param {Player} player
    @return {boolean} has enough power
    ]]
    function HL2CR_AUX:HasFlashlightPower(player)
        return HL2CR_AUX:GetFlashlightPower(player) > 0
    end

    --[[
    Sets an amount of flashlight power to a player
    @param {Player} player
    @param {number} amount
    ]]
    function HL2CR_AUX:SetFlashlightPower(player, amount)
        player.HL2CR_AUX.flashlight.power = amount
    end

    --[[
    Adds power amount to the flashlight and sends it to the player
    Turns the flashlight off if it reaches 0
    @param {Player} player
    @param {number} amount
    ]]
    function HL2CR_AUX:AddFlashlightPower(player, amount)
        -- Add power
		local old = HL2CR_AUX:GetFlashlightPower(player)
		local new = math.Clamp(old + amount, 0, 1 )
		
		if old == new then return end	--Saves wasted data/network if no change
		
        --HL2CR_AUX:SetFlashlightPower(player, math.Clamp(HL2CR_AUX:GetFlashlightPower(player) + amount, 0, 1 + (player.statFlashBatt or 0)))
		HL2CR_AUX:SetFlashlightPower(player, new)
        
        -- Check if it ran out of battery
        if (not HL2CR_AUX:HasFlashlightPower(player) or player:Team() ~= TEAM_ALIVE) and player:FlashlightIsOn() then
            player:Flashlight(false)
        end
        
        --print(math.Round(HL2CR_AUX:GetFlashlightPower(player), 2))
        -- Send it to the player
        net.Start("hl2cr_auxpow_flashlight")
            net.WriteFloat(new)
        net.Send(player)
    end

    --[[
    Drains a self power supply for the flashlight, turns it off if it
    runs out of battery and regenerates it if off
    @param {Player} player
    ]]
    local function UseFlashlight(pl)
        HL2CR_AUX:RemoveExpense(pl, ID)
        
        if pl.HL2CR_AUX.flashlight.tick < CurTime() then
            if pl:FlashlightIsOn() then
                HL2CR_AUX:AddFlashlightPower(pl, -GetConVar("hl2cr_suit_default_flashlight_rate"):GetFloat() * (player.statFlashBatt or 1))
                pl.HL2CR_AUX.flashlight.tick = CurTime() + DEFAULT_RATE / GetConVar("hl2cr_suit_default_flashlight_delay"):GetFloat()
            else
                HL2CR_AUX:AddFlashlightPower(pl, GetConVar("hl2cr_suit_default_recharge_rate"):GetFloat())
                pl.HL2CR_AUX.flashlight.tick = CurTime() + DEFAULT_RECOVERY_RATE / GetConVar("hl2cr_suit_default_recharge_delay"):GetFloat()
            end
        end
    end

    --[[
    Based on configuration, will either drain the auxiliar power or it's own
    flashlight supply
    ]]
    hook.Add("AuxPowerTick", "auxpow_flashlight", function(player)
        -- Disable flashlight if the suit is required and the player doesn't have it
        if player:CanUseFlashlight() and player:Team() == TEAM_ALIVE then
            player:AllowFlashlight(true)
        else
            player:AllowFlashlight(false)
        end

        UseFlashlight(player)
    end)
end

if CLIENT then
    local client_maps_no_suit = {
        ["d1_trainstation_01"] = true,
        ["d1_trainstation_02"] = true,
        ["d1_trainstation_03"] = true,
        ["d1_trainstation_04"] = true
    }
    
    -- Parameters
    local HORIZONTAL_OFFSET, VERTICAL_OFFSET = 431, 19
    local COLOUR = Color(255, 238, 23)
    local FWIDTH, FHEIGHT = 59, 38
    local LIGHT_IDLE, LIGHT_ACTIVE = "®", "©"
    local ALPHA_ACTIVE, ALPHA_IDLE = 1, 0.18

    -- Variables
    local power = 1
    local colour = 1
    local alpha = ALPHA_IDLE
    local barAlpha = 0

    -- Create scaled font
    surface.CreateFont( "auxpow_flashlight", {
        font = "HalfLife2",
        size = math.Round(51 * HL2CR_AUX:GetScale()),
        weight = 0,
        additive = true,
        antialias = true
    })

    --[[
    Returns the amount of flashlight battery the client acknowledges the player has
    @return {number} flashlight battery
    ]]
    function HL2CR_AUX:GetFlashlight()
        return power
    end

    --[[
    Returns the flashlight HUD component colour
    @return {Color} colour
    ]]
    local function GetColour()
        return HL2CR_AUX:ColourWithAlpha(HL2CR_AUX:IntersectColour(Color(255, 238, 23), Color(255, 20, 20), colour), alpha)
    end

    --[[
    Animates the flashlight HUD component
    @param {number}
    ]]
    local function Animate()
        -- Colour
        local col = 1
        if (power < 0.2) then col = 0 end
        colour = Lerp(FrameTime() * 4, colour, col)

        -- Alpha
        local a = ALPHA_IDLE
        if (LocalPlayer():FlashlightIsOn()) then a = ALPHA_ACTIVE end
        alpha = Lerp(FrameTime() * 4, alpha, a)

        a = 0
        if (power < 1) then a = 1 end
        barAlpha = Lerp(FrameTime() * 30, barAlpha, a)
    end

    --[[
    Draws the flashlight icon
    @param {number} x
    @param {number} y
    @param {boolean} is the flashlight active
    @param {Color|nil} colour
    @param {number|nil} alpha
    @param {number|nil} horizontal alignment
    ]]
    local function DrawFlashlightIcon(x, y, active, col, a, align)
        col = col or GetColour()
        a = a or alpha
        align = align or TEXT_ALIGN_LEFT
        local icon = LIGHT_IDLE
        if (active) then icon = LIGHT_ACTIVE end
        draw.SimpleText(icon, "auxpow_flashlight", x, y, GetColour(), align)
    end

    --[[
    Draws the flashlight panel
    @param {number} x
    @param {number} y
    ]]
    function HL2CR_AUX:DrawFlashlightHUD(x, y)
        if (not LocalPlayer():Alive()) then power = 1 return end
        
        if client_maps_no_suit[game.GetMap()] or (game.GetMap() == "d1_trainstation_05" and not GetGlobalBool("HL2CR_GLOBAL_SUIT")) then
            return 
        end

        local w, h = math.floor(FWIDTH * HL2CR_AUX:GetScale()), math.floor(FHEIGHT * HL2CR_AUX:GetScale())
        y = y - h
        Animate()
        draw.RoundedBox(6, x, y, w, h, Color(0, 0, 0, 80))
        HL2CR_AUX:DrawBar(x + 7 * HL2CR_AUX:GetScale(), y + 29 * HL2CR_AUX:GetScale(), 3, 3, 1, 10, power, GetColour(), barAlpha, 0.3)
        DrawFlashlightIcon(x + w * 0.51, y - h * 0.35, LocalPlayer():FlashlightIsOn(), nil, nil, TEXT_ALIGN_CENTER)
    end

    --[[
    Draws the default HUD component
    Calls the "EP2FlashlightHUDPaint" hook to see if it's overriden (in case you want to make your own)
    ]]
    hook.Add("HUDPaint", "auxpow_flashlight_hud", function()
        local x, y = 431, 20
        HL2CR_AUX:DrawFlashlightHUD(math.Round(x * HL2CR_AUX:GetScale()), ScrH() - math.Round(y * HL2CR_AUX:GetScale()))
    end)

-- Receive EP2 flashlight power amount
    net.Receive("hl2cr_auxpow_flashlight", function(len)
        power = net.ReadFloat()
    end)
end
