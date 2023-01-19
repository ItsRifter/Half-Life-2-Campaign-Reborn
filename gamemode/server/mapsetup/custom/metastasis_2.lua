Custom_NextMap = "metastasis_3"
Custom_ExpMul = 1.25

Custom_triggers = {
	["checkpoints"] = {
		[1] = {
			[1] = Vector(692,-723,-205), 		
			[2] = Vector(938,-1171,-350)
		},
		[2] = {
			[1] = Vector(-2746,-562,476), 		
			[2] = Vector(-2988,-1338,300)
		},
		[3] = {
			[1] = Vector(-707,-230,-723), 		
			[2] = Vector(-608,-340,-533)
		}
	},
	
	["checkpoint_spot"] = {
		[1] = Vector(938,-838,-293),
		[2] = Vector(-2945,-1057,310),
		[3] = Vector(-674,-278,-520)
	},
	
	["checkpoint_angle"] = {
		[1] = Angle(0,160,0),
		[2] = Angle(0,50,0),
		[3] = Angle(0,180,0)
	},
	
	["checkpoint_functions"] = {
		[3] = function()
			MoveSpawns(Vector(0,0,-40),Angle(0,180,0),"deeperlift-lift")
		end,
	},
	
	["changelevels"] = {
		[1] = Vector(-2345,-870,-3584),
		[2] = Vector(-2431,-980,-3743)
	},
	
	["changelevel_func"] = 
	function()
		--MovePlayers(Vector(0,-310,-980),Angle(0,0,0), false)
	end
	
}

function Custom_Startup()
	MoveSpawns(Vector(-397,-1301,-100),Angle(0,270,0))
end

function Custom_Equipment()
	table.insert(SPAWNING_WEAPONS, "weapon_pistol")
	table.insert(SPAWNING_WEAPONS, "weapon_smg1")
	table.insert(SPAWNING_WEAPONS, "weapon_357")
	table.insert(SPAWNING_WEAPONS, "weapon_ar2")
	
	table.insert(SPAWNING_ITEMS, 
	{
		[1] = {
			["Type"] = "Pistol",
			["Amount"] = 45,
		},
		
		[2] = {
			["Type"] = "SMG1",
			["Amount"] = 60,
		},
		
		[3] = {
			["Type"] = "357",
			["Amount"] = 6,
		},
		
		[4] = {
			["Type"] = "Armor",
			["Amount"] = 25,
		}
	})
end
