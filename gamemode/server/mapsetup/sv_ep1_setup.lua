
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

local ep1_triggers = {
    ["ep1_citadel_00"] = {
        ["checkpoints"] = {
            [1] = {
                [1] = Vector(-8932, 5740, -145), 		
                [2] = Vector(-9025, 5834, -25)
            },

            [2] = {
                [1] = Vector(-7810, 5506, -4),
                [2] = Vector(-8046, 5358, -98)
            },

            [3] = {
                [1] = Vector(4569, 3993, -6185),
                [2] = Vector(4766, 4159, -6349)
            }
        },
        
        ["checkpoint_functions"] = {
            [1] = function()
                for _, v in ipairs(player.GetAll()) do
                    if v:InVehicle() then
                        v:ExitVehicle()
                    end
                end
            end,
        },

        ["checkpoint_spot"] = {
            [1] = Vector(-8974, 5781, -134),
            [2] = Vector(-7908, 5435, -83),
			[3] = Vector(4680, 4230, -6348)
        },
        
		["checkpoint_angle"] = {
            [1] = Angle(0, 21, 0),
            [2] = Angle(0, 0, 0),
            [3] = Angle(0, 270, 0)
        },
		
        ["changelevels"] = {
            [1] = Vector(5374, 2784, -6197),
            [2] = Vector(5508, 2652, -6345)
        }
    }, 

    ["ep1_citadel_01"] = {
        ["checkpoints"] = {
            [1] = {
                [1] = Vector(-4826, 7538, 2702),
                [2] = Vector(-4578, 7555, 2521)
            },

            [2] = {
                [1] = Vector(-4548, 5124, 2744),
                [2] = Vector(-4650, 5209, 2595)
            },

            [3] = {
                [1] = Vector(-4946, 1672, 2682),
                [2] = Vector(-4763, 1290, 2462)
            }
        },

        ["checkpoint_functions"] = {
            [1] = function()
                ents.FindByClass("npc_alyx")[1]:SetPos(Vector(-4649, 7549, 2529))
            end
        },

        ["changelevels"] = {
            [1] = Vector(-2952, 1391, 2467),
            [2] = Vector(-3110, 1272, 2646)
        },

        ["checkpoint_spot"] = {
            [1] = Vector(-4711, 7650, 2531),
            [2] = Vector(-4865, 5240, 2605),
			[3] = Vector(-4864, 1536, 2471)
        },
		
		["checkpoint_angle"] = {
            [1] = Angle(0, 90, 0),
            [2] = Angle(0, 270, 0),
            [3] = Angle(0, 0, 0)
        },
    },

    ["ep1_citadel_02"] = {
        ["checkpoints"] = {
            [1] = {
                [1] = Vector(1257, 806, 971),
                [2] = Vector(1334, 784, 834)
            },

            [2] = {
                [1] = Vector(-4548, 5124, 2744),
                [2] = Vector(-4650, 5209, 2595)
            },

            [3] = {
                [1] = Vector(-4946, 1672, 2682),
                [2] = Vector(-4763, 1290, 2462)
            }
        },

        ["changelevels"] = {
            [1] = Vector(1712, 42, 959),
            [2] = Vector(1840, 134, 833)
        },
		
        ["checkpoint_spot"] = {
            [1] = Vector(1302, 686, 840)
        },
		
		["checkpoint_angle"] = {
            [1] = Angle(0, 270, 0)
        },
		
		["checkpoint_functions"] = {
            [1] = function()
                ents.FindByClass("npc_alyx")[1]:SetPos(Vector(1211,673,832))
            end
        }
		
    },

    ["ep1_citadel_02b"] = {
        ["checkpoints"] = {
            [1] = {
                [1] = Vector(3446, 4867, 2509),
                [2] = Vector(3076, 4402, 2663)
            },

            [2] = {
                [1] = Vector(3966, 4813, -6716),
                [2] = Vector(3777, 4465, -6541)
            }
        },

        ["checkpoint_functions"] = {
            [1] = function()
                timer.Simple(0.1, function()
                    local lift = ents.FindByName("citadel_train_lift01_1")[1]
                    for l, spawn in pairs(ents.FindByClass("info_player_start")) do
                        spawn:SetPos(lift:GetPos() + Vector(0, 0, 75))
                        spawn:SetParent(lift)
                    end
                end)
            end,

            [2] = function()
                for l, spawn in pairs(ents.FindByClass("info_player_start")) do
                    spawn:SetParent(nil)
                end
            end
        },

        ["changelevels"] = {
            [1] = Vector(5062, 4838, -6718),
            [2] = Vector(5297, 4461, -6488)
        },

        ["checkpoint_spot"] = {
            [1] = Vector(3279, 4644, 2534),
            [2] = Vector(3995, 4634, -6703)
        },
		
		["checkpoint_angle"] = {
            [1] = Angle(0, 180, 0),
            [2] = Angle(0, 0, 0)
        }
    },

    ["ep1_citadel_03"] = {
        ["changelevels"] = {
            [1] = Vector(921, 13276, 3935),
            [2] = Vector(1272, 13119, 3712)
        },

        ["checkpoints"] = {
            [1] = {
                [1] = Vector(-131,11989,5478),
                [2] = Vector(79,12337,5293)
            },
			
            [2] = {
                [1] = Vector(1884, 11595, 4419),
                [2] = Vector(1999, 11902, 4226)
            },

            [3] = {
                [1] = Vector(1927, 10407, 5794),
                [2] = Vector(1786, 10607, 5630)
            },

            [4] = {
                [1] = Vector(1040, 12607, 5465),
                [2] = Vector(1199, 12432, 5314)
            },

            [5] = {
                [1] = Vector(1240,13582,5522),
                [2] = Vector(1046,13732,5243)
            }
        },

        ["checkpoint_spot"] = {
			[1] = Vector(58,12177,5312),
            [2] = Vector(1955, 11735, 4242),
            [3] = Vector(1918, 10679, 5637),
            [4] = Vector(1112, 12528, 5323),
            [5] = Vector(1159,13663,5333)
        },
		
		["checkpoint_angle"] = {
            [1] = Angle(0, 0, 0),
            [2] = Angle(0, 310, 0),
			[3] = Angle(0, 80, 0),
            [4] = Angle(0, 270, 0),
			[5] = Angle(0, -90, 0)
        },
		
        ["checkpoint_functions"] = {
            [1] = function()
                ents.FindByClass("npc_alyx")[1]:SetPos(Vector(-164,12286,5312))
            end,

            [5] = function()
				timer.Simple(0.1, function()
                    local lift = ents.FindByName("Train_lift_coreexit")[1]
                    for l, spawn in pairs(ents.FindByClass("info_player_start")) do
                        spawn:SetPos(lift:GetPos() + Vector(0, 0, 75))
                        spawn:SetParent(lift)
                    end
                end)
            end,
        },


		--CHECKPOINT_FUNC_3 = function()
		--	if not pacifistAchGlobal then return end
		--	
		--	for _, v in ipairs(player.GetAll()) do	
		--		v:GrantAchievement("Pacifist")
		--	end
		--end
    },

    ["ep1_citadel_04"] = {
        ["changelevels"] = {
            [1] = Vector(4155, 8194, 3326),
            [2] = Vector(4015, 8150, 3454)
        },

        ["checkpoints"] = {
            [1] = {
                [1] = Vector(3249, 11813, 3766),
                [2] = Vector(3453, 11886, 3601)
            },

            [2] = {
                [1] = Vector(3449, -92, 3450),
                [2] = Vector(3570, -238, 3558)
            },

            [3] = {
                [1] = Vector(3696, 8017, 3579),
                [2] = Vector(3821, 7877, 3695)
            }
        },

        ["checkpoint_functions"] = {
            [1] = function()
                ents.FindByClass("npc_alyx")[1]:SetPos(Vector(3318, 11846, 3605))
            end
        },

        ["checkpoint_spot"] = {
            [1] = Vector(3387, 11756, 3618),
            [2] = Vector(3530, -172, 3449),
            [3] = Vector(3772, 7959, 3602)
        },
		
		["checkpoint_angle"] = {
            [1] = Angle(0, 270, 0),
            [2] = Angle(0, 0, 0),
			[3] = Angle(0, 0, 0)
        },
    },

    ["ep1_c17_00"] = {
        ["changelevels"] = {
            [1] = Vector(1776, 143, 456),
            [2] = Vector(1902, 64, 332)
        },

        ["checkpoints"] = {
            [1] = {
                [1] = Vector(4154, -2670, 10),
                [2] = Vector(4269, -2935, -121)
            }
        },

        ["checkpoint_spot"] = {
            [1] = Vector(4213, -2862, -111)
        },
		
		["checkpoint_angle"] = {
            [1] = Angle(0, 120, 0)
       },
    },
    		
    ["ep1_c17_00a"] = {
        ["changelevels"] = {
            [1] = Vector(4517, 3635, 1898),
            [2] = Vector(4667, 3522, 1668)
        },

        ["checkpoints"] = {
            [1] = {
                [1] = Vector(2669, 3871, 536),
                [2] = Vector(2811, 4114, 410)
            },

            [2] = {
                [1] = Vector(4666, 3642, 664),
                [2] = Vector(4522, 3521, 822)
            }
        },

        ["checkpoint_spot"] = {
            [1] = Vector(4326, 3589, 420),
            [2] = Vector(4586, 3580, 712)
        },
		
		["checkpoint_angle"] = {
            [1] = Angle(0, 150, 0),
            [2] = Angle(0, 180, 0)
        },
    },
	
    ["ep1_c17_01"] = {
        ["changelevels"] = {
            [1] = Vector(-3615, 207, 122),
            [2] = Vector(-3693, 269, 1)
        },

        ["checkpoints"] = {
            [1] = {
                [1] = Vector(2817, -1427, 109),
                [2] = Vector(2893, -1305, 3)
            },

            [2] = {
                [1] = Vector(1823, 2185, 97),
                [2] = Vector(1918, 2278, 254)
            },

            [3] = {
                [1] = Vector(-577, 760, 1),
                [2] = Vector(-641, 852, 127)
            }
        },

        ["checkpoint_spot"] = {
            [1] = Vector(2633, -1311, 12),
            [2] = Vector(1825, 2231, 115),
			[3] = Vector(-604, 813, 13)
        },
		
		["checkpoint_angle"] = {
            [1] = Angle(0, 150, 0),
            [2] = Angle(0, 180, 0),
			[3] = Angle(0, 90, 0)
        },
    },
	
    ["ep1_c17_02"] = {
        ["changelevels"] = {
            [1] = Vector(-2480, 2208, -23),
            [2] = Vector(-2455, 2286, -125)
        },

        ["checkpoints"] = {
            [1] = {
                [1] = Vector(1105, -273, 134),
                [2] = Vector(1012, -162, 17)
            },

            [2] = {
                [1] = Vector(-1096, 1606, 78), 
                [2] = Vector(-903, 1684, -2)
            }
        },

        ["checkpoint_spot"] = {
            [1] = Vector(1057, -212, 32),
            [2] = Vector(-1008, 1758, 4)
        },
		
		["checkpoint_angle"] = {
            [1] = Angle(0, 270, 0),
            [2] = Angle(0, 90, 0)
        },
    },

    ["ep1_c17_02b"] = {
        ["changelevels"] = {
            [1] = Vector(-718, 3997, 511),
            [2] = Vector(-465, 4243, 320)
        },

        ["checkpoints"] = {
            [1] = {
                [1] = Vector(1089, 1972, -254),
                [2] = Vector(1216, 1940, -135)
            },

            [2] = {
                [1] = Vector(1403, 1817, 129),
                [2] = Vector(1354, 1954, 248)
            }
        },

        ["checkpoint_spot"] = {
            [1] = Vector(1152, 1944, -244),
            [2] = Vector(1214, 1893, 142)
        },
		
		["checkpoint_angle"] = {
            [1] = Angle(0, 130, 0),
            [2] = Angle(0, 160, 0)
        },
    },

    ["ep1_c17_02a"] = {
        ["changelevels"] = {
            [1] = Vector(-2793, 8209, -2689),
            [2] = Vector(-2608, 8249, -2832)
        },

        ["checkpoints"] = {
            [1] = {
                [1] = Vector(944, 8684, -2431),
                [2] = Vector(1184, 8749, -2562)
            },

            [2] = {
                [1] = Vector(-658, 9533, -2681),
                [2] = Vector(-673, 9591, -2577)
            }
        },

        ["checkpoint_functions"] = {
            [1] = function()
                for _, v in ipairs(player.GetAll()) do
                    v:SetPos(Vector(1115, 8892, -2544))
                end
            end
        },

        ["checkpoint_spot"] = {
            [1] = Vector(1115, 8892, -2544),
            [2] = Vector(-690, 9561, -2688)
        },
		
		["checkpoint_angle"] = {
            [1] = Angle(0, 180, 0),
            [2] = Angle(0, 70, 0)
        },
    },

    ["ep1_c17_06"] = {
        ["changelevels"] = {
            [1] = Vector(-12764, -5814, -954),
            [2] = Vector(-13259, -5632, -528)
        },

        ["checkpoints"] = {
            [1] = {
                [1] = Vector(12213,9391,-622),
                [2] = Vector(12374,9683,-778)
            },
            [2] = {
                [1] = Vector(10028,8289,-736),
                [2] = Vector(10612,8059,-646)
            },

            [3] = {
                [1] = Vector(11839, 8328, -658),
                [2] = Vector(11894, 8428, -758)
            }
        },

        ["changelevel_func"] = --{
            --[1] = function()
			function(ply)
                for _, v in ipairs(player.GetAll()) do
                    v:SetPos(Vector(1115, 8892, -2544))
                end
            end
        --}
		,

        ["checkpoint_spot"] = {
			[1] = Vector(12318,9549,-700),
            [2] = Vector(9963,8285,-736),
            [3] = Vector(11460, 8355, -613)
        },		
		
		["checkpoint_angle"] = {
            [1] = Angle(0, 90, 0),
			[2] = Angle(0, 320, 0),
            [3] = Angle(0, 0, 0)
        }
    }
    
}

