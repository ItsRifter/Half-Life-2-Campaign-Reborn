Custom_NextMap = Lobby_map
Custom_ExpMul = 1.25

Custom_triggers = {
	["checkpoints"] = {
		[1] = {
			[1] = Vector(905,829,333), 		
			[2] = Vector(1054,1135,256)
		}
	},
	
	["checkpoint_spot"] = {
		[1] = Vector(988,870,273)
	},
	
	["checkpoint_angle"] = {
		[1] = Angle(0,0,0)
	}
	
	
}

function Custom_Startup()
	MoveSpawns(Vector(0,0,40),Angle(0,90,0),"deeplift-lift")
	
	CreateCustomTrigger(Vector(-1363,2199,-7129),Vector(-1024,2586,-7384), function(ent)
		if ent:IsPlayer() then
			for _, v in ipairs(player.GetAll()) do
				v:SetTeam(TEAM_COMPLETED_MAP)
				v:DisplayResults()
			end
			
			BroadcastMessageToAll(HL2CR_LevelupColour, translate.Get("Campaign_Finished_Metastasis"))
			StartFinalMapCountdown()
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
