local function SetCheckpoints()
	for k, cl in ipairs(ents.FindByClass("trigger_changelevel")) do
		cl:Remove()
	end
	
	if game.GetMap() == "ep1_citadel_00" then

		TRIGGER_CHANGELEVEL = {
			Vector(5374, 2784, -6197),		Vector(5508, 2652, -6345)
		}

		TRIGGER_CHECKPOINT = {
			Vector(-8932, 5740, -145), 		Vector(-9025, 5834, -25),
			Vector(-7810, 5506, -4), 		Vector(-8046, 5358, -98),
			Vector(4569, 3993, -6185), 		Vector(4766, 4159, -6349)
		}
			
		CHECKPOINT_POS = {
			Vector(-8974, 5781, -134),		Vector(-7908, 5435, -83),
			Vector(4680, 4230, -6348)
		}
	elseif game.GetMap() == "ep1_citadel_01" then

		TRIGGER_CHANGELEVEL = {
			Vector(-2952, 1391, 2467),		Vector(-3110, 1272, 2646)
		}

		TRIGGER_CHECKPOINT = {
			Vector(-4826, 7538, 2702), 		Vector(-4578, 7555, 2521),
			Vector(-4548, 5124, 2744), 		Vector(-4650, 5209, 2595),
			Vector(-4946, 1672, 2682), 		Vector(-4763, 1290, 2462)
		}
			
		CHECKPOINT_POS = {
			Vector(-4711, 7650, 2531),		Vector(-4865, 5240, 2605),
			Vector(-4864, 1536, 2471)
		}
	elseif game.GetMap() == "ep1_citadel_02" then

		TRIGGER_CHANGELEVEL = {
			Vector(1712, 42, 959),		Vector(1840, 134, 833)
		}

		TRIGGER_CHECKPOINT = {
			Vector(1257, 806, 971), 		Vector(1334, 784, 834)
		}
			
		CHECKPOINT_POS = {
			Vector(1302, 686, 840)
		}
	elseif game.GetMap() == "ep1_citadel_02b" then

		TRIGGER_CHANGELEVEL = {
			Vector(5487, 4814, -6718),		Vector(5333, 4480, -6521)
		}

		TRIGGER_CHECKPOINT = {
			Vector(3446, 4867, 2509), 		Vector(3076, 4402, 2663),
			Vector(3966, 4813, -6716), 		Vector(3777, 4465, -6541)
		}
			
		CHECKPOINT_POS = {
			Vector(3279, 4644, 2534),		Vector(3995, 4634, -6703)
		}
		
		CHECKPOINT_FUNC_1 = function()
			timer.Simple(0.1, function()
				local lift = ents.FindByName("citadel_train_lift01_1")[1]
				for l, spawn in pairs(ents.FindByClass("info_player_start")) do
					spawn:SetPos(lift:GetPos() + Vector(0, 0, 75))
					spawn:SetParent(lift)
				end
			end)
		end
		
		CHECKPOINT_FUNC_2 = function()
			for l, spawn in pairs(ents.FindByClass("info_player_start")) do
				spawn:SetParent(nil)
			end
		end
		
		CHANGELEVEL_FUNC = function()
			for _, v in ipairs(player.GetAll()) do	
				GrantAchievement(v, "EP1", "Citadel_Lift")
			end
		end
	elseif game.GetMap() == "ep1_citadel_03" then

		TRIGGER_CHANGELEVEL = {
			Vector(921, 13276, 3935),		Vector(1272, 13119, 3712)
		}

		TRIGGER_CHECKPOINT = {
			Vector(1884, 11595, 4419), 		Vector(1999, 11902, 4226),
			Vector(1927, 10407, 5794), 		Vector(1786, 10607, 5630),
			Vector(1040, 12607, 5465), 		Vector(1199, 12432, 5314),
			Vector(1056, 13505, 3713), 		Vector(1213, 13545, 3934)
		}
			
		CHECKPOINT_POS = {
			Vector(1955, 11735, 4242),		Vector(1918, 10679, 5637),
			Vector(1112, 12528, 5323),		Vector(1116, 13469, 3723)
		}
		
		CHECKPOINT_FUNC_3 = function()
			if not pacifistAchGlobal then return end
			
			for _, v in ipairs(player.GetAll()) do	
				GrantAchievement(v, "EP1", "Pacifist_Stalkers")
			end
		end
	elseif game.GetMap() == "ep1_citadel_04" then

		TRIGGER_CHANGELEVEL = {
			Vector(4155, 8194, 3326),		Vector(4015, 8150, 3454)
		}

		TRIGGER_CHECKPOINT = {
			Vector(3249, 11813, 3766), 		Vector(3453, 11886, 3601),
			Vector(3696, 8017, 3579), 		Vector(3821, 7877, 3695)
		}
			
		CHECKPOINT_POS = {
			Vector(3387, 11756, 3618),		Vector(3772, 7959, 3602)
		}
		
		CHECKPOINT_FUNC_1 = function()
			ents.FindByClass("npc_alyx")[1]:SetPos(Vector(3408, 11854, 3610))
		end
		
	elseif game.GetMap() == "ep1_c17_00" then
		TRIGGER_CHANGELEVEL = {
			Vector(1776, 143, 456),		Vector(1902, 64, 332)
		}

		TRIGGER_CHECKPOINT = {
			Vector(4154, -2670, 10), 		Vector(4269, -2935, -121)
		}
			
		CHECKPOINT_POS = {
			Vector(4213, -2862, -111),		Vector(3772, 7959, 3602)
		}
	elseif game.GetMap() == "ep1_c17_00a" then
		TRIGGER_CHANGELEVEL = {
			Vector(4517, 3635, 1898),		Vector(4667, 3522, 1668)
		}

		TRIGGER_CHECKPOINT = {
			Vector(2669, 3871, 536), 		Vector(2811, 4114, 410),
			Vector(4666, 3642, 664), 		Vector(4522, 3521, 822)
		}
			
		CHECKPOINT_POS = {
			Vector(4326, 3589, 420),		Vector(4586, 3580, 684)
		}
	elseif game.GetMap() == "ep1_c17_01" then
		TRIGGER_CHANGELEVEL = {
			Vector(-3615, 207, 122),		Vector(-3693, 269, 1)
		}

		TRIGGER_CHECKPOINT = {
			Vector(2817, -1427, 109), 		Vector(2893, -1305, 3),
			Vector(1823, 2185, 97), 		Vector(1918, 2278, 254),
			Vector(-577, 760, 1), 		Vector(-641, 852, 127)
		}
			
		CHECKPOINT_POS = {
			Vector(2633, -1311, 12),		Vector(1825, 2231, 115),
			Vector(-604, 813, 13)
		}
	elseif game.GetMap() == "ep1_c17_02" then
		TRIGGER_CHANGELEVEL = {
			Vector(-2480, 2208, -23),		Vector(-2455, 2286, -125)
		}

		TRIGGER_CHECKPOINT = {
			Vector(1013, -226, 136), 		Vector(1105, -162, 18),
			Vector(-1096, 1606, 78), 		Vector(-903, 1684, -2)
		}
			
		CHECKPOINT_POS = {
			Vector(1056, -235, 32),		Vector(-1008, 1758, 4)
		}
	elseif game.GetMap() == "ep1_c17_02b" then
		TRIGGER_CHANGELEVEL = {
			Vector(-718, 3997, 511),		Vector(-465, 4243, 320)
		}

		TRIGGER_CHECKPOINT = {
			Vector(1089, 1972, -254), 		Vector(1216, 1940, -135),
			Vector(1403, 1817, 129), 		Vector(1354, 1954, 248)
		}
			
		CHECKPOINT_POS = {
			Vector(1152, 1944, -244),	Vector(1214, 1893, 142)
		}
	elseif game.GetMap() == "ep1_c17_02a" then
		TRIGGER_CHANGELEVEL = {
			Vector(-2793, 8209, -2689),		Vector(-2608, 8249, -2832)
		}

		TRIGGER_CHECKPOINT = {
			Vector(944, 8684, -2431), 		Vector(1184, 8749, -2562),
			Vector(-658, 9533, -2681), 		Vector(-673, 9591, -2577)
		}
			
		CHECKPOINT_POS = {
			Vector(1115, 8892, -2544),		Vector(-663, 9619, -2681)
		}
	elseif game.GetMap() == "ep1_c17_06" then
		TRIGGER_CHANGELEVEL = {
			Vector(-12764, -5814, -954),		Vector(-13259, -5632, -528)
		}

		TRIGGER_CHECKPOINT = {
			Vector(10152, 8421, -758), 		Vector(10223, 8319, -650),
			Vector(11839, 8328, -658), 		Vector(11894, 8428, -758)
		}
			
		CHECKPOINT_POS = {
			Vector(10362, 8272, -733),		Vector(11930, 8367, -739)
		}
		
		CHANGELEVEL_FUNC = function()
			for _, v in ipairs(player.GetAll()) do
				v:SetPos(Vector(-13094, -5773, -867))
				GrantAchievement(v, "EP1", "Beat_EP1")
			end
		end
	end
	
	if TRIGGER_CHECKPOINT then
	
		if TRIGGER_CHECKPOINT[1] and TRIGGER_CHECKPOINT[2] then
			local Checkpoint = ents.Create("trigger_checkpoint")
			Checkpoint.Min = Vector(TRIGGER_CHECKPOINT[1])
			Checkpoint.Max = Vector(TRIGGER_CHECKPOINT[2])
			Checkpoint.Pos = Vector(TRIGGER_CHECKPOINT[2]) - ( ( Vector(TRIGGER_CHECKPOINT[2]) - Vector(TRIGGER_CHECKPOINT[1])) / 2 )
			Checkpoint.Point = Vector(CHECKPOINT_POS[1])
			Checkpoint:SetPos(Checkpoint.Pos)
			Checkpoint:SetPointIndex(1)
			Checkpoint:Spawn()
			
			Checkpoint.lambdaModel = ents.Create("prop_dynamic")
			Checkpoint.lambdaModel:SetModel("models/hl2cr_lambda.mdl")
			Checkpoint.lambdaModel:SetPos(Checkpoint.Pos)
			Checkpoint.lambdaModel:Spawn()
			Checkpoint.lambdaModel:ResetSequence("idle")
			Checkpoint.lambdaModel:SetMaterial(Checkpoint.Mat)
			
			Checkpoint.Func = CHECKPOINT_FUNC_1
		end
		
		if TRIGGER_CHECKPOINT[3] and TRIGGER_CHECKPOINT[4] then
			local Checkpoint = ents.Create("trigger_checkpoint")
			Checkpoint.Min = Vector(TRIGGER_CHECKPOINT[3])
			Checkpoint.Max = Vector(TRIGGER_CHECKPOINT[4])
			Checkpoint.Pos = Vector(TRIGGER_CHECKPOINT[4]) - ( ( Vector(TRIGGER_CHECKPOINT[4]) - Vector(TRIGGER_CHECKPOINT[3])) / 2 )
			Checkpoint.Point = Vector(CHECKPOINT_POS[2])
			Checkpoint:SetPos(Checkpoint.Pos)
			Checkpoint:SetPointIndex(2)
			Checkpoint:Spawn()
			
			Checkpoint.lambdaModel = ents.Create("prop_dynamic")
			Checkpoint.lambdaModel:SetModel("models/hl2cr_lambda.mdl")
			Checkpoint.lambdaModel:SetPos(Checkpoint.Pos)
			Checkpoint.lambdaModel:Spawn()
			Checkpoint.lambdaModel:ResetSequence("idle")
			Checkpoint.lambdaModel:SetMaterial(Checkpoint.Mat)
			
			Checkpoint.Func = CHECKPOINT_FUNC_2
		end
		
		if TRIGGER_CHECKPOINT[5] and TRIGGER_CHECKPOINT[6] then
			local Checkpoint = ents.Create("trigger_checkpoint")
			Checkpoint.Min = Vector(TRIGGER_CHECKPOINT[5])
			Checkpoint.Max = Vector(TRIGGER_CHECKPOINT[6])
			Checkpoint.Pos = Vector(TRIGGER_CHECKPOINT[6]) - ( ( Vector(TRIGGER_CHECKPOINT[6]) - Vector(TRIGGER_CHECKPOINT[5])) / 2 )
			Checkpoint.Point = Vector(CHECKPOINT_POS[3])
			Checkpoint:SetPos(Checkpoint.Pos)
			Checkpoint:SetPointIndex(3)
			Checkpoint:Spawn()

			Checkpoint.lambdaModel = ents.Create("prop_dynamic")
			Checkpoint.lambdaModel:SetModel("models/hl2cr_lambda.mdl")
			Checkpoint.lambdaModel:SetPos(Checkpoint.Pos)
			Checkpoint.lambdaModel:Spawn()
			Checkpoint.lambdaModel:ResetSequence("idle")
			Checkpoint.lambdaModel:SetMaterial(Checkpoint.Mat)
			
			Checkpoint.Func = CHECKPOINT_FUNC_3
		end
		
		if TRIGGER_CHECKPOINT[7] and TRIGGER_CHECKPOINT[8] then
			local Checkpoint = ents.Create("trigger_checkpoint")
			Checkpoint.Min = Vector(TRIGGER_CHECKPOINT[7])
			Checkpoint.Max = Vector(TRIGGER_CHECKPOINT[8])
			Checkpoint.Pos = Vector(TRIGGER_CHECKPOINT[8]) - ( ( Vector(TRIGGER_CHECKPOINT[8]) - Vector(TRIGGER_CHECKPOINT[7])) / 2 )
			Checkpoint.Point = Vector(CHECKPOINT_POS[4])
			Checkpoint:SetPos(Checkpoint.Pos)
			Checkpoint:SetPointIndex(4)
			Checkpoint:Spawn()

			Checkpoint.lambdaModel = ents.Create("prop_dynamic")
			Checkpoint.lambdaModel:SetModel("models/hl2cr_lambda.mdl")
			Checkpoint.lambdaModel:SetPos(Checkpoint.Pos)
			Checkpoint.lambdaModel:Spawn()
			Checkpoint.lambdaModel:ResetSequence("idle")
			Checkpoint.lambdaModel:SetMaterial(Checkpoint.Mat)
			
			Checkpoint.Func = CHECKPOINT_FUNC_4
		end
		
	end
	
	if TRIGGER_CHANGELEVEL then
		local Changelevel = ents.Create("trigger_changelevel")
		Changelevel.Min = Vector(TRIGGER_CHANGELEVEL[1])
		Changelevel.Max = Vector(TRIGGER_CHANGELEVEL[2])
		Changelevel.Pos = Vector(TRIGGER_CHANGELEVEL[2]) - ( ( Vector(TRIGGER_CHANGELEVEL[2]) - Vector(TRIGGER_CHANGELEVEL[1])) / 2 )
		Changelevel:SetPos(Changelevel.Pos)
		Changelevel:Spawn()
			
		Changelevel.lambdaModel = ents.Create("prop_dynamic")
		Changelevel.lambdaModel:SetModel("models/hl2cr_lambda.mdl")
		Changelevel.lambdaModel:SetPos(Changelevel.Pos)
		Changelevel.lambdaModel:Spawn()
		Changelevel.lambdaModel:SetName("lambdaCheckpoint")
		Changelevel.lambdaModel:ResetSequence("idle")
		Changelevel.lambdaModel:SetMaterial("phoenix_storms/wire/pcb_green")
		
		Changelevel.Func = CHANGELEVEL_FUNC
	end
	
	if TRIGGER_PUSHBACK then
		local PushBack = ents.Create("trigger_pushback")
		PushBack.Min = Vector(TRIGGER_PUSHBACK[1])
		PushBack.Max = Vector(TRIGGER_PUSHBACK[2])
		PushBack.Pos = Vector(TRIGGER_PUSHBACK[2]) - ( ( Vector(TRIGGER_PUSHBACK[2]) - Vector(TRIGGER_PUSHBACK[1])) / 2 )
		PushBack:SetPos(PushBack.Pos)
		PushBack:SetName("hl2cr_pushback")
		PushBack:Spawn()
	end
