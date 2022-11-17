//TEMPLATE
--[[
[""] = {
    ["checkpoints"] = {

    },
    
    
    ["checkpoint_spot"] = {
        
    },
    
    ["changelevels"] = {
        
    }
    
    ["checkpoint_functions"] = {

    }

    ["pushers"] = {
        
        ["spot"] = {

        }
    }
}
--]]

local pacifistAchGlobal = false;

local ep2_triggers = {
    ["ep2_outland_01"] = {
        ["checkpoints"] = {
            [1] = {
                [1] = Vector(220, -1090, 37), 		
                [2] = Vector(390, -490, 180)
            },
			[2] = {
                [1] = Vector(-3810, 1580, 130), 		
                [2] = Vector(-3575, 1720, 200)
            },
			[3] = {
                [1] = Vector(-5760, 4440, -110), 		
                [2] = Vector(-5530, 4610, -80)
            }
        },
        
        ["checkpoint_spot"] = {
            [1] = Vector(340, -790, 30),
			[2] = Vector(-3615, 1660, 150),
			[3] = Vector(-5530, 4560, -110)
        },
		
		["checkpoint_angle"] = {
			[1] = Angle(0, 200, 0),
			[2] = Angle(0, 120, 0),
			[3] = Angle(0, 230, 0)
		},
        
        ["changelevels"] = {
            [1] = Vector(-6480, 3620, -1420),
            [2] = Vector(-6020, 3690, -1320)
        },
		
		["pushers"] = {
            [1] = {	--Dont let people jump off the cliff at start
                [1] = Vector(20, -2560, -190),
                [2] = Vector(1350, -1920, -60)
            }
        },

        ["pusher_spot"] = {
            [1] = Vector(510, -1445, -10)
        }
    }, 
	
	["ep2_outland_01a"] = {
        ["changelevels"] = {
            [1] = Vector(-2250, -8350, -450),
            [2] = Vector(-2150, -8200, -370)
        },

    }, 
	
	--ToDo Add achievement for antlion event, maybe if player doesnt die during it only?
	["ep2_outland_02"] = {
        ["checkpoints"] = {
            [1] = {
                [1] = Vector(-2690, -9170, -740), 		
                [2] = Vector(-2290, -8900, -570)
            },
			[2] = {
                [1] = Vector(-480, -9780, -730), 		
                [2] = Vector(-280, -9390, -590)
            }
        },
        
        ["checkpoint_spot"] = {
            [1] = Vector(-2480, -9160, -690),
			[2] = Vector(-410, -9620, -700)
        },
		
		["checkpoint_angle"] = {
			[1] = Angle(0, 220, 0),
			[2] = Angle(0, 330, 0)
		},
        
        ["changelevels"] = {
            [1] = Vector(-1250, -10600, -500),
            [2] = Vector(-940, -10490, -400)
        },

    }, 

}

