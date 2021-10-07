local function SetCheckpoints()
	
	for k, cl in ipairs(ents.FindByClass("trigger_changelevel")) do
		cl:Remove()
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
			Vector(945, 910, -1555),		Vector(4934, 5940, -1632),
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
	elseif game.GetMap() == "level_1a" then
	
		TRIGGER_CHANGELEVEL = {
			Vector(1933, 1166, 355),	Vector(1874, 1082, 212)
		}
	
		TRIGGER_CHECKPOINT = {
			Vector(-253, -2045, 3), 		Vector(-97, -1941, 107),
			Vector(0, -1006, 256), 		Vector(-63, -913, 137),
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
	
}

local REMOVE_WEAPONS = {
	["weapon_medkit"] = true
}

local MAP_LOGIC = {
	["level01_synb2_entryway_of_doom"] = function(mapLua)
		local npc_vortigaunt = {
			["npc_vortigaunt"] = {xpMin = 25, xpMax = 50},
		}
		local npc_antlion = {
			["npc_antlion"] = {xpMin = 12, xpMax = 27},
		}
		
		table.Merge(RANDOM_XP_BASED_NPC, npc_vortigaunt)
		table.Merge(RANDOM_XP_BASED_NPC, npc_antlion)
		
		mapLua:SetKeyValue("Code", "hook.Run('EndCoopMap')")
		ents.FindByName("bouton10")[1]:Fire("AddOutput", "OnPressed triggerhook:RunCode")
	end,
	
	["level02_synb2_tricks_and_traps"] = function(mapLua)
		local npc_vortigaunt = {
			["npc_vortigaunt"] = {xpMin = 25, xpMax = 50},
		}
		local npc_antlion = {
			["npc_antlion"] = {xpMin = 12, xpMax = 27},
		}
		
		table.Merge(RANDOM_XP_BASED_NPC, npc_vortigaunt)
		table.Merge(RANDOM_XP_BASED_NPC, npc_antlion)
		
		mapLua:SetKeyValue("Code", "hook.Run('EndCoopMap')")
		ents.FindByName("m_g1")[1]:Fire("AddOutput", "OnAllSpawnedDead triggerhook:RunCode")
	end,
	
	["level03_synb2_underground"] = function(mapLua)
		local npc_vortigaunt = {
			["npc_vortigaunt"] = {xpMin = 25, xpMax = 50},
		}
		local npc_antlion = {
			["npc_antlion"] = {xpMin = 12, xpMax = 27},
		}
		
		table.Merge(RANDOM_XP_BASED_NPC, npc_vortigaunt)
		table.Merge(RANDOM_XP_BASED_NPC, npc_antlion)
		
		mapLua:SetKeyValue("Code", "hook.Run('EndCoopMap')")
		ents.FindByName("craps1")[1]:Fire("AddOutput", "OnDeath triggerhook:RunCode")
		
	end,
	
	["level04_synb2_across_the_darkness"] = function(mapLua)
		local npc_vortigaunt = {
			["npc_vortigaunt"] = {xpMin = 25, xpMax = 50},
		}
		local npc_antlion = {
			["npc_antlion"] = {xpMin = 12, xpMax = 27},
		}
		
		table.Merge(RANDOM_XP_BASED_NPC, npc_vortigaunt)
		table.Merge(RANDOM_XP_BASED_NPC, npc_antlion)
		
		mapLua:SetKeyValue("Code", "hook.Run('EndCoopMap')")
		ents.FindByClass("trigger_once")[18]:Fire("AddOutput", "OnStartTouch triggerhook:RunCode")
	end,
	
	["level05_synb2_diehard"] = function(mapLua)
		for _, newSpawn in ipairs(ents.FindByClass("info_player_deathmatch")) do
			newSpawn:SetPos(Vector(758, 93, 76))
		end
		
		ents.FindByName("trig_tele1")[1]:Remove()
		
		table.RemoveByValue(FRIENDLY_NPCS, "npc_dog")
		
		mapLua:SetKeyValue("Code", "hook.Run('EndCoopMap')")
		ents.FindByName("m_ag1")[1]:Fire("AddOutput", "OnAllSpawnedDead triggerhook:RunCode")
	
	end,
	
	["level06_synb2_base"] = function(mapLua)
		
		local booster = ents.Create("prop_dynamic")
		booster:SetModel("models/props_borealis/bluebarrel001.mdl")
		booster:SetPos(Vector(59, 99, -205))
		booster:PhysicsInit(SOLID_VPHYSICS)
		booster:Spawn()
		ents.FindByName("m_big1")[1]:Fire("AddOutput", "OnAllSpawnedDead sas15:Unlock()")
		
		mapLua:SetKeyValue("Code", "hook.Run('EndCoopMap')")
		ents.FindByName("countoto")[1]:Fire("AddOutput", "OnHitMax triggerhook:RunCode")
	
	end,
	
	["level07_synb2_scary_dark_house"] = function(mapLua)
		
		local npc_vortigaunt = {
			["npc_vortigaunt"] = {xpMin = 25, xpMax = 50},
		}
		
		table.Merge(RANDOM_XP_BASED_NPC, npc_vortigaunt)
		mapLua:SetKeyValue("Code", "hook.Run('EndCoopMap')")
		ents.FindByName("count")[1]:Fire("AddOutput", "OnHitMax triggerhook:RunCode")
	
	end,
	
	["level08_synb2_a_place_to_die"] = function(mapLua)
		
		local npc_vortigaunt = {
			["npc_vortigaunt"] = {xpMin = 25, xpMax = 50},
		}
		local npc_antlion = {
			["npc_antlion"] = {xpMin = 12, xpMax = 27},
		}
		
		table.Merge(RANDOM_XP_BASED_NPC, npc_vortigaunt)
		table.Merge(RANDOM_XP_BASED_NPC, npc_antlion)
		
		mapLua:SetKeyValue("Code", "hook.Run('EndCoopMap')")
		
		ents.FindByName("make_ag1")[1]:Fire("AddOutput", "OnAllSpawnedDead triggerhook:RunCode")
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
	
	["item_ammo_buckshot"] = "item_ammo_buckshot",
	["item_ammo_buckshot_large"] = "item_ammo_buckshot_large",
	
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

local function SetUpMisc()
	local MapLua = ents.Create("lua_run")
	MapLua:SetName("triggerhook")
	MapLua:Spawn()
	
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
	
	hook.Add("PlayerCanPickupItem", "HL2CR_COOP_ItemRespawn", function(ply, item)
	
		if not timer.Exists("respawn_" .. item:EntIndex()) then

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
		end
	end)

	hook.Add("PlayerCanPickupWeapon", "HL2CR_COOP_WeaponRespawn", function(ply, weapon)
		
		if not timer.Exists("respawn_" .. weapon:EntIndex()) then
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
		end
	end)
end

hook.Add("EndCoopMap", "HL2CR_EndCoop", function()
	for _, v in ipairs(player.GetAll()) do
		v:SetTeam(TEAM_COMPLETED_MAP)
		EnableSpectate(v)
		ShowMapResults(v)
	end
	
	net.Start("HL2CR_MapCountdown")
	net.Broadcast()
	
	StartMapCountdown()
	
end)

function StartCoop()
	SetCheckpoints()
	SetUpMisc()
end