end

local EP1_WEAPONS = {
	
	["ep1_citadel_01"] = {
		[1] = "weapon_physcannon",
	},
	
	["ep1_citadel_02"] = {
		[1] = "weapon_physcannon",
	},
	
	["ep1_citadel_02b"] = {
		[1] = "weapon_physcannon",
	},
	
	["ep1_citadel_03"] = {
		[1] = "weapon_physcannon",
	},
	
	["ep1_citadel_04"] = {
		[1] = "weapon_physcannon",
	},
	
	["ep1_c17_00"] = {
		[1] = "weapon_physcannon",
	},
	
	["ep1_c17_00a"] = {
		[1] = "weapon_physcannon",
		[2] = "weapon_pistol",
		[3] = "weapon_shotgun",
	},
	
	["ep1_c17_00a"] = {
		[1] = "weapon_physcannon",
		[2] = "weapon_pistol",
		[3] = "weapon_shotgun",
	},
	
	["ep1_c17_01"] = {
		[1] = "weapon_physcannon",
		[2] = "weapon_pistol",
		[3] = "weapon_shotgun",
	},
	
	["ep1_c17_02"] = {
		[1] = "weapon_physcannon",
		[2] = "weapon_pistol",
		[3] = "weapon_smg1",
		[4] = "weapon_shotgun",
	},
	
	["ep1_c17_02b"] = {
		[1] = "weapon_physcannon",
		[2] = "weapon_pistol",
		[3] = "weapon_smg1",
		[4] = "weapon_ar2",
		[5] = "weapon_shotgun",
	},
	
	["ep1_c17_02a"] = {
		[1] = "weapon_crowbar",
		[2] = "weapon_physcannon",
		[3] = "weapon_pistol",
		[4] = "weapon_smg1",
		[5] = "weapon_ar2",
		[6] = "weapon_shotgun",
		[7] = "weapon_crossbow",
	},
	
	["ep1_c17_05"] = {
		[1] = "weapon_crowbar",
		[2] = "weapon_physcannon",
		[3] = "weapon_pistol",
		[4] = "weapon_smg1",
		[5] = "weapon_ar2",
		[6] = "weapon_shotgun",
		[7] = "weapon_crossbow",
		[8] = "weapon_rpg",
	},
	
	["ep1_c17_06"] = {
		[1] = "weapon_crowbar",
		[2] = "weapon_physcannon",
		[3] = "weapon_pistol",
		[4] = "weapon_357",
		[5] = "weapon_smg1",
		[6] = "weapon_ar2",
		[7] = "weapon_shotgun",
		[8] = "weapon_crossbow",
		[9] = "weapon_rpg",
	},
}

