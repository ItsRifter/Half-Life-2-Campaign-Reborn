local function SetCheckpoints()
	
	for k, cl in ipairs(ents.FindByClass("trigger_changelevel")) do
		cl:Remove()
	end
	
	for k, clcoop in ipairs(ents.FindByClass("trigger_changelevel_coop")) do
		clcoop:Remove()
	end
	
	if game.GetMap() == "level02_synb2_tricks_and_traps" then

		TRIGGER_CHECKPOINT = {
			Vector(-2362, 2129, -176), 		Vector(-2550, 2007, -337),
			Vector(-191, 384, 33), 		Vector(-377, 529, 196),
			Vector(984, -650, -687), 		Vector(1106, -481, -538)
		}
			
		CHECKPOINT_POS = {
			Vector(-2450, 2134, -296),		Vector(-279, 486, 47),
			Vector(1109, -589, -681)
		}
		
	elseif game.GetMap() == "level03_synb2_underground" then
		
		TRIGGER_CHECKPOINT = {
			Vector(904, 872, -1565), 		Vector(986, 940, -1433),
			Vector(4865, 5783, -1572), 		Vector(5023, 5734, -1382),
			Vector(-2475, 1598, -142), 		Vector(-2493, 1405, 15),
			Vector(-4516, 5054, -826), 		Vector(-4872, 5107, -555),
			Vector(-4096, 1143, -17), 		Vector(-3923, 1248, -126)
		}
	
		CHECKPOINT_POS = {
			Vector(945, 910, -1555),		Vector(4945, 5716, -1471),
			Vector(-2522, 1505, -117),		Vector(-4691, 4867, -812),
			Vector(-4022, 1189, -114)
		}
	elseif game.GetMap() == "level04_synb2_across_the_darkness" then
	
		TRIGGER_CHECKPOINT = {
			Vector(-1773, -2421, 66), 		Vector(-1618, -2491, 190),
			Vector(-472, -1721, 176), 		Vector(-524, -1793, 97),
			Vector(3674, -8880, -1887), 	Vector(4262, -9423, -2021)
		}
	
		CHECKPOINT_POS = {
			Vector(-1699, -2495, 80),		Vector(-418, -1733, 113),
			Vector(3969, -8825, -2393)
		}
	elseif game.GetMap() == "level05_synb2_diehard" then
	
		TRIGGER_CHECKPOINT = {
			Vector(-743, -811, 242), 		Vector(-814, -689, 383),
			Vector(-597, -2969, 358), 		Vector(-517, -2930, 447),
			Vector(-2728, 3022, 3852), 		Vector(-2909, 2725, 4039)
		}
	
		CHECKPOINT_POS = {
			Vector(-830, -750, 260), 		Vector(-553, -2950, 356),
			Vector(-2902, 2854, 3888)
		}
	elseif game.GetMap() == "level06_synb2_base" then
	
		TRIGGER_CHECKPOINT = {
			Vector(1533, 115, -1367), 		Vector(1385, 318, -1280),
			Vector(1353, 443, -1972), 		Vector(1497, 371, -2092)
		}
	
		CHECKPOINT_POS = {
			Vector(1483, 207, -1363),		Vector(1440, 487, -2078)
		}
		
	elseif game.GetMap() == "level08_synb2_a_place_to_die" then
	
		TRIGGER_CHECKPOINT = {
			Vector(-2239, -1341, 73), 		Vector(-2352, -961, 384),
			Vector(-6304, -3289, -3124), 		Vector(-6179, -3210, -3254),
			Vector(-3906, -3890, -3360), 		Vector(-4168, -4127, -3554)
		}
	
		CHECKPOINT_POS = {
			Vector(-2272, -1174, 82),		Vector(-6245, -3363, -3244),
			Vector(-4284, -3987, -4069)		
		}
	elseif game.GetMap() == "level_1a" then
	
		TRIGGER_CHANGELEVEL_COOP = {
			Vector(1932, 1184, 376),	Vector(1873, 1091, 203)
		}
	
		TRIGGER_CHECKPOINT = {
			Vector(-253, -2045, 3), 		Vector(-97, -1941, 107),
			Vector(0, -1006, 256), 			Vector(-63, -913, 137),
			Vector(535, 1113, -62), 		Vector(694, 1527, 114),
			Vector(1161, 1528, 258), 		Vector(1221, 1426, 375)
		}
	
		CHECKPOINT_POS = {
			Vector(-187, -1988, 24),		Vector(-21, -956, 146),
			Vector(681, 1348, -48),		Vector(1196, 1485, 277)
		}
		
		CHECKPOINT_FUNC_2 = function()
			game.SetGlobalState("antlion_allied", 1)
		end
		
		CHECKPOINT_FUNC_4 = function()
			ents.FindByName("FieldLaser")[1]:Remove()
			timer.Simple(8, function()
				ents.FindByName("Brenda")[1]:SetPos(Vector(1401, 1023, -42))
			end)
		end
		
	elseif game.GetMap() == "level_1b" then
		TRIGGER_CHANGELEVEL_COOP = {
			Vector(3372, 2173, -69),		Vector(3410, 2237, -30),
		}
	
		TRIGGER_CHECKPOINT = {
			Vector(2051, 1369, 261),		Vector(2107, 1340, 378),
			Vector(2361, 4223, 256), 		Vector(2462, 4115, 132),
			Vector(1817, 4309, 230), 		Vector(1666, 4233, 130),
			Vector(3577, 3301, 4), 			Vector(3420, 3209, 112)
		}
	
		CHECKPOINT_POS = {
			Vector(2078, 1436, 278),		Vector(2404, 4167, 142),
			Vector(1746, 4316, 142),		Vector(3492, 3259, 26)
		}
		
	elseif game.GetMap() == "level_2" then
		TRIGGER_CHANGELEVEL_COOP = {
			Vector(5576, -10769, -88),		Vector(5623, -10820, -123),
		}
	
		TRIGGER_CHECKPOINT = {
			Vector(5538, -10489, -268),		Vector(5662, -10614, -129)
		}
	
		CHECKPOINT_POS = {
			Vector(5591, -10558, -122)
		}

		CHECKPOINT_FUNC_1 = function()
			for _, v in ipairs(player.GetAll()) do	
				GrantAchievement(v, "Custom", "Carts_Journey")
			end
		end
	
	elseif game.GetMap() == "level_3" then
	
		TRIGGER_CHANGELEVEL_COOP = {
			Vector(11969, 6688, -64), Vector(12094, 6620, -190)
		}
	
		TRIGGER_CHECKPOINT = {
			Vector(-6549, -2439, 12),		Vector(-6644, -2548, -125),
			Vector(-5563, -2374, 524),		Vector(-5187, -2617, 654),
			Vector(-5586, -3165, 772),		Vector(-5712, -3032, 888),
			Vector(8703, 5888, -161),		Vector(9210, 6651, 1)
		}
	
		CHECKPOINT_POS = {
			Vector(-6583, -2499, -111),	Vector(-5368, -2495, 560),
			Vector(-5626, -3083, 783),	Vector(8995, 6343, -112)
		}
	
	elseif game.GetMap() == "level_4a" then
	
		TRIGGER_CHANGELEVEL_COOP = {
			Vector(620, -1023, -253),		Vector(519, -1286, -138)
		}
	
		TRIGGER_CHECKPOINT = {
			Vector(3974, 1473, 133),		Vector(4401, 1339, 298),
		}
	
		CHECKPOINT_POS = {
			Vector(4180, 1230, 171)
		}
	elseif game.GetMap() == "level_4b" then
	
		TRIGGER_CHECKPOINT = {
			Vector(1003, -1444, -129),		Vector(1400, -1684, 47),
		}
	
		CHECKPOINT_POS = {
			Vector(1235, -1639, -95)
		}
	
	elseif game.GetMap() == "mimp1" then
		HL2CR_Voting = HL2CR_Voting or {}
		disableJalopyGlobal = true

		ents.FindByName("suicidetrigger")[1]:Remove()

		TRIGGER_CHANGELEVEL_COOP = {
			Vector(-3647, -637, -1277),	Vector(-3650, -122, -1084)
		}
	
		TRIGGER_CHECKPOINT = {
			Vector(-3858, 2292, -1165),		Vector(-3808, 2500, -1390),
			Vector(-2731, 2518, -936),		Vector(-2811, 2590, -853),
			Vector(-751, 4245, -765),		Vector(-682, 4413, -661),
			Vector(-1620, 568, -1626),		Vector(-1386, 883, -1506),
			Vector(3663, -1017, -1779),		Vector(3447, -1000, -1670),
		}
	
		CHECKPOINT_POS = {
			Vector(-3822, 2387, -1299),
			Vector(-2801, 2552, -920),
			Vector(-700, 4334, -724),
			Vector(-1498, 755, -1568),
			Vector(3558, -976, -1736)
		}

		if GetConVar("hl2cr_survival"):GetInt() == 0 then
		    CHECKPOINT_FUNC_3 = function()
			    GetConVar("hl2cr_survival"):SetInt(1)
			    HL2CR_Voting.nextVoteTime = CurTime() + (60 * 60)
			    for i = 1, 4 do
			        timer.Simple(.5 + i, function()
				        PrintMessage(HUD_PRINTCENTER, "Survival Mode are Enabled.") 
			        end)
			    end
				for i = 1, 4 do
			        timer.Simple(4.5 + i, function()
				        PrintMessage(HUD_PRINTCENTER, "Votes are disabled until the next CP.") 
			        end)
			    end
		    end
		    CHECKPOINT_FUNC_4 = function()
				GetConVar("hl2cr_survival"):SetInt(0)
		    	HL2CR_Voting.nextVoteTime = CurTime() / 36000
			    for i = 1, 4 do
				    timer.Simple(.5 + i, function()
					    PrintMessage(HUD_PRINTCENTER, "Survival Mode are Disabled.")
				    end)
			    end
	        end
	    end
		
		CHECKPOINT_FUNC_5 = function()
			disableJalopyGlobal = false
			canSpawnJalopyGlobal = true			
			BroadcastMessage(ENABLED_JALOPY)
		end

	elseif game.GetMap() == "mimp_intermission" then

		TRIGGER_CHANGELEVEL_COOP = {
			Vector(-3669, -185, -156),		Vector(-3646, 317, -20)
		}
	
		TRIGGER_CHECKPOINT = {
			Vector(1875, -1898, -258),		Vector(1883, -2028, -170),
			Vector(1744, -1086, -302),		Vector(1731, -980, -176),
		}
	
		CHECKPOINT_POS = {
			Vector(1875, -1970, -267),
			Vector(1729, -1031, -300)
		}

	elseif game.GetMap() == "mimp2" then

		disableJalopyGlobal = false
		canSpawnJalopyGlobal = true

		ents.FindByName("suicidetrigger")[1]:Remove()

		TRIGGER_CHANGELEVEL_COOP = {
			Vector(4349, -3003, -1153),			Vector(-4227, -2996, -1051)
		}
	
		TRIGGER_CHECKPOINT = {
			--Vector(-9484, -9495, -924), 		Vector(-9639, -9265, -816),
			Vector(-11068, -3997, -1315),		Vector(-10431, -3776, -1110),
			--Vector(11641, -9543, -1645), 		Vector(11795, -9404, -1533),
			Vector(-10738, 2283, -1231), 		Vector(-10610, 2273, -1129),
			Vector(13437, -6933, -1642), 		Vector(13153, -6597, -1505),
			Vector(9989, -4962, -1902), 		Vector(9859, -5630, -1555),
			Vector(4347, -4796, -1151), 		Vector(4227, -4698, -1051),
		}
	
		CHECKPOINT_POS = {
			--Vector(-9532, -9440, -884),
			Vector(-10724, -3889, -1178),
			--Vector(11731, -9471, -1604),
			Vector(-11026, 2861, -1227),
			Vector(13318, -6833, -1634),
			Vector(9951, -5134, -1824),
			Vector(4289, -4743, -1132)
		}

		CHECKPOINT_FUNC_1 = function()
			disableJalopyGlobal = true
			canSpawnJalopyGlobal = false
		end

	elseif game.GetMap() == "mimp3" then
		HL2CR_Voting = HL2CR_Voting or {}
		local npc_stalker = {
			["npc_stalker"] = true
		}
		
		table.Merge(FRIENDLY_NPCS, npc_stalker)
	
		TRIGGER_CHECKPOINT = {
			Vector(4363, -810, -3324), 		Vector(4443, -934, -3197),
			Vector(3010, -802, -4349),		Vector(3034, -1046, -4213),
			Vector(2495, -1202, -4510), 	Vector(2435, -1346, -4383),
			Vector(576, -1612, -4759), 		Vector(507, -1477, -4550),
			Vector(4325, 380, 115), 		Vector(4302, 321, 240),
		}
	
		CHECKPOINT_POS = {
			Vector(4389, -869, -3314),
			Vector(3043, -924, -4348),
			Vector(2480, -1256, -4498),
			Vector(438, -1535, -4840),
			Vector(4235, 350, 157)
		}

		if GetConVar("hl2cr_survival"):GetInt() == 0 then
		    CHECKPOINT_FUNC_4 = function()
			    GetConVar("hl2cr_survival"):SetInt(1)
			    HL2CR_Voting.nextVoteTime = CurTime() + (60 * 60)
			    for i = 1, 4 do
			        timer.Simple(.5 + i, function()
				        PrintMessage(HUD_PRINTCENTER, "Survival Mode are Enabled.") 
			        end)
			    end
				for i = 1, 4 do
			        timer.Simple(4.5 + i, function()
				        PrintMessage(HUD_PRINTCENTER, "Votes are disabled until the next CP.") 
			        end)
			    end
		    end
		    CHECKPOINT_FUNC_5 = function()
				GetConVar("hl2cr_survival"):SetInt(0)
		    	HL2CR_Voting.nextVoteTime = CurTime() / 36000
			    for i = 1, 4 do
				    timer.Simple(.5 + i, function()
					    PrintMessage(HUD_PRINTCENTER, "Survival Mode are Disabled.")
				    end)
			    end
	        end
	    end

	elseif game.GetMap() == "nh1remake1_fixed" then
	
		TRIGGER_CHECKPOINT = {
			Vector(465, 74, -237), 		Vector(369, -38, -361),
			Vector(702, -1186, -108), 		Vector(593, -1255, -233),
			Vector(1392, -1024, -415), 		Vector(1558, -1118, -670),
			Vector(398, -595, 136), 		Vector(329, -702, 9)
		}
	
		CHECKPOINT_POS = {
			Vector(451, 9, -352),		Vector(645, -1235, -221),
			Vector(1500, -1073, -597),		Vector(481, -658, 25)
		}
	elseif game.GetMap() == "nh2c1_v2" then
		
		TRIGGER_CHANGELEVEL_COOP = {
			Vector(-1423, -151, 2),		Vector(-1521, -218, 89)
		}
	
		TRIGGER_CHECKPOINT = {
			Vector(-830, -376, 5), 		Vector(-711, -274, 92),
			Vector(158, 684, 1), 		Vector(-38, 772, 126),
			Vector(-1409, 382, 1), 		Vector(-1492, 230, 124)
		}
	
		CHECKPOINT_POS = {
			Vector(-855, -323,	 11),		Vector(72, 760, 6),
			Vector(-1462, 312, 10)
		}
	elseif game.GetMap() == "nh2c2_v2" then
		
		TRIGGER_CHANGELEVEL_COOP = {
			Vector(-354, -3618, 3841),		Vector(-474, -3741, 3724)
		}
	
		TRIGGER_CHECKPOINT = {
			Vector(-1530, -10, 2683), 		Vector(-1423, -131, 2562),
			Vector(-2472, -1857, 2688), 		Vector(-2374, -2045, 2563),
			Vector(-2369, -2813, 2560), 		Vector(-2437, -2690, 2687)
		}
	
		CHECKPOINT_POS = {
			Vector(-1689, -7, 2571),		Vector(-2453, -1946, 2581),
			Vector(-2431, -2751, 2576)
		}

		CHECKPOINT_FUNC_1 = function()
			ents.FindByClass("info_player_start")[1]:SetParent(nil)
		end

		CHANGELEVEL_COOP_FUNC = function()
			for _, v in ipairs(player.GetAll()) do
				v:SetPos(Vector(-410, -3688, 3919))
			end
		end
	elseif game.GetMap() == "nh2c3_v2" then
		TRIGGER_CHANGELEVEL_COOP = {
			Vector(-8269, -5759, 162),		Vector(-8376, -5634, 2)
		}
	
		TRIGGER_CHECKPOINT = {
			Vector(-7163, -5914, -126), 	Vector(-7039, -6024, -12),
			Vector(-6560, -4653, 127), 		Vector(-6605, -4698, 2),
		}
	
		CHECKPOINT_POS = {
			Vector(-7091, -5975, -107),		Vector(-6583, -4667, 8),
			Vector(-2431, -2751, 2576)
		}
		
		CHANGELEVEL_COOP_FUNC = function()
			for _, v in ipairs(player.GetAll()) do
				v:SetPos(Vector(-8235, -5695, 64))
			end
		end
	end

	if TRIGGER_CHANGELEVEL_COOP then
		Changelevel = ents.Create("trigger_changelevel_coop")
		Changelevel.Min = Vector(TRIGGER_CHANGELEVEL_COOP[1])
		Changelevel.Max = Vector(TRIGGER_CHANGELEVEL_COOP[2])
		Changelevel.Pos = Vector(TRIGGER_CHANGELEVEL_COOP[2]) - ( ( Vector(TRIGGER_CHANGELEVEL_COOP[2]) - Vector(TRIGGER_CHANGELEVEL_COOP	[1])) / 2 )
		Changelevel:SetPos(Changelevel.Pos)
		Changelevel:Spawn()
			
		Changelevel.lambdaModel = ents.Create("prop_dynamic")
		Changelevel.lambdaModel:SetModel("models/hl2cr_lambda.mdl")
		Changelevel.lambdaModel:SetPos(Changelevel.Pos)
		Changelevel.lambdaModel:Spawn()
		Changelevel.lambdaModel:SetName("lambdaCheckpoint")
		Changelevel.lambdaModel:ResetSequence("idle")
		Changelevel.lambdaModel:SetMaterial("phoenix_storms/wire/pcb_green")
		
		Changelevel.Func = CHANGELEVEL_COOP_FUNC
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
		
		if TRIGGER_CHECKPOINT[9] and TRIGGER_CHECKPOINT[10] then
			local Checkpoint = ents.Create("trigger_checkpoint")
			Checkpoint.Min = Vector(TRIGGER_CHECKPOINT[9])
			Checkpoint.Max = Vector(TRIGGER_CHECKPOINT[10])
			Checkpoint.Pos = Vector(TRIGGER_CHECKPOINT[10]) - ( ( Vector(TRIGGER_CHECKPOINT[10]) - Vector(TRIGGER_CHECKPOINT[9])) / 2 )
			Checkpoint.Point = Vector(CHECKPOINT_POS[5])
			Checkpoint:SetPos(Checkpoint.Pos)
			Checkpoint:SetPointIndex(5)
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
end