local function SetEP1Checkpoints()
    for _, c in pairs(ents.FindByClass("trigger_changelevel")) do
        c:Remove()
    end

    //If this map doesn't have support, throw a message and stop here
    if not ep1_triggers[game.GetMap()] then
        print(MsgC(Color(255, 0, 0), "HL2 CO-OP RPG ERROR - MAP IS NOT SUPPORTED"))
        return
    end

    if ep1_triggers[game.GetMap()]["checkpoints"] then
        for i, t in ipairs(ep1_triggers[game.GetMap()]["checkpoints"]) do
		
			local Tspot = Vector(ep1_triggers[game.GetMap()]["checkpoint_spot"][i])
			local Tangle = Angle(ep1_triggers[game.GetMap()]["checkpoint_angle"][i]) or nil
			local Tfunc = nil
			if ep1_triggers[game.GetMap()]["checkpoint_functions"] then Tfunc = ep1_triggers[game.GetMap()]["checkpoint_functions"][i] end
			CreateCheckpoint(Vector(t[1]),Vector(t[2]),Tspot,Tangle,Tfunc)	
	
            --local checkpoint = ents.Create("trigger_checkpoint")
            --checkpoint.Min = Vector(t[1])
            --checkpoint.Max = Vector(t[2])
            --checkpoint.Pos = Vector(t[2]) - ( Vector(t[1]) - Vector(t[1])) / 2
            --checkpoint.TPPoint = Vector(ep1_triggers[game.GetMap()]["checkpoint_spot"][i])
			--if ep1_triggers[game.GetMap()]["checkpoint_angle"] then checkpoint.TPAngles = Angle(ep1_triggers[game.GetMap()]["checkpoint_angle"][i]) or checkpoint.TPAngles end	--default to 0,0,0
            --checkpoint.PointIndex = i
            --checkpoint:SetPos(checkpoint.Pos)
            --checkpoint:Spawn()
            
            --checkpoint.lambdaModel = ents.Create("prop_dynamic")
            --checkpoint.lambdaModel:SetModel("models/hl2cr_lambda.mdl")
            --checkpoint.lambdaModel:SetPos( checkpoint.TPPoint + Vector(0, 0, 75))
            --checkpoint.lambdaModel:Spawn()
            --checkpoint.lambdaModel:ResetSequence("idle")
            --checkpoint.lambdaModel:SetMaterial(checkpoint.Mat)

            --if ep1_triggers[game.GetMap()]["checkpoint_functions"] then
            --    checkpoint.Func = ep1_triggers[game.GetMap()]["checkpoint_functions"][i]
            --end
        end
    end

    if ep1_triggers[game.GetMap()]["changelevels"] and game.GetGlobalState("hl2cr_extendedmap") == GLOBAL_DEAD then
	
		local Tfunc = ep1_triggers[game.GetMap()]["changelevel_func"] or nil
		local TVecs = ep1_triggers[game.GetMap()]["changelevels"]
		CreateLevelChange(Vector(TVecs[1]),Vector(TVecs[2]),Tfunc)	
	
        --local changelevel = ents.Create("trigger_changemap")
        --changelevel.Min = Vector(ep1_triggers[game.GetMap()]["changelevels"][1])
        --changelevel.Max = Vector(ep1_triggers[game.GetMap()]["changelevels"][2])
        --changelevel.Pos = Vector(ep1_triggers[game.GetMap()]["changelevels"][2]) - 
        --( ( Vector(ep1_triggers[game.GetMap()]["changelevels"][2]) - Vector(ep1_triggers[game.GetMap()]["changelevels"][1])) / 2 )
        
        --changelevel:SetPos(changelevel.Pos)
        --changelevel:Spawn()

        --changelevel.lambdaModel = ents.Create("prop_dynamic")
        --changelevel.lambdaModel:SetModel("models/hl2cr_lambda.mdl")
        --changelevel.lambdaModel:SetPos(changelevel.Pos)
        --changelevel.lambdaModel:Spawn()
        --changelevel.lambdaModel:ResetSequence("idle")
        --changelevel.lambdaModel:SetMaterial("phoenix_storms/wire/pcb_green")

        --if ep1_triggers[game.GetMap()]["changelevel_func"] then
        --    changelevel.Func = ep1_triggers[game.GetMap()]["changelevel_func"][1]
        --end
    end
