--[[------------------------------------------------------------------
  POWER SUPPLY
  Player auxiliary power supply - Fitted for HL2-CR
]]--------------------------------------------------------------------

AddCSLuaFile()

HL2CR_AUX = {}

if SERVER then

    -- Parameters
    local DEFAULT_TICKRATE = 0.01
    local DEFAULT_RECOVERY_RATE = 0.09
    local DEFAULT_PENALTY = 0.03 -- Energy taken away when adding an expense
    local DEFAULT_PENALTY_TIME = 0.3 -- Recovery penalty
    local TIMER_NAME = "_auxpow"

    --[[
    Returns a player's auxiliary power data
    @param {Player} player
    @return {table} auxiliary power data
    ]]
    function HL2CR_AUX:GetData(player)
        return player.HL2CR_AUX
    end

    --[[
    Returns a player's auxiliary power expenses
    @param {Player} player
    @return {table} expenses
    ]]
    function HL2CR_AUX:GetExpenses(player)
        return HL2CR_AUX:GetData(player).expense
    end

    --[[
    Whether a player has active auxiliary power expenses
    @param {Player} player
    @return {boolean} has expenses
    ]]
    function HL2CR_AUX:HasExpenses(player)
        return table.Count(HL2CR_AUX:GetExpenses(player)) > 0
    end

    --[[
    Returns a player's current auxiliary power levels
    @param {Player} player
    @return {number} power level
    ]]
    function HL2CR_AUX:GetPower(player)
        return HL2CR_AUX:GetData(player).power
    end

    --[[
    Whether a player has auxiliary power
    @param {Player} player
    @return {boolean} has auxiliary power
    ]]
    function HL2CR_AUX:HasPower(player)
        return HL2CR_AUX:GetPower(player) > 0
    end

    --[[
    Sets a new level for a player's auxiliary power
    @param {Player} player
    @param {number} power
    ]]
    function HL2CR_AUX:SetPower(player, power)
        HL2CR_AUX:GetData(player).power = power

        -- Send to client
        net.Start("hl2cr_auxpow_amount")
            net.WriteFloat(HL2CR_AUX:GetPower(player))
        net.Send(player)
    end

    --[[
    Adds power to a player's auxiliary power supply
    @param {Player} player
    @param {number} power to add
    ]]
    function HL2CR_AUX:AddPower(player, power)
        HL2CR_AUX:SetPower(player, math.min(HL2CR_AUX:GetPower(player) + power, 1))

        -- If drained, get the greater downtime
        if (not HL2CR_AUX:HasPower(player) and HL2CR_AUX:HasExpenses(player)) then
            local downtime = 0
            for _, expense in pairs(HL2CR_AUX:GetExpenses(player)) do
                if (expense.downtime > downtime) then
                    downtime = expense.downtime
                end
            end
            HL2CR_AUX:SetPower(player, -(downtime * DEFAULT_TICKRATE) / (DEFAULT_RECOVERY_RATE * 1))
        end
    end

    --[[
    Adds an active expense to the auxiliary power system
    @param {Player} player
    @param {string} id
    @param {string} label
    @param {number} rate of energy consumption in seconds
    @param {number|nil} how much energy it consumes per tick
    @param {number|nil} how many seconds of downtime will the aux. power have after being drained
    ]]
    function HL2CR_AUX:AddExpense(player, id, label, rate, expense, downtime)
        expense = expense or 0.01
        downtime = downtime or 0
    
        if (HL2CR_AUX:GetExpenses(player)[id] ~= nil) then return end
        
        HL2CR_AUX:GetExpenses(player)[id] = {label = label, rate = rate, tick = CurTime() + rate, expense = expense, downtime = downtime}
        HL2CR_AUX:AddPower(player, -DEFAULT_PENALTY)

        -- Send to client
        net.Start("hl2cr_auxpow_expenses")
            net.WriteString(id)
            net.WriteString(label)
        net.Send(player)
    end

    --[[
    Removes a auxiliary power expense
    @param {Player} player
    @param {string} id
    ]]
    function HL2CR_AUX:RemoveExpense(player, id)
        if (HL2CR_AUX:GetExpenses(player)[id] == nil) then return end
        
        HL2CR_AUX:GetExpenses(player)[id] = nil

        -- Send to client
        net.Start("hl2cr_auxpow_expenses")
            net.WriteString(id)
            net.WriteString("")
        net.Send(player)
    end

    --[[
    Main power supply loop
    Checks for expenses and either depletes or regenerates the power level
    @param {Player} player
    ]]
    function HL2CR_AUX:PlayerTick(player)
        if (MAPS_NO_SUIT[game.GetMap()]) then player.HL2CR_AUX.power = 1 return end
        
        if (HL2CR_AUX:HasExpenses(player)) then
            for _, expense in pairs(HL2CR_AUX:GetExpenses(player)) do
                if (expense.tick < CurTime()) then
                    HL2CR_AUX:AddPower(player, -expense.expense * GetConVar("hl2cr_suit_default_rate"):GetFloat())
                    expense.tick = CurTime() + expense.rate
                end
            end
            player.HL2CR_AUX.regenTick = CurTime() + DEFAULT_PENALTY_TIME
        else
            if (HL2CR_AUX:GetData(player).regenTick < CurTime()) then
                HL2CR_AUX:AddPower(player, 0.01 * 1)
                player.HL2CR_AUX.regenTick = CurTime() + DEFAULT_RECOVERY_RATE
            end
        end
    end

    --[[
    Setups a player's variables
    @param {Player} player
    ]]
    function HL2CR_AUX:SetupAuxPower(player)
        -- Setup table
        player.HL2CR_AUX = {
            power = 1, -- Power level
            regenTick = 0, -- Power regeneration tick time
            expense = {} -- Power expenses
        }

        player.HL2CR_AUX.flashlight = {power = 1, tick = 0}

        -- Setup timer if it doesn't exist
        if (not timer.Exists(player:EntIndex() .. TIMER_NAME)) then
            timer.Create(player:EntIndex() .. TIMER_NAME, DEFAULT_TICKRATE, 0, function()
                if (IsValid(player)) then
                    HL2CR_AUX:PlayerTick(player)
                    hook.Run("AuxPowerTick", player)
                else
                    timer.Remove(player:EntIndex() .. TIMER_NAME)
                end
            end)
        end
    end

    --[[
    Called when a player disconnects
    @param {Player} player
    ]]
    function HL2CR_AUX:PlayerDisconnect(player)
        timer.Remove(player:EntIndex() .. TIMER_NAME)
    end