local EP1_EQUIPMENT = {
	["ep1_c17_00a"] = {		
		[1] = {
			["Type"] = "Armor",
			["Amount"] = 25,
		},
		
		[2] = {
			["Type"] = "Pistol",
			["Amount"] = 54,
		},
		
		[3] = {
			["Type"] = "Buckshot",
			["Amount"] = 12,
		},
	},
	
	["ep1_c17_01"] = {
		[1] = {
			["Type"] = "Pistol",
			["Amount"] = 54,
		},
		
		[2] = {
			["Type"] = "Buckshot",
			["Amount"] = 12,
		},
		
		[3] = {
			["Type"] = "AR2",
			["Amount"] = 30,
		},
		
		[4] = {
			["Type"] = "Armor",
			["Amount"] = 25,
		}
	},
	
	["ep1_c17_02"] = {
		[1] = {
			["Type"] = "Pistol",
			["Amount"] = 54,
		},
		
		[2] = {
			["Type"] = "Buckshot",
			["Amount"] = 12,
		},
		
		[3] = {
			["Type"] = "AR2",
			["Amount"] = 30,
		},
		
		[4] = {
			["Type"] = "Armor",
			["Amount"] = 25,
		},
		
		[5] = {
			["Type"] = "SMG1",
			["Amount"] = 45,
		},
	},
	
	["ep1_c17_02b"] = {
		[1] = {
			["Type"] = "Pistol",
			["Amount"] = 54,
		},
		
		[2] = {
			["Type"] = "SMG1",
			["Amount"] = 45,
		},
		
		[3] = {
			["Type"] = "Buckshot",
			["Amount"] = 6,
		},
		
		[4] = {
			["Type"] = "AR2",
			["Amount"] = 30,
		},
		
		[5] = {
			["Type"] = "Armor",
			["Amount"] = 25,
		}
	},
	
	["ep1_c17_02a"] = {
		[1] = {
			["Type"] = "Pistol",
			["Amount"] = 54,
		},
		
		[2] = {
			["Type"] = "SMG1",
			["Amount"] = 45,
		},
		
		[3] = {
			["Type"] = "Buckshot",
			["Amount"] = 6,
		},
		
		[4] = {
			["Type"] = "AR2",
			["Amount"] = 30,
		},
		
		[5] = {
			["Type"] = "Armor",
			["Amount"] = 25,
		},
		
		[6] = {
			["Type"] = "Xbolt",
			["Amount"] = 5,
		},
	},
	
	["ep1_c17_02a"] = {
		[1] = {
			["Type"] = "Pistol",
			["Amount"] = 54,
		},
		
		[2] = {
			["Type"] = "SMG1",
			["Amount"] = 45,
		},
		
		[3] = {
			["Type"] = "Buckshot",
			["Amount"] = 6,
		},
		
		[4] = {
			["Type"] = "AR2",
			["Amount"] = 30,
		},
		
		[5] = {
			["Type"] = "Xbolt",
			["Amount"] = 5,
		},
		
		[6] = {
			["Type"] = "Armor",
			["Amount"] = 25,
		}
	},
	
	["ep1_c17_05"] = {
		[1] = {
			["Type"] = "Pistol",
			["Amount"] = 54,
		},
		
		[2] = {
			["Type"] = "SMG1",
			["Amount"] = 45,
		},
		
		[3] = {
			["Type"] = "Buckshot",
			["Amount"] = 6,
		},
		
		[4] = {
			["Type"] = "AR2",
			["Amount"] = 30,
		},
		
		[5] = {
			["Type"] = "Xbolt",
			["Amount"] = 5,
		},
		
		[6] = {
			["Type"] = "RPG",
			["Amount"] = 3,
		},
		
		[7] = {
			["Type"] = "Armor",
			["Amount"] = 25,
		}
	},
	
	["ep1_c17_06"] = {
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
			["Type"] = "AR2",
			["Amount"] = 30,
		},
		
		[6] = {
			["Type"] = "Xbolt",
			["Amount"] = 5,
		},
		
		[7] = {
			["Type"] = "RPG",
			["Amount"] = 3,
		},
		
		[8] = {
			["Type"] = "Armor",
			["Amount"] = 25,
		}
	},
}