local COOP_WEAPONS = {
	["level01_synb2_entryway_of_doom"] = {
		[1] = "weapon_crowbar",
		[2] = "weapon_physcannon",
	},
	
	["level02_synb2_tricks_and_traps"] = {
		[1] = "weapon_crowbar",
		[2] = "weapon_physcannon",
	},
	
	["level03_synb2_underground"] = {
		[1] = "weapon_crowbar",
		[2] = "weapon_physcannon",
	},
	
	["level04_synb2_across_the_darkness"] = {
		[1] = "weapon_crowbar",
		[2] = "weapon_physcannon",
	},
	
	["level05_synb2_diehard"] = {
		[1] = "weapon_crowbar",
		[2] = "weapon_physcannon",
	},
	
	["level06_synb2_base"] = {
		[1] = "weapon_crowbar",
		[2] = "weapon_physcannon",
	},
	
	["level07_synb2_scary_dark_house"] = {
		[1] = "weapon_crowbar",
		[2] = "weapon_physcannon",
	},
	
	["level08_synb2_a_place_to_die"] = {
		[1] = "weapon_crowbar",
		[2] = "weapon_physcannon",
	},

	["mimp1"] = {
		[1] = "weapon_crowbar",
		[2] = "weapon_pistol",
	},

	["mimp_intermission"] = {
		[1] = "weapon_crowbar",
		[2] = "weapon_pistol",
		[3] = "weapon_357",
		[4] = "weapon_smg1",
		[5] = "weapon_ar2",
		[6] = "weapon_shotgun",
		[7] = "weapon_crossbow",
		[8] = "weapon_rpg",
	},
	
	["nh2c2_v2"] = {
		[1] = "weapon_nh_hatchet",
		[2] = "weapon_nh_colt",
	},
	
	["nh2c4_v2"] = {
		[1] = "weapon_nh_hatchet",
		[2] = "weapon_nh_colt",
		[3] = "weapon_nh_revolver",
	},
	
}

