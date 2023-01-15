Custom_NextMap = "level_1b"
Custom_ExpMul = 1

Custom_triggers = {
	["checkpoints"] = {
		[1] = {
			[1] = Vector(-253, -2045, 3), 		
			[2] = Vector(-97, -1941, 107)
		},
		[2] = {
			[1] = Vector(0, -1006, 256), 		
			[2] = Vector(-63, -913, 137)
		},
		[3] = {
			[1] = Vector(535, 1113, -62), 		
			[2] = Vector(694, 1527, 114)
		},
		[4] = {
			[1] = Vector(1161, 1528, 258), 		
			[2] = Vector(1221, 1326, 275)
		},
	},
	
	["checkpoint_spot"] = {
		[1] = Vector(-189, -1991, 64), 		
		[2] = Vector(-40, -944, 140),
		[3] = Vector(595, 1338, -60),
		[4] = Vector(1195, 1334, 260)
	},

	["checkpoint_angle"] = {
		[1] = Angle(0,90,0),
		[2] = Angle(0,55,0),
		[3] = Angle(0,-60,0),
		[4] = Angle(0,90,0)
	},
	
	["checkpoint_functions"] = {
		[2] = function()
			game.SetGlobalState("antlion_allied", 1)
		end,
		[4] = function()
			ents.FindByName("FieldLaser")[1]:Remove()
			timer.Simple(8, function()
				ents.FindByName("Brenda")[1]:SetPos(Vector(1401, 1023, -42))
			end)
			CreateLevelChange(Vector(1793, 1090, 143),Vector(1862, 1009, 326),nil)
		end
	},

	["pushers"] = {
		[1] = {
			[1] = Vector(-248, -2042, 139),
			[2] = Vector(-113, -1931, 263)
		},
		[4] = {
			[1] = Vector(1506, 1805, 200),
			[2] = Vector(-113, 1795, 0)
		}
	},

	["pusher_spot"] = {
		[1] = Vector(-110, -1982, 24),
		[4] = Vector(1400, 1686, 24)
	},
}

function Custom_Startup()
	for k, v in ipairs(ents.FindByClass("trigger_changelevel")) do
		v:Remove()
	end
	RemoveShopWeapons()
end