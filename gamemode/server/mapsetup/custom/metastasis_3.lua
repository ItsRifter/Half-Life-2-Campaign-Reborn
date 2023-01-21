Custom_NextMap = "metastasis_4a"
Custom_ExpMul = 1.25

Custom_triggers = {
	["checkpoints"] = {
		[1] = {
			[1] = Vector(4660,-92,7552), 		
			[2] = Vector(4732,61,7444)
		},
		[2] = {
			[1] = Vector(6210,-901,1366), 		
			[2] = Vector(6082,-761,1245)
		},
		[3] = {
			[1] = Vector(990,523,506), 		
			[2] = Vector(266,385,246)
		},
		[3] = {
			[1] = Vector(-332,-212,899), 		
			[2] = Vector(-268,176,768)
		}
	},
	
	["checkpoint_spot"] = {
		[1] = Vector(4675,-3,7483),
		[2] = Vector(6145,-874,1298),
		[3] = Vector(920,32,200),
		[4] = Vector(63,41,768)
	},
	
	["checkpoint_angle"] = {
		[1] = Angle(0,160,0),
		[2] = Angle(0,90,0),
		[3] = Angle(0,270,0),
		[4] = Angle(0,180,0),
	},
	
	["checkpoint_functions"] = {
		[1] = function()
			timer.Simple(8, function()
				SPAWNING_WEAPONS = {}
				SPAWNING_ITEMS= 
				{
					[1] = {
						["Type"] = "Armor",
						["Amount"] = 25,
					}
				}
				for k, p in ipairs(player.GetAll()) do
					if p:Team() == TEAM_AFK or p:Team() == TEAM_COMPLETED_MAP then continue end
						p:StripWeapons()
						p:GiveEquipment()
				end
			end)
		end,
		[4] = function()	
			CreateCustomTrigger(Vector(6210,-985,1303),Vector(6078,-1103,1462), function(ent)
				if ent:IsPlayer() and ent:Team() == TEAM_ALIVE then
					MoveSpawns(Vector(0,0,-40),Angle(0,90,0),"shaft-lift")
					MovePlayers(Vector(6138,-1071,1345),Angle(0,90,0), false, ent)
					return true	
				end
				return false
			end,0,true)
		end
	},
	
	["changelevels"] = {
		[1] = Vector(-5111,-5150,-2095),
		[2] = Vector(-4956,-5278,-2239)
	},
	
	["changelevel_func"] = 
	function()
		MovePlayers(Vector(-5041,-5217,-2208),Angle(0,0,0), false)
	end
	
}

function Custom_Startup()
	--MoveSpawns(Vector(-397,-1301,-100),Angle(0,270,0))
	
	CreateCustomTrigger(Vector(6206,-976,7453),Vector(6048,-1079,7289), function(ent)
		if ent:IsPlayer() and ent:Team() == TEAM_ALIVE then
			MoveSpawns(Vector(0,0,-40),Angle(0,270,0),"shaft-lift")
			return true	
		end
		return false
	end,0,true)
	
	CreateCustomTrigger(Vector(-741,-259,527),Vector(-622,-38,352), function(ent)
		if ent:IsPlayer() and ent:Team() == TEAM_ALIVE then
			MoveSpawns(Vector(-516,-133,408),Angle(0,180,0))
			MovePlayers(Vector(-516,-133,408),Angle(0,180,0), false, ent)
			return true	
		end
		return false
	end,0,true)
end

function Custom_Equipment()
	table.insert(SPAWNING_WEAPONS, "weapon_pistol")
	table.insert(SPAWNING_WEAPONS, "weapon_smg1")
	table.insert(SPAWNING_WEAPONS, "weapon_357")
	table.insert(SPAWNING_WEAPONS, "weapon_ar2")
	table.insert(SPAWNING_WEAPONS, "weapon_shotgun")
	
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
		},
		
		[5] = {
			["Type"] = "buckshot",
			["Amount"] = 6,
		}
	})
end
