
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
        },

        ["pushers"] = {
            [1] = {
                [1] = Vector(-5072, -4528, 422),
                [2] = Vector(-5133, -4595, 378)
            } ,
        },

        ["pusher_spot"] = {
            [1] = Vector(-5105, -4477, 334)
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

    ["d1_canals_01"] = {
        ["checkpoints"] = {
            [1] = {
                [1] = Vector(377, -3649, 375),
                [2] = Vector(129, -3616, 257)
            },

            [2] = {
                [1] = Vector(763, 2852, -94),
                [2] = Vector(638, 2785, 9)
            },            
        },
       
        ["checkpoint_spot"] = {
            [1] = Vector(111, -3459, 260),
            [2] = Vector(623, 2873, -88),
        },
        
        ["changelevels"] = {
            [1] = Vector(689, 2859, -98), 
            [2] = Vector(764, 2977, 18)
        }
    },

    ["d1_canals_01a"] = {
        ["checkpoints"] = {
            [1] = {
                [1] = Vector(-2760, 5232, 86),
                [2] = Vector(-2807, 5345, -42)
            }
        },
            
        ["checkpoint_spot"] = {
            [1] = Vector(-2821, 5296, -37)
        },
        
        ["changelevels"] = {
            [1] = Vector(-5758, 9295, -94), 		
            [2] = Vector(-5570, 9138, 160)
        }
    },

    ["d1_canals_02"] = {
        ["changelevels"] = {
            [1] = Vector(-416, 1702, -829),		
            [2] = Vector(-396, 1605, -725)
        },
        
        ["pushers"] = {
            [1] = {
                [1] = Vector(88, -56, -495),
                [2] = Vector(533, 100, -896)
            },
        },

        ["pusher_spot"] = {
            [1] = Vector(440, -317, -793)
        }
    },

    ["d1_canals_03"] = {
        ["changelevels"] = {
            [1] = Vector(-3451, -123, -942), 	
            [2] = Vector(-3537, -33, -1070)
        },

        ["checkpoints"] = {
            [1] = {
                [1] = Vector(-1488, 480, -943),
                [2] = Vector(-1679, 630, -1038)
            },

            [2] = {
                [1] = Vector(-2034, -1011, -1230),
                [2] = Vector(-2213, -722, -1124)
            }
        },

        ["checkpoint_spot"] = {
            [1] = Vector(-1579, 523, -1042),
            [2] = Vector(-2073, -885, -1223)
        }
    },

    ["d1_canals_05"] = {
        ["changelevels"] = {
            [1] = Vector(-5251, -2561, -476), 	
            [2] = Vector(-5016, -2048, -256)
        },

        ["checkpoints"] = {
            [1] = {
                [1] = Vector(4286, 1572, -343), 		
                [2] = Vector(4097, 1663, -472)
            },

            [2] = {
                [1] = Vector(6743, 1536, -446),
                [2] = Vector(6771, 1596, -347)
            }
        },

        ["checkpoint_spot"] = {
            [1] = Vector(4135, 1519, -455),
            [2] = Vector(6744, 1567, -439)
        }
    },

    ["d1_canals_06"] = {
        ["changelevels"] = {
            [1] = Vector(-1658, -3585, -468), 	
            [2] = Vector(-1046, -2491, -197)
        },
    },

    ["d1_canals_07"] = {
        ["changelevels"] = {
            [1] = Vector(-7215, -3843, -732),
            [2] = Vector(-7495, -4539, -1030)
        },

        ["checkpoints"] = {
            [1] = {
                [1] = Vector(7583, 1658, -2545), 		
                [2] = Vector(7666, 1797, -83)
            },
        },

        ["checkpoint_spot"] = {
            [1] = Vector(7611, 1745, -245)
        }
    },

    ["d1_canals_08"] = {
        ["changelevels"] = {
            [1] = Vector(-9138, 9429, -582),
            [2] = Vector(-8882, 8961, -216)
        },

        ["checkpoints"] = {
            [1] = {
                [1] = Vector(-777, -437, -487),
                [2] = Vector(-672, -544, -574)
            },

            [2] = {
                [1] = Vector(-2056, -3613, -352),
                [2] = Vector(-1730, -4486, -637)
            }
        },

        ["checkpoint_spot"] = {
            [1] = Vector(-775, -559, -571),
            [2] = Vector(-1910, -4146, -629)
        }
    },

    ["d1_canals_09"] = {
        ["changelevels"] = {
            [1] = Vector(-1782, -7391, -427), 	
            [2] = Vector(-1382, -7600, -140)
        }
    },

    ["d1_canals_10"] = {
        ["changelevels"] = {
            [1] = Vector(-13890, 316, -335),
            [2] = Vector(-13569, 608, -28)
        },
    },

    ["d1_canals_11"] = {
        ["changelevels"] = {
            [1] = Vector(-11332, -769, -950),
            [2] = Vector(-11705, -1019, -790)
        },

        ["checkpoints"] = {
            [1] = {
                [1] = Vector(6225, 5231, -894), 
                [2] = Vector(6321, 5365, -772),
            },

            [2] = {
                [1] = Vector(5635, 4733, -960), 
                [2] = Vector(5381, 5085, -753)
            },

            [3] = {
                [1] = Vector(2164, -7508, -829),
                [2] = Vector(2351, -7901, -958)
            }
        },

        ["checkpoint_spot"] = {
            [1] = Vector(6356, 5366, -889),
            [2] = Vector(5703, 4901, -931),
            [3] = Vector(1852, -7389, -919)
        },

        ["checkpoint_functions"] = {
            [1] = function()
                disableAirboatGlobal = true
                for _, v in ipairs(player.GetAll()) do
                    if v.vehicle and v.vehicle:IsValid() then
                        v.vehicle:Remove()
                        v.vehicle = nil
                    end
                end
            end,

            [2] = function()
                canSpawnGlobalGun = true
                BroadcastMessageToAll(HL2CR_GreenColour, translate.Get("Map_Enabled_Vehicles_Airboat_WithGun"))
            end
        },
    },

    ["d1_canals_12"] = {
        ["changelevels"] = {
            [1] = Vector(2623, -8575, 97),
            [2] = Vector(2263, -8499, 361)
        },
        
        ["checkpoints"] = {
            [1] = {
                [1] = Vector(-4583, 3482, 323),
                [2] = Vector(-4103, 3252, 463)
            }
        },

        ["checkpoint_spot"] = {
            [1] = Vector(-4509, 3346, 332)
        }

    },
    
}

