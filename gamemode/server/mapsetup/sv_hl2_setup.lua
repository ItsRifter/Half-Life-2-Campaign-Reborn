
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
                [1] = Vector(-8883, -2159, -60),
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
                for _, v in ipairs(player.GetAll()) do	
                    v:GrantAchievement("Malcontent")
                end
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
                [1] = Vector(6181, 4735, -1004), 
                [2] = Vector(6422, 5060, -708)
            },

            [2] = {
                [1] = Vector(5418, 5055, -1021), 
                [2] = Vector(4842, 4698, -755)
            },

            [3] = {
                [1] = Vector(1792, -7423, -929),
                [2] = Vector(1917, -7171, -753)
            }
        },

        ["checkpoint_spot"] = {
            [1] = Vector(6415, 4996, -937),
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

    ["d1_canals_13"] = {
        ["changelevels"] = {
            [1] = Vector(-760, -3764, -225),
            [2] = Vector(-514, -3840, -381)
        }
    },

    ["d1_eli_01"] = {
        ["changelevels"] = {
            [1] = Vector(-681, 1148, -2686),
            [2] = Vector(-511, 1091, -2574)
        },

        ["checkpoints"] = {
            [1] = {
                [1] = Vector(29, 2799, -1277),
                [2] = Vector(-181, 2671, -1154)
            },

            [2] = {
                [1] = Vector(528, 1738, -1279),
                [2] = Vector(382, 1605, -1155)
            },

            [3] = {
                [1] = Vector(340, 1849, -2593),
                [2] = Vector(550, 1762, -2733)
            },

            [4] = {
                [1] = Vector(-488, 2189, -2734),
                [2] = Vector(-539, 2065, -2624)
            },
        },

        ["checkpoint_spot"] = {
            [1] = Vector(-80, 2737, -1264),
            [2] = Vector(455, 1672, -1273),
            [3] = Vector(448, 1833, -2722),
            [4] = Vector(-703, 2119, -2729)
        }
    },

    ["d1_eli_02"] = {
        ["changelevels"] = {
            [1] = Vector(-3559, 4081, -1664),
            [2] = Vector(-3412, 4015, -1529)
        },

        ["checkpoints"] = {
            [1] = {
                [1] = Vector(-677, 864, -2676),
                [2] = Vector(-519, 779, -2566)
            },

            [2] = {
                [1] = Vector(-846, 1391, -2686),
                [2] = Vector(-500, 1319, -2561)
            },

            [3] = {
                [1] = Vector(-1933, 2014, -2636),
                [2] = Vector(-1984, 1826, -2733)
            }
        },

        ["checkpoint_spot"] = {
            [1] = Vector(-600, 750, -2676),
            [2] = Vector(-667, 1308, -2674),
            [3] = Vector(-2011, 1908, -2725)
        }
    },

    ["d1_town_01"] = {
        ["changelevels"] = {
            [1] = Vector(246, 363, -3208),
            [2] = Vector(136, 296, -3326)
        },

        ["checkpoints"] = {
            [1] = {
                [1] = Vector(1175, -341, -3389),
                [2] = Vector(1259, -401, -3515)
            },
        },

        ["checkpoint_spot"] = {
            [1] = Vector(1223, -361, -3507)
        }
    },

    ["d1_town_01a"] = {
        ["changelevels"] = {
            [1] = Vector(-615, 653, -3310),
            [2] = Vector(-689, 766, -3438)
        }
    },

    ["d1_town_02"] = {
        ["changelevels"] = {
            [1] = Vector(-3588, -573, -3439),
            [2] = Vector(-3710, -478, -3582)
        },

        ["changelevels_special"] = {
            [1] = Vector(-5286, 2102, -3260),
            [2] = Vector(-5092, 1863, -3041)
        },

        ["checkpoints"] = {
            [1] = {
                [1] = Vector(-4737, 952, -3085),
                [2] = Vector(-4531, 800, -3255)
            }
        },

        ["checkpoint_spot"] = {
            [1] = Vector(-4809, 589, -3246)
        }
    },

    ["d1_town_03"] = {
        ["changelevels"] = {
            [1] = Vector(-3722, -62, -3453),
            [2] = Vector(-3798, 9, -3337)
        },

        ["pushers"] = {
            [1] = {
                [1] = Vector(-2361, -1211, -3436),
                [2] = Vector(-2563, -1586, -3232)
            }
        },

        ["pusher_spot"] = {
            [1] = Vector(-1994, -1424, -3645)
        }
    },

    ["d1_town_02a"] = {
        ["changelevels"] = {
            [1] = Vector(-6531, -641, -3140),
            [2] = Vector(-6638, -722, -3261)
        },

        ["checkpoints"] = {
            [1] = {
                [1] = Vector(-7479, -290, -3293),
                [2] = Vector(-7547, -154, -3405)
            }
        },

        ["checkpoint_spot"] = {
            [1] = Vector(-7458, -208, -3402)
        },

        ["checkpoint_functions"] = {
            [1] = function()
                for _, v in ipairs(player.GetAll()) do	
                    v:GrantAchievement("Hallowed Ground")
                end
            end
        }
    },

    ["d1_town_04"] = {
        ["changelevels"] = {
            [1] = Vector(-2688, 1024, -4735),
            [2] = Vector(-2679, 1278, -4862)
        },
    },

    ["d1_town_05"] = {
        ["changelevels"] = {
            [1] = Vector(-1634, 10894, 1015),
            [2] = Vector(-1727, 10916, 896)
        },

        ["checkpoints"] = {
            [1] = {
                [1] = Vector(-7479, -290, -3293),
                [2] = Vector(-7547, -154, -3405)
            }
        },

        ["checkpoint_spot"] = {
            [1] = Vector(-1101, 10431, 905)
        },
    },

    ["d2_coast_01"] = {
        ["changelevels"] = {
            [1] = Vector(-12091, 4070, 1689),		
            [2] = Vector(-11584, 4384, 1540)
        }
    },

    ["d2_coast_03"] = {
        ["changelevels"] = {
            [1] = Vector(6274, 13159, 197),
            [2] = Vector(7177, 13340, 41)
        },

        ["checkpoints"] = {
            [1] = {
                [1] = Vector(8727, 4527, 372),
                [2] = Vector(8872, 4153, 258)
            }
        },

        ["checkpoint_spot"] = {
            [1] = Vector(8777, 4344, 267)
        },

        ["checkpoint_functions"] = {
            [1] = function()
                disableJeepGlobal = true
			    for _, v in ipairs(player.GetAll()) do
					if v.vehicle and v.vehicle:IsValid() then
                        v.vehicle:Remove()
                        v.vehicle = nil
                    end
				end
			end
        }
    },

    ["d2_coast_04"] = {
        ["changelevels"] = {
            [1] = Vector(-3806, 10753, 1922),
            [2] = Vector(-4263, 10241, 1793)
        },

        ["checkpoints"] = {
            [1] = {
                [1] = Vector(6204, -3945, 529),
                [2] = Vector(5888, -3701, 384)
            }
        },

        ["checkpoint_spot"] = {
            [1] = Vector(6049, -3863, 391)
        },
    },

    ["d2_coast_05"] = {
        ["changelevels"] = {
            [1] = Vector(2682, 5504, 1342),
            [2] = Vector(2212, 6073, 1633)
        },

        ["checkpoints"] = {
            [1] = {
                [1] = Vector(-4465, -1648, 1088),
                [2] = Vector(-5144, -1288, 1258)
            }
        },

        ["checkpoint_spot"] = {
            [1] = Vector(-4839, -1420, 1097)
        },
    },
}