local function SetUpMisc()
	local MapLua = ents.Create("lua_run")
	MapLua:SetName("triggerhook")
	MapLua:Spawn()
	
	timer.Simple(1.5, function()
		for _, ent in ipairs(ents.GetAll()) do
			if (string.find(ent:GetName(), "global_newgame_spawner")) then
				ent:Remove()
			end
		end
	end)
	
	if EP1_WEAPONS[game.GetMap()] then
		for i, wep in pairs(EP1_WEAPONS[game.GetMap()]) do 
			table.insert(SPAWNING_WEAPONS, wep)
		end
	end
	
	if EP1_EQUIPMENT[game.GetMap()] then
		table.insert(SPAWNING_ITEMS, EP1_EQUIPMENT[game.GetMap()])
	end
	
	if game.GetMap() == "ep1_citadel_00" then
		RunConsoleCommand("sv_auxpow_sprint_enabled", 1)
		
		ents.FindByName("relay_givegravgun_1")[1]:Fire("AddOutput", "OnTrigger triggerhook:RunPassedCode:GiveGravgunEP1()" )
		
		ents.FindByName("ss_dog_climb")[1]:Fire("AddOutput", "OnEndSequence triggerhook:RunPassedCode:FixDog00part1()")
		ents.FindByName("ss_alyx_climb")[1]:Fire("AddOutput", "OnEndSequence triggerhook:RunPassedCode:FixAlyx00()")
		ents.FindByName("relay_Van_crash_gate_1")[1]:Fire("AddOutput", "OnTrigger triggerhook:RunPassedCode:FixDog00part2()")
	end
	
	if game.GetMap() == "ep1_citadel_01" then
		ents.FindByName("logic_alyx_EMP_5")[1]:Fire("AddOutput", "OnTrigger triggerhook:RunPassedCode:FixBrushWall()")
	end
	
	if game.GetMap() == "ep1_citadel_02" then
		game.SetGlobalState("super_phys_gun", 1)
	end
	
	if game.GetMap() == "ep1_citadel_02b" then
		ents.FindByName("impact_trigger")[1]:Fire("AddOutput", "OnTrigger triggerhook:RunPassedCode:FailedMap()")
		
		
		for k, spawn in ipairs(ents.FindByClass("info_player_start")) do 
			if k ~= 1 then
				spawn:Remove()
			end
		end
	end
	
	if game.GetMap() == "ep1_citadel_03" then
		for k, spawn in ipairs(ents.FindByClass("info_player_start")) do 
			if k ~= 1 then
				spawn:Remove()
			end
		end
		
		pacifistAchGlobal = true
		
		ents.FindByName("trigger_physgunpower")[1]:Fire("AddOutput", "OnTrigger triggerhook:RunPassedCode:AchAll('Containment')")
		
		for _, failer in ipairs(ents.FindByName("trigger_fall")) do
			failer:Remove()
		end
	end
	
	if game.GetMap() == "ep1_c17_00" then
		ents.FindByName("train_2_ambush_zombine")[1]:SetHealth(1)
	end
	
	if game.GetMap() == "ep1_c17_02" then
		ents.FindByName("timer_give_guard_health")[1]:Remove()
	end
	
	if game.GetMap() == "ep1_c17_05" then
		ents.FindByName("trigger_citizen_boardtrain")[1]:Fire("Enable")
		ents.FindByName("lcs_rearsoldierslock")[1]:Fire("AddOutput", "OnCompletion triggerhook:RunPassedCode:FinishMap05()")
	end
