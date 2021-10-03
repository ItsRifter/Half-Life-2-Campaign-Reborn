NOSUIT_MAPS = {
	["d1_trainstation_01"] = true,
	["d1_trainstation_02"] = true,
	["d1_trainstation_03"] = true,
	["d1_trainstation_04"] = true
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

NO_PETS_MAPS = {
	["d1_trainstation_01"] = true,
	["d1_trainstation_02"] = true,
	["d1_trainstation_03"] = true,
	["d1_trainstation_04"] = true,
	["d1_trainstation_05"] = true,
	["d3_breen_01"] = true
}

AIRBOAT_GUN_MAPS = {
	["d1_canals_12"] = true,
	["d1_canals_13"] = true
}

JEEP_MAPS = {
	--["d2_coast_01"] = true,
	["d2_coast_03"] = true,
	["d2_coast_04"] = true,
	["d2_coast_05"] = true,
	["d2_coast_06"] = true,
	["d2_coast_06"] = true,
	["d2_coast_07"] = true,
	["d2_coast_09"] = true,
	["d2_coast_10"] = true
}

NO_REWARDS_MAPS = {
	["d1_trainstation_01"] = true,
	["d1_trainstation_02"] = true,
	["d1_trainstation_03"] = true,
	["d1_trainstation_04"] = true,
	["d1_trainstation_05"] = true,
	["d1_eli_01"] = true,
	["d1_eli_02"] = true,
	["d3_citadel_05"] = true
}

NO_REWARD_XP_MAPS_ANTLIONS = {
	["d2_coast_01"] = true,
	["d2_coast_03"] = true,
	["d2_coast_04"] = true,
	["d2_coast_11"] = true,
	["d2_coast_12"] = true,
	["d2_prison_01"] = true,
	["d2_prison_02"] = true,
	["d2_prison_03"] = true,
	["d2_prison_04"] = true,
	["d2_prison_05"] = true,
}

local IMPORTANT_MAPS = {
	["d1_trainstation_01"] = true,
	["d1_trainstation_02"] = true,
	["d1_trainstation_03"] = true,
	["d1_trainstation_04"] = true,
	["d1_trainstation_05"] = true,
	["d1_eli_01"] = true,
	["d1_eli_02"] = true,
	["d3_c17_01"] = true,
	["d3_citadel_05"] = true,
	["d3_breen_01"] = true,
}

local function SetCheckpoints()
	for k, cl in ipairs(ents.FindByClass("trigger_changelevel")) do
		cl:Remove()
	end

	
	if game.GetMap() == "d1_trainstation_01" then
		TRIGGER_CHANGELEVEL = {
			Vector(-3130, -164, -61),		Vector(-3073, -209, 59)
		}
		TRIGGER_CHECKPOINT = {
			Vector(-9423, -2419, 19), 		Vector(-9464, -2554, 143),
			Vector(-5413, -1987, 17),	 	Vector(-5294, -1937, 135),
			Vector(-3612, -257, 94), 		Vector(-3440, -340, -28),
			Vector(-3459, -119, 72),	 	Vector(-3410, -13, -29)
		}
		
		CHECKPOINT_POS = {
			Vector(-9294, -2445, 26),		Vector(-5400, -2070, -18),	
			Vector(-3419, -224, -21), 		Vector(-3549, -10, -19)		
		}
		
		CHECKPOINT_FUNC_2 = function()
			timer.Simple(2, function()
				for _, v in ipairs(player.GetAll()) do
					v:SetFOV(0, 1, v)
				end
			end)
		end
	elseif game.GetMap() == "d1_trainstation_02" then
		TRIGGER_CHANGELEVEL = {
			Vector(-5293, -4599, 1),		Vector(-5364, -4504, 130)
		}
	elseif game.GetMap() == "d1_trainstation_03" then
		TRIGGER_CHANGELEVEL = {
			Vector(-5206, -4756, 578), 		Vector(-5263, -4867, 688)
		}
		TRIGGER_CHECKPOINT = {
			Vector(-4522, -4569, 386),		Vector(-4594, -4654, 506),
			Vector(-4890, -4698, 513),		Vector(-5031, -4730, 640)
		}
		
		CHECKPOINT_POS = {
			Vector(-4556, -4632, 389),		Vector(-4990, -4788, 520)
		}
	elseif game.GetMap() == "d1_trainstation_04" then
		TRIGGER_CHANGELEVEL = {
			Vector(-8076, -4157, -253),		Vector(-8028, -4095, -122)
		}
		TRIGGER_CHECKPOINT = {
			Vector(-4063, -3408, 654),		Vector(-4095, -3517, 580),
			Vector(-6785, -4162, 521),		Vector(-7254, -3956, 659),
			Vector(-7829, -4096, -254),		Vector(-7796, -4156, -136)
		}
		
		CHECKPOINT_POS = {
			Vector(-4148, -3457, 524),		Vector(-7063, -4036, 522),
			Vector(-7872, -4126, -246)
		}
		
		CHANGELEVEL_FUNC = function()
			for _, v in ipairs(player.GetAll()) do
				GrantAchievement(v, "HL2", "Malcontent")
			end
		end
		
	elseif game.GetMap() == "d1_trainstation_05" then
		TRIGGER_CHANGELEVEL = {
			Vector(-10685, -3639, 475),		Vector(-10498, -3628, 321)
		}
		TRIGGER_CHECKPOINT = {
			Vector(-6409, -1195, 142),		Vector(-6544, -1105, 1),
			Vector(-7065, -1298, 1),		Vector(-7152, -1472, 125),
			Vector(-10383, -4692, 325),		Vector(-10283, -4760, 461)
		}
		
		CHECKPOINT_POS = {
			Vector(-6488, -1199, 8),		Vector(-7167, -1377, 5),
			Vector(-10337, -4717, 328)
		}
		
		CHECKPOINT_FUNC_1 = function()
			
			for _, b in ipairs(ents.FindByClass("prop_physics")) do
				if b:GetModel() == "models/props_c17/doll01.mdl" then
					for _, v in ipairs(player.GetAll()) do
						GrantAchievement(v, "HL2", "Red_Letter_Baby")
					end
				end	
			end
		end
	elseif game.GetMap() == "d1_trainstation_06" then
		TRIGGER_CHANGELEVEL = {
			Vector(-8594, -575, -262), 		Vector(-8703, -513, -382)
		}
		
	elseif game.GetMap() == "d1_canals_01" then
		TRIGGER_CHANGELEVEL = {
			Vector(689, 2859, -98), 		Vector(764, 2977, 18)
		}
		
		TRIGGER_CHECKPOINT = {
			Vector(377, -3649, 375), 		Vector(129, -3616, 257),
			Vector(763, 2852, -94), 		Vector(638, 2785, 9)
		}
		
		CHECKPOINT_POS = {
			Vector(111, -3459, 260),	 	Vector(623, 2873, -88),
		}
	elseif game.GetMap() == "d1_canals_01a" then
		TRIGGER_CHANGELEVEL = {
			Vector(-5758, 9295, -94), 		Vector(-5570, 9138, 160)
		}
		
		TRIGGER_CHECKPOINT = {
			Vector(-2760, 5232, 86),		Vector(-2807, 5345, -42)
		}
		
		CHECKPOINT_POS = {
			Vector(-2821, 5296, -37)
		}
	elseif game.GetMap() == "d1_canals_02" then
		TRIGGER_CHANGELEVEL = {
			Vector(-416, 1702, -829), 		Vector(-396, 1605, -725)
		}	

	elseif game.GetMap() == "d1_canals_03" then
		TRIGGER_CHANGELEVEL = {
			Vector(-3451, -123, -942), 		Vector(-3537, -33, -1070)
		}
		
		TRIGGER_CHECKPOINT = {
			Vector(-1488, 480, -943), 		Vector(-1679, 630, -1038),
			Vector(-2034, -1011, -1230), 	Vector(-2213, -722, -1124)
		}
		
		CHECKPOINT_POS = {
			Vector(-1579, 523, -1042),		Vector(-2073, -885, -1223),
		}
		
	elseif game.GetMap() == "d1_canals_05" then
		TRIGGER_CHANGELEVEL = {
			Vector(-5251, -2561, -476), 	Vector(-5016, -2048, -256)
		}
		
		TRIGGER_CHECKPOINT = {
			Vector(4286, 1572, -343), 		Vector(4097, 1663, -472),
			Vector(6743, 1536, -446), 		Vector(6771, 1596, -347)
		}
		
		CHECKPOINT_POS = {
			Vector(4135, 1519, -455),		Vector(6744, 1567, -439),
		}
		
	elseif game.GetMap() == "d1_canals_06" then
		TRIGGER_CHANGELEVEL = {
			Vector(-1658, -3585, -468), 	Vector(-1046, -2491, -197)
		}
	
	elseif game.GetMap() == "d1_canals_07" then
		TRIGGER_CHANGELEVEL = {
			Vector(-7215, -3843, -732), 	Vector(-7495, -4539, -1030)
		}
		
		TRIGGER_CHECKPOINT = {
			Vector(7583, 1658, -2545), 		Vector(7666, 1797, -83)
		}
		
		CHECKPOINT_POS = {
			Vector(7611, 1745, -245)
		}
		
	elseif game.GetMap() == "d1_canals_08" then
		TRIGGER_CHANGELEVEL = {
			Vector(-9138, 9429, -582), 	Vector(-8882, 8961, -216)
		}
		
		TRIGGER_CHECKPOINT = {
			Vector(-777, -437, -487), 		Vector(-672, -544, -574),
			Vector(-2056, -3613, -352), 	Vector(-1730, -4486, -637)
		}
		
		CHECKPOINT_POS = {
			Vector(-775, -559, -571),		Vector(-1910, -4146, -629)
		}
	elseif game.GetMap() == "d1_canals_09" then
		TRIGGER_CHANGELEVEL = {
			Vector(-1782, -7391, -427), 	Vector(-1382, -7600, -140)
		}
	elseif game.GetMap() == "d1_canals_10" then
		TRIGGER_CHANGELEVEL = {
			Vector(-13890, 316, -335), 		Vector(-13569, 608, -28)
		}
	elseif game.GetMap() == "d1_canals_11" then
		TRIGGER_CHANGELEVEL = {
			Vector(-11332, -769, -950), 	Vector(-11705, -1019, -790)
		}
		
		TRIGGER_CHECKPOINT = {
			Vector(6225, 5231, -894), 		Vector(6321, 5365, -772),
			Vector(5635, 4733, -960), 		Vector(5381, 5085, -753),
			Vector(2164, -7508, -829), 		Vector(2351, -7901, -958)
		}
		
		CHECKPOINT_POS = {
			Vector(6356, 5366, -889),	Vector(5703, 4901, -931),
			Vector(1852, -7389, -919)
		}
		
		CHECKPOINT_FUNC_1 = function()
			disableAirboatGlobal = true
			for _, v in ipairs(player.GetAll()) do
				if v.vehicle and v.vehicle:IsValid() then
					v.vehicle:Remove()
					v.vehicle = nil
				end
			end
			
			local gunboatMap = ents.Create(AirboatGun.Class)
			gunboatMap:SetModel(Airboat.Model)
			gunboatMap:SetPos(Vector(6306, 4861, -943) )
			
			for i, key in pairs(AirboatGun.KeyValues) do
				gunboatMap:SetKeyValue(i, key)
			end
			gunboatMap:Activate()
			gunboatMap:Fire( "addoutput", "targetname airboat" );
			gunboatMap:Spawn()
			gunboatMap:SetAngles(Angle(0, 180, 0))
					
		end
		
		CHECKPOINT_FUNC_2 = function()
			canSpawnGlobalGun = true
						
			BroadcastMessage(ENABLED_AIRBOAT_GUN)
		end
	elseif game.GetMap() == "d1_canals_12" then
		TRIGGER_CHANGELEVEL = {
			Vector(2623, -8575, 97), 	Vector(2263, -8499, 361)
		}
		
		TRIGGER_CHECKPOINT = {
			Vector(-4583, 3482, 323), 	Vector(-4103, 3252, 463)
		}
		
		CHECKPOINT_POS = {
			Vector(-4509, 3346, 332)
		}
	elseif game.GetMap() == "d1_canals_13" then
		TRIGGER_CHANGELEVEL = {
			Vector(-760, -3764, -225), 	Vector(-514, -3840, -381)
		}
	elseif game.GetMap() == "d1_eli_01" then
		TRIGGER_CHANGELEVEL = {
			Vector(-681, 1148, -2686),	Vector(-511, 1091, -2574)
		}
		
		TRIGGER_CHECKPOINT = { 
			Vector(29, 2799, -1277),	Vector(-181, 2671, -1154),
			Vector(528, 1738, -1279), 	Vector(382, 1605, -1155),
			Vector(340, 1849, -2593), 	Vector(550, 1762, -2733),
			Vector(-488, 2189, -2734), 	Vector(-539, 2065, -2624)
		}
		
		CHECKPOINT_POS = {
			Vector(-80, 2737, -1264),	Vector(455, 1672, -1273), 	
			Vector(448, 1833, -2722),	Vector(-703, 2119, -2729), 	
		}
	elseif game.GetMap() == "d1_eli_02" then
		TRIGGER_CHANGELEVEL = {
			Vector(-3559, 4081, -1664),		Vector(-3412, 4015, -1529)
		}
		TRIGGER_CHECKPOINT = {
			Vector(-677, 864, -2676), 		Vector(-519, 779, -2566),
			Vector(-846, 1391, -2686), 		Vector(-500, 1319, -2561),
			Vector(-1933, 2014, -2636), 	Vector(-1984, 1826, -2733)
		}
		
		CHECKPOINT_POS = {
			Vector(-600, 750, -2676),		Vector(-667, 1308, -2674),
			Vector(-2011, 1908, -2725)
		}
	elseif game.GetMap() == "d1_town_01" then
		TRIGGER_CHANGELEVEL = {
			Vector(246, 363, -3208),		Vector(136, 296, -3326)
		}
		TRIGGER_CHECKPOINT = {
			Vector(1175, -341, -3389), 		Vector(1259, -401, -3515)
		}
		
		CHECKPOINT_POS = {
			Vector(1223, -361, -3507),		
		}
	elseif game.GetMap() == "d1_town_01a" then
		TRIGGER_CHANGELEVEL = {
			Vector(-615, 653, -3310),		Vector(-689, 766, -3438)
		}
	elseif game.GetMap() == "d1_town_02" and not file.Exists("hl2cr_data/ravenholmcheck.txt", "DATA") then
		TRIGGER_CHANGELEVEL = {
			Vector(-3588, -573, -3439),		Vector(-3710, -478, -3582)
		}
	elseif game.GetMap() == "d1_town_03" then
		TRIGGER_CHANGELEVEL = {
			Vector(-3722, -62, -3453),		Vector(-3798, 9, -3337)
		}
	elseif game.GetMap() == "d1_town_02" and file.Exists("hl2cr_data/ravenholmcheck.txt", "DATA") then
		TRIGGER_CHANGELEVEL = {
			Vector(-5286, 2102, -3260),		Vector(-5092, 1863, -3041)
		}
		
		TRIGGER_CHECKPOINT = {
			Vector(-4516, 800, -3061),		Vector(-4722, 982, -2954)
		}
		
		CHECKPOINT_POS = {
			Vector(-4809, 589, -3246)
		}
		
	elseif game.GetMap() == "d1_town_02a" then
		TRIGGER_CHANGELEVEL = {
			Vector(-6531, -641, -3140),		Vector(-6638, -722, -3261)
		}
		
		TRIGGER_CHECKPOINT = {
			Vector(-7479, -290, -3293),		Vector(-7547, -154, -3405)
		}
		
		CHECKPOINT_POS = {
			Vector(-7458, -208, -3402)
		}
	elseif game.GetMap() == "d1_town_04" then
		TRIGGER_CHANGELEVEL = {
			Vector(-2688, 1024, -4735),		Vector(-2679, 1278, -4862)
		}
	elseif game.GetMap() == "d1_town_05" then
		TRIGGER_CHANGELEVEL = {
			Vector(-1634, 10894, 1015),		Vector(-1727, 10916, 896)
		}
		TRIGGER_CHECKPOINT = {
			Vector(-1051, 10363, 897),		Vector(-1174, 10428, 1013)
		}
		
		CHECKPOINT_POS = {
			Vector(-1101, 10431, 905)
		}
	elseif game.GetMap() == "d2_coast_01" then
		TRIGGER_CHANGELEVEL = {
			Vector(-12091, 4070, 1689),		Vector(-11584, 4384, 1540)
		}
	elseif game.GetMap() == "d2_coast_03" then
		TRIGGER_CHANGELEVEL = {
			Vector(6274, 13159, 197),		Vector(7177, 13340, 41)
		}
		TRIGGER_CHECKPOINT = {
			Vector(8727, 4527, 372),		Vector(8872, 4153, 258)
		}
		CHECKPOINT_POS = {
			Vector(8777, 4344, 267)
		}
	elseif game.GetMap() == "d2_coast_04" then
		TRIGGER_CHANGELEVEL = {
			Vector(-3806, 10753, 1922),		Vector(-4263, 10241, 1793)
		}
		TRIGGER_CHECKPOINT = {
			Vector(6204, -3945, 529),		Vector(5888, -3701, 384)
		}
		CHECKPOINT_POS = {
			Vector(6049, -3863, 391)
		}
	elseif game.GetMap() == "d2_coast_05" then
		TRIGGER_CHANGELEVEL = {
			Vector(2682, 5504, 1342),		Vector(2212, 6073, 1633)
		}
		TRIGGER_CHECKPOINT = {
			Vector(-4465, -1648, 1088),		Vector(-5144, -1288, 1258)
		}
		CHECKPOINT_POS = {
			Vector(-4839, -1420, 1097)
		}
	elseif game.GetMap() == "d2_coast_07" and not file.Exists("hl2cr_data/bridgecheck.txt", "DATA") then
		TRIGGER_CHANGELEVEL = {
			Vector(3296, 5159, 1536),		Vector(3358, 5132, 1664)
		}
	elseif game.GetMap() == "d2_coast_08" then
		TRIGGER_CHANGELEVEL = {
			Vector(3051, 1601, 1536),		Vector(3135, 1786, 1665)
		}
		TRIGGER_CHECKPOINT = {
			Vector(3062, -6920, 1922),		Vector(2825, -7023, 2040)
		}
		CHECKPOINT_POS = {
			Vector(2954, -6999, 1927)
		}
		
	elseif game.GetMap() == "d2_coast_07" and file.Exists("hl2cr_data/bridgecheck.txt", "DATA") then
		TRIGGER_CHANGELEVEL = {
			Vector(9438, -9582, 2050),		Vector(8961, -9463, 2240)
		}
	elseif game.GetMap() == "d2_coast_09" then
		TRIGGER_CHANGELEVEL = {
			Vector(11503, -1684, -184),		Vector(10983, -1947, 6)
		}
		
		TRIGGER_CHECKPOINT = {
			Vector(11179, 8389, -187),		Vector(10869, 8636, -52)
		}
		
		CHECKPOINT_POS = {
			Vector(11012, 8545, -182)
		}
	elseif game.GetMap() == "d2_coast_10" then
		TRIGGER_CHANGELEVEL = {
			Vector(5161, 2652, 512),		Vector(4916, 3135, 294)
		}
		
		TRIGGER_CHECKPOINT = {
			Vector(4773, -330, 1048),		Vector(4932, -131, 916),
			Vector(8317, 1815, 962),		Vector(8128, 1868, 1088)
		}
		
		CHECKPOINT_POS = {
			Vector(4838, -415, 928),		Vector(8223, 1839, 966)
		}
		
		CHECKPOINT_FUNC_1 = function()
			disableJeepGlobal = true
		end
		
	elseif game.GetMap() == "d2_coast_11" then
		TRIGGER_CHANGELEVEL = {
			Vector(-3288, 13717, 590),		Vector(-3419, 13176, 300)
		}
		
		TRIGGER_CHECKPOINT = {
			Vector(4196, 6553, 717),		Vector(4665, 6785, 577),
			Vector(669, 11687, 481),		Vector(690, 11475, 663)
		}
		
		CHECKPOINT_POS = {
			Vector(4412, 6692, 588),		Vector(591, 11602, 473)
		}
		
		CHECKPOINT_FUNC_1 = function()
			if keepOffSand then
				for k, sand in ipairs(ents.FindByClass("env_player_surface_trigger")) do
					sand:Remove()
				end
				
				for _, v in ipairs(player.GetAll()) do
					GrantAchievement(v, "HL2", "Keep_Off_Sand")
				end
				
				StayedOffSand = true
			end
		end
		
	elseif game.GetMap() == "d2_coast_12" then
		TRIGGER_CHANGELEVEL = {
			Vector(9214, 8471, 2206),		Vector(9338, 8463, 2085)
		}
		
		TRIGGER_CHECKPOINT = {
			Vector(2048, -263, 672),		Vector(2238, -318, 798),
			Vector(8842, 7747, 1039),		Vector(9024, 7657, 898)
		}
		
		CHECKPOINT_POS = {
			Vector(2138, -275, 681),		Vector(8966, 7884, 924)
		}
	elseif game.GetMap() == "d2_prison_01" then
		TRIGGER_CHANGELEVEL = {
			Vector(537, -1598, 1601),		Vector(705, -1432, 1741)
		}
		
		TRIGGER_CHECKPOINT = {
			Vector(1232, -1409, 1601),		Vector(1138, -1597, 1724)
		}
		
		CHECKPOINT_POS = {
			Vector(1005, -1484, 1608)
		}
	elseif game.GetMap() == "d2_prison_02" then
		TRIGGER_CHANGELEVEL = {
			Vector(-2558, 1155, 787),		Vector(-2797, 1310, 641)
		}
	elseif game.GetMap() == "d2_prison_03" then
		TRIGGER_CHANGELEVEL = {
			Vector(-3567, 5954, 150),		Vector(-3422, 6142, 1)
		}
		TRIGGER_CHECKPOINT = {
			Vector(-3394, 3283, 157),		Vector(-3583, 3392, 1)
		}
		
		CHECKPOINT_POS = {
			Vector(-3474, 3376, 4)
		}
	elseif game.GetMap() == "d2_prison_04" then
		TRIGGER_CHANGELEVEL = {
			Vector(-1250, 3030, 386),		Vector(-1437, 2881, 512)
		}
	elseif game.GetMap() == "d2_prison_05" then
		TRIGGER_CHANGELEVEL = {
			Vector(-4052, -1080, 401),		Vector(-4305, -980, 582)
		}
		TRIGGER_CHECKPOINT = {
			Vector(-2348, 564, 895),		Vector(-2185, 446, 769),
			Vector(-4250, -467, 646),		Vector(-4032, -652, 486),
			Vector(-4685, -744, 642),		Vector(-4440, -890, 772)
		}
		
		CHECKPOINT_POS = {
			Vector(-2253, 423, 778),		Vector(-4543, -571, 539),
			Vector(-4547, -924, 720)
		}
	elseif game.GetMap() == "d2_prison_06" then
		TRIGGER_CHANGELEVEL = {
			Vector(247, -2687, -240),		Vector(-80, -2400, -111)
		}
		TRIGGER_CHECKPOINT = {
			Vector(1484, 606, -189),		Vector(1617, 754, -73),
			Vector(267, -460, 115),		Vector(359, -380, -63),
			Vector(511, -1031, 3),		Vector(597, -835, 128)
		}
		
		CHECKPOINT_POS = {
			Vector(1559, 678, -186),		Vector(310, -410, -54),
			Vector(576, -928, 9)
		}
	elseif game.GetMap() == "d2_prison_07" then
		TRIGGER_CHANGELEVEL = {
			Vector(4419, -4242, -567),		Vector(4660, -4430, -693)
		}
		TRIGGER_CHECKPOINT = {
			Vector(-346, -2863, -111),		Vector(-534, -2788, -238),
			Vector(1588, -3267, -536),		Vector(1474, -3359, -678),
			Vector(4333, -4093, -416),		Vector(3986, -3905, -542)
		}
		
		CHECKPOINT_POS = {
			Vector(-440, -2915, -237),		Vector(1505, -3317, -672),
			Vector(4152, -3989, -536)
		}
		
		CHANGELEVEL_FUNC = function()
			for _, v in ipairs(player.GetAll()) do
				GrantAchievement(v, "HL2", "Warden_Freeman")
			end
		end
		
	elseif game.GetMap() == "d2_prison_08" then
		TRIGGER_CHANGELEVEL = {
			Vector(-958, -962, 914),		Vector(-865, -1084, 1067)
		}
		TRIGGER_CHECKPOINT = {
			Vector(-1069, 993, 961),		Vector(-705, 900, 1163),
			Vector(-590, 526, 1086),		Vector(-289, 638, 929),
			Vector(638, 128, 1152),			Vector(-254, 445, 961),
			Vector(162, -25, 1200),			Vector(92, 50, 1228)
		}
		
		CHECKPOINT_POS = {
			Vector(-930, 816, 964),			Vector(-430, 558, 936),
			Vector(124, 276, 998),			Vector(125, 3, 1215)
		}
	elseif game.GetMap() == "d3_c17_01" then
		TRIGGER_CHANGELEVEL = {
			Vector(-6780, -738, -257),		Vector(-6604, -918, -81)
		}
		TRIGGER_CHECKPOINT = {
			Vector(-7054, -1481, 0),		Vector(-6995, -1275, 139),
			Vector(-6578, -891, 128),		Vector(-6353, -1007, 1),
		}
		
		CHECKPOINT_POS = {
			Vector(-6932, -1447, 5),		Vector(-6481, -930, 10),
		}
	elseif game.GetMap() == "d3_c17_02" then
		TRIGGER_CHANGELEVEL = {
			Vector(-5211, -4546, 130),		Vector(-5142, -4471, 2)
		}
		TRIGGER_CHECKPOINT = {
			Vector(-5565, -5185, 1),		Vector(-5440, -5297, 173),
		}
		
		CHECKPOINT_POS = {
			Vector(-5501, -5247, 5)
		}
	elseif game.GetMap() == "d3_c17_03" then
		TRIGGER_CHANGELEVEL = {
			Vector(-1084, -3490, 251),		Vector(-960, -3583, 128)
		}
		
		CHANGELEVEL_FUNC = function()
			for _, v in ipairs(player.GetAll()) do
				GrantAchievement(v, "HL2", "Follow_Freeman")
			end
		end
		
	elseif game.GetMap() == "d3_c17_04" then
		TRIGGER_CHANGELEVEL = {
			Vector(42, -5817, 247),		Vector(141, -5879, 130)
		}
	elseif game.GetMap() == "d3_c17_05" then
		TRIGGER_CHANGELEVEL = {
			Vector(2865, -3329, -126),		Vector(2669, -3443, -1)
		}
		TRIGGER_CHECKPOINT = {
			Vector(1914, -3574, 568),		Vector(1674, -3402, 449)
		}
		
		CHECKPOINT_POS = {
			Vector(1789, -3462, 453)
		}
	elseif game.GetMap() == "d3_c17_06a" then
		TRIGGER_CHANGELEVEL = {
			Vector(2112, 2916, -35),		Vector(2172, 2975, -126)
		}
		TRIGGER_CHECKPOINT = {
			Vector(3261, 2085, -320),		Vector(2624, 2270, -196)
		}
		
		CHECKPOINT_POS = {
			Vector(2963, 2255, -312)
		}
		
		CHANGELEVEL_FUNC = function()
			for _, v in ipairs(player.GetAll()) do
				GrantAchievement(v, "HL2", "Radiation_Levels")
			end
		end
		
	elseif game.GetMap() == "d3_c17_06b" then
		TRIGGER_CHANGELEVEL = {
			Vector(5374, 1774, 257),		Vector(5280, 1679, 374)
		}
		TRIGGER_CHECKPOINT = {
			Vector(3133, 1404, 158),		Vector(3064, 1281, 2),
			Vector(4306, 1918, 385),		Vector(4511, 1860, 518),
		}
		
		CHECKPOINT_POS = {
			Vector(2984, 1346, 5),			Vector(4427, 1918, 388)
		}
	elseif game.GetMap() == "d3_c17_07" then
		TRIGGER_CHANGELEVEL = {
			Vector(10190, 2954, -477),		Vector(10117, 2852, -321)
		}
		TRIGGER_CHECKPOINT = {
			Vector(5628, 1482, 112),		Vector(5538, 1349, 0),
			Vector(7394, 1282, 146),		Vector(7526, 1790, 1),
		}
		
		CHECKPOINT_POS = {
			Vector(5602, 1401, 5),			Vector(7487, 1544, 2)
		}
	elseif game.GetMap() == "d3_c17_08" then
		TRIGGER_CHANGELEVEL = {
			Vector(2599, -361, 665),		Vector(2463, -485, 498)
		}
		TRIGGER_CHECKPOINT = {
			Vector(1315, -578, -195),		Vector(1225, -631, -381),
			Vector(866, 638, 402),			Vector(991, 534, 549)
		}
		
		CHECKPOINT_POS = {
			Vector(1257, -573, -374),		Vector(922, 579, 406)
		}
	elseif game.GetMap() == "d3_c17_09" then
		TRIGGER_CHANGELEVEL = {
			Vector(9286, 7058, 151),		Vector(9328, 7151, 1)
		}
		TRIGGER_CHECKPOINT = {
			Vector(6208, 6493, 195),		Vector(6145, 6419, 299)
		}
		
		CHECKPOINT_POS = {
			Vector(6244, 6448, 201)
		}
	elseif game.GetMap() == "d3_c17_10a" then
		TRIGGER_CHANGELEVEL = {
			Vector(528, 4974, 256),		Vector(484, 4802, 409)
		}
		TRIGGER_CHECKPOINT = {
			Vector(-2978, 6740, 129),		Vector(-3069, 6806, 247)
		}
		
		CHECKPOINT_POS = {
			Vector(-3023, 6760, 146)
		}
		
		CHECKPOINT_FUNC_1 = function()
			ents.FindByClass("npc_barney")[1]:SetPos(Vector(-3015, 6936, 140))
		end
		
	elseif game.GetMap() == "d3_c17_10b" then
		TRIGGER_CHANGELEVEL = {
			Vector(2817, 1138, 827),		Vector(2878, 1024, 705)
		}
		TRIGGER_CHECKPOINT = {
			Vector(2318, -756, 501),		Vector(2909, -982, 257),
			Vector(2657, 971, 393),		Vector(2719, 1085, 258)
		}
		
		CHECKPOINT_POS = {
			Vector(2456, -862, 279),		Vector(2690, 1029, 268)
		}
		
	elseif game.GetMap() == "d3_c17_11" then
		TRIGGER_CHANGELEVEL = {
			Vector(1211, 3309, 1086),		Vector(1262, 3396, 962)
		}
	elseif game.GetMap() == "d3_c17_12" then
		TRIGGER_CHANGELEVEL = {
			Vector(-2569, 9152, -4),		Vector(-2687, 9260, -127)
		}
	elseif game.GetMap() == "d3_c17_12b" then
		TRIGGER_CHANGELEVEL = {
			Vector(-4423, 938, 95),			Vector(-4518, 1057, -30)
		}
		TRIGGER_CHECKPOINT = {
			Vector(-8751, -1231, -255),		Vector(-8611, -594, -100)
		}
		
		CHECKPOINT_POS = {
			Vector(-8669, -912, -222)
		}
		
		CHANGELEVEL_FUNC = function()
			for _, v in ipairs(player.GetAll()) do
				GrantAchievement(v, "HL2", "Giant_Killer")
			end
		end
		
	elseif game.GetMap() == "d3_c17_13" then
		TRIGGER_CHANGELEVEL = {
			Vector(8301, 1796, -281),		Vector(8455, 1978, -428)
		}
		TRIGGER_CHECKPOINT = {
			Vector(6190, -1289, 1),			Vector(6111, -1318, 120),
			Vector(5487, 257, 2),			Vector(4832, 725, 159),
			Vector(8321, 1086, -106),		Vector(8445, 961, -197)
		}
		
		CHECKPOINT_POS = {
			Vector(6146, -1343, 12),		Vector(5134, 449, 8),
			Vector(8393, 993, -189)
		}
	elseif game.GetMap() == "d3_citadel_01" then
		TRIGGER_CHANGELEVEL = {
			Vector(11329, 5982, -1772),		Vector(11623, 5792, -1530)
		}
		
		CHANGELEVEL_FUNC = function()
			local endPoint = Vector(TRIGGER_CHANGELEVEL[2]) - ( ( Vector(TRIGGER_CHANGELEVEL[2]) - Vector(TRIGGER_CHANGELEVEL[1])) / 2 )
			for k, v in ipairs(player.GetAll()) do
				if v:InVehicle() then v:ExitVehicle() end
				v:SetPos(Vector(11539, 5926, -1643))
			end
		end
	elseif game.GetMap() == "d3_citadel_03" then
		TRIGGER_CHANGELEVEL = {
			Vector(729, -382, 2497),		Vector(587, -257, 2370)
		}
		TRIGGER_CHECKPOINT = {
			Vector(7742, -1050, 2113),		Vector(7617, -906, 2303),
			Vector(3160, 254, 2369),		Vector(3072, 130, 2567)
		}
		
		CHECKPOINT_POS = {
			Vector(7684, -995, 2138),	Vector(3156, 197, 2373)
		}
		
		CHECKPOINT_FUNC_1 = function()
			table.Empty(SPAWNING_WEAPONS)
			table.insert(SPAWNING_WEAPONS, "weapon_physcannon")
			
			for _, v in ipairs(player.GetAll()) do
				v:StripWeapons()
				v:Give("weapon_physcannon")
			end
			
			ON_CITADEL_MAPS = true
		end
		
	elseif game.GetMap() == "d3_citadel_04" then
		TRIGGER_CHANGELEVEL = {
			Vector(-1278, -7745, 6122),		Vector(-1153, -8382, 6118)
		}
		TRIGGER_CHECKPOINT = {
			Vector(65, 991, 2791),		Vector(416, 654, 2622),
			Vector(446, 159, 6402),		Vector(65, -16, 6606)
		}
		
		CHECKPOINT_POS = {
			Vector(271, 822, 2612),		Vector(260, 72, 6406)
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
		
	elseif game.GetMap() == "d3_citadel_05" then
		TRIGGER_CHANGELEVEL = {
			Vector(14150, -9734, 8448),		Vector(14466, -10106, 8753)
		}

		CHANGELEVEL_FUNC = function()
			for k, v in ipairs(player.GetAll()) do 
				if v:InVehicle() then v:ExitVehicle() end
				v:SetPos(Vector(14347, -9935, 8741))
			end
		end
		
	elseif game.GetMap() == "d3_breen_01" then
		TRIGGER_CHANGELEVEL = {
			Vector(0, 0, 0),		Vector(0, 0, 0)
		}
		
		TRIGGER_CHECKPOINT = {
			Vector(-1617, -51, 1513),		Vector(-1465, 63, 1344),
			Vector(-827, -126, -254),			Vector(-766, 123, -62),
			Vector(-502, -375, 1449),			Vector(-767, -510, 1282)
		}
		CHECKPOINT_POS = {
			Vector(-1576, -3, 1368),		Vector(-635, 4, -248),
			Vector(-680, -420, 1292)
		}

	elseif game.GetMap() == "d2_lostcoast" then
		TRIGGER_CHANGELEVEL = {
			Vector(1155, 2902, 2528),		Vector(1046, 3018, 2556)
		}
		TRIGGER_CHECKPOINT = {
			Vector(1857, 4768, 2564),		Vector(1922, 4731, 2696),
			Vector(1723, 3482, 2853),		Vector(1219, 3521, 2700),
			Vector(2094, 3008, 2692),		Vector(1987, 3064, 2899)
		}
		
		CHECKPOINT_POS = {
			Vector(1888, 4662, 2571),		Vector(1474, 3536, 2714),
			Vector(2041, 2979, 2698)
		}
		
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
		Changelevel = ents.Create("trigger_changelevel")
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
end

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

local VEHICLES = {
	["prop_vehicle_airboat"] = true,
	["pro_vehicle_jeep_old"] = true,
	["pro_vehicle_jeep"] = true
}


local function SetUpMisc()
	local MapLua = ents.Create("lua_run")
	MapLua:SetName("triggerhook")
	MapLua:Spawn()
	
	timer.Simple(0.1, function()
		for _, ent in ipairs(ents.GetAll()) do
			if string.find(ent:GetName(), "global_newgame_") and not VEHICLES[ent:GetClass()] then
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
	HOSTILE_VORTS = false
	
	for _, portal in ipairs(ents.FindByClass("func_areaportal")) do
		portal:SetKeyValue("StartOpen", "1")
	end
	
	if game.GetMap() == "d1_trainstation_01" then
		game.SetGlobalState("gordon_precriminal", 1)
		game.SetGlobalState("gordon_invulnerable", 1)
		game.SetGlobalState("suit_no_sprint", 1)
	end
	
	if game.GetMap() == "d1_trainstation_02" then
		for k, spawn in ipairs(ents.FindByClass("info_player_start")) do 
			if k ~= 1 then
				spawn:Remove()
			end
		end
		ents.FindByName("trashcan_trigger")[1]:Fire("AddOutput", "OnTrigger triggerhook:RunPassedCode:TrainSodaCan(true)")
		ents.FindByName("cupcop_fail_relay")[1]:Fire("AddOutput", "OnTrigger triggerhook:RunPassedCode:TrainSodaCan(false)")
		ents.FindByName("player_escape_trigger")[1]:Remove()
	end
		
	if game.GetMap() == "d1_trainstation_05" then
		for a, catTrigger in ipairs(ents.FindByName("kill_mtport_rl_1")) do
			catTrigger:Fire("AddOutput", "OnTrigger triggerhook:RunPassedCode:hook.Run( 'GiveWhatCat' ):2:-1" )
		end
	end
	
	if game.GetMap() == "d1_trainstation_06" then
		ents.FindByClass("info_player_start")[1]:SetPos(Vector(-9939, -3672, 333))
	end
	
	if game.GetMap() == "d1_canals_07" then
		local blocker = ents.Create("prop_dynamic")
		blocker:SetModel("models/props_lab/blastdoor001b.mdl")
		blocker:SetPos(Vector(7672, 1374, -265))
		blocker:Spawn()
	end
	
	if game.GetMap() == "d1_canals_10" then
		ents.FindByClass("info_player_start")[1]:SetPos(Vector(11911, -12159, -499))
	end

	if NOSUIT_MAPS[game.GetMap()] or game.GetMap() == "d1_trainstation_05" then
		RunConsoleCommand("sv_auxpow_sprint_enabled", 0)	
	else
		RunConsoleCommand("sv_auxpow_sprint_enabled", 1)
	end

	if game.GetMap() == "d1_eli_02" then
		for k, g in ipairs( ents.FindByName( "trigger_Get_physgun" )) do
			g:Fire("AddOutput", "OnTrigger triggerhook:RunPassedCode:hook.Run( 'GiveGravgun' ):0:-1" )
		end
		
		for k, basket in ipairs(ents.FindByName("trigger_BBall_score_top")) do
			basket:Fire("AddOutput", "OnEndTouch triggerhook:RunPassedCode:hook.Run( 'GiveBallAch' ):0:-1" )
		end
	end
	
	if game.GetMap() == "d1_town_02a" then
		local checkpoint = ents.FindByClass("trigger_checkpoint")[1] 
		checkpoint:AddAchTrigger("HL2", "Hallowed_Ground")
	end
	
	if file.Exists("hl2cr_data/babycheck.txt", "DATA") then
		local spawnpoint
		if game.GetMap() != "d1_trainstation_05" then
			spawnpoint = ents.FindByClass("info_player_start")[1]
		else
			spawnpoint = ents.FindByClass("info_player_start")[2]
		end
		local baby = ents.Create("prop_physics")
		baby:SetModel("models/props_c17/doll01.mdl")
		baby:SetPos(spawnpoint:GetPos() + Vector(30, 30, 0))
		baby:Spawn()
	end
	
	if file.Exists("hl2cr_data/ballcheck.txt", "DATA") then
		local spawnpoint 
		if game.GetMap() == "d1_town_01" then
			spawnpoint = ents.FindByClass("info_player_start")[2]
		elseif game.GetMap() == "d1_town_01a" or (game.GetMap() == "d1_town_02" and not file.Exists("hl2cr_data/ravenholmcheck.txt", "DATA") ) or game.GetMap() == "d1_town_03" then
			spawnpoint = ents.FindByClass("info_player_start")[1]
		elseif game.GetMap() == "d1_town_02" and file.Exists("hl2cr_data/ravenholmcheck.txt", "DATA") then	
			local ball = ents.Create("prop_physics")
			ball:SetModel("models/roller.mdl")
			ball:SetPos(Vector(-3745, 64, -3395))
			ball:Spawn()
		elseif game.GetMap() == "d1_town_04" then
			spawnpoint = ents.FindByClass("info_player_start")[2]
		else
			spawnpoint = ents.FindByClass("info_player_start")[1]
		end
		if not ball and spawnpoint then
			local ball = ents.Create("prop_physics")
			ball:SetModel("models/roller.mdl")
			ball:SetPos(spawnpoint:GetPos() + Vector(30, 30, 0))
			ball:Spawn()
		end
	end
	
	if file.Exists("hl2cr_data/ravenholmcheck.txt", "DATA") and game.GetMap() == "d1_town_02" then
		for i, s in ipairs(ents.FindByClass("info_player_start")) do
			s:SetPos(Vector(-3763, -36, -3439))
			s:SetAngles(Angle(0, 90, 0))
		end
		
		local addBuckshot = {
			["Type"] = "Buckshot",
			["Amount"] = 6,
		}
		
		table.insert(SPAWNING_ITEMS, addBuckshot)
		table.insert(SPAWNING_WEAPONS, "weapon_shotgun")
	end
	
	if game.GetMap() == "d1_town_02a" and file.Exists("hl2cr_data/ravenholmcheck.txt", "DATA") then
		file.Delete("hl2cr_data/ravenholmcheck.txt", "DATA")
	end
	
	if game.GetMap() == "d2_coast_09" and file.Exists("hl2cr_data/bridgecheck.txt", "DATA") then
		file.Delete("hl2cr_data/bridgecheck.txt", "DATA")
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
		ents.FindByName("gunship_spawner_2")[1]:Fire("AddOutput", "OnAllSpawnedDead triggerhook:RunPassedCode:hook.Run( 'OpenGateCoast' ):0:-1" )
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
	
	for _, failer in ipairs(ents.FindByName("fall_trigger")) do
		failer:Remove()
	end
	
	if game.GetMap() == "d2_coast_07" and file.Exists("hl2cr_data/bridgecheck.txt", "DATA") then
		ents.FindByClass("npc_combinedropship")[1]:Remove()
		ents.FindByClass("info_player_start")[1]:SetPos(Vector(3148, 5263, 1540))
		ents.FindByClass("info_player_start")[1]:SetAngles(Angle(0, 180, 0))
		timer.Simple(10, function()
			for _, forcefield in ipairs(ents.FindByName("bridge_field_02")) do
				forcefield:Remove()
			end
		end)
	end
	
	if game.GetMap() == "d2_coast_08" then
		blocker = ents.Create("prop_dynamic")
		blocker:SetModel("models/props_doors/door03_slotted_left.mdl")
		blocker:SetPos(Vector(3305, 1542, 1588))
		blocker:SetAngles(Angle(0, -90, 0))
		blocker:PhysicsInit(SOLID_VPHYSICS)
		blocker:Spawn()
	
		ents.FindByClass("info_player_start")[1]:SetPos(Vector(3330, 1471, 1600))
		ents.FindByClass("info_player_start")[1]:SetAngles(Angle(0, -90, 0))
		
		for k, fog in ipairs(ents.FindByClass("env_fog_controller")) do
			fog:Remove()
		end

		
		hook.Add("Tick", "HL2CR_BridgeThink", function()
			if ents.FindByClass("trigger_checkpoint")[1]:IsTriggered() and blocker:IsValid() then
				blocker:Remove()
			end
		end)
	end
	
	if game.GetMap() == "d2_coast_10" then
		for k, spawn in ipairs(ents.FindByClass("info_player_start")) do 
			if k ~= 1 then
				spawn:Remove()
			end
		end
	end
	
	if game.GetMap() == "d2_coast_11" then
		StayedOffSand = false
		keepOffSand = true
	end
	
	if game.GetMap() == "d2_prison_01" then
		for k, spawn in ipairs(ents.FindByClass("info_player_start")) do 
			if k ~= 1 then
				spawn:Remove()
			end
		end
	end
	
	if game.GetMap() == "d2_prison_03" then
		for k, spawn in ipairs(ents.FindByClass("info_player_start")) do 
			if k ~= 1 then
				spawn:Remove()
			end
		end
	end
	
	if game.GetMap() == "d2_prison_05" or game.GetMap() == "d3_c17_07" or game.GetMap() == "d3_c17_10a" then
		for k, spawn in ipairs(ents.FindByClass("info_player_start")) do 
			if k ~= 1 then
				spawn:Remove()
			end
		end
	end
	
	if game.GetMap() == "d3_c17_10b" then
		ents.FindByName("s_room_detected_relay")[1]:Fire("AddOutput", "OnTrigger triggerhook:RunPassedCode:hook.Run( 'ResetLaserTrap' ):15:-1" )
	end
	
	if game.GetMap() == "d3_c17_12" then
		for k, spawn in ipairs(ents.FindByClass("info_player_start")) do 
			if k ~= 1 then
				spawn:Remove()
			end
		end
	end

	if game.GetMap() == "d3_breen_01" then
		for k, spawn in ipairs(ents.FindByClass("info_player_start")) do
			spawn:SetPos(Vector(-2183, 836, 587))
		end
		ents.FindByClass("item_suit")[1]:SetPos(Vector(-2183, 836, 587))
		
		ents.FindByName("logic_swap")[1]:Fire("AddOutput", "OnTrigger triggerhook:RunPassedCode:hook.Run( 'FinishHL2' ):10:-1" )
	end
end

function SetUpLambdas()
	if game.GetMap() == "d1_trainstation_05" then
		TRIGGER_LAMBDA = {
			Vector(-6464, -1087, 4),		Vector(-6505, -1079, 91)
		}
	elseif game.GetMap() == "d1_canals_01" then
		TRIGGER_LAMBDA = {
			Vector(805, -6154, 515),		Vector(700, -6260, 653),
			Vector(588, -4979, 552),		Vector(625, -4942, 513)
		}
	elseif game.GetMap() == "d1_canals_01a" then
		TRIGGER_LAMBDA = {
			Vector(53, 6094, 3),			Vector(64, 6016, -88)
		}
	elseif game.GetMap() == "d1_canals_02" then
		TRIGGER_LAMBDA = {
			Vector(-269, -944, -959),		Vector(-161, -1005, -1070)
		}
	elseif game.GetMap() == "d1_canals_03" then
		TRIGGER_LAMBDA = {
			Vector(-49, -573, -868),		Vector(-191, -447, -1015)
		}
	elseif game.GetMap() == "d1_canals_05" then
		TRIGGER_LAMBDA = {
			Vector(4028, 4939, -32),		Vector(4145, 4970, -125)
		}
	elseif game.GetMap() == "d1_canals_06" then
		TRIGGER_LAMBDA = {
			Vector(7934, 9121, -144),		Vector(7872, 9026, -237),
			Vector(4551, 5891, 99),			Vector(4608, 6025, 171),
			Vector(-8408, 14048, 105),		Vector(-8016, 13732, -45)
		}
	elseif game.GetMap() == "d1_canals_07" then
		TRIGGER_LAMBDA = {
			Vector(-4353, -14914, -894),	Vector(-4491, -14780, -765)
		}
	elseif game.GetMap() == "d1_canals_08" then
		TRIGGER_LAMBDA = {
			Vector(10337, -7445, -311),		Vector(10224, -7360, -438),
			Vector(-6973, 578, -605),		Vector(-6738, 799, -417)
		}
	elseif game.GetMap() == "d1_canals_09" then
		TRIGGER_LAMBDA = {
			Vector(7166, -9340, -313), 		Vector(6916, -9220, -140)
		}
	elseif game.GetMap() == "d1_canals_10" then
		TRIGGER_LAMBDA = {
			Vector(11972, -1737, -25), 		Vector(11778, -1918, -189),
			Vector(11105, 497, -223), 		Vector(11229, 306, -382)
		}
	elseif game.GetMap() == "d1_canals_12" then
		TRIGGER_LAMBDA = {
			Vector(450, 10891, 499), 		Vector(562, 11000, 607)
		}
	elseif game.GetMap() == "d1_eli_01" then
		TRIGGER_LAMBDA = {
			Vector(104, 4383, -1295), 		Vector(189, 4476, -1404)
		}
	elseif game.GetMap() == "d1_town_01" then
		TRIGGER_LAMBDA = {
			Vector(771, -1662, -3568), 		Vector(640, -1600, -3647),
			Vector(777, 1057, -3645), 		Vector(893, 1140, -3560)
		}
	elseif game.GetMap() == "d1_town_01a" then
		TRIGGER_LAMBDA = {
			Vector(67, 416, -3240), 		Vector(127, 136, -3326)
		}
	elseif game.GetMap() == "d1_town_05" then
		TRIGGER_LAMBDA = {
			Vector(-11400, 4340, 1107), 	Vector(-11425, 4267, 1040)
		}
	elseif game.GetMap() == "d2_coast_01" then
		TRIGGER_LAMBDA = {
			Vector(-12765, 746, 1524), 		Vector(-13023, 606, 1679)
		}
	elseif game.GetMap() == "d2_coast_03" then
		TRIGGER_LAMBDA = {
			Vector(-3441, -6112, 589), 		Vector(-3179, -6293, 717)
		}
	elseif game.GetMap() == "d2_coast_04" then
		TRIGGER_LAMBDA = {
			Vector(2161, 6663, 1162), 		Vector(2246, 6561, 1238)
		}
	elseif game.GetMap() == "d2_coast_05" then
		TRIGGER_LAMBDA = {
			Vector(-3561, 1269, 1219), 		Vector(-3184, 1422, 1097)
		}
	elseif game.GetMap() == "d2_coast_07" then
		TRIGGER_LAMBDA = {
			Vector(1461, 9405, 1830), 		Vector(1847, 9220, 1717)
		}
	elseif game.GetMap() == "d2_coast_09" then
		TRIGGER_LAMBDA = {
			Vector(11172, 8764, -42), 		Vector(11086, 8861, -7)
		}
	elseif game.GetMap() == "d2_coast_11" then
		TRIGGER_LAMBDA = {
			Vector(3432, 613, 995), 		Vector(3203, 968, 815)
		}
	elseif game.GetMap() == "d2_prison_02" then
		TRIGGER_LAMBDA = {
			Vector(-2257, 1725, 513), 		Vector(-2368, 1572, 657)
		}
	elseif game.GetMap() == "d3_c17_02" then
		TRIGGER_LAMBDA = {
			Vector(-10111, -6248, 231), 		Vector(-10237, -6161, 66)
		}
	elseif game.GetMap() == "d3_c17_04" then
		TRIGGER_LAMBDA = {
			Vector(-1081, -4866, 445), 		Vector(-1026, -4980, 321)
		}
	elseif game.GetMap() == "d3_c17_05" then
		TRIGGER_LAMBDA = {
			Vector(2434, -4117, 264), 		Vector(2557, -4209, 129)
		}
	elseif game.GetMap() == "d3_c17_06a" then
		TRIGGER_LAMBDA = {
			Vector(3752, -1662, -197), 		Vector(3524, -1947, -317)
		}
	elseif game.GetMap() == "d3_c17_06b" then
		TRIGGER_LAMBDA = {
			Vector(4474, 2027, 505), 		Vector(4653, 1930, 384),
			Vector(5020, 1409, 178), 		Vector(5067, 1281, 65)
		}
	elseif game.GetMap() == "d3_c17_08" then
		TRIGGER_LAMBDA = {
			Vector(-927, -1810, -289), 		Vector(-1151, -1887, -391),
			Vector(1198, -926, -539), 		Vector(1291, -850, -414),
			Vector(2574, -944, -526), 		Vector(2471, -1021, -416),
			Vector(1641, 648, 926), 		Vector(1758, 577, 770)
		}
	elseif game.GetMap() == "d3_c17_12b" then
		TRIGGER_LAMBDA = {
			Vector(-4339, 637, 100), 		Vector(-4248, 493, 225)
		}
	end
	
	if TRIGGER_LAMBDA then
		if TRIGGER_LAMBDA[1] and TRIGGER_LAMBDA[2] then
			local lambdaTrigger = ents.Create("trigger_lambda")
			lambdaTrigger.Min = Vector(TRIGGER_LAMBDA[1])
			lambdaTrigger.Max = Vector(TRIGGER_LAMBDA[2])
			lambdaTrigger.Pos = Vector(TRIGGER_LAMBDA[2]) - ( ( Vector(TRIGGER_LAMBDA[2]) - Vector(TRIGGER_LAMBDA[1])) / 2 )
			lambdaTrigger:SetPos(lambdaTrigger.Pos)
			lambdaTrigger:Spawn()
		end
		
		if TRIGGER_LAMBDA[3] and TRIGGER_LAMBDA[4] then
			local lambdaTrigger = ents.Create("trigger_lambda")
			lambdaTrigger.Min = Vector(TRIGGER_LAMBDA[3])
			lambdaTrigger.Max = Vector(TRIGGER_LAMBDA[4])
			lambdaTrigger.Pos = Vector(TRIGGER_LAMBDA[4]) - ( ( Vector(TRIGGER_LAMBDA[4]) - Vector(TRIGGER_LAMBDA[3])) / 2 )
			lambdaTrigger:SetPos(lambdaTrigger.Pos)
			lambdaTrigger:Spawn()
		end
		
		if TRIGGER_LAMBDA[5] and TRIGGER_LAMBDA[6] then
			local lambdaTrigger = ents.Create("trigger_lambda")
			lambdaTrigger.Min = Vector(TRIGGER_LAMBDA[5])
			lambdaTrigger.Max = Vector(TRIGGER_LAMBDA[6])
			lambdaTrigger.Pos = Vector(TRIGGER_LAMBDA[6]) - ( ( Vector(TRIGGER_LAMBDA[6]) - Vector(TRIGGER_LAMBDA[5])) / 2 )
			lambdaTrigger:SetPos(lambdaTrigger.Pos)
			lambdaTrigger:Spawn()
		end
		
		if TRIGGER_LAMBDA[7] and TRIGGER_LAMBDA[8] then
			local lambdaTrigger = ents.Create("trigger_lambda")
			lambdaTrigger.Min = Vector(TRIGGER_LAMBDA[7])
			lambdaTrigger.Max = Vector(TRIGGER_LAMBDA[8])
			lambdaTrigger.Pos = Vector(TRIGGER_LAMBDA[8]) - ( ( Vector(TRIGGER_LAMBDA[8]) - Vector(TRIGGER_LAMBDA[7])) / 2 )
			lambdaTrigger:SetPos(lambdaTrigger.Pos)
			lambdaTrigger:Spawn()
		end
	end
end

hook.Add("OpenGateCoast", "HL2CR_OpenGate", function()
	for k, v in ipairs(ents.FindByName("village_gate")) do
		v:Fire("Open")
	end
	
	for k, v in ipairs(player.GetAll()) do
		GrantAchievement(v, "HL2", "Cubbage")
	end
end)

hook.Add("GiveHallow", "HL2CR_GiveHallowGround", function()
	for k, v in ipairs(player.GetAll()) do
		GrantAchievement(v, "HL2", "Hallowed_Ground")
	end
end)

hook.Add("GiveWhatCat", "HL2CR_GiveWhatCat", function()
	for k, v in ipairs(player.GetAll()) do
		GrantAchievement(v, "HL2", "What_Cat")
	end
end)

hook.Add("GiveBallAch", "HL2CR_GiveTwoPoints", function()
	for k, v in ipairs(player.GetAll()) do
		GrantAchievement(v, "HL2", "Two_Points")
	end
end)

hook.Add("GiveGravgun", "HL2CR_GrantGravgun", function()
	for k, v in ipairs(player.GetAll()) do
		v:Give("weapon_physcannon")
		GrantAchievement(v, "HL2", "Zero_Point_Energy")
	end
end)

hook.Add("GravGunOnPickedUp", "HL2CR_BlastAch", function(ply, ent)
	if ent and ent:GetModel() == "models/props_lab/hevplate.mdl" then
		GrantAchievement(ply, "HL2", "Blast_From_The_Past")
	end
end)

hook.Add( "PlayerFootstep", "CustomFootstep", function( ply, pos, foot, sound, volume, rf )
	if game.GetMap() == "d2_coast_11" then
		if string.find(sound, "sand") and (keepOffSand and not StayedOffSand) then
			FailSandAchievement(ply)
		end
	end
	return false 
end)

function TrainSodaCan(hasSubmissive)
	for _, v in ipairs(player.GetAll()) do
		if hasSubmissive then
			GrantAchievement(v, "HL2", "Submissive")
		else
			GrantAchievement(v, "HL2", "Defiant")
		end
	end
end

function FailSandAchievement(ply)		
	local FAILER = {
		["Colour"] = Color(215, 50, 50),
		["Message"] = "ACH_FAILED_SAND",
	}
	
	BroadcastMessage(FAILER)
	
	keepOffSand = false
end

hook.Add("FinishHL2", "HL2CR_CompleteHL2", function(ply, ent)
	for k, v in ipairs(player.GetAll()) do
		v:SetTeam(TEAM_COMPLETED_MAP)
		GrantAchievement(v, "HL2", "Beat_HL2")
	end
	
	BroadcastMessage(MAPS_HL2_FINISHED)
	
	net.Start("HL2CR_EndCampaign")
	net.Broadcast()
	StartFinalMapCountdown()
end)

hook.Add("ResetLaserTrap", "HL2CR_ResetTrap", function()
	for k, laser in ipairs(ents.FindByName("s_laser*")) do
		laser:Fire("TurnOn")
	end
	
	for p, door in ipairs(ents.FindByName("s_room_doors")) do
		door:Fire("Open")
	end
	
	for t, turret in ipairs(ents.FindByName("s_room_turret_*")) do
		turret:Fire("Disable")
	end
	
	ents.FindByName("s_room_panelswitch")[1]:Fire("UnLock")
end)

function StartHL2()
	SetCheckpoints()
	SetUpMisc()
	SetUpLambdas()
end