local HL2_WEAPONS = {
	["d1_canals_01"] = {
		[1] = "weapon_crowbar",
	},
	
	["d1_canals_01a"] = {
		[1] = "weapon_crowbar",
		[2] = "weapon_pistol"
	},
	
	["d1_canals_02"] = {
		[1] = "weapon_crowbar",
		[2] = "weapon_pistol"
	},
	
	["d1_canals_03"] = {
		[1] = "weapon_crowbar",
		[2] = "weapon_pistol"
	},
	
	["d1_canals_05"] = {
		[1] = "weapon_crowbar",
		[2] = "weapon_pistol",
		[3] = "weapon_smg1"
	},
	
	["d1_canals_06"] = {
		[1] = "weapon_crowbar",
		[2] = "weapon_pistol",
		[3] = "weapon_smg1"
	},
	
	["d1_canals_07"] = {
		[1] = "weapon_crowbar",
		[2] = "weapon_pistol",
		[3] = "weapon_smg1"
	},
	
	["d1_canals_08"] = {
		[1] = "weapon_crowbar",
		[2] = "weapon_pistol",
		[3] = "weapon_smg1"
	},
	
	["d1_canals_09"] = {
		[1] = "weapon_crowbar",
		[2] = "weapon_pistol",
		[3] = "weapon_smg1",
		[4] = "weapon_357"
	},
	
	["d1_canals_10"] = {
		[1] = "weapon_crowbar",
		[2] = "weapon_pistol",
		[3] = "weapon_smg1",
		[4] = "weapon_357"
	},
	
	["d1_canals_11"] = {
		[1] = "weapon_crowbar",
		[2] = "weapon_pistol",
		[3] = "weapon_smg1",
		[4] = "weapon_357"
	},
	
	["d1_canals_12"] = {
		[1] = "weapon_crowbar",
		[2] = "weapon_pistol",
		[3] = "weapon_smg1",
		[4] = "weapon_357"
	},
	
	["d1_canals_13"] = {
		[1] = "weapon_crowbar",
		[2] = "weapon_pistol",
		[3] = "weapon_smg1",
		[4] = "weapon_357"
	},
	
	["d1_eli_01"] = {
		[1] = "weapon_crowbar",
		[2] = "weapon_pistol",
		[3] = "weapon_smg1",
		[4] = "weapon_357"
	},
	
	["d1_eli_02"] = {
		[1] = "weapon_crowbar",
		[2] = "weapon_pistol",
		[3] = "weapon_smg1",
		[4] = "weapon_357"
	},
	
	["d1_town_01"] = {
		[1] = "weapon_crowbar",
		[2] = "weapon_pistol",
		[3] = "weapon_smg1",
		[4] = "weapon_357",
		[5] = "weapon_physcannon"
	},
	
	["d1_town_01a"] = {
		[1] = "weapon_crowbar",
		[2] = "weapon_pistol",
		[3] = "weapon_smg1",
		[4] = "weapon_357",
		[5] = "weapon_physcannon"
	},
	
	["d1_town_02"] = {
		[1] = "weapon_crowbar",
		[2] = "weapon_pistol",
		[3] = "weapon_smg1",
		[4] = "weapon_357",
		[5] = "weapon_physcannon"
	},
	
	["d1_town_03"] = {
		[1] = "weapon_crowbar",
		[2] = "weapon_pistol",
		[3] = "weapon_smg1",
		[4] = "weapon_357",
		[5] = "weapon_physcannon",
		[6] = "weapon_shotgun"
	},
	
	["d1_town_04"] = {
		[1] = "weapon_crowbar",
		[2] = "weapon_pistol",
		[3] = "weapon_smg1",
		[4] = "weapon_357",
		[5] = "weapon_physcannon",
		[6] = "weapon_shotgun"
	},
	
	["d1_town_05"] = {
		[1] = "weapon_crowbar",
		[2] = "weapon_pistol",
		[3] = "weapon_smg1",
		[4] = "weapon_357",
		[5] = "weapon_physcannon",
		[6] = "weapon_shotgun"
	},
	
	["d2_coast_01"] = {
		[1] = "weapon_crowbar",
		[2] = "weapon_pistol",
		[3] = "weapon_smg1",
		[4] = "weapon_357",
		[5] = "weapon_physcannon",
		[6] = "weapon_shotgun",
		[7] = "weapon_ar2"
	},
	
	["d2_coast_03"] = {
		[1] = "weapon_crowbar",
		[2] = "weapon_pistol",
		[3] = "weapon_smg1",
		[4] = "weapon_357",
		[5] = "weapon_physcannon",
		[6] = "weapon_shotgun",
		[7] = "weapon_ar2",
	},
	
	["d2_coast_04"] = {
		[1] = "weapon_crowbar",
		[2] = "weapon_pistol",
		[3] = "weapon_smg1",
		[4] = "weapon_357",
		[5] = "weapon_physcannon",
		[6] = "weapon_shotgun",
		[7] = "weapon_ar2",
		[8] = "weapon_rpg"
	},
	
	["d2_coast_05"] = {
		[1] = "weapon_crowbar",
		[2] = "weapon_pistol",
		[3] = "weapon_smg1",
		[4] = "weapon_357",
		[5] = "weapon_physcannon",
		[6] = "weapon_shotgun",
		[7] = "weapon_ar2",
		[8] = "weapon_rpg"
	},
	
	["d2_coast_07"] = {
		[1] = "weapon_crowbar",
		[2] = "weapon_pistol",
		[3] = "weapon_smg1",
		[4] = "weapon_357",
		[5] = "weapon_physcannon",
		[6] = "weapon_shotgun",
		[7] = "weapon_ar2",
		[8] = "weapon_rpg",
		[9] = "weapon_crossbow"
	},
	
	["d2_coast_08"] = {
		[1] = "weapon_crowbar",
		[2] = "weapon_pistol",
		[3] = "weapon_smg1",
		[4] = "weapon_357",
		[5] = "weapon_physcannon",
		[6] = "weapon_shotgun",
		[7] = "weapon_ar2",
		[8] = "weapon_rpg",
		[9] = "weapon_crossbow"
	},
	
	["d2_coast_09"] = {
		[1] = "weapon_crowbar",
		[2] = "weapon_pistol",
		[3] = "weapon_smg1",
		[4] = "weapon_357",
		[5] = "weapon_physcannon",
		[6] = "weapon_shotgun",
		[7] = "weapon_ar2",
		[8] = "weapon_rpg",
		[9] = "weapon_crossbow"
	},
	
	["d2_coast_10"] = {
		[1] = "weapon_crowbar",
		[2] = "weapon_pistol",
		[3] = "weapon_smg1",
		[4] = "weapon_357",
		[5] = "weapon_physcannon",
		[6] = "weapon_shotgun",
		[7] = "weapon_ar2",
		[8] = "weapon_rpg",
		[9] = "weapon_crossbow"
	},
	
	["d2_coast_11"] = {
		[1] = "weapon_crowbar",
		[2] = "weapon_pistol",
		[3] = "weapon_smg1",
		[4] = "weapon_357",
		[5] = "weapon_physcannon",
		[6] = "weapon_shotgun",
		[7] = "weapon_ar2",
		[8] = "weapon_rpg",
		[9] = "weapon_crossbow"
	},
	
	["d2_coast_12"] = {
		[1] = "weapon_crowbar",
		[2] = "weapon_pistol",
		[3] = "weapon_smg1",
		[4] = "weapon_357",
		[5] = "weapon_physcannon",
		[6] = "weapon_shotgun",
		[7] = "weapon_ar2",
		[8] = "weapon_rpg",
		[9] = "weapon_crossbow",
		[10] = "weapon_bugbait"
	},
	
	["d2_prison_01"] = {
		[1] = "weapon_crowbar",
		[2] = "weapon_pistol",
		[3] = "weapon_smg1",
		[4] = "weapon_357",
		[5] = "weapon_physcannon",
		[6] = "weapon_shotgun",
		[7] = "weapon_ar2",
		[8] = "weapon_rpg",
		[9] = "weapon_crossbow",
		[10] = "weapon_bugbait"
	},
	
	["d2_prison_02"] = {
		[1] = "weapon_crowbar",
		[2] = "weapon_pistol",
		[3] = "weapon_smg1",
		[4] = "weapon_357",
		[5] = "weapon_physcannon",
		[6] = "weapon_shotgun",
		[7] = "weapon_ar2",
		[8] = "weapon_rpg",
		[9] = "weapon_crossbow",
		[10] = "weapon_bugbait"
	},
	
	["d2_prison_03"] = {
		[1] = "weapon_crowbar",
		[2] = "weapon_pistol",
		[3] = "weapon_smg1",
		[4] = "weapon_357",
		[5] = "weapon_physcannon",
		[6] = "weapon_shotgun",
		[7] = "weapon_ar2",
		[8] = "weapon_rpg",
		[9] = "weapon_crossbow",
		[10] = "weapon_bugbait"
	},
	
	["d2_prison_04"] = {
		[1] = "weapon_crowbar",
		[2] = "weapon_pistol",
		[3] = "weapon_smg1",
		[4] = "weapon_357",
		[5] = "weapon_physcannon",
		[6] = "weapon_shotgun",
		[7] = "weapon_ar2",
		[8] = "weapon_rpg",
		[9] = "weapon_crossbow",
		[10] = "weapon_bugbait"
	},
	
	["d2_prison_05"] = {
		[1] = "weapon_crowbar",
		[2] = "weapon_pistol",
		[3] = "weapon_smg1",
		[4] = "weapon_357",
		[5] = "weapon_physcannon",
		[6] = "weapon_shotgun",
		[7] = "weapon_ar2",
		[8] = "weapon_rpg",
		[9] = "weapon_crossbow",
		[10] = "weapon_bugbait"
	},
	
	["d2_prison_06"] = {
		[1] = "weapon_crowbar",
		[2] = "weapon_pistol",
		[3] = "weapon_smg1",
		[4] = "weapon_357",
		[5] = "weapon_physcannon",
		[6] = "weapon_shotgun",
		[7] = "weapon_ar2",
		[8] = "weapon_rpg",
		[9] = "weapon_crossbow"
	},
	
	["d2_prison_07"] = {
		[1] = "weapon_crowbar",
		[2] = "weapon_pistol",
		[3] = "weapon_smg1",
		[4] = "weapon_357",
		[5] = "weapon_physcannon",
		[6] = "weapon_shotgun",
		[7] = "weapon_ar2",
		[8] = "weapon_rpg",
		[9] = "weapon_crossbow"
	},
	
	["d2_prison_08"] = {
		[1] = "weapon_crowbar",
		[2] = "weapon_pistol",
		[3] = "weapon_smg1",
		[4] = "weapon_357",
		[5] = "weapon_physcannon",
		[6] = "weapon_shotgun",
		[7] = "weapon_ar2",
		[8] = "weapon_rpg",
		[9] = "weapon_crossbow"
	},
	
	["d3_c17_01"] = {
		[1] = "weapon_crowbar",
		[2] = "weapon_pistol",
		[3] = "weapon_smg1",
		[4] = "weapon_357",
		[5] = "weapon_physcannon",
		[6] = "weapon_shotgun",
		[7] = "weapon_ar2",
		[8] = "weapon_rpg",
		[9] = "weapon_crossbow"
	},
	
	["d3_c17_02"] = {
		[1] = "weapon_crowbar",
		[2] = "weapon_pistol",
		[3] = "weapon_smg1",
		[4] = "weapon_357",
		[5] = "weapon_physcannon",
		[6] = "weapon_shotgun",
		[7] = "weapon_ar2",
		[8] = "weapon_rpg",
		[9] = "weapon_crossbow"
	},
	
	["d3_c17_03"] = {
		[1] = "weapon_crowbar",
		[2] = "weapon_pistol",
		[3] = "weapon_smg1",
		[4] = "weapon_357",
		[5] = "weapon_physcannon",
		[6] = "weapon_shotgun",
		[7] = "weapon_ar2",
		[8] = "weapon_rpg",
		[9] = "weapon_crossbow"
	},
	
	["d3_c17_04"] = {
		[1] = "weapon_crowbar",
		[2] = "weapon_pistol",
		[3] = "weapon_smg1",
		[4] = "weapon_357",
		[5] = "weapon_physcannon",
		[6] = "weapon_shotgun",
		[7] = "weapon_ar2",
		[8] = "weapon_rpg",
		[9] = "weapon_crossbow"
	},
	
	["d3_c17_05"] = {
		[1] = "weapon_crowbar",
		[2] = "weapon_pistol",
		[3] = "weapon_smg1",
		[4] = "weapon_357",
		[5] = "weapon_physcannon",
		[6] = "weapon_shotgun",
		[7] = "weapon_ar2",
		[8] = "weapon_rpg",
		[9] = "weapon_crossbow"
	},
	
	["d3_c17_06a"] = {
		[1] = "weapon_crowbar",
		[2] = "weapon_pistol",
		[3] = "weapon_smg1",
		[4] = "weapon_357",
		[5] = "weapon_physcannon",
		[6] = "weapon_shotgun",
		[7] = "weapon_ar2",
		[8] = "weapon_rpg",
		[9] = "weapon_crossbow"
	},
	
	["d3_c17_06b"] = {
		[1] = "weapon_crowbar",
		[2] = "weapon_pistol",
		[3] = "weapon_smg1",
		[4] = "weapon_357",
		[5] = "weapon_physcannon",
		[6] = "weapon_shotgun",
		[7] = "weapon_ar2",
		[8] = "weapon_rpg",
		[9] = "weapon_crossbow"
	},
	
	["d3_c17_07"] = {
		[1] = "weapon_crowbar",
		[2] = "weapon_pistol",
		[3] = "weapon_smg1",
		[4] = "weapon_357",
		[5] = "weapon_physcannon",
		[6] = "weapon_shotgun",
		[7] = "weapon_ar2",
		[8] = "weapon_rpg",
		[9] = "weapon_crossbow"
	},
	
	["d3_c17_08"] = {
		[1] = "weapon_crowbar",
		[2] = "weapon_pistol",
		[3] = "weapon_smg1",
		[4] = "weapon_357",
		[5] = "weapon_physcannon",
		[6] = "weapon_shotgun",
		[7] = "weapon_ar2",
		[8] = "weapon_rpg",
		[9] = "weapon_crossbow"
	},
	
	["d3_c17_09"] = {
		[1] = "weapon_crowbar",
		[2] = "weapon_pistol",
		[3] = "weapon_smg1",
		[4] = "weapon_357",
		[5] = "weapon_physcannon",
		[6] = "weapon_shotgun",
		[7] = "weapon_ar2",
		[8] = "weapon_rpg",
		[9] = "weapon_crossbow"
	},
	
	["d3_c17_10a"] = {
		[1] = "weapon_crowbar",
		[2] = "weapon_pistol",
		[3] = "weapon_smg1",
		[4] = "weapon_357",
		[5] = "weapon_physcannon",
		[6] = "weapon_shotgun",
		[7] = "weapon_ar2",
		[8] = "weapon_rpg",
		[9] = "weapon_crossbow"
	},
	
	["d3_c17_10b"] = {
		[1] = "weapon_crowbar",
		[2] = "weapon_pistol",
		[3] = "weapon_smg1",
		[4] = "weapon_357",
		[5] = "weapon_physcannon",
		[6] = "weapon_shotgun",
		[7] = "weapon_ar2",
		[8] = "weapon_rpg",
		[9] = "weapon_crossbow"
	},
	
	["d3_c17_11"] = {
		[1] = "weapon_crowbar",
		[2] = "weapon_pistol",
		[3] = "weapon_smg1",
		[4] = "weapon_357",
		[5] = "weapon_physcannon",
		[6] = "weapon_shotgun",
		[7] = "weapon_ar2",
		[8] = "weapon_rpg",
		[9] = "weapon_crossbow"
	},
	
	["d3_c17_12"] = {
		[1] = "weapon_crowbar",
		[2] = "weapon_pistol",
		[3] = "weapon_smg1",
		[4] = "weapon_357",
		[5] = "weapon_physcannon",
		[6] = "weapon_shotgun",
		[7] = "weapon_ar2",
		[8] = "weapon_rpg",
		[9] = "weapon_crossbow"
	},
	
	["d3_c17_12b"] = {
		[1] = "weapon_crowbar",
		[2] = "weapon_pistol",
		[3] = "weapon_smg1",
		[4] = "weapon_357",
		[5] = "weapon_physcannon",
		[6] = "weapon_shotgun",
		[7] = "weapon_ar2",
		[8] = "weapon_rpg",
		[9] = "weapon_crossbow"
	},
	
	["d3_c17_13"] = {
		[1] = "weapon_crowbar",
		[2] = "weapon_pistol",
		[3] = "weapon_smg1",
		[4] = "weapon_357",
		[5] = "weapon_physcannon",
		[6] = "weapon_shotgun",
		[7] = "weapon_ar2",
		[8] = "weapon_rpg",
		[9] = "weapon_crossbow"
	},
	
	["d3_citadel_01"] = {
		[1] = "weapon_crowbar",
		[2] = "weapon_pistol",
		[3] = "weapon_smg1",
		[4] = "weapon_357",
		[5] = "weapon_physcannon",
		[6] = "weapon_shotgun",
		[7] = "weapon_ar2",
		[8] = "weapon_rpg",
		[9] = "weapon_crossbow"
	},
	
	["d3_citadel_03"] = {
		[1] = "weapon_crowbar",
		[2] = "weapon_pistol",
		[3] = "weapon_smg1",
		[4] = "weapon_357",
		[5] = "weapon_physcannon",
		[6] = "weapon_shotgun",
		[7] = "weapon_ar2",
		[8] = "weapon_rpg",
		[9] = "weapon_crossbow"
	},
	
	["d3_citadel_04"] = {
		[1] = "weapon_physcannon",
	},
	
	["d3_citadel_05"] = {
		[1] = "weapon_physcannon",
	},
}