end

local function SetUpMisc()
    
    local MapLua = ents.Create("lua_run")
	MapLua:SetName("hl2crlua")
	MapLua:Spawn()

    if EP1_WEAPONS[game.GetMap()] then
		for i, wep in pairs(EP1_WEAPONS[game.GetMap()]) do 
			table.insert(SPAWNING_WEAPONS, wep)
		end
	end
	
	if EP1_EQUIPMENT[game.GetMap()] then
		table.insert(SPAWNING_ITEMS, EP1_EQUIPMENT[game.GetMap()])
	end

    if game.GetMap() == "ep1_citadel_00" then        
        --ss_DogIntro
		ents.FindByName("lcs_ep1_intro_01")[1]:Fire("AddOutput", "OnTrigger1 hl2crlua:RunPassedCode:EP1_FixGordenStart()" )
	
		ents.FindByName("lcs_ep1_intro_04b")[1]:Fire("AddOutput", "OnTrigger1 pclip_gunship_2 Disable",7 )
	
		ents.FindByName("relay_givegravgun_1")[1]:Fire("AddOutput", "OnTrigger hl2crlua:RunPassedCode:EP1_GiveGravgunEP1()" )
		ents.FindByName("ss_dog_climb")[1]:Fire("AddOutput", "OnEndSequence hl2crlua:RunPassedCode:EP1_FixDog00part1()")
		ents.FindByName("ss_alyx_climb")[1]:Fire("AddOutput", "OnEndSequence hl2crlua:RunPassedCode:EP1_FixAlyx00()")
		ents.FindByName("relay_Van_crash_gate_1")[1]:Fire("AddOutput", "OnTrigger hl2crlua:RunPassedCode:EP1_FixDog00part2()")
		
        timer.Simple(1, function()
            for _, fall in ipairs(ents.FindByName("trigger_falldeath")) do
                fall:Remove()
            end
		end)
			--if veh:GetName() ==  "vehicle_blackout" then return true end --ep1 fix
	end

    if game.GetMap() == "ep1_citadel_01" then
		ents.FindByName("logic_alyx_EMP_5")[1]:Fire("AddOutput", "OnTrigger hl2crlua:RunPassedCode:EP1_FixBrushWall()")
	end

    if game.GetMap() == "ep1_citadel_02" then
		game.SetGlobalState("super_phys_gun", 1)
	end

    if game.GetMap() == "ep1_citadel_02b" then
		ents.FindByName("impact_trigger")[1]:Fire("AddOutput", "OnTrigger hl2crlua:RunPassedCode:FailedMap()")
		
		for k, spawn in ipairs(ents.FindByClass("info_player_start")) do 
			if k ~= 1 then
				spawn:Remove()
			end
		end
	end

    if game.GetMap() == "ep1_citadel_03" then
		
        --ents.FindByName("trigger_closedoors")[1]:Fire("AddOutput", "OnTrigger hl2crlua:RunPassedCode:FixAlyxCitadel()")

        for k, spawn in ipairs(ents.FindByClass("info_player_start")) do 
			if k ~= 1 then
				spawn:Remove()
			end
		end
		
		pacifistAchGlobal = true
		
		ents.FindByName("trigger_physgunpower")[1]:Fire("AddOutput", "OnTrigger hl2crlua:RunPassedCode:AchAll('Containment')")
		
		for _, failer in ipairs(ents.FindByName("trigger_fall")) do
			failer:Remove()
		end
	end

    if game.GetMap() == "ep1_c17_00" then
		ents.FindByName("lrelay_ZombineIntro_01")[1]:Fire("AddOutput", "OnTrigger hl2crlua:RunPassedCode:EP1_FixZombineTrain():")
	end
	
	if game.GetMap() == "ep1_c17_02" then
		ents.FindByName("timer_give_guard_health")[1]:Remove()
	end	
	
	if game.GetMap() == "ep1_c17_02a" then
        timer.Simple(2, function()
            ents.FindByName("gunship_showdown")[1]:Fire("AddOutput", "OnDeath hl2crlua:RunPassedCode:AchAll('Attica')")		--Need tp readd achievement
        end)
	end
	
	if game.GetMap() == "ep1_c17_05" then
		ents.FindByName("trigger_citizen_boardtrain")[1]:Fire("Enable")	--this is a brush that makes citizens who make it to the door safe/adds damage filter
		
		--counter_citizens_boardtrain_dryrun -- Counter for first train part
		--counter_citizens_boardtrain-- Counter used for all train parts?
		--ents.FindByName("counter_citizens_boardtrain_dryrun")[1]:Fire("AddOutput", "OnHitMax hl2crlua:RunPassedCode:EP1_FinishMap05()")
		
		--ents.FindByName("lcs_rearsoldierslock")[1]:Fire("AddOutput", "OnCompletion hl2crlua:RunPassedCode:EP1_FinishMap05()")
		
		EP1_SetupMap05()
	end