end

function FixBrushWall()
	ents.FindByName("clip_combineshieldwall6")[1]:Fire("Disable")
end

function FixDog00part1()
	ents.FindByClass("npc_dog")[1]:SetPos(Vector(-8646, 5986, -61))
end

function FixDog00part2()
	timer.Simple(9, function()
		ents.FindByClass("npc_dog")[1]:SetPos(Vector(-6464, 6196, -89))
	end)
end

function FixAlyx00()
	ents.FindByClass("npc_alyx")[1]:SetPos(Vector(-8646, 5986, -61))
end

function CitizenFollow()
	local test = ents.Create("npc_citizen")
	test:SetPos(Vector(10461, 10230, -771))
	test:Spawn()
end

function FinishMap05()
	for _, v in ipairs(player.GetAll()) do
		v:SetTeam(TEAM_COMPLETED_MAP)
		EnableSpectate(v)
		ShowMapResults(v)
	end
	
	StartMapCountdown()
	net.Start("HL2CR_MapCountdown")
	net.Broadcast()
end

hook.Add( "AcceptInput", "HL2CR_EP1_ReachedEnd05", function( ent, name, activator, caller, data )
	if ent:GetName() == "trigger_citizen_boardtrain_dryrun" or ent:GetName() == "trigger_citizen_boardtrain" then
		if activator:GetClass() ~= "npc_citizen" then return end
		activator.ReachedEnd = true
	end
end )

