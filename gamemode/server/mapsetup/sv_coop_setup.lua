

XPFARM_MAPS = {
    ["level01_synb2_entryway_of_doom"] = true,
	["level02_synb2_tricks_and_traps"] = true,
	["level03_synb2_underground"] = true,
	["level04_synb2_across_the_darkness"] = true,
	["level05_synb2_diehard"] = true,
	["level06_synb2_base"] = true,
	["level07_synb2_scary_dark_house"] = true,
	["level08_synb2_a_place_to_die"] = true,
	["level09_synb2_choose_your_destiny"] = true,
	["level10_synb2_end_of_evil_part1_b1"] = true,
}


//TEMPLATE
--[[
[""] = {
    ["checkpoints"] = {

    },
    
    
    ["checkpoint_spot"] = {
        
    },
	
	["checkpoint_angle"] = {
		[1] = Angle(0, 0, 0),
		[2] = Angle(0, 0, 0),
		[3] = Angle(0, 0, 0),
		[4] = Angle(0, 0, 0)
	},
    
    ["changelevels"] = {
        
    },
    
    ["checkpoint_functions"] = {

    },

    ["pushers"] = {
        
    }
	
	["pusher_spot"] = {

    }
}
--]]

--Hopefully to declutter the SetUpCoop function
local COOP_FUNCTIONS = {
    ["syn_trials4"] = function()
        ents.FindByName("intro_waiter")[1]:Remove()
        ents.FindByName("intro_stopwaiting")[1]:Fire("trigger")
        ents.FindByName("game_start")[1]:Fire("trigger")

        for _, s in ipairs(ents.FindByClass("info_player_coop")) do
            s:Remove()
        end
    end
}

local COOP_TRIGGERS = {
    ["level01_synb2_entryway_of_doom"] = {
        ["changelevels"] = {
            [1] = Vector(2934, -5766, -317),
            [2] = Vector(3054, -5870, -457)
        }
    }
}

local function SetUpCoop()
    if COOP_FUNCTIONS[game.GetMap()] then COOP_FUNCTIONS[game.GetMap()]() end

    table.insert(SPAWNING_WEAPONS, "weapon_crowbar")
    table.insert(SPAWNING_WEAPONS, "weapon_physcannon")
end

local function SetUpCheckpoints()
	if !COOP_TRIGGERS[game.GetMap()] then return end
    if COOP_TRIGGERS[game.GetMap()]["changelevels"] then
        local changelevel = ents.Create("trigger_changemap")
        changelevel.Min = Vector(COOP_TRIGGERS[game.GetMap()]["changelevels"][1])
        changelevel.Max = Vector(COOP_TRIGGERS[game.GetMap()]["changelevels"][2])
        changelevel.Pos = Vector(COOP_TRIGGERS[game.GetMap()]["changelevels"][2]) - 
        ( ( Vector(COOP_TRIGGERS[game.GetMap()]["changelevels"][2]) - Vector(COOP_TRIGGERS[game.GetMap()]["changelevels"][1])) 
        / 2 )
        
        changelevel:SetPos(changelevel.Pos)
        changelevel:Spawn()

        changelevel.lambdaModel = ents.Create("prop_dynamic")
        changelevel.lambdaModel:SetModel("models/hl2cr_lambda.mdl")
        changelevel.lambdaModel:SetPos(changelevel.Pos)
        changelevel.lambdaModel:Spawn()
        changelevel.lambdaModel:ResetSequence("idle")
        changelevel.lambdaModel:SetMaterial("phoenix_storms/wire/pcb_green")

        if COOP_TRIGGERS[game.GetMap()]["changelevel_func"] then
            changelevel.Func = COOP_TRIGGERS[game.GetMap()]["changelevel_func"][1]
        end
    end
end

function StartCoop()
    SetUpCoop()
    SetUpCheckpoints()
end