end

function StartEP1()
	SetEP1Checkpoints()
	SetUpMisc()
end

hook.Add("OnNPCKilled", "HL2CR_PacifistAch", function(npc, attacker, inflictor)
	if game.GetMap() == "ep1_citadel_03" and pacifistAchGlobal then
		if npc:GetClass() == "npc_stalker" and attacker:IsPlayer() then
			pacifistAchGlobal = false

			BroadcastMessageToAll(HL2CR_PlayerColour, attacker:Nick(), HL2CR_RedColour, translate.Get("Failed_EP1_Pacifist"))
		end
	end
end)

function EP1_FinishMap05()
	for _, v in ipairs(player.GetAll()) do
		v:SetTeam(TEAM_COMPLETED_MAP)
		v:DisplayResults()
	end
	
	StartMapCountdown()
	--net.Start("HL2CR_MapCountdown")
	--net.Broadcast()
end

function EP1_FixBrushWall()
	ents.FindByName("clip_combineshieldwall6")[1]:Fire("Disable")
end

function EP1_FixGordenStart()
	timer.Simple(24, function()
		ents.FindByName("vehicle_blackout")[1]:Remove()
	end)
end

function EP1_FixDog00part1()
	ents.FindByClass("npc_dog")[1]:SetPos(Vector(-8646, 5986, -61))