local REMOVE_WEAPONS = {
	["weapon_medkit"] = true
}

local MAP_LOGIC = {
	["level01_synb2_entryway_of_doom"] = function(MapLua)		
		MapLua:SetKeyValue("Code", "hook.Run('EndCoopMap')")
		ents.FindByName("bouton10")[1]:Fire("AddOutput", "OnPressed triggerhook:RunCode")
	end,
	
	["level02_synb2_tricks_and_traps"] = function(MapLua)
				MapLua:SetKeyValue("Code", "hook.Run('EndCoopMap')")
		ents.FindByName("m_g1")[1]:Fire("AddOutput", "OnAllSpawnedDead triggerhook:RunCode")
	end,
	
	["level03_synb2_underground"] = function(MapLua)
		MapLua:SetKeyValue("Code", "hook.Run('EndCoopMap')")
		ents.FindByName("craps1")[1]:Fire("AddOutput", "OnDeath triggerhook:RunCode")
		
	end,
	
	["level04_synb2_across_the_darkness"] = function(MapLua)
		MapLua:SetKeyValue("Code", "hook.Run('EndCoopMap')")
		ents.FindByClass("trigger_once")[18]:Fire("AddOutput", "OnStartTouch triggerhook:RunCode")
	end,
	
	["level05_synb2_diehard"] = function(MapLua)
		for _, newSpawn in ipairs(ents.FindByClass("info_player_deathmatch")) do
			newSpawn:SetPos(Vector(758, 93, 76))
		end
		
		ents.FindByName("trig_tele1")[1]:Remove()
		
		table.RemoveByValue(FRIENDLY_NPCS, "npc_dog")
		
		MapLua:SetKeyValue("Code", "hook.Run('EndCoopMap')")
		ents.FindByName("m_ag1")[1]:Fire("AddOutput", "OnAllSpawnedDead triggerhook:RunCode")
	
	end,
	
	["level06_synb2_base"] = function(MapLua)
		local booster = ents.Create("prop_dynamic")
		booster:SetModel("models/props_borealis/bluebarrel001.mdl")
		booster:SetPos(Vector(59, 99, -205))
		booster:PhysicsInit(SOLID_VPHYSICS)
		booster:Spawn()
		ents.FindByName("m_big1")[1]:Fire("AddOutput", "OnAllSpawnedDead sas15:Unlock()")
		
		MapLua:SetKeyValue("Code", "hook.Run('EndCoopMap')")
		ents.FindByName("countoto")[1]:Fire("AddOutput", "OnHitMax triggerhook:RunCode")
	
	end,
	
	["level07_synb2_scary_dark_house"] = function(MapLua)
		table.Merge(RANDOM_XP_BASED_NPC, npc_vortigaunt)
		MapLua:SetKeyValue("Code", "hook.Run('EndCoopMap')")
		ents.FindByName("count")[1]:Fire("AddOutput", "OnHitMax triggerhook:RunCode")
	
	end,
	
	["level08_synb2_a_place_to_die"] = function(MapLua)	
		MapLua:SetKeyValue("Code", "hook.Run('EndCoopMap')")
		ents.FindByName("ag1")[1]:Fire("AddOutput", "OnDeath triggerhook:RunCode")
	end,
	
	["level_1b"] = function(MapLua)
		for _, c in ipairs(ents.FindByName("ConveyorArm*")) do
			c:Fire("AddOutput", "OnStartTouch triggerhook:RunPassedCode:hook.Run('FailCoopMap'):0:-1")
		end
		
		for _, t in ipairs(ents.FindByName("SteamJetPush*")) do
			t:Fire("AddOutput", "OnStartTouch triggerhook:RunPassedCode:hook.Run('FailCoopMap'):0:-1")
		end
		
		ents.FindByName("MicrowaveKitRelay2")[1]:Fire("AddOutput", "OnTrigger triggerhook:RunPassedCode:hook.Run('Fix1b'):0:-1")
	end,
	
	["level_3"] = function(MapLua)
		ents.FindByName("fusebox_fix_rl")[1]:Fire("AddOutput", "OnTrigger roller_exit_doors:Open")
	end,
	
	["level_4b"] = function(MapLua)
		ents.FindByName("strider_hit_count")[1]:Fire("AddOutput", "OnHitMax triggerhook:RunPassedCode:hook.Run('FinishRnD')")
	end,

	["mimp3"] = function(MapLua)
		ents.FindByName("end_of_an_era_sadface")[1]:Fire("AddOutput", "OnTrigger triggerhook:RunPassedCode:hook.Run('FinishMI')")
	end,
	
	["nh1remake1_fixed"] = function(MapLua)	
		local axe = ents.Create("weapon_nh_hatchet")
		axe:SetPos(ents.FindByClass("weapon_crowbar")[1]:GetPos())
		axe:SetAngles(ents.FindByClass("weapon_crowbar")[1]:GetAngles())
		axe:Spawn()
		
		ents.FindByClass("weapon_crowbar")[1]:Remove()
		
		local pistol = ents.Create("weapon_nh_colt")
		pistol:SetPos(ents.FindByClass("weapon_pistol")[1]:GetPos())
		pistol:SetAngles(ents.FindByClass("weapon_pistol")[1]:GetAngles())
		pistol:Spawn()
		
		ents.FindByClass("weapon_pistol")[1]:Remove()
		
		local magnum = ents.Create("weapon_nh_revolver")
		magnum:SetPos(ents.FindByClass("weapon_357")[1]:GetPos())
		magnum:SetAngles(ents.FindByClass("weapon_357")[1]:GetAngles())
		magnum:Spawn()
		
		ents.FindByClass("weapon_357")[1]:Remove()
		
		local shotgun = ents.Create("weapon_nh_shotgun")
		shotgun:SetPos(ents.FindByClass("weapon_shotgun")[1]:GetPos())
		shotgun:SetAngles(ents.FindByClass("weapon_shotgun")[1]:GetAngles())
		shotgun:Spawn()
		
		ents.FindByClass("weapon_shotgun")[1]:Remove()
		
		MapLua:SetKeyValue("Code", "hook.Run('EndCoopMap')")
		
		ents.FindByName("teleport2")[1]:Fire("AddOutput", "OnStartTouch triggerhook:RunCode")
	end,
	
	["nh2c1_v2"] = function(MapLua)	
		
		local pistol = ents.Create("weapon_nh_colt")
		pistol:SetPos(Vector(-1473, 380, 62))
		pistol:SetAngles(Angle(0, -180, 0))
		pistol:Spawn()
		
		ents.FindByClass("weapon_nh_hatchet")[1]:Fire("AddOutput", "OnPlayerPickup wood_block1_wall:Kill")
		
		pistol:Fire("AddOutput", "OnPlayerPickup secroom_monitor1:SetCamera('lab_camera')")
		pistol:Fire("AddOutput", "OnPlayerPickup secroom_monitor2:SetCamera('lab_camera')")
		pistol:Fire("AddOutput", "OnPlayerPickup secroom_monitor3:SetCamera('lab_camera')")
		pistol:Fire("AddOutput", "OnPlayerPickup secroom_monitor4:SetCamera('lab_camera')")
		pistol:Fire("AddOutput", "OnPlayerPickup monitor_1:SetCamera('lab_camera')")
		pistol:Fire("AddOutput", "OnPlayerPickup lab_mic:SetSpeakerName('TV_speaker')")
		pistol:Fire("AddOutput", "OnPlayerPickup sec_room_door:Close")
		pistol:Fire("AddOutput", "OnPlayerPickup sec_room_door:Lock")
		
		pistol:Fire("AddOutput", "OnPlayerPickup whitenoise_sound1:PlaySound:0:2")
		pistol:Fire("AddOutput", "OnPlayerPickup tv_sound1:PlaySound:0:2")
		
		pistol:Fire("AddOutput", "OnPlayerPickup secroom_monitor2:Enable:0:3")
		pistol:Fire("AddOutput", "OnPlayerPickup tv_sound1:PlaySound:0:3")
		
		pistol:Fire("AddOutput", "OnPlayerPickup secroom_monitor3:Enable:0:4")
		pistol:Fire("AddOutput", "OnPlayerPickup tv_sound1:PlaySound:0:4")
		
		pistol:Fire("AddOutput", "OnPlayerPickup secroom_monitor4:Enable:0:5")
		pistol:Fire("AddOutput", "OnPlayerPickup tv_sound1:PlaySound:0:5")

		pistol:Fire("AddOutput", "OnPlayerPickup secroom_monitor1:SetCamera('lab_camera'):0:5")
		pistol:Fire("AddOutput", "OnPlayerPickup secroom_monitor2:SetCamera('lab_camera'):0:5")
		pistol:Fire("AddOutput", "OnPlayerPickup secroom_monitor3:SetCamera('lab_camera'):0:5")
		pistol:Fire("AddOutput", "OnPlayerPickup secroom_monitor4:SetCamera('lab_camera'):0:5")
		pistol:Fire("AddOutput", "OnPlayerPickup monitor_1:SetCamera('lab_camera'):0:5")

		pistol:Fire("AddOutput", "OnPlayerPickup doctor_scriptseq:BeginSequence:0:5")
		
		pistol:Fire("AddOutput", "OnPlayerPickup secroom_monitor1:SetCamera('lab_camera'):0:7")
		pistol:Fire("AddOutput", "OnPlayerPickup secroom_monitor2:SetCamera('lab_camera'):0:7")
		pistol:Fire("AddOutput", "OnPlayerPickup secroom_monitor3:SetCamera('lab_camera'):0:7")
		pistol:Fire("AddOutput", "OnPlayerPickup secroom_monitor4:SetCamera('lab_camera'):0:7")
		pistol:Fire("AddOutput", "OnPlayerPickup monitor_1:SetCamera('lab_camera'):0:7")

		pistol:Fire("AddOutput", "OnPlayerPickup secroom_monitor1:SetCamera('lab_camera'):0:8")
		pistol:Fire("AddOutput", "OnPlayerPickup secroom_monitor2:SetCamera('lab_camera'):0:8")
		pistol:Fire("AddOutput", "OnPlayerPickup secroom_monitor3:SetCamera('lab_camera'):0:8")
		pistol:Fire("AddOutput", "OnPlayerPickup secroom_monitor4:SetCamera('lab_camera'):0:8")
		pistol:Fire("AddOutput", "OnPlayerPickup monitor_1:SetCamera('lab_camera'):0:8")
		
		ents.FindByName("woman_eleroom_seq")[1]:Fire("AddOutput", "OnBeginSequence sec_room_wall:Kill:0:-1")
	end,
	
	["nh2c2_v2"] = function(MapLua)	
		local npc_stalker = {
			["npc_stalker"] = true
		}
		
		table.Merge(FRIENDLY_NPCS, npc_stalker)
		
		ents.FindByClass("info_player_start")[1]:SetParent(ents.FindByName("elevator_parts")[1])
		
		ents.FindByName("speed")[1]:Remove()
		
		ents.FindByName("nurse1")[1]:Fire("AddOutput", "OnWake triggerhook:RunPassedCode:hook.Run('ReduceSpeed'):0:-1")
		
		ents.FindByName("dreamhall_doors")[1]:Fire("AddOutput", "OnClose triggerhook:RunPassedCode:hook.Run('FixSpeed'):0:-1")
		ents.FindByName("doorzombie_triggerlook")[1]:Fire("AddOutput", "OnTrigger firstdoor_door:Open")
		ents.FindByName("speed2")[1]:Remove()		
	end,
	
	["nh2c3_v2"] = function(MapLua)
		for i, s in ipairs(ents.FindByClass("info_player_start")) do
			if i ~= 1 then
				s:Remove()
			end
		end
		
		local axe = ents.Create("weapon_nh_hatchet")
		axe:SetPos(Vector(-4912, -4204, 21))
		axe:Spawn()
		
		local colt = ents.Create("weapon_nh_colt")
		colt:SetPos(Vector(-4912, -4204, 21))
		colt:Spawn()
		
		ents.FindByName("speed2")[1]:Remove()
	end,	
}

