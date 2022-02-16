AddCSLuaFile()
--When creating an achievement, the following must in place
--List = Where does this be listed in?
--Achievement = The achievement, must be named accordingly E.G Test_Ach
	--Name = The name of the achievement, doesn't need to be defined in language files
	--Mat = the icon
	--Desc = Description, should be defined in the language file
	-- Rewards = what to give to the player when they unlock it
		--XP = XP to give
		-- Item = Items to give the player, leave nil if no item is given
	--IsRare = is it rare to obtain this achievement?
	--Value = Initial value for progressive achievements
	--Update = Every time the value is met, send an update notification to the player E.G (every 5 values of progress = notify player)
	--Max = Maximum value for progress achievements, will be given when max is met

--EXAMPLE
--[[
	HL2 = {
		Breens_Benefactors = {
			Name = "Breens Benefactors",
			Mat = "vgui/achievements/hl2_get_crowbar.png",
			Desc = "Breens_Benefactors_Desc"
			Rewards = {
				XP = 1,
				Item = nil
			}
			IsRare = true,
		}
	}
--]]

GM.Achievements = {

	HL2 = {
		Malcontent = {
			Name = "Malcontent",
			Mat = "vgui/achievements/hl2_escape_apartmentraid.png", 
			Desc = "Malcontent_Desc",
			Rewards = {
				XP = 500,
				Item = nil
			},
			IsRare = false
		},
		
		Submissive = {
			Name = "Submissive",
			Mat = "vgui/achievements/hl2_put_canintrash.png", 
			Desc = "Submissive_Desc",
			Rewards = {
				XP = 500,
				Item = nil
			},
			IsRare = false
		},
		
		Defiant = {
			Name = "Defiant",
			Mat = "vgui/achievements/hl2_hit_cancop_withcan.png", 
			Desc = "Defiant_Desc",
			Rewards = {
				XP = 500,
				Item = nil
			},
			IsRare = false
		},
		
		Barney_Wish = {
			Name = "Barney_Wish", 
			Mat = "vgui/achievements/hl2_beat_game.png", 
			Desc = "Barney_Wish_Desc",
			Rewards = {
				XP = 500,
				Item = nil
			},
			IsRare = false
		},
		
		Trusty_Hardware = {
			Name = "Trusty_Hardware", 
			Mat = "vgui/achievements/hl2_get_crowbar.png", 
			Desc = "Trusty_Hardware_Desc",
			Rewards = {
				XP = 500,
				Item = nil
			},
			IsRare = false
		},
		
		Keep_Off_Sand = {
			Name = "Keep_Off_Sand", 
			Mat = "vgui/achievements/hl2_beat_donttouchsand.png", 
			Desc = "Keep_Off_Sand_Desc",
			Rewards = {
				XP = 5000,
				Item = nil
			},
			IsRare = false
		},
		
		Warden_Freeman = {
			Name = "Warden_Freeman", 
			Mat = "vgui/achievements/hl2_beat_turretstandoff2.png", 
			Desc = "Warden_Freeman_Desc",
			Rewards = {
				XP = 1500,
				Item = nil
			},
			IsRare = false
		},
		
		Follow_Freeman = {
			Name = "Follow_Freeman", 
			Mat = "vgui/achievements/hl2_followfreeman.png", 
			Desc = "Follow_Freeman_Desc",
			Rewards = {
				XP = 1500,
				Item = nil
			},
			IsRare = false
		},
		
		Cubbage = {
			Name = "Cubbage", 
			Mat = "vgui/achievements/hl2_kill_odessagunship.png", 
			Desc = "Cubbage_Desc",
			Rewards = {
				XP = 2500,
				Item = nil
			},
			IsRare = false
		},
		
		Radiation_Levels = {
			Name = "Radiation_Levels",
			Mat = "vgui/achievements/hl2_beat_toxictunnel.png", 
			Desc = "Radiation_Levels_Desc",
			Rewards = {
				XP = 1500,
				Item = nil
			},
			IsRare = false
		},
		
		Red_Letter_Baby = {
			Name = "Red_Letter_Baby",	
			Mat = "vgui/achievements/hl2_beat_game.png", 
			Desc = "Red_Letter_Baby_Desc",
			Rewards = {
				XP = 2250,
				Item = nil
				--Replace with baby hat
			},
			IsRare = false
		},
		
		Zero_Point_Energy = {
			Name = "Zero_Point_Energy",
			Mat = "vgui/achievements/hl2_get_gravitygun.png", 
			Desc = "Zero_Point_Energy_Desc",
			Rewards = {
				XP = 1000,
				Item = nil
			},
			IsRare = false
		},
		
		Two_Points = {
			Name = "Two_Points",
			Mat = "vgui/achievements/hl2_get_gravitygun.png", 
			Desc = "Two_Points_Desc",
			Rewards = {
				XP = 2500,
				Item = nil
			},
			IsRare = false
		},
		
		Hallowed_Ground = {
			Name = "Hallowed_Ground",
			Mat = "vgui/achievements/hl2_beat_cemetery.png", 
			Desc = "Hallowed_Ground_Desc",
			Rewards = {
				XP = 1250,
				Item = nil
			},
			IsRare = false
		},
		
		
		Barnacle_Bowling = {
			Name = "Barnacle_Bowling",
			Mat = "vgui/achievements/hl2_kill_barnacleswithbarrel.png", 
			Desc = "Barnacle_Bowling_Desc",
			Rewards = {
				XP = 3500,
				Item = nil
			},
			IsRare = false
		},
		
		Raven_Ball = {
			Name = "Raven_Ball",
			Mat = "vgui/achievements/hl2_get_gravitygun.png", 
			Desc = "Raven_Ball_Desc",
			Rewards = {
				XP = 12500,
				Item = nil
			},
			IsRare = false
		},
		
		Flushed = {
			Name = "Flushed",
			Mat = "vgui/achievements/hl2_kill_enemy_withtoilet.png", 
			Desc = "Flushed_Desc",
			Rewards = {
				XP = 2500,
				Item = nil
			},
			IsRare = false
		},
		
		Hack_Attack = {
			Name = "Hack_Attack",
			Mat = "vgui/achievements/hlx_kill_enemies_withmanhack.png", 
			Desc = "Hack_Attack_Desc",
			Rewards = {
				XP = 3500,
				Item = nil
			},
			IsRare = false
		},
		
		What_Cat = {
			Name = "What_Cat", 
			Mat = "vgui/achievements/hl2_beat_game.png", 
			Desc = "What_Cat_Desc",
			Rewards = {
				XP = 2500,
				Item = nil
			},
			IsRare = false
		},
		
		Blast_From_The_Past = {
			Name = "Blast_From_The_Past",
			Mat = "vgui/achievements/hl2_find_hevfaceplate.png", 
			Desc = "Blast_From_The_Past_Desc",
			Rewards = {
				XP = 1750,
				Item = nil
			},
			IsRare = false
		},
		
		Beat_HL2 = {
			Name = "Beat_HL2",
			Mat = "vgui/achievements/hl2_beat_game.png", 
			Desc = "Beat_HL2_Desc",
			Rewards = {
				XP = 5000,
				Item = nil
			},
			IsRare = false
		},
		
		Giant_Killer = {
			Name = "Giant_Killer",
			Mat = "vgui/achievements/hl2_beat_c1713striderstandoff.png", 
			Desc = "Giant_Killer_Desc",
			Rewards = {
				XP = 2500,
				Item = nil
			},
			IsRare = false
		},
		
		Lambda_Locator = {
			Name = "Lambda_Locator",
			Mat = "vgui/achievements/hl2_find_alllambdas.png", 
			Desc = "Lambda_Locator_Desc",
			Rewards = {
				XP = 17500,
				Item = nil
			},
			IsRare = false,
			Value = 0,
			Update = 1,
			Max = 45,
			Maps = {}
		},
	},
	
	EP1 = {
		Citadel_Lift = {
			Name = "Citadel_Lift!",
			Mat = "vgui/achievements/ep1_beat_mainelevator.png", 
			Desc = "Citadel_Lift_Desc",
			Rewards = {
				XP = 1000,
				Item = nil
			},
			IsRare = false
		},
		
		Containment = {
			Name = "Containment",
			Mat = "vgui/achievements/ep1_beat_citadelcore.png", 
			Desc = "Containment_Desc",
			Rewards = {
				XP = 1000,
				Item = nil
			},
			IsRare = false
		},
		
		Pacifist_Stalkers = {
			Name = "Pacifist_Stalkers",
			Mat = "vgui/achievements/ep1_beat_citadelcore_nostalkerkills.png", 
			Desc = "Pacifist_Stalkers_Desc",
			Rewards = {
				XP = 4500,
				Item = nil
			},
			IsRare = false
		},
		
		Attica = {
			Name = "Attica",
			Mat = "vgui/achievements/ep1_beat_hospitalatticgunship.png", 
			Desc = "Attica_Desc",
			Rewards = {
				XP = 3000,
				Item = nil
			},
			IsRare = false
		},
	},
	
	EP2 = {
		Acid_Reflex = {
			Name = "Acid_Reflex",
			Mat = "vgui/achievements/ep2_kill_poisonantlion.png", 
			Desc = "Acid_Reflex_Desc",
			Rewards = {
				XP = 1000,
				Item = nil
			},
			IsRare = false
		},
		
		IntoBreach = {
			Name = "IntoBreach",
			Mat = "vgui/achievements/ep2_beat_antlioninvasion.png", 
			Desc = "IntoBreach_Desc",
			Rewards = {
				XP = 1000,
				Item = nil
			},
			IsRare = false
		},
		
		Twofer = {
			Name = "Twofer",
			Mat = "vgui/achievements/ep2_beat_antlionguards.png", 
			Desc = "Twofer_Desc",
			Rewards = {
				XP = 2000,
				Item = nil
			},
			IsRare = false
		},
		
		HunterAmbush = {
			Name = "HunterAmbush",
			Mat = "vgui/achievements/ep2_beat_hunterambush.png", 
			Desc = "HunterAmbush_Desc",
			Rewards = {
				XP = 2500,
				Item = nil
			},
			IsRare = false
		},
	},
	
	Misc = {
		New_Arrival = {
			Name = "New_Arrival",
			Mat = "materials/hl2cr/ach_arrival.jpg", 
			Desc = "New_Arrival_Desc",
			Rewards = {
				XP = 0,
				Item = nil
			},
			IsRare = false
		},
		
		Leiftiger = {
			Name = "Leiftiger",
			Mat = "materials/hl2cr/ach_leif.jpg", 
			Desc = "Leiftiger_Desc",
			Rewards = {
				XP = 0,
				Item = nil
			},
			IsRare = true
		},
		
		Unpleasant_Secret = {
			Name = "Unpleasant_Secret",
			Mat = "materials/hl2cr/ach_gimmeasecret.jpg", 
			Desc = "Unpleasant_Secret_Desc",
			Rewards = {
				XP = 0,
				Item = nil
			},
			IsRare = false
		},
		
		Sven_Coop = {
			Name = "Sven_Coop",
			Mat = "materials/hl2cr/ach_svensecret.jpg", 
			Desc = "Sven_Coop_Desc",
			Rewards = {
				XP = 500,
				Item = nil
			},
			IsRare = false
		},
		
		Pet_Zombie_Max = {
			Name = "Pet_Zombie_Max",
			Mat = "vgui/achievements/hl2_beat_cemetery.png", 
			Desc = "Pet_Zombie_Max_Desc",
			Rewards = {
				XP = 5000,
				Item = nil
			},
			IsRare = false
		},
		
		Craft_1 = {
			Name = "Craft_1!",
			Mat = "vgui/achievements/hl2_get_gravitygun.png", 
			Desc = "Craft_1_Desc",
			Rewards = {
				XP = 2500,
				Item = nil
			},
			IsRare = false
		},
	},
	
	Custom = {
		The_Beginning = {
			Name = "The_Beginning", 
			Mat = "materials/hl2cr/ach_nightmare.jpg", 
			Desc = "The_Beginning_Desc",
			Rewards = {
				XP = 500,
				Item = nil
			},
			IsRare = false
		},
		
		The_End = {
			Name = "The_End",
			Mat = "materials/hl2cr/ach_losehope.jpg",
			Desc = "The_End_Desc",
			Rewards = {
				XP = 2000,
				Item = nil
			},
			IsRare = false
		},
		
		Carts_Journey = {
			Name = "Carts_Journey", 
			Mat = "vgui/achievements/ep2_kill_enemies_withcar.png", 
			Desc = "Carts_Journey_Desc",
			Rewards = {
				XP = 1500,
				Item = nil
			},
			IsRare = false
		},
		
		Science_Squared = {
			Name = "Science_Squared",
			Mat = "vgui/achievements/hl2_beat_game.png", 
			Desc = "Science_Squared_Desc",
			Rewards = {
				XP = 5000,
				Item = nil
			},
			IsRare = false
		},
		
		MI_Wheelchair = {
			Name = "MI_Wheelchair",
			Mat = "vgui/achievements/hl2_beat_game.png", 
			Desc = "MI_Wheelchair_Desc",
			Rewards = {
				XP = 2500,
				Item = nil
			},
			IsRare = false
		},
	},
	
	Killer = {
		Zombie_Killer_1 = {
			Name = "Zombie Killer I", 
			Mat = "vgui/achievements/hl2_beat_cemetery.png", 
			Desc = "Kill 100 Zombies",
			Rewards = {
				XP = 3500,
				Item = nil
			},
			IsRare = false,
			Value = 0,
			Update = 25,
			Max = 100
		},
		
		Zombie_Killer_2 = {
			Name = "Zombie Killer II", 
			Mat = "vgui/achievements/hl2_beat_cemetery.png", 
			Desc = "Kill 250 Zombies",
			Rewards = {
				XP = 11500,
				Item = nil
			},
			IsRare = false,
			Value = 0,
			Update = 50,
			Max = 250
		},
		
		Zombie_Killer_3 = {
			Name = "Zombie Killer III", 
			Mat = "vgui/achievements/hl2_beat_cemetery.png", 
			Desc = "Kill 1000 Zombies",
			Rewards = {
				XP = 25000,
				Item = nil
			},
			IsRare = false,
			Value = 0,
			Update = 100,
			Max = 1000
		},
		
		Combine_Killer_1 = {
			Name = "Combine Killer I", 
			Mat = "vgui/achievements/hl2_beat_cemetery.png", 
			Desc = "Kill 100 Combine soldiers",
			Rewards = {
				XP = 3500,
				Item = nil
			},
			IsRare = false,
			Value = 0,
			Update = 25,
			Max = 100
		},
		
		Combine_Killer_2 = {
			Name = "Combine Killer II", 
			Mat = "vgui/achievements/hl2_beat_cemetery.png", 
			Desc = "Kill 250 Combine soldiers",
			Rewards = {
				XP = 11500,
				Item = nil
			},
			IsRare = false,
			Value = 0,
			Update = 50,
			Max = 250
		},
		
		Combine_Killer_3 = {
			Name = "Combine Killer III", 
			Mat = "vgui/achievements/hl2_beat_cemetery.png", 
			Desc = "Kill 1000 Combine soldiers",
			Rewards = {
				XP = 25000,
				Item = nil
			},
			IsRare = false,
			Value = 0,
			Update = 100,
			Max = 1000
		},
	}
}