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

JALOPY_MAPS = {
	["ep2_outland_06a"] = true,
	["ep2_outland_07"] = true,
	["ep2_outland_08"] = true,
	--09 starts without it and enabled by doing event
	["ep2_outland_10"] = true,
	["ep2_outland_10a"] = true,
}

local ep2_triggers = {
    ["ep2_outland_01"] = {
        ["checkpoints"] = {
            [1] = {
                [1] = Vector(220, -1090, 37), 		
                [2] = Vector(390, -490, 180)
            },
			[2] = {
                [1] = Vector(-2830, -890, 230), 		
                [2] = Vector(-2610, -650, 300)
            },
			[3] = {
                [1] = Vector(-3810, 1580, 130), 		
                [2] = Vector(-3575, 1720, 200)
            },
			[4] = {
                [1] = Vector(-5760, 4440, -110), 		
                [2] = Vector(-5530, 4610, -80)
            }
        },
        
        ["checkpoint_spot"] = {
            [1] = Vector(340, -790, 30),
			[2] = Vector(-2800, -740, 240),
			[3] = Vector(-3615, 1660, 150),
			[4] = Vector(-5530, 4560, -110)
        },
		
		["checkpoint_angle"] = {
			[1] = Angle(0, 200, 0),
			[2] = Angle(0, 180, 0),
			[3] = Angle(0, 120, 0),
			[4] = Angle(0, 230, 0)
		},
        
        ["changelevels"] = {
            [1] = Vector(-6480, 3620, -1420),
            [2] = Vector(-6020, 3690, -1220)
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
                [1] = Vector(-480, -9780, -730), 		
                [2] = Vector(-280, -9390, -590)
            }
        },
        
        ["checkpoint_spot"] = {
			[1] = Vector(-410, -9620, -700)
        },
		
		["checkpoint_angle"] = {
			[1] = Angle(0, 330, 0)
		},
        
		
        ["changelevels"] = {
			[1] = Vector(-960, -10300, -500),
            [2] = Vector(-820, -10200, -380)
        },
		
		["changelevels_special"] = {
            [1] = Vector(-4180, -10130, 180),
            [2] = Vector(-3880, -9870, 250)
        }

    }, 
	
	["ep2_outland_03"] = {
        ["checkpoints"] = {
            [1] = {
                [1] = Vector(800, -4400, -950), 		
                [2] = Vector(1080, -4100, -820)
            },
			[2] = {
                [1] = Vector(950, -8510, -1830), 		
                [2] = Vector(1750, -7950, -1730)
            },
			[3] = {
                [1] = Vector(3460, -9510, -550), 		
                [2] = Vector(3770, -9460, -460)
            }
        },
        
        ["checkpoint_spot"] = {
            [1] = Vector(940, -4310, -920),
			[2] = Vector(1480, -8200, -1770),
			[3] = Vector(3620, -9450, -500)
        },
		
		["checkpoint_angle"] = {
			[1] = Angle(0, 210, 0),
			[2] = Angle(0, 270, 0),
			[3] = Angle(0, 45, 0)
		},
        
		["checkpoint_functions"] = {
            [2] = function()
				ents.FindByClass("npc_vortigaunt")[1]:SetPos(Vector(1251,-7358,-1664))
			end,
        },
		
        ["changelevels"] = {
			[1] = Vector(4950, -7520, -520),
            [2] = Vector(5250, -7240, -200)
        },
		
		["pushers"] = {
            [1] = {	--Prevent skipping
                [1] = Vector(1528,-5794,-1877),
                [2] = Vector(2141,-5997,-902)
            }
        },

        ["pusher_spot"] = {
            [1] = Vector(1603,-5114,-960)
        },
    }, 
	
	--Hunting the antlion--A lot of no return clips
	["ep2_outland_04"] = {
        ["checkpoints"] = {	
            [1] = {
                [1] = Vector(5600, -2520, -1240), 		
                [2] = Vector(5830, -1930, -1140)
            },
			[2] = {
                [1] = Vector(5105,-2809,-2220), 		
                [2] = Vector(5582,-2663,-2352)
            }
        },
        
        ["checkpoint_spot"] = {
			[1] = Vector(5800, -2320, -1200),
            [2] = Vector(5374,-2653,-2289)
        },
		
		["checkpoint_angle"] = {
			[1] = Angle(0, 260, 0),
			[2] = Angle(0, 90, 0)
		},
		
		["checkpoint_functions"] = {
            [2] = function()	--Removed anti skip trigger
                timer.Simple(0.1, function()
                    RemovePushTrigger()
                end)
			end,
        },
		
		["pushers"] = {
            [1] = {	--Prevent skipping
                [1] = Vector(4780, -1900, -20),
                [2] = Vector(5210, -1400, -80)
            }
        },

        ["pusher_spot"] = {
            [1] = Vector(4770, -1280, 385)
        },
        
        ["changelevels"] = {
			[1] = Vector(4790, -1840, 1500),
            [2] = Vector(5100, -1400, 3200)
        },
		
		["changelevel_func"] = --{	--For those who miss the lift back up
            --[1] = function(ply)
			function(ply)
                for k, v in ipairs(player.GetAll()) do
                    v:SetPos(Vector(5000, -1600, 1750))
                end
            end
        --}
    }, 

	["ep2_outland_05"] = {	--Antlions fight quick map
        ["changelevels"] = {
            [1] = Vector(2000, 6100, 540),
            [2] = Vector(2130, 6410, 750)
        },
    }, 

    ["ep2_outland_06"] = {	--Giant Bridge
        ["checkpoints"] = {
            [1] = {
                [1] = Vector(400, 350, 370), 		
                [2] = Vector(760, 730, 440)
            },
			[2] = {
                [1] = Vector(260, 2040, 30), 		
                [2] = Vector(580, 2460, 70)
            },
			[3] = {
                [1] = Vector(1260, 2730, -270), 		
                [2] = Vector(960, 2900, -170)
            },
			[4] = {
                [1] = Vector(2930, 1060, 190), 		
                [2] = Vector(3120, 1400, 220)
            },
			[5] = {
                [1] = Vector(-320, 1290, 810), 		
                [2] = Vector(-510, 1420, 880)
            }
        },
        
        ["checkpoint_spot"] = {
            [1] = Vector(510, 640, 380),
			[2] = Vector(385, 2165, 0),
			[3] = Vector(1060, 2840, -240),
			[4] = Vector(2940, 1050, 195),
			[5] = Vector(-550, 1350, 840)
        },
		
		["checkpoint_angle"] = {
			[1] = Angle(0, 270, 0),
			[2] = Angle(0, 90, 0),
			[3] = Angle(0, 270, 0),
			[4] = Angle(0, 340, 0),
			[5] = Angle(0, 0, 0)
		},
		
		["checkpoint_functions"] = {
            [5] = function()	--Force car position, alyx does not care for other peoples jeeps
                timer.Simple(0.1, function()
                    local jeep = ents.FindByClass("prop_vehicle_jeep")[1]
					jeep:SetPos(Vector(-170, 2310, 690))
					jeep:SetAngles(Angle(0, 90, 0))
                end)
			end,
        },
        
        ["changelevels"] = {
            [1] = Vector(-3380, 2080, 640),
            [2] = Vector(-2730, 2630, 850)
        },
		
		["pushers"] = {
            [1] = {	--Dont let people jump off the edge at start
                [1] = Vector(70, 900, 740),
                [2] = Vector(320, 1500, 820)
            },
			[2] = {	--Dont let people jump off the edge at start
                [1] = Vector(250, 1460, 740),
                [2] = Vector(350, 760, 1400)
            }
        },

        ["pusher_spot"] = {
            [1] = Vector(-160, 1280, 840),
			[2] = Vector(-160, 1280, 840)
        }
    }, 
	
	["ep2_outland_06a"] = {
        ["changelevels"] = {
            [1] = Vector(2000, 6100, 540),
            [2] = Vector(2130, 6410, 750)
        },
		
		["checkpoints"] = {
			[1] = {
                [1] = Vector(-3260, -9980, -1540), 		
                [2] = Vector(-3060, -9630, -1460)
            }
        },
        
        ["checkpoint_spot"] = {
			[1] = Vector(-3100, -9720, -1520)
        },
		
		["checkpoint_angle"] = {
			[1] = Angle(0, 180, 0)
		},
		
		["checkpoint_functions"] = {
            [1] = function()	--Force car position just incase
                timer.Simple(0.1, function()
                    local jeep = ents.FindByClass("prop_vehicle_jeep")[1]
					jeep:SetPos(Vector(-2850, -8400, -1540))
					jeep:SetAngles(Angle(0, 90, 0))
					GAMEMODE:DisableVehicles(true)
					--for _, v in ipairs(player.GetAll()) do
					--	GAMEMODE:RemoveVehicle(v)
					--end
                end)
			end,
        },
		
		["changelevels"] = {
            [1] = Vector(-10080, -4400, -2500),
            [2] = Vector(-9800, -3400, -1810)
        },
    }, 
	
	["ep2_outland_07"] = {	--Advisor Attack
		["checkpoints"] = {
			[1] = {
				[1] = Vector(-12190, -11100, 150),
				[2] = Vector(-7780, -10600, 540)
            },
			[2] = {
				[1] = Vector(-10087,-9241,65),
				[2] = Vector(-9274,-9956,20)
            }
        },
        
        ["checkpoint_spot"] = {
			[1] = Vector(-10070, -11590, 150),
			[2] = Vector(-9986, -9296, 34)
        },
		
		["checkpoint_angle"] = {
			[1] = Angle(0, 60, 0),
			[2] = Angle(0, 240, 0)
		},
		
		["checkpoint_functions"] = {
            [1] = function()
                --timer.Simple(0.1, function()
					GAMEMODE:DisableVehicles(true)
                --end)
			end,
        },
		
		["changelevels"] = {
            [1] = Vector(-4560, 10860, -40),
            [2] = Vector(-3100, 10950, 360)
        },	

    }, 

	["ep2_outland_08"] = {	--Roller Mine HeliBoss
        ["checkpoints"] = {	
            [1] = {
                [1] = Vector(-330, 1100, 0), 		
                [2] = Vector(-850, 1440, 290)
            },
			[2] = {
                [1] = Vector(-1430, 1000, 50), 		
                [2] = Vector(-1350, 1160, 110)
            },
			[3] = {
                [1] = Vector(-3050, 1870, 60), 		
                [2] = Vector(-2950, 2050, 140)
            }
        },
        
        ["checkpoint_spot"] = {
			[1] = Vector(-440, 1120, 60),
            [2] = Vector(-1365, 1080, 65),
			[3] = Vector(-2930, 1990, 75)
        },
		
		["checkpoint_angle"] = {
			[1] = Angle(0, 90, 0),
			[2] = Angle(0, 180, 0),
			[3] = Angle(0, 180, 0)
		},
		
		["checkpoint_functions"] = {
            [1] = function()
				GAMEMODE:DisableVehicles(true)
			end,
        },
		
        ["changelevels"] = {
			[1] = Vector(-3270, 1850, 70),
            [2] = Vector(-3180, 2060, 180)
        }
    }, 
	
	["ep2_outland_09"] = {	--JunkYard Combine Turret Funtime
        ["checkpoints"] = {	
            [1] = {
                [1] = Vector(330, -9270, 50), 		
                [2] = Vector(620, -9140, 100)
            },
			[2] = {
                [1] = Vector(-1100, -7520, 60), 		
                [2] = Vector(90, -7290, 320)
            },
			[3] = {
                [1] = Vector(-3050, 1870, 60), 		
                [2] = Vector(-2950, 2050, 140)
            }
        },
        
        ["checkpoint_spot"] = {
			[1] = Vector(620, -9170, 80),
            [2] = Vector(-180, -7520, 70),
			[3] = Vector(-2930, 1990, 75)
        },
		
		["checkpoint_angle"] = {
			[1] = Angle(0, 240, 0),
			[2] = Angle(0, 100, 0),
			[3] = Angle(0, 180, 0)
		},
		
		["pushers"] = {
            [1] = {	--Dont let people skip turret event
                [1] = Vector(-2500, -9170, 20),
                [2] = Vector(-1580, -7500, 500)
            }
        },

        ["pusher_spot"] = {
            [1] = Vector(-940, -9990, 80)
        },
		
        ["changelevels"] = {
			[1] = Vector(3100, 7400, 90),
            [2] = Vector(3540, 7600, 450)
        }
    }, 
	
	["ep2_outland_10"] = {	--Ambush
        ["checkpoints"] = {	
            [1] = {
                [1] = Vector(3310, -500, -160), 		
                [2] = Vector(3650, -290, 0)
            },
			[2] = {
                [1] = Vector(630, -2650, 134), 		
                [2] = Vector(750, -2248, 264)
            },
			[3] = {
                [1] = Vector(-3050, 1870, 60), 		
                [2] = Vector(-2950, 2050, 140)
            }
        },
        
        ["checkpoint_spot"] = {
			[1] = Vector(3243,-313,-120),
            [2] = Vector(790, -2440, 170),
			[3] = Vector(-2930, 1990, 75)
        },
		
		["checkpoint_angle"] = {
			[1] = Angle(0, 220, 0),
			[2] = Angle(0, 130, 0),
			[3] = Angle(0, 180, 0)
		},
		
		["checkpoint_functions"] = {
            [1] = function()
				GAMEMODE:DisableVehicles(true)
				--ents.FindByClass("npc_alyx")[1]:SetPos(Vector(3162,-891,-100))
			end,
			[2] = function()
				CreateCheckpoint(Vector(1184,-2665,314),Vector(1217,-2132,76),Vector(1091,-2507,150),Angle(0,50,0),
						function()
							GAMEMODE:DisableVehicles(false)
						end
					)
			end,
        },
		
        ["changelevels"] = {
			[1] = Vector(6195,8192,-1260),
            [2] = Vector(6031,7764,-1515)
        }
    }, 
	
	["ep2_outland_10a"] = {	--White Forest
	    ["checkpoints"] = {	
            [1] = {
                [1] = Vector(2670,-1502,-1715), 		
                [2] = Vector(1756,-1401,-2027)
            },
			[2] = {
                [1] = Vector(3692,10601,429), 		
                [2] = Vector(3800,8205,12)
            }
        },
        
        ["checkpoint_spot"] = {
			[1] = Vector(1955,-1641,-1910),
            [2] = Vector(3503,10037,200)
        },
		
		["checkpoint_angle"] = {
			[1] = Angle(0,50,0),
			[2] = Angle(0,-60,0)
		},
	
        ["changelevels"] = {
            [1] = Vector(5032,10910,360),
            [2] = Vector(4860,10986,180)
        },
    }, 
	
	["ep2_outland_11"] = {	--White Forest Inside
	    ["checkpoints"] = {	
            [1] = {
                [1] = Vector(-117,-10561,145), 		
                [2] = Vector(14,-10158,64)
            },
			[2] = {
                [1] = Vector(1471,-10022,-244), 		
                [2] = Vector(1584,-9787,-356)
            },
			[3] = {
                [1] = Vector(1522,-10075,-1408), 		
                [2] = Vector(1256,-9824,-1302)
            }
        },
        
        ["checkpoint_spot"] = {
			[1] = Vector(-10,-10601,64),
            [2] = Vector(1573,-10019,-318),
			[3] = Vector(1332,-9936,-1233)
        },
		
		["checkpoint_angle"] = {
			[1] = Angle(0,90,0),
			[2] = Angle(0,-50,0),
			[3] = Angle(0,-15,0)
		},
	
        ["changelevels"] = {
            [1] = Vector(1702,-9200,-1300),
            [2] = Vector(1626,-9000,-1400)
        },
    }, 
	
	["ep2_outland_11a"] = {	--White Forest Silo
	    ["checkpoints"] = {	
            [1] = {
                [1] = Vector(1024,-9220,-1536), 		
                [2] = Vector(941,-9402,-1457)
            },
			[2] = {
                [1] = Vector(2061,-10746,-1074), 		
                [2] = Vector(2176,-10349,-1126)
            },
			[3] = {
                [1] = Vector(1522,-10075,-1408), 		
                [2] = Vector(1256,-9824,-1302)
            }
        },
        
        ["checkpoint_spot"] = {
			[1] = Vector(988,-9332,-1536),
            [2] = Vector(2093,-10605,-1088),
			[3] = Vector(1332,-9936,-1233)
        },
		
		["checkpoint_angle"] = {
			[1] = Angle(0,-90,0),
			[2] = Angle(0,-70,0),
			[3] = Angle(0,-15,0)
		},
	
        ["changelevels"] = {
            [1] = Vector(283,-11318,184),
            [2] = Vector(86,-11170,51)
        },
    }, 
	
	["ep2_outland_11b"] = {	--White Forest Back inside
	    ["checkpoints"] = {	
            [1] = {
                [1] = Vector(513,-8789,-256), 		
                [2] = Vector(262,-8682,-347)
            },
			[2] = {
                [1] = Vector(-123,-8948,-243), 		
                [2] = Vector(-382,-9238,-338)
            }
        },
        
        ["checkpoint_spot"] = {
			[1] = Vector(299,-8703,-319),
            [2] = Vector(-153,-9039,-339)
        },
		
		["checkpoint_angle"] = {
			[1] = Angle(0,30,0),
			[2] = Angle(0,-150,0)
		},
	
        ["changelevels"] = {
            [1] = Vector(-572,-8907,-159),
            [2] = Vector(-635,-8321,-320)
        },
    }, 

	["ep2_outland_12"] = {	--Strider Assault
	    ["checkpoints"] = {	
            [1] = {
                [1] = Vector(-423,-7115,-148), 		
                [2] = Vector(-969,-6960,-336)
            },
        },
        
        ["checkpoint_spot"] = {
			[1] = Vector(-453,-6779,-288),
        },
		
		["checkpoint_angle"] = {
			[1] = Angle(0,120,0),
		},
	
        ["changelevels"] = {
            [1] = Vector(-572,-8907,-159),
            [2] = Vector(-635,-8321,-320)
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
		
			local Tspot = Vector(ep2_triggers[game.GetMap()]["checkpoint_spot"][i])
			local Tangle = Angle(ep2_triggers[game.GetMap()]["checkpoint_angle"][i]) or nil
			local Tfunc = nil
			if ep2_triggers[game.GetMap()]["checkpoint_functions"] then Tfunc = ep2_triggers[game.GetMap()]["checkpoint_functions"][i] end
			CreateCheckpoint(Vector(t[1]),Vector(t[2]),Tspot,Tangle,Tfunc)	
		
        end
    end

    if ep2_triggers[game.GetMap()]["changelevels"] and game.GetGlobalState("hl2cr_extendedmap") == GLOBAL_DEAD then
		local Tfunc = ep2_triggers[game.GetMap()]["changelevel_func"] or nil
		local TVecs = ep2_triggers[game.GetMap()]["changelevels"]
		CreateLevelChange(Vector(TVecs[1]),Vector(TVecs[2]),Tfunc)	
	
    end
	
	 if ep2_triggers[game.GetMap()]["changelevels_special"] and game.GetGlobalState("hl2cr_extendedmap") == GLOBAL_ON then
		local Tfunc = ep2_triggers[game.GetMap()]["changelevels_special_func"] or nil
		local TVecs = ep2_triggers[game.GetMap()]["changelevels_special"]
		CreateLevelChange(Vector(TVecs[1]),Vector(TVecs[2]),Tfunc)	
	 
    end
	
	--Added pusher functionality
	if ep2_triggers[game.GetMap()]["pushers"] then
        for i, p in ipairs(ep2_triggers[game.GetMap()]["pushers"]) do
			CreatePusher(Vector(p[1]),Vector(p[2]),ep2_triggers[game.GetMap()]["pusher_spot"][i])
        end
    end
end

local gnome_pos = {
    ["ep2_outland_01a"] = Vector(-11550, -6420, 1296),
	["ep2_outland_02"] = Vector(-2050, -8240, -504),
	["ep2_outland_03"] = Vector(-1636, -3938, -888),
	["ep2_outland_04"] = Vector(4532, -1560, 384),
	["ep2_outland_05"] = Vector(-2867, 697, 153),
	["ep2_outland_06"] = Vector(-473, 763, 832),
	["ep2_outland_06a"] = Vector(5190, 20, -2467),
	["ep2_outland_07"] = Vector(-3175, -12284, 546),
	["ep2_outland_08"] = Vector(-12580, -11050, 439),
	["ep2_outland_09"] = Vector(729, -9233, 72),
	["ep2_outland_10"] = Vector(4648, -10616, -1024),
	["ep2_outland_10a"] = Vector(4793,-5961,-1542),
	["ep2_outland_11"] = Vector(-964,-11132,59)
}

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

    if game.GetMap() == "ep2_outland_01" then	--Make sure players get physgun
		ents.FindByName("trigger_Get_physgun")[1]:Fire("AddOutput", "OnTrigger hl2crlua:RunPassedCode:EP2_GiveGravgunEP2()")
	end

    if game.GetMap() == "ep2_outland_02" then
		if game.GetGlobalState("hl2cr_extendedmap") == GLOBAL_ON then	--Return from antlions
			--Find elevator so we can parent spawn to it and for placing vort
			local elevator = ents.FindByName("elevator")[1]
			--for l, spawn in pairs(ents.FindByClass("info_player_start")) do
			--	spawn:SetPos(elevator:GetPos() + Vector(0, 20, -50))
			--	spawn:SetParent(elevator)
			--	spawn:SetAngles(Angle(0, 0, 0))
			--end
			MoveSpawns(Vector(0, 20, -50),Angle(0, 0, 0),elevator)
			
			CreateCheckpoint(Vector(-3410, -9550, 80),Vector(-3250, -9300, 220),Vector(-3420, -9450, 120),Angle(0, 160, 0))
			
			local NewVort = ents.Create("npc_vortigaunt")	--Needs to be spawned in
			NewVort:SetName("Vort")
			NewVort:SetPos(elevator:GetPos() + Vector(0, -20, -50))
			NewVort:Spawn()
		else	--First visit and antlion attack
			ents.FindByName("trigger_turret2_vcd")[1]:Fire("AddOutput", "OnTrigger hl2crlua:RunPassedCode:EP2_SetupAntevent()")
			ents.FindByName("generator_start_relay")[1]:Fire("AddOutput", "OnTrigger hl2crlua:RunPassedCode:EP2_FinishAntevent()")
			
			CreateCheckpoint(Vector(-2690, -9170, -740),Vector(-2290, -8900, -570),Vector(-2480, -9160, -690),Angle(0, 220, 0))
			--CreateCheckpoint(Min,Max,TPos,TAngle,func)
		end
	end

	if game.GetMap() == "ep2_outland_03" then
		RemoveNamedBrushes({"bridge_cave_entry_clip","bucket_tunnel_clip","player_death_trigger"})
	end

    if game.GetMap() == "ep2_outland_04" then
		RemoveNamedBrushes({"_block_player","_clip","_playerblock"})
		
		ents.FindByName("elevator_exit_trigger")[1]:Fire("AddOutput", "OnTrigger hl2crlua:RunPassedCode:EP2_ElevatorSpawn()")
	end

	if game.GetMap() == "ep2_outland_06" then
		ents.FindByName("trigger_goopit3_ladder_up")[1]:Remove()	--Stops a kill trigger activating
		ents.FindByName("trigger_shutExitGate")[1]:Remove()			--Prevents end gate closing
		
	end

    if game.GetMap() == "ep2_outland_06a" then
		ents.FindByName("trigger_useradio")[1]:Fire("AddOutput", "OnTrigger hl2crlua:RunPassedCode:EP2_AlyxRadioTalk()")
	end
	
    if game.GetMap() == "ep2_outland_07" then
		ents.FindByName("alyx_check_end_trigger")[1]:Remove()	--Prevents resets when alyx left behind
		--for l, spawn in pairs(ents.FindByClass("info_player_start")) do
		--	spawn:SetPos(Vector(-3020, -12280, 540))
		--	spawn:SetAngles(Angle(0, 180, 0))
		--end
		
		MoveSpawns(Vector(-3020, -12280, 540),Angle(0, 180, 0))
		
		ents.FindByName("logic_ballgenerator1_disabled")[1]:Fire("AddOutput", "OnTrigger hl2crlua:RunPassedCode:EP2_AdvisorAttack()")
	end
	
    if game.GetMap() == "ep2_outland_08" then
		--for l, spawn in pairs(ents.FindByClass("info_player_start")) do
		--	spawn:SetPos(Vector(-12824, -12848, 450))
		--	spawn:SetAngles(Angle(0, 80, 0))
		--end
		MoveSpawns(Vector(-12824, -12848, 450),Angle(0, 80, 0))
		ents.FindByName("alyx_check_end_trigger")[1]:Remove()	--Prevents resets when alyx left behind
		ents.FindByName("alyx_check_end_trigger1")[1]:Remove()	--Prevents resets when alyx left behind
	end
	
    if game.GetMap() == "ep2_outland_09" then
		--for l, spawn in pairs(ents.FindByClass("info_player_start")) do
		--	spawn:SetPos(Vector(1050, -9190, 75))
		--	spawn:SetAngles(Angle(0, 180, 0))
		--end
		MoveSpawns(Vector(1050, -9190, 75),ngle(0, 180, 0))
		ents.FindByName("alyx_check_end_trigger_0")[1]:Remove()	--Prevents resets when alyx left behind
		
		ents.FindByName("relay.power.off")[1]:Fire("AddOutput", "OnTrigger hl2crlua:RunPassedCode:EP2_TurretsDefeated()")
	end
	
    if game.GetMap() == "ep2_outland_10" then	--ambush
		CreateAmmoCrate(Vector(2838,-650,-112),Angle(0,0,0),4) --Add shotgun ammo to house for convinience
	end

    if game.GetMap() == "ep2_outland_11" then	--white forest inside
		ents.FindByName("door_silo_lab_4")[1]:Remove()
		ents.FindByName("brush_pclip_door_silo_lab_4")[1]:Remove()
		
		
		ents.FindByName("door_garage_fence_1")[1]:Remove()
		ents.FindByName("pclip_fence")[1]:Remove()
	end
	
    if game.GetMap() == "ep2_outland_11b" then	--back inside
		ents.FindByName("magnusson_courtyard_exitdoor")[1]:Remove()
		ents.FindByName("magnusson_courtyard_exitdoor_brush")[1]:Remove()
	end

--door_garage_fence_1/func_brush


    if game.GetGlobalState("hl2cr_bringitem_gnome") == GLOBAL_ON and gnome_pos[game.GetMap()] then
        game.SetGlobalState("hl2cr_bringitem_gnome", GLOBAL_DEAD)
        
        local gnome = ents.Create("prop_physics")
        gnome:SetModel("models/props_junk/gnome.mdl")

		if game.GetGlobalState("hl2cr_extendedmap") == GLOBAL_ON then	--Fix for 2nd visit to outlands 2
			gnome:SetPos(Vector(-3120, -9445, -3070))
			gnome:Spawn()
        else
			gnome:SetPos(gnome_pos[game.GetMap()])
			gnome:Spawn()
			gnome:GetPhysicsObject():Sleep()
		end
    end

    --if removeclip_maps[game.GetMap()] then
    --    local validclips = {
    --        "_block_player",
    --        "_clip",
    --    }
    --    
    --    for _, i in ipairs(ents.FindByClass("func_brush")) do
    --        for _, c in ipairs(validclips) do 
    --            if string.EndsWith(i:GetName(), c) then 
	--				print("removing "..i:GetName())
    --               i:Remove()
    --                break
    --            end
    --        end
    --    end
    --end

end

function StartEP2()
	SetEP2Checkpoints()
	SetUpMisc()
end

function EP2_GiveGravgunEP2()
	for k, v in ipairs(player.GetAll()) do
		v:Give("weapon_physcannon")
	end
end

function EP2_SetupAntevent()
    timer.Simple(40, function()	--Delay for talking and give time to connect
		BroadcastMessageToAll(HL2CR_AchNotifyColour, translate.Get("Achievement_EP2_Antlions"), HL2CR_StandardColour, translate.Get("Achievement_EP2_Antlions_Event"))
		for k, v in ipairs(player.GetAll()) do
			v.NoDeaths = true
		end
	end)
end

function EP2_FinishAntevent()
	for k, v in ipairs(player.GetAll()) do
		if v.NoDeaths then
			v:BroadcastMessage(HL2CR_AchNotifyColour, translate.Get("Achievement_EP2_Antlions"),  HL2CR_StandardColour, " debug yay you did it")
		end
	end
end

function EP2_ElevatorSpawn()
	local elevator = ents.FindByName("elevator")[1]
	MoveSpawns(Vector(0, 20, -52),Angle(0, 0, 0),elevator)
	--for l, spawn in pairs(ents.FindByClass("info_player_start")) do
	--	spawn:SetPos(elevator:GetPos() + Vector(0, 20, -52))
	--	spawn:SetParent(elevator)
	--	spawn:SetAngles(Angle(0, 0, 0))
	--end
end

function EP2_AlyxRadioTalk()
    timer.Simple(60, function()	--Delay for talking
		GAMEMODE:DisableVehicles(false)
	end)
end

function EP2_AdvisorAttack()
    timer.Simple(30, function()	
		ents.FindByName("speedmod_player")[1]:Fire("modifyspeed", "1")	--Give player control back
		ents.FindByName("Advisor_Escape")[1]:Fire("Trigger")	
		
		CreateCheckpoint(Vector(-10050, -10360, 80),Vector(-8570, -10160, 210),Vector(-9200, -10200, 130),Angle(0, 320, 0),
				function()
					GAMEMODE:DisableVehicles(false)
				end
			)
		
	end)
end

function EP2_TurretsDefeated()
	CreateCheckpoint(Vector(380, -9110, 30),Vector(550, -8730, 160),Vector(480, -9060, 75),Angle(0, 75, 0),
			function()
				RemovePushTrigger()
			end
		)
end