local ITEMS = {
	["item_ammo_pistol"] = "item_ammo_pistol",
	["item_ammo_pistol_large"] = "item_ammo_pistol_large",
	
	["item_ammo_357"] = "item_ammo_357",
	["item_ammo_357_large"] = "item_ammo_357_large",
	
	["item_ammo_smg1"] = "item_ammo_smg1",
	["item_ammo_smg1_large"] = "item_ammo_smg1_large",
	
	["item_ammo_357"] = "item_ammo_357",
	["item_ammo_357_large"] = "item_ammo_357_large",
	
	["item_ammo_smg1"] = "item_ammo_smg1",
	["item_ammo_smg1_large"] = "item_ammo_smg1_large",
	
	["item_ammo_smg1_grenade"] = "item_ammo_smg1_grenade",
	["item_ammo_ar2_altfire"] = "item_ammo_ar2_altfire",
	
	["item_ammo_ar2"] = "item_ammo_ar2",
	["item_ammo_ar2_large"] = "item_ammo_ar2_large",
	
	["item_box_buckshot"] = "item_box_buckshot",
	["item_box_buckshot_large"] = "item_box_buckshot_large",
	
	["item_ammo_crossbow"] = "item_ammo_crossbow",
	
	["item_rpg_round"] = "item_rpg_round",
	
	["weapon_frag"] = "weapon_frag",

	["item_battery"] = "item_battery",
	["item_healthvial"] = "item_healthvial",
	["item_healthkit"] = "item_healthkit"
}