end

function EP1_FixDog00part2()
	timer.Simple(9, function()
		ents.FindByClass("npc_dog")[1]:SetPos(Vector(-6464, 6196, -89))
	end)
end

function EP1_FixAlyx00()
	ents.FindByClass("npc_alyx")[1]:SetPos(Vector(-8646, 5986, -61))
end

function EP1_GiveGravgunEP1()
	for k, v in ipairs(player.GetAll()) do
		v:Give("weapon_physcannon")
	end
end

function EP1_FixZombineTrain()
	timer.Simple(3, function()
        ents.FindByName("train_2_ambush_zombine")[1]:Fire("Kill")
		ents.FindByName("brush_combine_train_door")[1]:Remove()
	end)
end

function AchAll(achName)
	for _, v in ipairs(player.GetAll()) do	
		v:GrantAchievement("EP1", achName)
	end
end

function EP1_SetupMap05()

	ents.FindByName("assaultpoint_barney_lasttrain")[1]:Fire("AddOutput", "OnArrival hl2crlua:RunPassedCode:EP1_FinishMap05()")
	ents.FindByName("assaultpoint_standoff_barney")[1]:Fire("AddOutput", "OnArrival hl2crlua:RunPassedCode:EP1_BarneyStandoff()")

	CreateCustomTrigger(Vector(8699,9599,-696),Vector(8945,9393,-792), function(ent)
		if ent.squaded  and not ent.ReachedEnd then
			ent.ReachedEnd = true
			EP1_TrainCitSucess()
			BroadcastMessageToAll(HL2CR_GreenColour, train_sucess.. translate.Get("Achievement_EP1_Train_Saved"))
			return true	--Custom trigger needs to be true on valid so it knows if trigger was valid
		end
		return false	--Custome trigger returns false if trigger wasnt valid
	end,0.2,false)

	if timer.Exists( "HL2CR_CitizenFollow05" ) then timer.Remove( "HL2CR_CitizenFollow05" ) end	
	timer.Create( "HL2CR_CitizenFollow05", 0.5, 0, function() 
		local positions = {}	--creating list of alive player positions
		for i, v in ipairs( player.GetAll() ) do	
			if v:Alive() then
				table.insert( positions, v:GetPos() )
			end
		end
	
		for _, cit in ipairs(ents.FindByClass("npc_citizen")) do
			if !IsValid(cit) or not string.find(cit:GetName(), "citizen_refugees_") then continue end

			if cit.ReachedEnd then continue end
			
			if cit:GetSquad() == "player_squad" then 
				cit.squaded = true
			else
				if cit.squaded then 
					if cit:Health() <= 0 then
						--EP1_TrainCitSucess()
						--BroadcastMessageToAll(HL2CR_GreenColour, train_sucess.. translate.Get("Achievement_EP1_Train_Saved"))
					--else
						BroadcastMessageToAll(HL2CR_RedColour, translate.Get("Achievement_EP1_Train_Lost"))
					end
					
					--cit.ReachedEnd = true
					continue 
				end
				
			end

			if not cit:IsCurrentSchedule(SCHED_FORCED_GO_RUN) then
				local target = nil
				local distance = 500
				local citpos = cit:GetPos()
				
				
				for i, v in ipairs( positions ) do	
					local toplayer = citpos:Distance(v)
					if toplayer > 50 and toplayer < distance then
						target = v
						distance = toplayer
					end
				end
				
				if IsValid(target) then
					cit:SetLastPosition( target )
					cit:SetSchedule(SCHED_FORCED_GO_RUN)
				end
			end

			--if (cit:GetPos():Distance(player.GetAll()[1]:GetPos()) > 50 and cit:GetPos():Distance(player.GetAll()[1]:GetPos()) <= 500) and not cit:IsCurrentSchedule(SCHED_FORCED_GO_RUN) then
			--	cit:SetLastPosition( player.GetAll()[1]:GetPos() )
			--	cit:SetSchedule(SCHED_FORCED_GO_RUN)
			--end
		end

	end)
	
	local AddAmmoCrate = ents.Create("item_ammo_crate")
	AddAmmoCrate:SetPos(Vector(8907, 9578, -752))
	AddAmmoCrate:SetAngles(Angle(0, 180, 0))
	AddAmmoCrate:SetKeyValue( "ammotype", 1 )
	AddAmmoCrate:Spawn()
	
	train_sucess = 0
end

function EP1_TrainCitSucess()
	train_sucess = train_sucess + 1
	
	if train_sucess == 14 then
		ents.FindByName("relay_barney_head_for_train")[1]:Fire("trigger")
	end
	
end

function EP1_BarneyStandoff()
	timer.Simple(25, function()
		local trigger = ents.FindByName("relay_al_ba_retreat")
		if IsValid(trigger[1]) then
			trigger[1]:Fire("enable")
			trigger[1]:Fire("trigger")
		end
	end)
end
