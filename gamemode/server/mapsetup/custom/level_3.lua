Custom_NextMap = "level_4a"
Custom_ExpMul = 1

Custom_triggers = {
	["checkpoints"] = {
		[1] = {
			[1] = Vector(-6535, -2448, 0), 		
			[2] = Vector(-6640, -2561, -128)
		},
		[2] = {
			[1] = Vector(-5563, -2374, 524), 		
			[2] = Vector(-5187, -2617, 654)
		},
		[3] = {
			[1] = Vector(-5586, -3165, 772), 		
			[2] = Vector(-5712, -3032, 888)
		},
		[4] = {
			[1] = Vector(8703, 5888, -161), 		
			[2] = Vector(9210, 6651, 1)
		}
	},

	["checkpoint_spot"] = {
		[1] = Vector(-6574, -2495, -128), 	
		[2] = Vector(-5342, -2481, 534),
		[3] = Vector(-5632, -3055, 775),
		[4] = Vector(9000, 6200, -80)
	},

	["checkpoint_angle"] = {
		[1] = Angle(0,0,0),
		[2] = Angle(0,90,0),
		[3] = Angle(0,-90,0),
		[4] = Angle(0,90,0)
	},

	["checkpoint_functions"] = {
		[4] = function()
		CreateLevelChange(Vector(12094, 6856, -191),Vector(11969, 6859, -94),nil)
		end
	}
}
function Custom_Startup()
	for k, v in ipairs(ents.FindByClass("trigger_changelevel")) do
		v:Remove()
	end
	ents.FindByName("fusebox_fix_rl")[1]:Fire("AddOutput", "OnTrigger roller_exit_doors:Open")
	ents.FindByName("gunship_path_4")[1]:Remove()
	ents.FindByName("gunship_health_case")[1]:Fire("AddOutput", "OnCase04 hl2crlua:RunPassedCode:Custom_Ambush():10:1")
	RemoveShopWeapons()
end

function Custom_Ambush()
	MovePlayers(Vector(9000, 6200, -80),Angle(0,90,0), true)
end

function Custom_Equipment()
	table.insert(SPAWNING_WEAPONS, "weapon_physcannon")
end