local WEAPONS = {
	["weapon_crowbar"] = "weapon_crowbar",
	["weapon_pistol"] = "weapon_pistol",
	["weapon_357"] = "weapon_357",
	["weapon_smg1"] = "weapon_smg1",
	["weapon_ar2"] = "weapon_ar2",
	["weapon_shotgun"] = "weapon_shotgun",
	["weapon_crossbow"] = "weapon_crossbow",
	["weapon_rpg"] = "weapon_rpg",
	["weapon_deagle"] = "weapon_deagle",
	["weapon_mg1"] = "weapon_mg1",
	["weapon_mp5k"] = "weapon_mp5k",
	["weapon_sl8"] = "weapon_sl8"

}

local isCoopMap = false

local function SetUpMisc()
	local MapLua = ents.Create("lua_run")
	MapLua:SetName("triggerhook")
	MapLua:Spawn()
	
	isCoopMap = true
	
	local npc_vortigaunt = {
		["npc_vortigaunt"] = true
	}
	
	table.Merge(HOSTILE_NPCS, npc_vortigaunt)
	
	for _, cl in ipairs(ents.FindByClass("trigger_changelevel")) do
		cl:Remove()
	end
	
	for _, gameEnd in ipairs(ents.FindByClass("game_end")) do
		gameEnd:Remove()
	end
	for _, weaponStrip in ipairs(ents.FindByClass("trigger_weapon_strip")) do
		weaponStrip:Remove()
	end
	
	timer.Simple(0.5, function()
		for _, resWep in ipairs(ents.FindByClass("weapon_*")) do
			if REMOVE_WEAPONS[resWep:GetClass()] then
				resWep:Remove()
			end	
		end
	end)
	
	if COOP_WEAPONS[game.GetMap()] then
		for i, wep in pairs(COOP_WEAPONS[game.GetMap()]) do 
			table.insert(SPAWNING_WEAPONS, wep)
		end
	end
	
	if MAP_LOGIC[game.GetMap()] then
		MAP_LOGIC[game.GetMap()](MapLua)
	end
