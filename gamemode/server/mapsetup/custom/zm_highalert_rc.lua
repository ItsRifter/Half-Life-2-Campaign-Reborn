--All custom maps can take this format, the lua is only loaded if said map is currently playing
Custom_NextMap = Lobby_map
Custom_ExpMul = 2 --multiplies the EXP needed when on map so 2 will need players to do 2x the damage

Custom_triggers = {
	["checkpoints"] = {
		[1] = {
			[1] = Vector(172,-110,213), 		
			[2] = Vector(378,238,103)
		},
		[2] = {
			[1] = Vector(1954,-877,143), 		
			[2] = Vector(2340,-1184,-33)
		},
		[3] = {
			[1] = Vector(930,-3564,0), 		
			[2] = Vector(1182,-3741,0)
		},
		[4] = {
			[1] = Vector(1704,-3752,1280), 		
			[2] = Vector(1560,-3544,1344)
		}
	},
	
	["checkpoint_spot"] = {
		[1] = Vector(296,50,128),
		[2] = Vector(2119,-696,-4),
		[3] = Vector(954,-3704,0),
		[4] = Vector(1570,-3734,1280)
	},
	
	["checkpoint_angle"] = {
		[1] = Angle(0,100,0),
		[2] = Angle(0,-80,0),
		[3] = Angle(0,0,0),
		[4] = Angle(0,015,0)
	},
	
	["checkpoint_functions"] = {
		[4] = function()	
			timer.Simple(5, function()
				Custom_EndEvent()
			end)
		end,
	},
	
	["changelevels"] = {
		[1] = Vector(-6480, 3620, -1420),
		[2] = Vector(-6020, 3690, -1220)
	},
	
	["pushers"] = {
		[1] = {
			[1] = Vector(20, -2560, -190),
			[2] = Vector(1350, -1920, -60)
		}
	},

	["pusher_spot"] = {
		[1] = Vector(510, -1445, -10)
	}
}

function Custom_Startup()
	print("Hey look high alert was loaded wow much ZM, dont spam traps")

	ents.FindByName("End_Tele_Btn")[1]:Fire("AddOutput", "OnPressed hl2crlua:RunPassedCode:Custom_Ambush():0:1")
	ents.FindByName("heli_path_17")[1]:Fire("AddOutput", "OnPass hl2crlua:RunPassedCode:Custom_LevelEnd():3:1")
	
	timer.Remove( "custom_endevent" )
	
	CreateAmmoCrate(Vector(981,-4285,1424),Angle(0,0,0),0)
end

function Custom_Equipment()
	table.insert(SPAWNING_WEAPONS, "weapon_crowbar")
end

function Custom_Ambush()
	CreateEnemy("npc_metropolice",Vector(976,-3610,128),Angle(0,-80,0),"weapon_smg1", true)
	CreateEnemy("npc_metropolice",Vector(1149,-3587,128),Angle(0,-110,0),"weapon_smg1", true)
	CreateEnemy("npc_metropolice",Vector(1311,-4313,-32),Angle(0,170,0),"weapon_smg1", true)
end

local end_spawns = {
	[1] = {
		[1] = Vector(1834,-3575,1278),
		[2] = Angle(0,-82,0),
		[3] = "npc_zombie"
	},
	[2] = {
		[1] = Vector(1029,-3827,1276),
		[2] = Angle(0,65,0),
		[3] = "npc_zombie"
	},
	[3] = {
		[1] = Vector(1479,-3712,1152),
		[2] = Angle(0,-143,0),
		[3] = "npc_zombie"
	}
}

function Custom_EndEvent()
	timer.Create( "custom_endevent", 2, 50, function()
	local rng = math.random( 1, 3 )
		CreateEnemy(end_spawns[rng][3],end_spawns[rng][1],end_spawns[rng][2], nil, true)
	end	 )
end

function Custom_LevelEnd()
	timer.Remove( "custom_endevent" )
	CreateLevelChange(Vector(1478,-4488,1557),Vector(995,-4566,1385),nil)	
end