local HL2_EQUIPMENT = {
	["d1_trainstation_06"] = {
		[1] = {
			["Type"] = "Armor",
			["Amount"] = 25,
		}
	},
	
	["d1_canals_01"] = {
		[1] = {
			["Type"] = "Armor",
			["Amount"] = 25,
		}
	},
	
	["d1_canals_01a"] = {
		[1] = {
			["Type"] = "Pistol",
			["Amount"] = 54,
		},
		
		[2] = {
			["Type"] = "Armor",
			["Amount"] = 25,
		}
	},
	
	["d1_canals_02"] = {
		[1] = {
			["Type"] = "Pistol",
			["Amount"] = 54,
		},
		
		[2] = {
			["Type"] = "Armor",
			["Amount"] = 25,
		}
	},
	
	["d1_canals_03"] = {
		[1] = {
			["Type"] = "Pistol",
			["Amount"] = 54,
		},
		
		[2] = {
			["Type"] = "Armor",
			["Amount"] = 25,
		}
	},
	
	["d1_canals_05"] = {
		[1] = {
			["Type"] = "Pistol",
			["Amount"] = 54,
		},
		
		[2] = {
			["Type"] = "SMG1",
			["Amount"] = 45,
		},
		
		[3] = {
			["Type"] = "Armor",
			["Amount"] = 25,
		}
	},
	
	["d1_canals_06"] = {
		[1] = {
			["Type"] = "Pistol",
			["Amount"] = 72,
		},
		
		[2] = {
			["Type"] = "SMG1",
			["Amount"] = 45,
		},
		
		[3] = {
			["Type"] = "Armor",
			["Amount"] = 45,
		}
	},
	
	["d1_canals_07"] = {
		[1] = {
			["Type"] = "Pistol",
			["Amount"] = 54,
		},
		
		[2] = {
			["Type"] = "SMG1",
			["Amount"] = 45,
		},
		
		[3] = {
			["Type"] = "SMG1_Grenade",
			["Amount"] = 1,
		},
		
		[4] = {
			["Type"] = "Grenade",
			["Amount"] = 1,
		},
		
		[5] = {
			["Type"] = "Armor",
			["Amount"] = 45,
		}
	},
	
	["d1_canals_08"] = {
		[1] = {
			["Type"] = "Pistol",
			["Amount"] = 54,
		},
		
		[2] = {
			["Type"] = "SMG1",
			["Amount"] = 45,
		},
		
		[3] = {
			["Type"] = "SMG1_Grenade",
			["Amount"] = 1,
		},
		
		[4] = {
			["Type"] = "Grenade",
			["Amount"] = 1,
		},
		
		[5] = {
			["Type"] = "Armor",
			["Amount"] = 45,
		}
	},
	
	["d1_canals_09"] = {
		[1] = {
			["Type"] = "Pistol",
			["Amount"] = 54,
		},
		
		[2] = {
			["Type"] = "SMG1",
			["Amount"] = 45,
		},
		
		[3] = {
			["Type"] = "357",
			["Amount"] = 6,
		},
		
		[4] = {
			["Type"] = "SMG1_Grenade",
			["Amount"] = 1,
		},
		
		[5] = {
			["Type"] = "Grenade",
			["Amount"] = 1,
		},
		
		[6] = {
			["Type"] = "Armor",
			["Amount"] = 45,
		}
	},
	
	["d1_canals_10"] = {
		[1] = {
			["Type"] = "Pistol",
			["Amount"] = 54,
		},
		
		[2] = {
			["Type"] = "SMG1",
			["Amount"] = 45,
		},
		
		[3] = {
			["Type"] = "357",
			["Amount"] = 6,
		},
		
		[4] = {
			["Type"] = "SMG1_Grenade",
			["Amount"] = 1,
		},
		
		[5] = {
			["Type"] = "Grenade",
			["Amount"] = 1,
		},
		
		[6] = {
			["Type"] = "Armor",
			["Amount"] = 45,
		}
	},
	
	["d1_canals_11"] = {
		[1] = {
			["Type"] = "Pistol",
			["Amount"] = 54,
		},
		
		[2] = {
			["Type"] = "SMG1",
			["Amount"] = 45,
		},
		
		[3] = {
			["Type"] = "357",
			["Amount"] = 6,
		},
		
		[4] = {
			["Type"] = "SMG1_Grenade",
			["Amount"] = 1,
		},
		
		[5] = {
			["Type"] = "Grenade",
			["Amount"] = 1,
		},
		
		[6] = {
			["Type"] = "Armor",
			["Amount"] = 45,
		}
	},
	
	["d1_canals_12"] = {
		[1] = {
			["Type"] = "Pistol",
			["Amount"] = 54,
		},
		
		[2] = {
			["Type"] = "SMG1",
			["Amount"] = 45,
		},
		
		[3] = {
			["Type"] = "357",
			["Amount"] = 6,
		},
		
		[4] = {
			["Type"] = "SMG1_Grenade",
			["Amount"] = 1,
		},
		
		[5] = {
			["Type"] = "Grenade",
			["Amount"] = 1,
		},
		
		[6] = {
			["Type"] = "Armor",
			["Amount"] = 45,
		}
	},
	
	["d1_canals_13"] = {
		[1] = {
			["Type"] = "Pistol",
			["Amount"] = 54,
		},
		
		[2] = {
			["Type"] = "SMG1",
			["Amount"] = 45,
		},
		
		[3] = {
			["Type"] = "357",
			["Amount"] = 6,
		},
		
		[4] = {
			["Type"] = "SMG1_Grenade",
			["Amount"] = 1,
		},
		
		[5] = {
			["Type"] = "Grenade",
			["Amount"] = 1,
		},
		
		[6] = {
			["Type"] = "Armor",
			["Amount"] = 45,
		}
	},
	
	["d1_eli_01"] = {
		[1] = {
			["Type"] = "Pistol",
			["Amount"] = 54,
		},
		
		[2] = {
			["Type"] = "SMG1",
			["Amount"] = 45,
		},
		
		[3] = {
			["Type"] = "357",
			["Amount"] = 6,
		},
		
		[4] = {
			["Type"] = "SMG1_Grenade",
			["Amount"] = 1,
		},
		
		[5] = {
			["Type"] = "Grenade",
			["Amount"] = 1,
		},
		
		[6] = {
			["Type"] = "Armor",
			["Amount"] = 60,
		}
	},
	
	["d1_eli_02"] = {
		[1] = {
			["Type"] = "Pistol",
			["Amount"] = 54,
		},
		
		[2] = {
			["Type"] = "SMG1",
			["Amount"] = 45,
		},
		
		[3] = {
			["Type"] = "357",
			["Amount"] = 6,
		},
		
		[4] = {
			["Type"] = "SMG1_Grenade",
			["Amount"] = 1,
		},
		
		[5] = {
			["Type"] = "Grenade",
			["Amount"] = 1,
		},
		
		[6] = {
			["Type"] = "Armor",
			["Amount"] = 60,
		}
	},
	
	["d1_town_01"] = {
		[1] = {
			["Type"] = "Pistol",
			["Amount"] = 54,
		},
		
		[2] = {
			["Type"] = "SMG1",
			["Amount"] = 45,
		},
		
		[3] = {
			["Type"] = "357",
			["Amount"] = 3,
		},
		
		[4] = {
			["Type"] = "Armor",
			["Amount"] = 25,
		}
	},
	
	["d1_town_01a"] = {
		[1] = {
			["Type"] = "Pistol",
			["Amount"] = 54,
		},
		
		[2] = {
			["Type"] = "SMG1",
			["Amount"] = 45,
		},
		
		[3] = {
			["Type"] = "357",
			["Amount"] = 3,
		},
		
		[4] = {
			["Type"] = "Armor",
			["Amount"] = 25,
		}
	},
	
	["d1_town_02"] = {
		[1] = {
			["Type"] = "Pistol",
			["Amount"] = 54,
		},
		
		[2] = {
			["Type"] = "SMG1",
			["Amount"] = 45,
		},
		
		[3] = {
			["Type"] = "357",
			["Amount"] = 3,
		},
		
		[4] = {
			["Type"] = "Armor",
			["Amount"] = 25,
		}
	},
	
	["d1_town_03"] = {
		[1] = {
			["Type"] = "Pistol",
			["Amount"] = 54,
		},
		
		[2] = {
			["Type"] = "SMG1",
			["Amount"] = 45,
		},
		
		[3] = {
			["Type"] = "357",
			["Amount"] = 3,
		},
		
		[4] = {
			["Type"] = "Buckshot",
			["Amount"] = 6,
		},
		
		[5] = {
			["Type"] = "Armor",
			["Amount"] = 25,
		}
	},
	
	["d1_town_04"] = {
		[1] = {
			["Type"] = "Pistol",
			["Amount"] = 54,
		},
		
		[2] = {
			["Type"] = "SMG1",
			["Amount"] = 45,
		},
		
		[3] = {
			["Type"] = "357",
			["Amount"] = 3,
		},
		
		[4] = {
			["Type"] = "Buckshot",
			["Amount"] = 6,
		},
		
		[5] = {
			["Type"] = "Armor",
			["Amount"] = 25,
		}
	},
	
	["d1_town_05"] = {
		[1] = {
			["Type"] = "Pistol",
			["Amount"] = 54,
		},
		
		[2] = {
			["Type"] = "SMG1",
			["Amount"] = 45,
		},
		
		[3] = {
			["Type"] = "357",
			["Amount"] = 6,
		},
		
		[4] = {
			["Type"] = "Buckshot",
			["Amount"] = 12,
		},
		
		[5] = {
			["Type"] = "Grenade",
			["Amount"] = 6,
		},
		
		[6] = {
			["Type"] = "Armor",
			["Amount"] = 45,
		}
	},
	
	["d2_coast_01"] = {
		[1] = {
			["Type"] = "Pistol",
			["Amount"] = 54,
		},
		
		[2] = {
			["Type"] = "SMG1",
			["Amount"] = 45,
		},
		
		[3] = {
			["Type"] = "357",
			["Amount"] = 6,
		},
		
		[4] = {
			["Type"] = "Buckshot",
			["Amount"] = 12,
		},
		
		[5] = {
			["Type"] = "Grenade",
			["Amount"] = 6,
		},
		
		[6] = {
			["Type"] = "SMG1_Grenade",
			["Amount"] = 1,
		},
		
		[7] = {
			["Type"] = "AR2",
			["Amount"] = 30,
		},
		
		[8] = {
			["Type"] = "Armor",
			["Amount"] = 60,
		}
	},
	
	["d2_coast_03"] = {
		[1] = {
			["Type"] = "Pistol",
			["Amount"] = 54,
		},
		
		[2] = {
			["Type"] = "SMG1",
			["Amount"] = 45,
		},
		
		[3] = {
			["Type"] = "357",
			["Amount"] = 6,
		},
		
		[4] = {
			["Type"] = "Buckshot",
			["Amount"] = 12,
		},
		
		[5] = {
			["Type"] = "Grenade",
			["Amount"] = 6,
		},
		
		[6] = {
			["Type"] = "SMG1_Grenade",
			["Amount"] = 1,
		},
		
		[7] = {
			["Type"] = "AR2",
			["Amount"] = 30,
		},
		
		[8] = {
			["Type"] = "Armor",
			["Amount"] = 60,
		}
	},
	
	["d2_coast_04"] = {
		[1] = {
			["Type"] = "Pistol",
			["Amount"] = 54,
		},
		
		[2] = {
			["Type"] = "SMG1",
			["Amount"] = 45,
		},
		
		[3] = {
			["Type"] = "357",
			["Amount"] = 6,
		},
		
		[4] = {
			["Type"] = "Buckshot",
			["Amount"] = 12,
		},
		
		[5] = {
			["Type"] = "Grenade",
			["Amount"] = 6,
		},
		
		[6] = {
			["Type"] = "SMG1_Grenade",
			["Amount"] = 1,
		},
		
		[7] = {
			["Type"] = "AR2",
			["Amount"] = 30,
		},
		
		[8] = {
			["Type"] = "RPG",
			["Amount"] = 1,
		},
		
		[9] = {
			["Type"] = "Armor",
			["Amount"] = 60,
		}
	},
	
	["d2_coast_05"] = {
		[1] = {
			["Type"] = "Pistol",
			["Amount"] = 54,
		},
		
		[2] = {
			["Type"] = "SMG1",
			["Amount"] = 45,
		},
		
		[3] = {
			["Type"] = "357",
			["Amount"] = 6,
		},
		
		[4] = {
			["Type"] = "Buckshot",
			["Amount"] = 12,
		},
		
		[5] = {
			["Type"] = "Grenade",
			["Amount"] = 6,
		},
		
		[6] = {
			["Type"] = "SMG1_Grenade",
			["Amount"] = 1,
		},
		
		[7] = {
			["Type"] = "AR2",
			["Amount"] = 30,
		},
		
		[8] = {
			["Type"] = "RPG",
			["Amount"] = 1,
		},
		
		[9] = {
			["Type"] = "Armor",
			["Amount"] = 60,
		}
	},
	
	["d2_coast_07"] = {
		[1] = {
			["Type"] = "Pistol",
			["Amount"] = 54,
		},
		
		[2] = {
			["Type"] = "SMG1",
			["Amount"] = 45,
		},
		
		[3] = {
			["Type"] = "357",
			["Amount"] = 6,
		},
		
		[4] = {
			["Type"] = "Buckshot",
			["Amount"] = 12,
		},
		
		[5] = {
			["Type"] = "Grenade",
			["Amount"] = 6,
		},
		
		[6] = {
			["Type"] = "SMG1_Grenade",
			["Amount"] = 1,
		},
		
		[7] = {
			["Type"] = "AR2",
			["Amount"] = 30,
		},
		
		[8] = {
			["Type"] = "RPG",
			["Amount"] = 1,
		},
		
		[9] = {
			["Type"] = "Armor",
			["Amount"] = 60,
		}
	},
	
	["d2_coast_08"] = {
		[1] = {
			["Type"] = "Pistol",
			["Amount"] = 54,
		},
		
		[2] = {
			["Type"] = "SMG1",
			["Amount"] = 45,
		},
		
		[3] = {
			["Type"] = "357",
			["Amount"] = 6,
		},
		
		[4] = {
			["Type"] = "Buckshot",
			["Amount"] = 12,
		},
		
		[5] = {
			["Type"] = "Grenade",
			["Amount"] = 6,
		},
		
		[6] = {
			["Type"] = "SMG1_Grenade",
			["Amount"] = 1,
		},
		
		[7] = {
			["Type"] = "AR2",
			["Amount"] = 30,
		},
		
		[8] = {
			["Type"] = "RPG",
			["Amount"] = 1,
		},
		
		[9] = {
			["Type"] = "Armor",
			["Amount"] = 60,
		}
	},
	
	["d2_coast_09"] = {
		[1] = {
			["Type"] = "Pistol",
			["Amount"] = 54,
		},
		
		[2] = {
			["Type"] = "SMG1",
			["Amount"] = 45,
		},
		
		[3] = {
			["Type"] = "357",
			["Amount"] = 6,
		},
		
		[4] = {
			["Type"] = "Buckshot",
			["Amount"] = 12,
		},
		
		[5] = {
			["Type"] = "Grenade",
			["Amount"] = 6,
		},
		
		[6] = {
			["Type"] = "SMG1_Grenade",
			["Amount"] = 1,
		},
		
		[7] = {
			["Type"] = "AR2",
			["Amount"] = 30,
		},
		
		[8] = {
			["Type"] = "RPG",
			["Amount"] = 1,
		},
		
		[9] = {
			["Type"] = "XBowBolt",
			["Amount"] = 5,
		},
		
		[10] = {
			["Type"] = "Armor",
			["Amount"] = 60,
		}
	},
	
	["d2_coast_10"] = {
		[1] = {
			["Type"] = "Pistol",
			["Amount"] = 54,
		},
		
		[2] = {
			["Type"] = "SMG1",
			["Amount"] = 45,
		},
		
		[3] = {
			["Type"] = "357",
			["Amount"] = 6,
		},
		
		[4] = {
			["Type"] = "Buckshot",
			["Amount"] = 12,
		},
		
		[5] = {
			["Type"] = "Grenade",
			["Amount"] = 6,
		},
		
		[6] = {
			["Type"] = "SMG1_Grenade",
			["Amount"] = 1,
		},
		
		[7] = {
			["Type"] = "AR2",
			["Amount"] = 30,
		},
		
		[8] = {
			["Type"] = "RPG",
			["Amount"] = 1,
		},
		
		[9] = {
			["Type"] = "Armor",
			["Amount"] = 60,
		},
		
		[10] = {
			["Type"] = "XBowBolt",
			["Amount"] = 5,
		}
	},
	
	["d2_coast_11"] = {
		[1] = {
			["Type"] = "Pistol",
			["Amount"] = 54,
		},
		
		[2] = {
			["Type"] = "SMG1",
			["Amount"] = 45,
		},
		
		[3] = {
			["Type"] = "357",
			["Amount"] = 6,
		},
		
		[4] = {
			["Type"] = "Buckshot",
			["Amount"] = 12,
		},
		
		[5] = {
			["Type"] = "Grenade",
			["Amount"] = 6,
		},
		
		[6] = {
			["Type"] = "SMG1_Grenade",
			["Amount"] = 1,
		},
		
		[7] = {
			["Type"] = "AR2",
			["Amount"] = 30,
		},
		
		[8] = {
			["Type"] = "RPG",
			["Amount"] = 1,
		},
		
		[9] = {
			["Type"] = "Armor",
			["Amount"] = 60,
		},
		
		[10] = {
			["Type"] = "XBowBolt",
			["Amount"] = 5,
		}
	},
	
	["d2_coast_12"] = {
		[1] = {
			["Type"] = "Pistol",
			["Amount"] = 54,
		},
		
		[2] = {
			["Type"] = "SMG1",
			["Amount"] = 45,
		},
		
		[3] = {
			["Type"] = "357",
			["Amount"] = 6,
		},
		
		[4] = {
			["Type"] = "Buckshot",
			["Amount"] = 12,
		},
		
		[5] = {
			["Type"] = "Grenade",
			["Amount"] = 6,
		},
		
		[6] = {
			["Type"] = "SMG1_Grenade",
			["Amount"] = 1,
		},
		
		[7] = {
			["Type"] = "AR2",
			["Amount"] = 30,
		},
		
		[8] = {
			["Type"] = "RPG",
			["Amount"] = 1,
		},
		
		[9] = {
			["Type"] = "Armor",
			["Amount"] = 60,
		},
		
		[10] = {
			["Type"] = "XBowBolt",
			["Amount"] = 5,
		}
	},
	
	["d2_prison_01"] = {
		[1] = {
			["Type"] = "Pistol",
			["Amount"] = 54,
		},
		
		[2] = {
			["Type"] = "SMG1",
			["Amount"] = 45,
		},
		
		[3] = {
			["Type"] = "357",
			["Amount"] = 6,
		},
		
		[4] = {
			["Type"] = "Buckshot",
			["Amount"] = 12,
		},
		
		[5] = {
			["Type"] = "Grenade",
			["Amount"] = 6,
		},
		
		[6] = {
			["Type"] = "SMG1_Grenade",
			["Amount"] = 1,
		},
		
		[7] = {
			["Type"] = "AR2",
			["Amount"] = 30,
		},
		
		[8] = {
			["Type"] = "RPG",
			["Amount"] = 1,
		},
		
		[9] = {
			["Type"] = "Armor",
			["Amount"] = 60,
		},
		
		[10] = {
			["Type"] = "XBowBolt",
			["Amount"] = 5,
		}
	},
	
	["d2_prison_02"] = {
		[1] = {
			["Type"] = "Pistol",
			["Amount"] = 54,
		},
		
		[2] = {
			["Type"] = "SMG1",
			["Amount"] = 45,
		},
		
		[3] = {
			["Type"] = "357",
			["Amount"] = 6,
		},
		
		[4] = {
			["Type"] = "Buckshot",
			["Amount"] = 12,
		},
		
		[5] = {
			["Type"] = "Grenade",
			["Amount"] = 6,
		},
		
		[6] = {
			["Type"] = "SMG1_Grenade",
			["Amount"] = 1,
		},
		
		[7] = {
			["Type"] = "AR2",
			["Amount"] = 30,
		},
		
		[8] = {
			["Type"] = "RPG",
			["Amount"] = 1,
		},
		
		[9] = {
			["Type"] = "Armor",
			["Amount"] = 60,
		},
		
		[10] = {
			["Type"] = "XBowBolt",
			["Amount"] = 5,
		}
	},
	
	["d2_prison_03"] = {
		[1] = {
			["Type"] = "Pistol",
			["Amount"] = 54,
		},
		
		[2] = {
			["Type"] = "SMG1",
			["Amount"] = 45,
		},
		
		[3] = {
			["Type"] = "357",
			["Amount"] = 6,
		},
		
		[4] = {
			["Type"] = "Buckshot",
			["Amount"] = 12,
		},
		
		[5] = {
			["Type"] = "Grenade",
			["Amount"] = 6,
		},
		
		[6] = {
			["Type"] = "SMG1_Grenade",
			["Amount"] = 1,
		},
		
		[7] = {
			["Type"] = "AR2",
			["Amount"] = 30,
		},
		
		[8] = {
			["Type"] = "RPG",
			["Amount"] = 1,
		},
		
		[9] = {
			["Type"] = "Armor",
			["Amount"] = 60,
		},
		
		[10] = {
			["Type"] = "XBowBolt",
			["Amount"] = 5,
		}
	},
	
	["d2_prison_04"] = {
		[1] = {
			["Type"] = "Pistol",
			["Amount"] = 54,
		},
		
		[2] = {
			["Type"] = "SMG1",
			["Amount"] = 45,
		},
		
		[3] = {
			["Type"] = "357",
			["Amount"] = 6,
		},
		
		[4] = {
			["Type"] = "Buckshot",
			["Amount"] = 12,
		},
		
		[5] = {
			["Type"] = "Grenade",
			["Amount"] = 6,
		},
		
		[6] = {
			["Type"] = "SMG1_Grenade",
			["Amount"] = 1,
		},
		
		[7] = {
			["Type"] = "AR2",
			["Amount"] = 30,
		},
		
		[8] = {
			["Type"] = "RPG",
			["Amount"] = 1,
		},
		
		[9] = {
			["Type"] = "Armor",
			["Amount"] = 60,
		},
		
		[10] = {
			["Type"] = "XBowBolt",
			["Amount"] = 5,
		}
	},
	
	["d2_prison_05"] = {
		[1] = {
			["Type"] = "Pistol",
			["Amount"] = 54,
		},
		
		[2] = {
			["Type"] = "SMG1",
			["Amount"] = 45,
		},
		
		[3] = {
			["Type"] = "357",
			["Amount"] = 6,
		},
		
		[4] = {
			["Type"] = "Buckshot",
			["Amount"] = 12,
		},
		
		[5] = {
			["Type"] = "Grenade",
			["Amount"] = 6,
		},
		
		[6] = {
			["Type"] = "SMG1_Grenade",
			["Amount"] = 1,
		},
		
		[7] = {
			["Type"] = "AR2",
			["Amount"] = 30,
		},
		
		[8] = {
			["Type"] = "RPG",
			["Amount"] = 1,
		},
		
		[9] = {
			["Type"] = "Armor",
			["Amount"] = 60,
		},
		
		[10] = {
			["Type"] = "XBowBolt",
			["Amount"] = 5,
		}
	},
	
	["d2_prison_06"] = {
		[1] = {
			["Type"] = "Pistol",
			["Amount"] = 54,
		},
		
		[2] = {
			["Type"] = "SMG1",
			["Amount"] = 45,
		},
		
		[3] = {
			["Type"] = "357",
			["Amount"] = 6,
		},
		
		[4] = {
			["Type"] = "Buckshot",
			["Amount"] = 12,
		},
		
		[5] = {
			["Type"] = "Grenade",
			["Amount"] = 6,
		},
		
		[6] = {
			["Type"] = "SMG1_Grenade",
			["Amount"] = 1,
		},
		
		[7] = {
			["Type"] = "AR2",
			["Amount"] = 30,
		},
		
		[8] = {
			["Type"] = "RPG",
			["Amount"] = 1,
		},
		
		[9] = {
			["Type"] = "Armor",
			["Amount"] = 60,
		},
		
		[10] = {
			["Type"] = "XBowBolt",
			["Amount"] = 5,
		}
	},
	
	["d2_prison_07"] = {
		[1] = {
			["Type"] = "Pistol",
			["Amount"] = 54,
		},
		
		[2] = {
			["Type"] = "SMG1",
			["Amount"] = 45,
		},
		
		[3] = {
			["Type"] = "357",
			["Amount"] = 6,
		},
		
		[4] = {
			["Type"] = "Buckshot",
			["Amount"] = 12,
		},
		
		[5] = {
			["Type"] = "Grenade",
			["Amount"] = 6,
		},
		
		[6] = {
			["Type"] = "SMG1_Grenade",
			["Amount"] = 1,
		},
		
		[7] = {
			["Type"] = "AR2",
			["Amount"] = 30,
		},
		
		[8] = {
			["Type"] = "AR2AltFire",
			["Amount"] = 1,
		},
		
		[9] = {
			["Type"] = "Armor",
			["Amount"] = 60,
		},
		
		[10] = {
			["Type"] = "XBowBolt",
			["Amount"] = 5,
		}
	},
	
	["d2_prison_08"] = {
		[1] = {
			["Type"] = "Pistol",
			["Amount"] = 54,
		},
		
		[2] = {
			["Type"] = "SMG1",
			["Amount"] = 45,
		},
		
		[3] = {
			["Type"] = "357",
			["Amount"] = 6,
		},
		
		[4] = {
			["Type"] = "Buckshot",
			["Amount"] = 12,
		},
		
		[5] = {
			["Type"] = "Grenade",
			["Amount"] = 6,
		},
		
		[6] = {
			["Type"] = "SMG1_Grenade",
			["Amount"] = 1,
		},
		
		[7] = {
			["Type"] = "AR2",
			["Amount"] = 30,
		},
		
		[8] = {
			["Type"] = "AR2AltFire",
			["Amount"] = 1,
		},
		
		[9] = {
			["Type"] = "Armor",
			["Amount"] = 60,
		},
		
		[10] = {
			["Type"] = "XBowBolt",
			["Amount"] = 5,
		}
	},
	
	["d3_c17_01"] = {
		[1] = {
			["Type"] = "Pistol",
			["Amount"] = 54,
		},
		
		[2] = {
			["Type"] = "SMG1",
			["Amount"] = 45,
		},
		
		[3] = {
			["Type"] = "357",
			["Amount"] = 6,
		},
		
		[4] = {
			["Type"] = "Buckshot",
			["Amount"] = 12,
		},
		
		[5] = {
			["Type"] = "Grenade",
			["Amount"] = 6,
		},
		
		[6] = {
			["Type"] = "SMG1_Grenade",
			["Amount"] = 1,
		},
		
		[7] = {
			["Type"] = "AR2",
			["Amount"] = 30,
		},
		
		[8] = {
			["Type"] = "AR2AltFire",
			["Amount"] = 1,
		},
		
		[9] = {
			["Type"] = "Armor",
			["Amount"] = 60,
		},
		
		[10] = {
			["Type"] = "XBowBolt",
			["Amount"] = 5,
		}
	},
	
	["d3_c17_02"] = {
		[1] = {
			["Type"] = "Pistol",
			["Amount"] = 54,
		},
		
		[2] = {
			["Type"] = "SMG1",
			["Amount"] = 45,
		},
		
		[3] = {
			["Type"] = "357",
			["Amount"] = 6,
		},
		
		[4] = {
			["Type"] = "Buckshot",
			["Amount"] = 30,
		},
		
		[5] = {
			["Type"] = "Grenade",
			["Amount"] = 6,
		},
		
		[6] = {
			["Type"] = "SMG1_Grenade",
			["Amount"] = 1,
		},
		
		[7] = {
			["Type"] = "AR2",
			["Amount"] = 60,
		},
		
		[8] = {
			["Type"] = "AR2AltFire",
			["Amount"] = 1,
		},
		
		[9] = {
			["Type"] = "Armor",
			["Amount"] = 60,
		},
		
		[10] = {
			["Type"] = "XBowBolt",
			["Amount"] = 5,
		}
	},
	
	["d3_c17_03"] = {
		[1] = {
			["Type"] = "Pistol",
			["Amount"] = 54,
		},
		
		[2] = {
			["Type"] = "SMG1",
			["Amount"] = 45,
		},
		
		[3] = {
			["Type"] = "357",
			["Amount"] = 6,
		},
		
		[4] = {
			["Type"] = "Buckshot",
			["Amount"] = 12,
		},
		
		[5] = {
			["Type"] = "Grenade",
			["Amount"] = 6,
		},
		
		[6] = {
			["Type"] = "SMG1_Grenade",
			["Amount"] = 1,
		},
		
		[7] = {
			["Type"] = "AR2",
			["Amount"] = 30,
		},
		
		[8] = {
			["Type"] = "AR2AltFire",
			["Amount"] = 1,
		},
		
		[9] = {
			["Type"] = "Armor",
			["Amount"] = 60,
		},
		
		[10] = {
			["Type"] = "XBowBolt",
			["Amount"] = 5,
		}
	},
	
	["d3_c17_04"] = {
		[1] = {
			["Type"] = "Pistol",
			["Amount"] = 54,
		},
		
		[2] = {
			["Type"] = "SMG1",
			["Amount"] = 45,
		},
		
		[3] = {
			["Type"] = "357",
			["Amount"] = 6,
		},
		
		[4] = {
			["Type"] = "Buckshot",
			["Amount"] = 12,
		},
		
		[5] = {
			["Type"] = "Grenade",
			["Amount"] = 6,
		},
		
		[6] = {
			["Type"] = "SMG1_Grenade",
			["Amount"] = 1,
		},
		
		[7] = {
			["Type"] = "AR2",
			["Amount"] = 30,
		},
		
		[8] = {
			["Type"] = "AR2AltFire",
			["Amount"] = 1,
		},
		
		[9] = {
			["Type"] = "Armor",
			["Amount"] = 60,
		},
		
		[10] = {
			["Type"] = "XBowBolt",
			["Amount"] = 5,
		}
	},
	
	["d3_c17_05"] = {
		[1] = {
			["Type"] = "Pistol",
			["Amount"] = 54,
		},
		
		[2] = {
			["Type"] = "SMG1",
			["Amount"] = 45,
		},
		
		[3] = {
			["Type"] = "357",
			["Amount"] = 6,
		},
		
		[4] = {
			["Type"] = "Buckshot",
			["Amount"] = 12,
		},
		
		[5] = {
			["Type"] = "Grenade",
			["Amount"] = 6,
		},
		
		[6] = {
			["Type"] = "SMG1_Grenade",
			["Amount"] = 1,
		},
		
		[7] = {
			["Type"] = "AR2",
			["Amount"] = 30,
		},
		
		[8] = {
			["Type"] = "AR2AltFire",
			["Amount"] = 1,
		},
		
		[9] = {
			["Type"] = "Armor",
			["Amount"] = 60,
		},
		
		[10] = {
			["Type"] = "XBowBolt",
			["Amount"] = 5,
		}
	},
	
	["d3_c17_06a"] = {
		[1] = {
			["Type"] = "Pistol",
			["Amount"] = 54,
		},
		
		[2] = {
			["Type"] = "SMG1",
			["Amount"] = 45,
		},
		
		[3] = {
			["Type"] = "357",
			["Amount"] = 6,
		},
		
		[4] = {
			["Type"] = "Buckshot",
			["Amount"] = 12,
		},
		
		[5] = {
			["Type"] = "Grenade",
			["Amount"] = 6,
		},
		
		[6] = {
			["Type"] = "SMG1_Grenade",
			["Amount"] = 1,
		},
		
		[7] = {
			["Type"] = "AR2",
			["Amount"] = 30,
		},
		
		[8] = {
			["Type"] = "AR2AltFire",
			["Amount"] = 1,
		},
		
		[9] = {
			["Type"] = "Armor",
			["Amount"] = 60,
		},
		
		[10] = {
			["Type"] = "XBowBolt",
			["Amount"] = 5,
		}
	},
	
	["d3_c17_06b"] = {
		[1] = {
			["Type"] = "Pistol",
			["Amount"] = 54,
		},
		
		[2] = {
			["Type"] = "SMG1",
			["Amount"] = 45,
		},
		
		[3] = {
			["Type"] = "357",
			["Amount"] = 6,
		},
		
		[4] = {
			["Type"] = "Buckshot",
			["Amount"] = 12,
		},
		
		[5] = {
			["Type"] = "Grenade",
			["Amount"] = 6,
		},
		
		[6] = {
			["Type"] = "SMG1_Grenade",
			["Amount"] = 1,
		},
		
		[7] = {
			["Type"] = "AR2",
			["Amount"] = 30,
		},
		
		[8] = {
			["Type"] = "AR2AltFire",
			["Amount"] = 1,
		},
		
		[9] = {
			["Type"] = "Armor",
			["Amount"] = 60,
		},
		
		[10] = {
			["Type"] = "XBowBolt",
			["Amount"] = 5,
		}
	},
	["d3_c17_07"] = {
		[1] = {
			["Type"] = "Pistol",
			["Amount"] = 54,
		},
		
		[2] = {
			["Type"] = "SMG1",
			["Amount"] = 45,
		},
		
		[3] = {
			["Type"] = "357",
			["Amount"] = 6,
		},
		
		[4] = {
			["Type"] = "Buckshot",
			["Amount"] = 12,
		},
		
		[5] = {
			["Type"] = "Grenade",
			["Amount"] = 6,
		},
		
		[6] = {
			["Type"] = "SMG1_Grenade",
			["Amount"] = 1,
		},
		
		[7] = {
			["Type"] = "AR2",
			["Amount"] = 30,
		},
		
		[8] = {
			["Type"] = "AR2AltFire",
			["Amount"] = 1,
		},
		
		[9] = {
			["Type"] = "Armor",
			["Amount"] = 60,
		},
		
		[10] = {
			["Type"] = "XBowBolt",
			["Amount"] = 5,
		}
	},
	
	["d3_c17_08"] = {
		[1] = {
			["Type"] = "Pistol",
			["Amount"] = 54,
		},
		
		[2] = {
			["Type"] = "SMG1",
			["Amount"] = 45,
		},
		
		[3] = {
			["Type"] = "357",
			["Amount"] = 6,
		},
		
		[4] = {
			["Type"] = "Buckshot",
			["Amount"] = 12,
		},
		
		[5] = {
			["Type"] = "Grenade",
			["Amount"] = 6,
		},
		
		[6] = {
			["Type"] = "SMG1_Grenade",
			["Amount"] = 1,
		},
		
		[7] = {
			["Type"] = "AR2",
			["Amount"] = 30,
		},
		
		[8] = {
			["Type"] = "AR2AltFire",
			["Amount"] = 1,
		},
		
		[9] = {
			["Type"] = "Armor",
			["Amount"] = 60,
		},
		
		[10] = {
			["Type"] = "XBowBolt",
			["Amount"] = 5,
		}
	},
	
	["d3_c17_09"] = {
		[1] = {
			["Type"] = "Pistol",
			["Amount"] = 54,
		},
		
		[2] = {
			["Type"] = "SMG1",
			["Amount"] = 45,
		},
		
		[3] = {
			["Type"] = "357",
			["Amount"] = 6,
		},
		
		[4] = {
			["Type"] = "Buckshot",
			["Amount"] = 12,
		},
		
		[5] = {
			["Type"] = "Grenade",
			["Amount"] = 6,
		},
		
		[6] = {
			["Type"] = "SMG1_Grenade",
			["Amount"] = 1,
		},
		
		[7] = {
			["Type"] = "AR2",
			["Amount"] = 30,
		},
		
		[8] = {
			["Type"] = "AR2AltFire",
			["Amount"] = 1,
		},
		
		[9] = {
			["Type"] = "Armor",
			["Amount"] = 60,
		},
		
		[10] = {
			["Type"] = "XBowBolt",
			["Amount"] = 5,
		}
	},
	
	["d3_c17_10a"] = {
		[1] = {
			["Type"] = "Pistol",
			["Amount"] = 54,
		},
		
		[2] = {
			["Type"] = "SMG1",
			["Amount"] = 45,
		},
		
		[3] = {
			["Type"] = "357",
			["Amount"] = 6,
		},
		
		[4] = {
			["Type"] = "Buckshot",
			["Amount"] = 12,
		},
		
		[5] = {
			["Type"] = "Grenade",
			["Amount"] = 6,
		},
		
		[6] = {
			["Type"] = "SMG1_Grenade",
			["Amount"] = 1,
		},
		
		[7] = {
			["Type"] = "AR2",
			["Amount"] = 30,
		},
		
		[8] = {
			["Type"] = "AR2AltFire",
			["Amount"] = 1,
		},
		
		[9] = {
			["Type"] = "Armor",
			["Amount"] = 60,
		},
		
		[10] = {
			["Type"] = "XBowBolt",
			["Amount"] = 5,
		}
	},
	
	["d3_c17_10b"] = {
		[1] = {
			["Type"] = "Pistol",
			["Amount"] = 54,
		},
		
		[2] = {
			["Type"] = "SMG1",
			["Amount"] = 45,
		},
		
		[3] = {
			["Type"] = "357",
			["Amount"] = 6,
		},
		
		[4] = {
			["Type"] = "Buckshot",
			["Amount"] = 12,
		},
		
		[5] = {
			["Type"] = "Grenade",
			["Amount"] = 6,
		},
		
		[6] = {
			["Type"] = "SMG1_Grenade",
			["Amount"] = 1,
		},
		
		[7] = {
			["Type"] = "AR2",
			["Amount"] = 30,
		},
		
		[8] = {
			["Type"] = "AR2AltFire",
			["Amount"] = 1,
		},
		
		[9] = {
			["Type"] = "Armor",
			["Amount"] = 60,
		},
		
		[10] = {
			["Type"] = "XBowBolt",
			["Amount"] = 5,
		}
	},
	
	["d3_c17_11"] = {
		[1] = {
			["Type"] = "Pistol",
			["Amount"] = 54,
		},
		
		[2] = {
			["Type"] = "SMG1",
			["Amount"] = 45,
		},
		
		[3] = {
			["Type"] = "357",
			["Amount"] = 6,
		},
		
		[4] = {
			["Type"] = "Buckshot",
			["Amount"] = 12,
		},
		
		[5] = {
			["Type"] = "Grenade",
			["Amount"] = 6,
		},
		
		[6] = {
			["Type"] = "SMG1_Grenade",
			["Amount"] = 1,
		},
		
		[7] = {
			["Type"] = "AR2",
			["Amount"] = 30,
		},
		
		[8] = {
			["Type"] = "AR2AltFire",
			["Amount"] = 1,
		},
		
		[9] = {
			["Type"] = "Armor",
			["Amount"] = 60,
		},
		
		[10] = {
			["Type"] = "XBowBolt",
			["Amount"] = 5,
		}
	},
	
	["d3_c17_12"] = {
		[1] = {
			["Type"] = "Pistol",
			["Amount"] = 54,
		},
		
		[2] = {
			["Type"] = "SMG1",
			["Amount"] = 45,
		},
		
		[3] = {
			["Type"] = "357",
			["Amount"] = 6,
		},
		
		[4] = {
			["Type"] = "Buckshot",
			["Amount"] = 12,
		},
		
		[5] = {
			["Type"] = "Grenade",
			["Amount"] = 6,
		},
		
		[6] = {
			["Type"] = "SMG1_Grenade",
			["Amount"] = 1,
		},
		
		[7] = {
			["Type"] = "AR2",
			["Amount"] = 30,
		},
		
		[8] = {
			["Type"] = "AR2AltFire",
			["Amount"] = 1,
		},
		
		[9] = {
			["Type"] = "Armor",
			["Amount"] = 60,
		},
		
		[10] = {
			["Type"] = "XBowBolt",
			["Amount"] = 5,
		}
	},
	
	["d3_c17_12b"] = {
		[1] = {
			["Type"] = "Pistol",
			["Amount"] = 54,
		},
		
		[2] = {
			["Type"] = "SMG1",
			["Amount"] = 45,
		},
		
		[3] = {
			["Type"] = "357",
			["Amount"] = 6,
		},
		
		[4] = {
			["Type"] = "Buckshot",
			["Amount"] = 12,
		},
		
		[5] = {
			["Type"] = "Grenade",
			["Amount"] = 6,
		},
		
		[6] = {
			["Type"] = "SMG1_Grenade",
			["Amount"] = 1,
		},
		
		[7] = {
			["Type"] = "AR2",
			["Amount"] = 30,
		},
		
		[8] = {
			["Type"] = "AR2AltFire",
			["Amount"] = 1,
		},
		
		[9] = {
			["Type"] = "Armor",
			["Amount"] = 60,
		},
		
		[10] = {
			["Type"] = "XBowBolt",
			["Amount"] = 5,
		}
	},
	
	["d3_c17_13"] = {
		[1] = {
			["Type"] = "Pistol",
			["Amount"] = 54,
		},
		
		[2] = {
			["Type"] = "SMG1",
			["Amount"] = 45,
		},
		
		[3] = {
			["Type"] = "357",
			["Amount"] = 6,
		},
		
		[4] = {
			["Type"] = "Buckshot",
			["Amount"] = 12,
		},
		
		[5] = {
			["Type"] = "Grenade",
			["Amount"] = 6,
		},
		
		[6] = {
			["Type"] = "SMG1_Grenade",
			["Amount"] = 1,
		},
		
		[7] = {
			["Type"] = "AR2",
			["Amount"] = 30,
		},
		
		[8] = {
			["Type"] = "AR2AltFire",
			["Amount"] = 1,
		},
		
		[9] = {
			["Type"] = "Armor",
			["Amount"] = 60,
		},
		
		[10] = {
			["Type"] = "XBowBolt",
			["Amount"] = 5,
		}
	},
	
	["d3_citadel_01"] = {
		[1] = {
			["Type"] = "Pistol",
			["Amount"] = 54,
		},
		
		[2] = {
			["Type"] = "SMG1",
			["Amount"] = 45,
		},
		
		[3] = {
			["Type"] = "357",
			["Amount"] = 6,
		},
		
		[4] = {
			["Type"] = "Buckshot",
			["Amount"] = 12,
		},
		
		[5] = {
			["Type"] = "Grenade",
			["Amount"] = 6,
		},
		
		[6] = {
			["Type"] = "SMG1_Grenade",
			["Amount"] = 1,
		},
		
		[7] = {
			["Type"] = "AR2",
			["Amount"] = 30,
		},
		
		[8] = {
			["Type"] = "AR2AltFire",
			["Amount"] = 1,
		},
		
		[9] = {
			["Type"] = "Armor",
			["Amount"] = 60,
		},
		
		[10] = {
			["Type"] = "XBowBolt",
			["Amount"] = 5,
		}
	},
	
	["d3_citadel_03"] = {
		[1] = {
			["Type"] = "Armor",
			["Amount"] = 60,
		}
	},
	
	["d3_citadel_04"] = {
		[1] = {
			["Type"] = "Armor",
			["Amount"] = 60,
		}
	},
	
	["d3_citadel_05"] = {
		[1] = {
			["Type"] = "Armor",
			["Amount"] = 60,
		}
	},
	
	["d3_breen_01"] = {
		[1] = {
			["Type"] = "Armor",
			["Amount"] = 75,
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
    
    if HL2_TRIGGERS[game.GetMap()]["changelevels_special"] and (file.Exists("hl2cr_data/ravenholmcheck.txt", "DATA") or file.Exists("hl2cr_data/bridgecheck.txt", "DATA"))then
        local special_changelevel = ents.Create("trigger_changemap")
        special_changelevel.Min = Vector(HL2_TRIGGERS[game.GetMap()]["changelevels_special"][1])
        special_changelevel.Max = Vector(HL2_TRIGGERS[game.GetMap()]["changelevels_special"][2])
        special_changelevel.Pos = Vector(HL2_TRIGGERS[game.GetMap()]["changelevels_special"][2]) - 
        ( ( Vector(HL2_TRIGGERS[game.GetMap()]["changelevels_special"][2]) - Vector(HL2_TRIGGERS[game.GetMap()]["changelevels_special"][1])) 
        / 2 )
        
        special_changelevel:SetPos(special_changelevel.Pos)
        special_changelevel:Spawn()

        special_changelevel.lambdaModel = ents.Create("prop_dynamic")
        special_changelevel.lambdaModel:SetModel("models/hl2cr_lambda.mdl")
        special_changelevel.lambdaModel:SetPos(changelevel.Pos)
        special_changelevel.lambdaModel:Spawn()
        special_changelevel.lambdaModel:ResetSequence("idle")
        special_changelevel.lambdaModel:SetMaterial("phoenix_storms/wire/pcb_green")
    end

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

local remove_vehicles = {
	["prop_vehicle_airboat"] = true,
	["pro_vehicle_jeep_old"] = true,
	["pro_vehicle_jeep"] = true
}

local function SetUpMisc()

    local MapLua = ents.Create("lua_run")
	MapLua:SetName("hl2crlua")
	MapLua:Spawn()

    SetGlobalBool( "HL2CR_GLOBAL_SUIT", false )

    for _, failer in ipairs(ents.FindByName("fall_trigger")) do
		failer:Remove()
	end

    timer.Simple(0.1, function()
		for _, ent in ipairs(ents.GetAll()) do
			if string.find(ent:GetName(), "global_newgame_") and not remove_vehicles[ent:GetClass()] then
				ent:Remove()
			end
		end
	end)
	
	if HL2_WEAPONS[game.GetMap()] then
		for i, wep in pairs(HL2_WEAPONS[game.GetMap()]) do 
			table.insert(SPAWNING_WEAPONS, wep)
		end
	end
	
	if HL2_EQUIPMENT[game.GetMap()] then
		table.insert(SPAWNING_ITEMS, HL2_EQUIPMENT[game.GetMap()])
	end

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

    if game.GetMap() == "d1_eli_02" then
		for k, g in ipairs( ents.FindByName( "trigger_Get_physgun" )) do
			g:Fire("AddOutput", "OnTrigger hl2crlua:RunPassedCode:GiveGravGun()" )
		end

		for k, basket in ipairs(ents.FindByName("trigger_BBall_score_top")) do
			basket:Fire("AddOutput", "OnEndTouch hl2crlua:RunPassedCode:GiveBallAch():0:-1" )
		end
	end

    if game.GetMap() == "d1_town_03" then
		ents.FindByName("street_lever")[1]:Fire("AddOutput", "OnPressed hl2crlua:RunPassedCode:RemovePushTrigger()")
	end

    if file.Exists("hl2cr_data/ravenholmcheck.txt", "DATA") and game.GetMap() == "d1_town_02" then
		for i, s in ipairs(ents.FindByClass("info_player_start")) do
			s:SetPos(Vector(-3763, -36, -3439))
			s:SetAngles(Angle(0, 90, 0))
		end
    end

    if game.GetMap() == "d1_town_02a" and file.Exists("hl2cr_data/ravenholmcheck.txt", "DATA") then
		file.Delete("hl2cr_data/ravenholmcheck.txt", "DATA")
	end

    if game.GetMap() == "d2_coast_01" then
		local fixLeap = ents.Create("prop_dynamic")
		fixLeap:SetPos(Vector(-8606, 476, 961))
		fixLeap:SetAngles(Angle(0, 180, 0))
		fixLeap:SetModel("models/props_wasteland/cargo_container01.mdl")
		fixLeap:PhysicsInit(SOLID_VPHYSICS)
		fixLeap:Spawn()
		
		local fixLeap2 = ents.Create("prop_dynamic")
		fixLeap2:SetPos(Vector(-8477, 476, 961))
		fixLeap2:SetAngles(Angle(0, 180, 0))
		fixLeap2:SetModel("models/props_wasteland/cargo_container01.mdl")
		fixLeap2:PhysicsInit(SOLID_VPHYSICS)
		fixLeap2:Spawn()
	end
	
	if game.GetMap() == "d2_coast_03" then
		ents.FindByName("gunship_spawner_2")[1]:Fire("AddOutput", "OnAllSpawnedDead hl2crlua:RunPassedCode:OpenGateCoast():0:-1" )
	end
	
	if game.GetMap() == "d2_coast_04" then
		local fixLeap = ents.Create("prop_dynamic")
		fixLeap:SetPos(Vector(-1813, 1204, 860))
		fixLeap:SetAngles(Angle(0, -90, 0))
		fixLeap:SetModel("models/props_wasteland/cargo_container01.mdl")
		fixLeap:PhysicsInit(SOLID_VPHYSICS)
		fixLeap:Spawn()
		
		local fixLeap2 = ents.Create("prop_dynamic")
		fixLeap2:SetPos(Vector(-1813, 1074, 860))
		fixLeap2:SetAngles(Angle(0, -90, 0))
		fixLeap2:SetModel("models/props_wasteland/cargo_container01.mdl")
		fixLeap2:PhysicsInit(SOLID_VPHYSICS)
		fixLeap2:Spawn()
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

function GiveGravGun()
	for k, v in ipairs(player.GetAll()) do
		v:Give("weapon_physcannon")
		v:GrantAchievement("Zero-Point Energy")
	end
end

function GiveBallAch()
	for k, v in ipairs(player.GetAll()) do
		v:GrantAchievement("Two Points")
	end
end

function OpenGateCoast()
	for k, v in ipairs(ents.FindByName("village_gate")) do
		v:Fire("Open")
	end

	disableJeepGlobal = false
	
	for k, v in ipairs(player.GetAll()) do
		v:GrantAchievement("Where Cubbage Fears to Tread")
	end
end