end

function RespawnItem(ply, item)
	if not isCoopMap then return end

	local class = item:GetClass()
	local oldPos = item:GetPos()
	timer.Create("respawn_" .. item:EntIndex(), GetConVar("hl2cr_coop_respawnrate"):GetInt(), 1, function()
	
		if item:IsValid() then return end
		if not ITEMS[class] then return end
		
		local newItem = ents.Create(ITEMS[class])
		newItem:SetPos(oldPos)
		newItem:Spawn()
		newItem:EmitSound("AlyxEMP.Discharge")
	end)
	
	return true
end

function RespawnWeapon(ply, weapon)
	if not isCoopMap then return end
	
	local class = weapon:GetClass()
	local oldPos = weapon:GetPos()
	timer.Create("respawn_" .. weapon:EntIndex(), GetConVar("hl2cr_coop_respawnrate"):GetInt(), 1, function()

		if weapon:IsValid() then return end
		if not WEAPONS[class] then return end
		
		local newItem = ents.Create(WEAPONS[class])
		newItem:SetPos(oldPos)
		newItem:Spawn()
		newItem:EmitSound("AlyxEMP.Discharge")
	end)
	
	return true
end

hook.Add("ReduceSpeed", "HL2CR_NH2_ReduceSpeed", function()
	for _, v in ipairs(player.GetAll()) do
		v:SetWalkSpeed(125)
		v:SetRunSpeed(125)
	end
end)

