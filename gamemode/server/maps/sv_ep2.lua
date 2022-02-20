JALOPY_MAPS = {
	["ep2_outland_06a"] = true,
	["ep2_outland_07"] = true,
}

local function SetCheckpoints()
	for k, cl in ipairs(ents.FindByClass("trigger_changelevel")) do
		cl:Remove()
	end
	if game.GetMap() == "ep2_outland_01" then

		TRIGGER_CHANGELEVEL = {
			Vector(-6199, 3558, -1279),		Vector(-6134, 3432, -1391)
		}

		TRIGGER_CHECKPOINT = {
			Vector(803, -79, -65), 			Vector(636, -144, 62),
			Vector(-3193, -908, 347), 		Vector(-3230, -640, 249),
			Vector(-5303, 2268, 90), 		Vector(-4940, 2161, -182),
			Vector(-6219, 3672, -1242), 	Vector(-6343, 3727, -1404)
		}
			
		CHECKPOINT_POS = {
			Vector(617, -74, -8),		Vector(-3269, -740, 278),
			Vector(-4805, 2313, -178),	Vector(-6284, 3644, -1386)
		}
	elseif game.GetMap() == "ep2_outland_01a" then

		TRIGGER_CHANGELEVEL = {
			Vector(-2407, -8191, -268),		Vector(-2350, -8308, -414)
		}

		TRIGGER_CHECKPOINT = {
			Vector(-6574, -7493, 206), 		Vector(-6901, -7385, -58),
		}
			
		CHECKPOINT_POS = {
			Vector(-6798, -7424, -30)
		}
	elseif game.GetMap() == "ep2_outland_02" then

		TRIGGER_CHANGELEVEL = {
			Vector(-829, -10351, -345),		Vector(-743, -10183, -519)
		}

		TRIGGER_CHECKPOINT = {
			Vector(-2648, -9221, -715), 		Vector(-3306, -9731, -898),
			Vector(-469, -9793, -705), 			Vector(-283, -9421, -518)
		}
			
		CHECKPOINT_POS = {
			Vector(-2587, -9477, -673),			Vector(-420, -9639, -705)
		}
		
		CHECKPOINT_FUNC_2 = function()
			for _, v in ipairs(player.GetAll()) do
				GrantAchievement(v, "EP2", "IntoBreach")
			end
		end
		
	elseif game.GetMap() == "ep2_outland_03" then

		TRIGGER_CHANGELEVEL = {
			Vector(5222, -7502, -271),		Vector(5024, -7406, -438)
		}

		TRIGGER_CHECKPOINT = {
			Vector(1057, -4334, -826), 		Vector(903, -4166, -880),
			Vector(1061, -7289, -1659), 		Vector(946, -7479, -1472),
			Vector(1303, -9712, -344), 		Vector(1091, -9618, -510),
			Vector(3691, -9261, -573), 		Vector(3888, -9326, -386),
		}
			
		CHECKPOINT_POS = {
			Vector(935, -4232, -874),		Vector(1098, -7354, -1625),
			Vector(1179, -9733, -500),		Vector(3808, -9264, -566)
		}
	elseif game.GetMap() == "ep2_outland_04" then

		TRIGGER_CHANGELEVEL = {
			Vector(4977, -1662, 3084),		Vector(4885, -1555, 3286)
		}

		TRIGGER_CHECKPOINT = {
			Vector(6089, -3164, -1023), 		Vector(6152, -2965, -1159),
			Vector(5437, -3127, -2171), 		Vector(5249, -2963, -2300)
		}
			
		CHECKPOINT_POS = {
			Vector(6105, -3063, -1127),		Vector(5331, -3039, -2272)
		}
		
		CHANGELEVEL_FUNC = function()
			for _, v in ipairs(player.GetAll()) do
				v:SetPos(Vector(4938, -1622, 3240))
			end
		end
	elseif game.GetMap() == "ep2_outland_05" then

		TRIGGER_CHANGELEVEL = {
			Vector(2008, 6143, 765),		Vector(2135, 6206, 513)
		}

		TRIGGER_CHECKPOINT = {
			Vector(-456, 3709, 306), 		Vector(285, 4302, 1),
			Vector(1249, 5876, 839), 		Vector(1070, 5657, 641)
		}
			
		CHECKPOINT_POS = {
			Vector(-196, 4066, 59),		Vector(1147, 5759, 659)
		}
		
		CHECKPOINT_FUNC_2 = function()
			for _, v in ipairs(player.GetAll()) do
				GrantAchievement(v, "EP2", "Twofer")
			end
		end
	elseif game.GetMap() == "ep2_outland_06" then

		TRIGGER_CHANGELEVEL = {
			Vector(-3102, 2577, 921),		Vector(-3347, 2081, 673)
		}

		TRIGGER_CHECKPOINT = {
			Vector(781, 644, 351), 			Vector(679, 717, 232),
			Vector(704, 3086, 1), 		Vector(544, 2960, -119),
			Vector(3061, 1138, 73), 		Vector(2935, 1255, 186)
		}
			
		CHECKPOINT_POS = {
			Vector(732, 597, 248),		Vector(621, 3107, -105),
			Vector(3252, 1145, 227)
		}
	elseif game.GetMap() == "ep2_outland_06a" then

		TRIGGER_CHANGELEVEL = {
			Vector(-10293, -3729, -2476),		Vector(-9910, -4395, -2212)
		}

		TRIGGER_CHECKPOINT = {
			Vector(-3570, -9774, -1687), 			Vector(-3477, -9689, -1566),
			Vector(-4403, -7566, -1345), 		Vector(-4536, -8088, -1537)
		}
			
		CHECKPOINT_POS = {
			Vector(-3542, -9727, -1492),		Vector(-4538, -7831, -1519)
		}
		
		CHECKPOINT_FUNC_2 = function()
			for _, v in ipairs(player.GetAll()) do
				GrantAchievement(v, "EP2", "HunterAmbush")
			end
		end
	elseif game.GetMap() == "ep2_outland_07" then
		TRIGGER_CHANGELEVEL = {
			Vector(-3970, 13658, 48),		Vector(-3392, 14061, 286)
		}

		TRIGGER_CHECKPOINT = {
			Vector(-9873, -9872, 144), 		Vector(-9946, -9817, 36)
		}
			
		CHECKPOINT_POS = {
			Vector(-9618, -9636, 76)
		}

		CHECKPOINT_FUNC_1 = function()
			ents.FindByName("relay_remove_outer_door")[1]:Fire("trigger")
			ents.FindByName("gate_open_relay")[1]:Fire("trigger")
		end
	elseif game.GetMap() == "ep2_outland_08" then
		TRIGGER_CHANGELEVEL = {
			Vector(-3161, 2022, 74),		Vector(-3061, 1871, 203)
		}

		TRIGGER_CHECKPOINT = {
			Vector(-827, 1396, 180), 		Vector(-327, 1202, 30),
		}
			
		CHECKPOINT_POS = {
			Vector(-969, 1584, 70),		Vector(-4538, -7831, -1519)
		}

		CHANGELEVEL_FUNC = function()
			for _, v in ipairs(player.GetAll()) do
				v:SetPos(Vector(-3108, 1948, 90))
			end
		end

		CHECKPOINT_FUNC_1 = function()
			canSpawnJalopyGlobal = false
		end

	elseif game.GetMap() == "ep2_outland_09" then
		TRIGGER_CHANGELEVEL = {
			Vector(3076, 10168, 192),		Vector(3600, 9826, 485)
		}

		TRIGGER_CHECKPOINT = {
			Vector(545, -9116, 195), 		Vector(328, -9262, 73),
		}
			
		CHECKPOINT_POS = {
			Vector(458, -9181, 98),		Vector(-4538, -7831, -1519)
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

local EP2_WEAPONS = {
	["ep2_outland_01a"] = {
		[1] = "weapon_physcannon",
		[2] = "weapon_crowbar",
	},
	
	["ep2_outland_02"] = {
		[1] = "weapon_physcannon",
		[2] = "weapon_crowbar",
		[3] = "weapon_pistol",
		[4] = "weapon_357",
		[5] = "weapon_shotgun",
	},
	
	["ep2_outland_03"] = {
		[1] = "weapon_physcannon",
		[2] = "weapon_crowbar",
		[3] = "weapon_pistol",
		[4] = "weapon_357",
		[5] = "weapon_shotgun",
		[6] = "weapon_smg1",
	},
	
	["ep2_outland_04"] = {
		[1] = "weapon_physcannon",
		[2] = "weapon_crowbar",
		[3] = "weapon_pistol",
		[4] = "weapon_357",
		[5] = "weapon_shotgun",
		[6] = "weapon_smg1",
	},
	
	["ep2_outland_05"] = {
		[1] = "weapon_physcannon",
		[2] = "weapon_crowbar",
		[3] = "weapon_pistol",
		[4] = "weapon_357",
		[5] = "weapon_shotgun",
		[6] = "weapon_smg1",
	},
	
	["ep2_outland_06"] = {
		[1] = "weapon_physcannon",
		[2] = "weapon_crowbar",
		[3] = "weapon_pistol",
		[4] = "weapon_357",
		[5] = "weapon_shotgun",
		[6] = "weapon_smg1",
	},
	
	["ep2_outland_06a"] = {
		[1] = "weapon_physcannon",
		[2] = "weapon_crowbar",
		[3] = "weapon_pistol",
		[4] = "weapon_357",
		[5] = "weapon_shotgun",
		[6] = "weapon_smg1",
		[7] = "weapon_ar2",
	},
}

local EP2_EQUIPMENT = {

}

local function SetUpMisc()
	local MapLua = ents.Create("lua_run")
	MapLua:SetName("triggerhook")
	MapLua:Spawn()
	
	for k, spawn in ipairs(ents.FindByClass("info_player_start")) do 
		if k ~= 1 then
			spawn:Remove()
		end
	end

	local npc_vortigaunt = {
		["npc_vortigaunt"] = true
	}
	
	table.Merge(FRIENDLY_NPCS, npc_vortigaunt)
	
	timer.Simple(1.5, function()
		for _, ent in ipairs(ents.GetAll()) do
			if (string.find(ent:GetName(), "global_newgame_spawner")) then
				ent:Remove()
			end
		end
	end)
	
	for _, clip in ipairs(ents.FindByClass("func_brush")) do
		if string.find(clip:GetName(), "clip") then
			clip:Remove()
		end
	end
	
	if game.GetMap() == "ep2_outland_01" then
		ents.FindByName("trigger_Get_physgun")[1]:Fire("AddOutput", "OnTrigger triggerhook:RunPassedCode:GiveGravgunEP2()")
		ents.FindByName("SS_alyx_scrapyard_down")[1]:Fire("AddOutput", "OnEndSequence triggerhook:RunPassedCode:FixAlyxDrop()")
		ents.FindByName("speedmod")[1]:Remove()
	end
	
	if game.GetMap() == "ep2_outland_05" then
		ents.FindByName("ss_alyx_wait_02")[1]:Fire("AddOutput", "OnEndSequence triggerhook:RunPassedCode:FixAlyxStandup()")
	end
	
	if game.GetMap() == "ep2_outland_08" then
		canSpawnJalopyGlobal = true
	end

	if game.GetMap() == "ep2_outland_09" then
		canSpawnJalopyGlobal = false
		ents.FindByName("relay.power.off")[1]:Fire("AddOutput", "OnTrigger triggerhook:RunPassedCode:GunnerDestroyed()")
		ents.FindByName("lcs.radar")[1]:Fire("AddOutput", "OnTrigger4 triggerhook:RunPassedCode:AllowJelopy()" )
	end

	if EP2_WEAPONS[game.GetMap()] then
		for i, wep in pairs(EP2_WEAPONS[game.GetMap()]) do 
			table.insert(SPAWNING_WEAPONS, wep)
		end
	end
	
	if EP2_EQUIPMENT[game.GetMap()] then
		table.insert(SPAWNING_ITEMS, EP2_EQUIPMENT[game.GetMap()])
	end
	
end

function GiveGravgunEP2()
	for k, v in ipairs(player.GetAll()) do
		v:Give("weapon_physcannon")
	end
end

function FixAlyxDrop()
	timer.Simple(1, function()
		ents.FindByClass("npc_alyx")[1]:SetPos(Vector(-3983, 1701, 186))
	end)
end

function FixAlyxStandup()
	timer.Simple(1, function()
		ents.FindByClass("npc_alyx")[1]:SetPos(Vector(363, 5798, 7))
	end)
end

function GunnerDestroyed()
	ents.FindByClass("info_player_start")[1]:SetPos(Vector(-768, -7157, 85))

	for _, v in ipairs(player.GetAll()) do
		if v:Team() == TEAM_DEAD then
			v:Spawn()
		end
		v:SetPos(Vector(-768, -7157, 85))
	end
end


function AllowJelopy()
	canSpawnJalopyGlobal = true
	BroadcastMessage(ENABLED_JALOPY)
end

function StartEP2()
	SetCheckpoints()
	SetUpMisc()
end