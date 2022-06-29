
//TEMPLATE
--[[
[""] = {
    ["checkpoints"] = {

    },
    
    ["checkpoint_functions"] = {

    },

    ["checkpoint_spot"] = {

    },
    
    ["changelevels"] = {

    }
}
--]]

local HL2_TRIGGERS = {
    ["d1_trainstation_01"] = {
        ["checkpoints"] = {
            [1] = {
                [1] = Vector(-9423, -2419, 19),
                [2] = Vector(-9464, -2554, 143)
            },

            [2] = {
                [1] = Vector(-5413, -1987, 17),
                [2] = Vector(-5294, -1937, 135)
            },

            [3] = {
                [1] = Vector(-3612, -257, 94), 		
                [2] = Vector(-3440, -340, -28)
            },
            
            [4] = {
                [1] = Vector(-3459, -119, 72),
                [2] = Vector(-3410, -13, -29)
            }
        },

        ["checkpoint_functions"] = {
            [2] = function()
                timer.Simple(3, function()
                    for _, v in ipairs(player.GetAll()) do
                        print(v:Nick())
                        v:SetFOV(0, 1)
                    end
                end)
            end
        },

        ["checkpoint_spot"] = {
            [1] = Vector(-9294, -2445, 26),
            [2] = Vector(-5400, -2070, -18),
            [3] = Vector(-3419, -224, -21),
            [4] = Vector(-3549, -10, -19)
        },

        ["changelevels"] = {
            [1] = Vector(-3130, -164, -61),
            [2] = Vector(-3073, -209, 59)
        }
    },

    ["d1_trainstation_02"] = {        
        ["changelevels"] = {
            [1] = Vector(-5293, -4599, 1),
            [2] = Vector(-5364, -4504, 130)
        },
    },

    ["d1_trainstation_03"] = {
        ["checkpoints"] = {
            [1] = {
                [1] = Vector(-4522, -4569, 386),
                [2] = Vector(-4594, -4654, 506),
            },

            [2] = {
                [1] = Vector(-4890, -4698, 513),
                [2] = Vector(-5031, -4730, 640)
            },
        },
        
        ["checkpoint_spot"] = {
            [1] = Vector(-4556, -4632, 389),
            [2] = Vector(-4990, -4788, 520)
        },
        
        ["changelevels"] = {
            [1] = Vector(-5206, -4756, 578),
            [2] = Vector(-5263, -4867, 688)
        }
    },

    ["d1_trainstation_04"] = {
        ["checkpoints"] = {
            [1] = {
                [1] = Vector(-4063, -3408, 654),
                [2] = Vector(-4095, -3517, 580)
            },

            [2] = {
                [1] = Vector(-6785, -4162, 521),
                [2] = Vector(-7254, -3956, 659)
            },

            [3] = {
                [1] = Vector(-7829, -4096, -254),
                [2] = Vector(-7796, -4156, -136)
            }
        },
        
        ["checkpoint_functions"] = {
            [3] = function()
                //Give achievement
            end
        },

        ["checkpoint_spot"] = {
            [1] = Vector(-4148, -3457, 524),
            [2] = Vector(-7063, -4036, 522),
            [3] = Vector(-7872, -4126, -246)
        },
        
        ["changelevels"] = {
            [1] = Vector(-8076, -4157, -253),
            [2] = Vector(-8028, -4095, -122)
        }
    },

    ["d1_trainstation_05"] = {
        ["checkpoints"] = {
            [1] = {
                [1] = Vector(-6409, -1195, 142),
                [2] = Vector(-6544, -1105, 1)
            },

            [2] = {
                [1] = Vector(-7065, -1298, 1),
                [2] = Vector(-7152, -1472, 125)
            },

            [3] = {
                [1] = Vector(-10383, -4692, 325),
                [2] = Vector(-10283, -4760, 461)
            },
            
        },

        ["checkpoint_spot"] = {
            [1] = Vector(-6488, -1199, 8),
            [2] = Vector(-7167, -1377, 5),
            [3] = Vector(-10337, -4717, 328)
        },
        
        ["changelevels"] = {
            [1] = Vector(-10685, -3639, 475),
            [2] = Vector(-10498, -3628, 321)
        }
    },

    ["d1_trainstation_06"] = {
        ["changelevels"] = {
            [1] = Vector(-8594, -575, -262),
            [2] = Vector(-8703, -513, -382)
        }
    },
}