hook.Add("FixSpeed", "HL2CR_NH2_FixSpeed", function()
	for _, v in ipairs(player.GetAll()) do
		v:SetWalkSpeed(200)
		v:SetRunSpeed(320)
	end
end)

hook.Add("EntityTakeDamage", "MI_Water_Kills", function(ent, dmginfo)
	if ent:IsPlayer() and ent:WaterLevel() >= 1 and ((string.find(string.lower(game.GetMap()),"mimp1")) or (string.find(string.lower(game.GetMap()),"mimp2"))) then
	ent:Kill()
	end
end)

hook.Add("FailCoopMap", "HL2CR_RestartCoop", function()
	BroadcastSound("music/hl2_song23_suitsong3.mp3")
	timer.Simple(10, function()
		RunConsoleCommand("ChangeLevel", game.GetMap())
	end)
end)

hook.Add("FinishRnD", "HL2CR_FinishRndSeries", function()
	for k, v in ipairs(player.GetAll()) do
		v:SetTeam(TEAM_COMPLETED_MAP)
		GrantAchievement(v, "Custom", "Science_Squared")
	end
	
	BroadcastMessage(MAPS_CUSTOM_FINISHED_RND)
	
	net.Start("HL2CR_EndCampaign")
	net.Broadcast()
	StartFinalMapCountdown()
end)

