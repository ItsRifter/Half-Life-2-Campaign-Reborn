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
			Vector(-1096, 1606, 78), 		Vector(-903, 1684, -2)
		}
			
		CHECKPOINT_POS = {
			Vector(-1008, 1758, 4)
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
			Vector(1115, 8892, -2544),		Vector(-764, 9427, -2694)
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

local function SetUpMisc()
	local MapLua = ents.Create("lua_run")
	MapLua:SetName("triggerhook")
	MapLua:Spawn()
	
	if game.GetMap() == "ep1_citadel_00" then
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
	
	if game.GetMap() == "ep1_c17_05" then
		game.SetGlobalState("citizens_passive", 0)
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

function FailedMap()
	BroadcastSound("music/hl2_song23_suitsong3.mp3")
	timer.Simple(10, function()
		RunConsoleCommand("ChangeLevel", game.GetMap())
	end)
end

hook.Add( "AcceptInput", "HL2CR_EP1_ReachedEnd", function( ent, name, activator, caller, data )
    print(caller)
	if ent:GetName() == "trigger_citizen_boardtrain" then
		print("works")
		if caller:IsNPC() then
			caller.ReachedEnd = true
		end
	end
end )

hook.Add("Tick", "HL2CR_CitizenFollow05", function()
	if game.GetMap() == "ep1_c17_05" then
		for _, cit in ipairs(ents.FindByClass("npc_citizen")) do
			if cit:GetPos():Distance(player.GetAll()[1]:GetPos()) > 50 and not cit.ReachedEnd and not cit:IsCurrentSchedule(SCHED_FORCED_GO_RUN) then
				cit:SetLastPosition( player.GetAll()[1]:GetPos() )
				cit:SetSchedule(SCHED_FORCED_GO_RUN)
			end
		end
	end
end)

hook.Add("OnNPCKilled", "HL2CR_PacifistAch", function(npc, attacker, inflictor)
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