hook.Add("Tick", "HL2CR_CitizenFollow05", function()
	if game.GetMap() == "ep1_c17_05" then
		for _, cit in ipairs(ents.FindByClass("npc_citizen")) do
			if not cit or not string.find(cit:GetName(), "citizen_refugees_") then continue end
			if cit.ReachedEnd == true then continue end
			if (cit:GetPos():Distance(player.GetAll()[1]:GetPos()) > 50 and cit:GetPos():Distance(player.GetAll()[1]:GetPos()) <= 500) and not cit:IsCurrentSchedule(SCHED_FORCED_GO_RUN) then
				cit:SetLastPosition( player.GetAll()[1]:GetPos() )
				cit:SetSchedule(SCHED_FORCED_GO_RUN)
			end
		end
	end
end)

hook.Add( "EntityTakeDamage", "HL2CR_EP1_SafetyFirst", function( prop, dmginfo )	
	if game.GetMap() == "ep1_c17_02a" and prop:GetModel() == "models/gunship.mdl" then
		if not dmginfo:GetAttacker():IsPlayer() then return end
		
		if dmginfo:GetAttacker():GetActiveWeapon():GetClass() ~= "weapon_crowbar" then return end
		
		if not dmginfo:GetAttacker().SafetyProg then
			dmginfo:GetAttacker().SafetyProg = 1
		end
		
		dmginfo:GetAttacker().SafetyProg = dmginfo:GetAttacker().SafetyProg + 1

		if dmginfo:GetAttacker().SafetyProg == 6 then
			GrantAchievement(dmginfo:GetAttacker(), "EP1", "Safety_First")
		else 
			return
		end

	end
end)

hook.Add("OnNPCKilled", "HL2CR_EP1_Achievements", function(npc, attacker, inflictor)
	if game.GetMap() == "ep1_citadel_03" then
		if npc:GetClass() == "npc_stalker" and attacker:IsPlayer() then
			pacifistAchGlobal = false
	
			local FAILER = {
				["Colour"] = Color(215, 50, 50),
				["Message"] = "ACH_FAILED_PACIFIST",
				["Other"] = {
					["Player"] = attacker:Nick()
				}
			}
	
			BroadcastMessage(FAILER)
		end
	end
	
	if game.GetMap() == "ep1_c17_02a" and ents.FindByClass("npc_combinegunship")[1] then
		ents.FindByClass("npc_combinegunship")[1]:Fire("AddOutput", "OnDeath triggerhook:RunPassedCode:AchAll('Attica')")
	end
end)

function GiveGravgunEP1()
	for k, v in ipairs(player.GetAll()) do
		v:Give("weapon_physcannon")
	end
end

function AchAll(achName)
	for _, v in ipairs(player.GetAll()) do	
		GrantAchievement(v, "EP1", achName)
	end
end

function StartEP1()
	SetCheckpoints()
	SetUpMisc()
end