hook.Add("FinishMI", "HL2CR_FinishMissionImprobableSeries", function()
	for k, v in ipairs(player.GetAll()) do
		v:SetTeam(TEAM_COMPLETED_MAP)
		GrantAchievement(v, "Custom", "MI_Wheelchair")
	end
	
	BroadcastMessage(MAPS_CUSTOM_FINISHED_MI)
	
	net.Start("HL2CR_EndCampaign")
	net.Broadcast()
	StartFinalMapCountdown()
end)

hook.Add("Fix1b", "HL2CR_RNDFixMap", function()
	for _, j in ipairs(ents.FindByName("kit_junk")) do
		j:Remove()
	end
	
	for _, j in ipairs(ents.FindByName("KitCeilingDebris")) do
		j:Remove()
	end
	
	for _, j in ipairs(ents.FindByName("MicrowaveKitDissolver*")) do
		j:Remove()
	end
	
	ents.FindByName("MicrowaveKitCore")[1]:Remove()
	ents.FindByName("MicrowaveKitTable")[1]:Remove()
	ents.FindByName("KitchenDoorBreak1")[1]:Remove()
	ents.FindByName("KitchenDoorBreak2")[1]:Remove()

end)

hook.Add("EndCoopMap", "HL2CR_EndCoop", function()
	for _, v in ipairs(player.GetAll()) do
		v:SetTeam(TEAM_COMPLETED_MAP)
		EnableSpectate(v)
		ShowMapResults(v)
		
		if game.GetMap() == "nh1remake1_fixed" then
			GrantAchievement(v, "Custom", "The_Beginning")
		end
	end

	net.Start("HL2CR_MapCountdown")
	net.Broadcast()
	
	StartMapCountdown()
	
end)

function StartCoop()
	SetCheckpoints()
	SetUpMisc()
end