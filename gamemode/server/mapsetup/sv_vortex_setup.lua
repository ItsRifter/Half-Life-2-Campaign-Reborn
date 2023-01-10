local vortex_map_pos = {
    ["d1_trainstation_04"] = {
        [1] = Vector(-3728, -3856, 534),
        [2] = Vector(-3918, -3290, 629)
    },
    
    ["d1_trainstation_05"] = {
        [1] = Vector(-6820, -1593, 131)
    },

    ["d1_eli_01"] = {
        [1] = Vector(227, 3600, -1343),
        [2] = Vector(547, 2087, -2436)
    },

    ["d1_eli_02"] = {
        [1] = Vector(-910, 472, -2153),
        [2] = Vector(-2467, 367, -2330)
    }
}

VortexBall = VortexBall or nil

local function ShouldSpawnVortex()
    return math.random(1, 100) <= GetConVar("hl2cr_vortex_chance"):GetInt() 
end

function SetUpVortex()
    if not vortex_map_pos[game.GetMap()] then return end
    if not ShouldSpawnVortex() then return end

    VortexBall = ents.Create("prop_dynamic")
    VortexBall:SetModel("models/effects/combineball.mdl")
    VortexBall:SetPos(vortex_map_pos[game.GetMap()][math.random(1, #vortex_map_pos[game.GetMap()])])
    VortexBall:Spawn()

    local trigger = ents.Create("trigger_vortex")
    trigger:SetParent(VortexBall)
    trigger.Min, trigger.Max = VortexBall:GetCollisionBounds()
    trigger:SetCollisionBoundsWS(trigger:WorldToLocal(trigger.Min), trigger:WorldToLocal(trigger.Max))
    trigger:SetPos(VortexBall:GetPos())
    trigger.Vortex = VortexBall
    trigger:Spawn()

end