MAPS_NO_SUIT = {
    ["d1_trainstation_01"] = true,
	["d1_trainstation_02"] = true,
	["d1_trainstation_03"] = true,
	["d1_trainstation_04"] = true
}

MAPS_NO_PETS = {
    ["d1_trainstation_01"] = true,
	["d1_trainstation_02"] = true,
	["d1_trainstation_03"] = true,
	["d1_trainstation_04"] = true,
	["d1_trainstation_05"] = true,
	["d3_breen_01"] = true
}

MAPS_SUPERGRAVGUN = {
	["d3_citadel_03"] = true,
	["d3_citadel_04"] = true,
	["d3_citadel_05"] = true,
	["d3_breen_01"] = true
}

NO_SUICIDE_MAPS = {
	["d1_trainstation_01"] = true,
	["d1_trainstation_02"] = true,
	["d1_trainstation_03"] = true,
	["d1_trainstation_04"] = true,
	["d1_trainstation_05"] = true,
	["d1_eli_01"] = true,
	["d1_eli_02"] = true,
	["d3_breen_01"] = true
}


AIRBOAT_MAPS = {
	["d1_canals_06"] = true,
	["d1_canals_07"] = true,
	["d1_canals_08"] = true,
	["d1_canals_09"] = true,
	["d1_canals_10"] = true
}

AIRBOAT_GUN_MAPS = {
	["d1_canals_12"] = true,
	["d1_canals_13"] = true
}

JEEP_MAPS = {
	["d2_coast_03"] = true,
	["d2_coast_04"] = true,
	["d2_coast_05"] = true,
	["d2_coast_06"] = true,
	["d2_coast_06"] = true,
	["d2_coast_07"] = true,
	["d2_coast_09"] = true,
	["d2_coast_10"] = true
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

    local changelevel = ents.Create("trigger_changemap")
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

    if HL2_TRIGGERS[game.GetMap()]["pushers"] then
        for i, p in ipairs(HL2_TRIGGERS[game.GetMap()]["pushers"]) do
            local pusher = ents.Create("trigger_pushback")
            pusher.Min = Vector(p[1])
            pusher.Max = Vector(p[2])
            pusher.Pos = Vector(p[2]) - ( ( Vector(p[2]) - Vector(p[1])) / 2 )
            pusher:SetPos(pusher.Pos)
            pusher:Spawn()
            pusher.TPSpot = HL2_TRIGGERS[game.GetMap()]["pusher_spot"][i]
        end
    end
end

local maps_trainstation = {
    ["d1_trainstation_01"] = true,
    ["d1_trainstation_02"] = true,
    ["d1_trainstation_03"] = true,
    ["d1_trainstation_05"] = true
}

local function SetUpMisc()

    local MapLua = ents.Create("lua_run")
	MapLua:SetName("hl2crlua")
	MapLua:Spawn()

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

    if maps_trainstation[game.GetMap()] then
        game.SetGlobalState("gordon_invulnerable", 1)
        game.SetGlobalState("gordon_precriminal", 1)
    else
        game.SetGlobalState("gordon_invulnerable", 0)
        game.SetGlobalState("gordon_precriminal", 0)
    end

    if game.GetMap() == "d1_trainstation_06" then
        ents.FindByClass("info_player_start")[1]:SetPos(Vector(-9946, -3652, 326))
    end

    if game.GetMap() == "d1_canals_02" then
		ents.FindByName("underground_door_basinexit2")[1]:Fire("AddOutput", "OnOpen hl2crlua:RunPassedCode:RemovePushTrigger()")
	end

    if game.GetMap() == "d1_canals_07" then
		local blocker_1 = ents.Create("prop_dynamic")
		blocker_1:SetModel("models/props_lab/blastdoor001b.mdl")
		blocker_1:SetPos(Vector(7672, 1374, -265))
        blocker_1:SetName("blocker_1")
		blocker_1:Spawn()

        local blocker_2 = ents.Create("prop_dynamic")
		blocker_2:SetModel("models/props_lab/blastdoor001b.mdl")
		blocker_2:SetPos(Vector(6882, 1300, -260))
        blocker_2:SetName("blocker_2")
		blocker_2:Spawn()

        ents.FindByName("gatehouse_door2")[1]:Fire("AddOutput", "OnOpen hl2crlua:RunPassedCode:RemoveBlockers()")
	end
	
	if game.GetMap() == "d1_canals_10" then
		ents.FindByClass("info_player_start")[1]:SetPos(Vector(11911, -12159, -499))
	end
end

function StartHL2()
	SetHL2Checkpoints()
	SetUpMisc()
	//SetUpLambdas()
end

function RemoveBlockers()
    if ents.FindByName("blocker_1")[1] then
        ents.FindByName("blocker_1")[1]:Remove()
    end

    if ents.FindByName("blocker_2")[1] then
        ents.FindByName("blocker_2")[1]:Remove()
    end
end

function RemovePushTrigger()
	ents.FindByClass("trigger_pushback")[1]:Remove()
end