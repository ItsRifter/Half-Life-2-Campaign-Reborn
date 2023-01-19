Custom_NextMap = "metastasis_2"
Custom_ExpMul = 1.25

Custom_triggers = {
	["checkpoints"] = {
		[1] = {
			[1] = Vector(-1308,1921,139), 		
			[2] = Vector(-487,2712,-39)
		},
		[2] = {
			[1] = Vector(-387,214,-275), 		
			[2] = Vector(-276,-72,-398)
		},
		[3] = {
			[1] = Vector(540,-1256,-235), 		
			[2] = Vector(331,-1378,-362)
		},
		[4] = {
			[1] = Vector(109,172,-573), 		
			[2] = Vector(-48,-85,-672)
		}
	},
	
	["checkpoint_spot"] = {
		[1] = Vector(-1059,2347,-31),
		[2] = Vector(-204,92,-331),
		[3] = Vector(459,-1320,-332),
		[4] = Vector(8,181,-666)
	},
	
	["checkpoint_angle"] = {
		[1] = Angle(0,310,0),
		[2] = Angle(0,300,0),
		[3] = Angle(0,90,0),
		[4] = Angle(0,270,0)
	},
	
	["changelevels"] = {
		[1] = Vector(63,-251,-995),
		[2] = Vector(-74,-392,-1160)
	},
	
	["changelevel_func"] = 
	function()
		MovePlayers(Vector(0,-310,-980),Angle(0,0,0), false)
	end
	
}

function Custom_Startup()

end

function Custom_Equipment()
	table.insert(SPAWNING_WEAPONS, "weapon_pistol")
	table.insert(SPAWNING_WEAPONS, "weapon_smg1")
	
	table.insert(SPAWNING_ITEMS, 
	{
		[1] = {
			["Type"] = "Pistol",
			["Amount"] = 36,
		},
		
		[2] = {
			["Type"] = "SMG1",
			["Amount"] = 45,
		},
		
		[3] = {
			["Type"] = "Armor",
			["Amount"] = 25,
		}
	})
end