local function SetHL2Checkpoints()

    //Remove map changelevels, we'll make up our own
    //in case something unexpected happens
    for _, c in pairs(ents.FindByClass("trigger_changelevel")) do
        c:Remove()
    end

    //If this map doesn't have support, throw a message and stop here
    if not HL2_TRIGGERS[game.GetMap()] then
        print(MsgC(Color(255, 0, 0), "HL2CR ERROR - MAP IS NOT SUPPORTED"))
        return
    end

    if HL2_TRIGGERS[game.GetMap()]["checkpoints"] then
        for i, t in ipairs(HL2_TRIGGERS[game.GetMap()]["checkpoints"]) do
            local checkpoint = ents.Create("trigger_checkpoint")
            checkpoint.Min = Vector(t[1])
            checkpoint.Max = Vector(t[2])
            checkpoint.Pos = Vector(t[2]) - ( Vector(t[1]) - Vector(t[1])) / 2
            checkpoint.TPPoint = Vector(HL2_TRIGGERS[game.GetMap()]["checkpoint_spot"][i])
            checkpoint.PointIndex = i
            checkpoint:SetPos(checkpoint.Pos)
            checkpoint:Spawn()
            
            checkpoint.lambdaModel = ents.Create("prop_dynamic")
            checkpoint.lambdaModel:SetModel("models/hl2cr_lambda.mdl")
            checkpoint.lambdaModel:SetPos( checkpoint.TPPoint + Vector(0, 0, 75))
            checkpoint.lambdaModel:Spawn()
            checkpoint.lambdaModel:ResetSequence("idle")
            checkpoint.lambdaModel:SetMaterial(checkpoint.Mat)

            if HL2_TRIGGERS[game.GetMap()]["checkpoint_functions"] then
                checkpoint.Func = HL2_TRIGGERS[game.GetMap()]["checkpoint_functions"][i]
            end
        end
    end

    local changelevel = ents.Create("trigger_changelevel")
    changelevel.Min = Vector(HL2_TRIGGERS[game.GetMap()]["changelevels"][1])
    changelevel.Max = Vector(HL2_TRIGGERS[game.GetMap()]["changelevels"][2])
    changelevel.Pos = Vector(HL2_TRIGGERS[game.GetMap()]["changelevels"][2]) - 
    ( ( Vector(HL2_TRIGGERS[game.GetMap()]["changelevels"][2]) - Vector(HL2_TRIGGERS[game.GetMap()]["changelevels"][1])) 
    / 2 )
    
    changelevel:SetPos(changelevel.Pos)
    changelevel:Spawn()
    
    changelevel.lambdaModel = ents.Create("prop_dynamic")
    changelevel.lambdaModel:SetModel("models/hl2cr_lambda.mdl")
    changelevel.lambdaModel:SetPos(changelevel.Pos)
    changelevel.lambdaModel:Spawn()
    changelevel.lambdaModel:ResetSequence("idle")
    changelevel.lambdaModel:SetMaterial("phoenix_storms/wire/pcb_green")

end

local function SetUpMisc()

    SetGlobalBool( "HL2CR_GLOBAL_SUIT", false )

    for _, portal in ipairs(ents.FindByClass("func_areaportal")) do
		portal:SetKeyValue("StartOpen", "1")
	end
	
	if game.GetMap() == "d1_trainstation_01" then
		game.SetGlobalState("gordon_precriminal", 1)
		game.SetGlobalState("gordon_invulnerable", 1)
	end

    if game.GetMap() == "d1_trainstation_02" then
        for i, sp in ipairs(ents.FindByClass("info_player_start")) do
            if i == 1 then continue end
            sp:Remove()
        end
    end

    if game.GetMap() == "d1_trainstation_06" then
        ents.FindByClass("info_player_start")[1]:SetPos(Vector(-9946, -3652, 326))
    end
end

function StartHL2()
	SetHL2Checkpoints()
	SetUpMisc()
	//SetUpLambdas()
end