local function SetEP2Checkpoints()
    for _, c in pairs(ents.FindByClass("trigger_changelevel")) do
        c:Remove()
    end

    //If this map doesn't have support, throw a message and stop here
    if not ep2_triggers[game.GetMap()] then
        print(MsgC(Color(255, 0, 0), "HL2 CO-OP RPG ERROR - MAP IS NOT SUPPORTED"))
        return
    end

    if ep2_triggers[game.GetMap()]["checkpoints"] then
        for i, t in ipairs(ep2_triggers[game.GetMap()]["checkpoints"]) do
            local checkpoint = ents.Create("trigger_checkpoint")
            checkpoint.Min = Vector(t[1])
            checkpoint.Max = Vector(t[2])
            checkpoint.Pos = Vector(t[2]) - ( Vector(t[1]) - Vector(t[1])) / 2
            checkpoint.TPPoint = Vector(ep2_triggers[game.GetMap()]["checkpoint_spot"][i])
			if ep2_triggers[game.GetMap()]["checkpoint_angle"] then checkpoint.TPAngles = Angle(ep2_triggers[game.GetMap()]["checkpoint_angle"][i]) or checkpoint.TPAngles end	--default to 0,0,0
            checkpoint.PointIndex = i
            checkpoint:SetPos(checkpoint.Pos)
            checkpoint:Spawn()
            
            checkpoint.lambdaModel = ents.Create("prop_dynamic")
            checkpoint.lambdaModel:SetModel("models/hl2cr_lambda.mdl")
            checkpoint.lambdaModel:SetPos( checkpoint.TPPoint + Vector(0, 0, 75))
            checkpoint.lambdaModel:Spawn()
            checkpoint.lambdaModel:ResetSequence("idle")
            checkpoint.lambdaModel:SetMaterial(checkpoint.Mat)

            if ep2_triggers[game.GetMap()]["checkpoint_functions"] then
                checkpoint.Func = ep2_triggers[game.GetMap()]["checkpoint_functions"][i]
            end
        end
    end

    if ep2_triggers[game.GetMap()]["changelevels"] and game.GetGlobalState("hl2cr_extendedmap") == GLOBAL_DEAD then
        local changelevel = ents.Create("trigger_changemap")
        changelevel.Min = Vector(ep2_triggers[game.GetMap()]["changelevels"][1])
        changelevel.Max = Vector(ep2_triggers[game.GetMap()]["changelevels"][2])
        changelevel.Pos = Vector(ep2_triggers[game.GetMap()]["changelevels"][2]) - 
        ( ( Vector(ep2_triggers[game.GetMap()]["changelevels"][2]) - Vector(ep2_triggers[game.GetMap()]["changelevels"][1])) 
        / 2 )
        
        changelevel:SetPos(changelevel.Pos)
        changelevel:Spawn()

        changelevel.lambdaModel = ents.Create("prop_dynamic")
        changelevel.lambdaModel:SetModel("models/hl2cr_lambda.mdl")
        changelevel.lambdaModel:SetPos(changelevel.Pos)
        changelevel.lambdaModel:Spawn()
        changelevel.lambdaModel:ResetSequence("idle")
        changelevel.lambdaModel:SetMaterial("phoenix_storms/wire/pcb_green")

        if ep2_triggers[game.GetMap()]["changelevel_func"] then
            changelevel.Func = ep2_triggers[game.GetMap()]["changelevel_func"][1]
        end
    end
	
	--Dont know if needed but if we do use pusher
	if ep2_triggers[game.GetMap()]["pushers"] then
        for i, p in ipairs(ep2_triggers[game.GetMap()]["pushers"]) do
            local pusher = ents.Create("trigger_pushback")
            pusher.Min = Vector(p[1])
            pusher.Max = Vector(p[2])
            pusher.Pos = Vector(p[2]) - ( ( Vector(p[2]) - Vector(p[1])) / 2 )
            pusher:SetPos(pusher.Pos)
            pusher:Spawn()
            pusher.TPSpot = ep2_triggers[game.GetMap()]["pusher_spot"][i]
        end
    end
end

local function SetUpMisc()
    
    local MapLua = ents.Create("lua_run")
	MapLua:SetName("hl2crlua")
	MapLua:Spawn()

    if EP2_WEAPONS[game.GetMap()] then
		for i, wep in pairs(EP2_WEAPONS[game.GetMap()]) do 
			table.insert(SPAWNING_WEAPONS, wep)
		end
	end
	
	if EP2_EQUIPMENT[game.GetMap()] then
		table.insert(SPAWNING_ITEMS, EP2_EQUIPMENT[game.GetMap()])
	end

    if game.GetMap() == "ep2_outland_01" then
		ents.FindByName("trigger_Get_physgun")[1]:Fire("AddOutput", "OnTrigger hl2crlua:RunPassedCode:GiveGravgunEP2()")
		
		timer.Simple(15, function()	--trapdoor does not seem to wake up blocking progress so removing it
			for _, physbox in ipairs(ents.FindByName("physbox_floor_door")) do
				physbox:Remove()
			end
		end)
	end

end

function StartEP2()
	SetEP2Checkpoints()
	SetUpMisc()
end

function GiveGravgunEP2()
	--print("Blah")
	for k, v in ipairs(player.GetAll()) do
		v:Give("weapon_physcannon")
	end
end