end

if CLIENT then

    local aux_no_suit = {
        ["d1_trainstation_01"] = true,
        ["d1_trainstation_02"] = true,
        ["d1_trainstation_03"] = true,
        ["d1_trainstation_04"] = true,
        ["d1_trainstation_05"] = true
    }

    local LABEL = "AUX POWER"
    local WIDTH, HEIGHT = 163, 41
    local EXPENSE_HEIGHT = 16
    local HORIZONTAL_OFFSET, VERTICAL_OFFSET = 25, 87
    local SW, SH, SM = 9, 6, 5
    local COLOUR = Color(255, 238, 23)
    local ANIM_RATE = 0.04
    local FADE_SPEED = 0.04

    local client_auxpower = 1
    
    local labels = {}
    local tick = 0
    local height = 0
    local colour = 0
    local alpha = 0

    function HL2CR_AUX:GetPower()
        return client_auxpower
    end
   
    function HL2CR_AUX:GetScale()
        return ScrH() / 768
    end

    local function GetColour()
        return HL2CR_AUX:ColourWithAlpha(HL2CR_AUX:IntersectColour(Color(255, 238, 23), Color(255, 0, 0), colour), alpha);
    end

    surface.CreateFont( "hl2cr_auxpow", {
        font = "Verdana",
        size = math.Round(14 * HL2CR_AUX:GetScale()),
        weight = 1000,
        antialias = true
    })

    local function Animate()
        -- Colour
        local col = 1;
        if (client_auxpower < 0.2) then col = 0; end
        colour = Lerp(FrameTime() * 4, colour, col);
    
        -- Linear animations
        if (tick < CurTime()) then
          -- Label animation
          if (table.Count(labels) >= height) then
            height = math.min(height + ANIM_RATE, table.Count(labels));
          else
            height = math.max(height - ANIM_RATE, 0);
          end
    
          -- Fade-in/out
          if (client_auxpower < 1 or table.Count(labels) > 0) then
            alpha = math.min(alpha + FADE_SPEED, 1);
          else
            alpha = math.max(alpha - FADE_SPEED, 0);
          end
    
          tick = CurTime() + 0.01;
        end
    end

    function HL2CR_AUX:IntersectColour(a, b, value)
		return Color(HL2CR_AUX:Intersect(a.r, b.r, value), HL2CR_AUX:Intersect(a.g, b.g, value), HL2CR_AUX:Intersect(a.b, b.b, value), HL2CR_AUX:Intersect(a.a, b.a, value))
    end

    function HL2CR_AUX:Intersect(a, b, value)
		return (a * value) + (b * (1-value))
	end

    function HL2CR_AUX:ColourWithAlpha(col, a)
        return Color(col.r, col.g, col.b, col.a * a)
    end

    function HL2CR_AUX:DrawBar(x, y, w, h, m, amount, value, col, a, bgA)
        col = col or GetColour()
        a = a or alpha
        bgA = bgA or 0.4
        
        -- Background
        for i=0, amount do
            draw.RoundedBox(0, x + math.Round((w + m) * HL2CR_AUX:GetScale()) * i, y, math.Round(w * HL2CR_AUX:GetScale()), math.Round(h * HL2CR_AUX:GetScale()), Color(col.r * 0.8, col.g * 0.8, col.b * 0.8, col.a * bgA * a))
        end

        -- Foreground
        if (value <= 0) then return end
        
        for i=0, math.Round(value * amount) do
            draw.RoundedBox(0, x + math.Round((w + m) * HL2CR_AUX:GetScale()) * i, y, math.Round(w * HL2CR_AUX:GetScale()), math.Round(h * HL2CR_AUX:GetScale()), Color(col.r, col.g, col.b, col.a * a))
        end
    end

    function HL2CR_AUX:DrawHUDPanel(x, y)
        if (not LocalPlayer():Alive()) then client_auxpower = 1 labels = {} return end
        local w, h = WIDTH * HL2CR_AUX:GetScale(), (HEIGHT + EXPENSE_HEIGHT * height) * HL2CR_AUX:GetScale()
        y = y - h
    
        -- Animate
        Animate()
    
        -- Background
        draw.RoundedBox(6, x, y, w, h, Color(0, 0, 0, 80 * alpha))
    
        -- Title
        draw.SimpleText(LABEL, "hl2cr_auxpow", x + (13 * HL2CR_AUX:GetScale()), y + (5 * HL2CR_AUX:GetScale()), GetColour())
    
        -- Bar
        HL2CR_AUX:DrawBar(x + 14 * HL2CR_AUX:GetScale(), y + 24 * HL2CR_AUX:GetScale(), SW, SH, SM, 9, client_auxpower)
    
        -- Expenses
        render.SetScissorRect(x, y, x + w, y + h, true)
        local i = 1
        for _, label in pairs(labels) do
          draw.SimpleText(label, "hl2cr_auxpow", x + (14 * HL2CR_AUX:GetScale()), y + (35 + (EXPENSE_HEIGHT * (i - 1))) * HL2CR_AUX:GetScale(), GetColour())
          i = i + 1
        end
        render.SetScissorRect(0, 0, 0, 0, false)
    end
    
      --[[
        Draws the default HUD component
        Calls the "AuxPowerHUDPaint" hook to see if it's overriden (in case you want to make your own)
      ]]
      hook.Add("HUDPaint", "auxpow_drawhud", function()
        local shouldDraw = hook.Run("AuxPowerHUDPaint", client_auxpower, labels) ~= true
        if shouldDraw and GetConVar("cl_drawhud"):GetInt() > 0 and not (aux_no_suit[game.GetMap()] and not GetGlobalBool("HL2CR_GLOBAL_SUIT")) then
            local x, y = 25, 87
            HL2CR_AUX:DrawHUDPanel(x * HL2CR_AUX:GetScale(), ScrH() - (y * HL2CR_AUX:GetScale()))
        end
    end)
    
    -- Receive power levels
    net.Receive("hl2cr_auxpow_amount", function(len)
        client_auxpower = net.ReadFloat()
    end)
    
    -- Receive labels
    net.Receive("hl2cr_auxpow_expenses", function(len)
        local id = net.ReadString()
        local label = net.ReadString()

        -- Check if the label is valid if not, remove it from tray
        if (string.len(label) > 0) then
        labels[id] = label
        else
        labels[id] = nil
        end
    end)
end

