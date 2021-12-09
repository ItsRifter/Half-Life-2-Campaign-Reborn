AddCSLuaFile()
--When creating an achievement, the following must in place
--List = Where does this be listed in?
--Achievement = The achievement, must be named accordingly E.G Test_Ach
	--Name = The name of the achievement
	--Mat = the icon
	--Desc = Description of the achievement
	-- Rewards = what to give to the player when they unlock it
		--XP = XP to give
		-- Item = Items to give the player, leave nil if no item is given
	--IsRare = is it a rare to obtain achievement?
	--Value = Initial value for progressive achievements
	--Update = Every time the value is met, send an update notification to the player E.G (every 5 values of progress = notify player)
	--Max = Maximum value for progress achievements, will be given when max is met

--EXAMPLE
--[[
	HL2 = {
		Breens_Benefactors = {
			Name = "Breens Benefactors",
			Mat = "vgui/achievements/hl2_get_crowbar.png",
			Desc = "Become loyal to Dr. Breen"
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
			Desc = "Escape the apartment\nblock raid",
			Rewards = {
				XP = 500,
				Item = nil
			},
			IsRare = false
		},
		
		Submissive = {
			Name = "Submissive",
			Mat = "vgui/achievements/hl2_put_canintrash.png", 
			Desc = "Put the can\nin the trash",
			Rewards = {
				XP = 500,
				Item = nil
			},
			IsRare = false
		},
		
		Defiant = {
			Name = "Defiant",
			Mat = "vgui/achievements/hl2_hit_cancop_withcan.png", 
			Desc = "Hit the trashcan\ncop with the can",
			Rewards = {
				XP = 500,
				Item = nil
			},
			IsRare = false
		},
		
		Barney_Wish = {
			Name = "Wish Granted", 
			Mat = "vgui/achievements/hl2_beat_game.png", 
			Desc = "Fulfil Barney's request",
			Rewards = {
				XP = 500,
				Item = nil
			},
			IsRare = false
		},
		
		Trusty_Hardware = {
			Name = "Trusty Hardware", 
			Mat = "vgui/achievements/hl2_get_crowbar.png", 
			Desc = "Acquire the crowbar",
			Rewards = {
				XP = 500,
				Item = nil
			},
			IsRare = false
		},
		
		Keep_Off_Sand = {
			Name = "Keep off the Sand", 
			Mat = "vgui/achievements/hl2_beat_donttouchsand.png", 
			Desc = "Cross the antlion beach\nwithout touching the sand",
			Rewards = {
				XP = 5000,
				Item = nil
			},
			IsRare = false
		},
		
		Warden_Freeman = {
			Name = "Warden Freeman", 
			Mat = "vgui/achievements/hl2_beat_turretstandoff2.png", 
			Desc = "Survive the second turret\nstandoff in Nova Prospekt",
			Rewards = {
				XP = 1500,
				Item = nil
			},
			IsRare = false
		},
		
		Follow_Freeman = {
			Name = "Follow Freeman", 
			Mat = "vgui/achievements/hl2_followfreeman.png", 
			Desc = "Gain command of a squad\nof rebels in the uprising",
			Rewards = {
				XP = 1500,
				Item = nil
			},
			IsRare = false
		},
		
		Cubbage = {
			Name = "Where Cubbage Fears to Tread", 
			Mat = "vgui/achievements/hl2_kill_odessagunship.png", 
			Desc = "Defend Little Odessa\nfrom the gunship attack",
			Rewards = {
				XP = 2500,
				Item = nil
			},
			IsRare = false
		},
		
		Radiation_Levels = {
			Name = "Radiation Levels Detected",
			Mat = "vgui/achievements/hl2_beat_toxictunnel.png", 
			Desc = "Get through thetoxic tunnel\nunder City 17 in Half-Life 2",
			Rewards = {
				XP = 1500,
				Item = nil
			},
			IsRare = false
		},
		
		Red_Letter_Baby = {
			Name = "Red Letter... Baby?",	
			Mat = "vgui/achievements/hl2_beat_game.png", 
			Desc = "Take the baby from the\nplayground to Dr.Kleiner's lab",
			Rewards = {
				XP = 2250,
				Item = nil
				--Replace with baby hat
			},
			IsRare = false
		},
		
		Zero_Point_Energy = {
			Name = "Zero Point Energy",
			Mat = "vgui/achievements/hl2_get_gravitygun.png", 
			Desc = "Acquire the Gravity Gun\nin Black Mesa East",
			Rewards = {
				XP = 1000,
				Item = nil
			},
			IsRare = false
		},
		
		Two_Points = {
			Name = "Two Points",
			Mat = "vgui/achievements/hl2_get_gravitygun.png", 
			Desc = "Use DOG's ball\nto make a basket",
			Rewards = {
				XP = 2500,
				Item = nil
			},
			IsRare = false
		},
		
		Hallowed_Ground = {
			Name = "Hallowed Ground",
			Mat = "vgui/achievements/hl2_beat_cemetery.png", 
			Desc = "Escort Gregori safely\nthrough the church cemetery",
			Rewards = {
				XP = 1250,
				Item = nil
			},
			IsRare = false
		},
		
		
		Barnacle_Bowling = {
			Name = "Barnacle Bowling",
			Mat = "vgui/achievements/hl2_kill_barnacleswithbarrel.png", 
			Desc = "Kill five barnacles\nwith one barrel",
			Rewards = {
				XP = 3500,
				Item = nil
			},
			IsRare = false
		},
		
		Raven_Ball = {
			Name = "Raven Ball",
			Mat = "vgui/achievements/hl2_get_gravitygun.png", 
			Desc = "Escort DOG's ball to\nthe end of Ravenholm's mine",
			Rewards = {
				XP = 12500,
				Item = nil
			},
			IsRare = false
		},
		
		Flushed = {
			Name = "Flushed",
			Mat = "vgui/achievements/hl2_kill_enemy_withtoilet.png", 
			Desc = "Kill an enemy\nwith a toilet",
			Rewards = {
				XP = 2500,
				Item = nil
			},
			IsRare = false
		},
		
		Hack_Attack = {
			Name = "Hack Attack!",
			Mat = "vgui/achievements/hlx_kill_enemies_withmanhack.png", 
			Desc = "Kill five enemies\nwith a Manhack",
			Rewards = {
				XP = 3500,
				Item = nil
			},
			IsRare = false
		},
		
		What_Cat = {
			Name = "What Cat?", 
			Mat = "vgui/achievements/hl2_beat_game.png", 
			Desc = "Break Dr.Kleiner's\nmini-teleporter",
			Rewards = {
				XP = 2500,
				Item = nil
			},
			IsRare = false
		},
		
		Blast_From_The_Past = {
			Name = "Blast from the past",
			Mat = "vgui/achievements/hl2_find_hevfaceplate.png", 
			Desc = "Find the old\nH.E.V suit charger",
			Rewards = {
				XP = 1750,
				Item = nil
			},
			IsRare = false
		},
		
		Beat_HL2 = {
			Name = "Singularity Collapse",
			Mat = "vgui/achievements/hl2_beat_game.png", 
			Desc = "Destroy the Citadel's\nreactor core",
			Rewards = {
				XP = 5000,
				Item = nil
			},
			IsRare = false
		},
		
		Giant_Killer = {
			Name = "Giant Killer",
			Mat = "vgui/achievements/hl2_beat_c1713striderstandoff.png", 
			Desc = "Survive the rooftop\nstrider battle in\nthe ruins of City 17",
			Rewards = {
				XP = 2500,
				Item = nil
			},
			IsRare = false
		},
		
		Lambda_Locator = {
			Name = "Lambda Locator",
			Mat = "vgui/achievements/hl2_find_alllambdas.png", 
			Desc = "Find all Lambda Caches",
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
			Name = "Watch your head!",
			Mat = "vgui/achievements/ep1_beat_mainelevator.png", 
			Desc = "Make it to the bottom\nof the Citadel's\nmain elevator shaft in one piece",
			Rewards = {
				XP = 1000,
				Item = nil
			},
			IsRare = false
		},
		
		Containment = {
			Name = "Containment",
			Mat = "vgui/achievements/ep1_beat_citadelcore.png", 
			Desc = "Contain the Citadel core",
			Rewards = {
				XP = 1000,
				Item = nil
			},
			IsRare = false
		},
		
		Pacifist_Stalkers = {
			Name = "Pacifist",
			Mat = "vgui/achievements/ep1_beat_citadelcore_nostalkerkills.png", 
			Desc = "Contain the Citadel core\nwithout killing any stalkers",
			Rewards = {
				XP = 4500,
				Item = nil
			},
			IsRare = false
		},
	},
	
	Misc = {
		New_Arrival = {
			Name = "New Arrival",
			Mat = "materials/hl2cr/ach_arrival.jpg", 
			Desc = "Play the gamemode\nfor the first time",
			Rewards = {
				XP = 0,
				Item = nil
			},
			IsRare = false
		},
		
		Leiftiger = {
			Name = "The return of the Leiftiger",
			Mat = "materials/hl2cr/ach_leif.jpg", 
			Desc = "Met the original creator\nof HL2-C",
			Rewards = {
				XP = 0,
				Item = nil
			},
			IsRare = true
		},
		
		Unpleasant_Secret = {
			Name = "Unpleasant Secret",
			Mat = "materials/hl2cr/ach_gimmeasecret.jpg", 
			Desc = "Plot twist:\nYou get nothing!",
			Rewards = {
				XP = 0,
				Item = nil
			},
			IsRare = false
		},
		
		Sven_Coop = {
			Name = "Classic Co-Op",
			Mat = "materials/hl2cr/ach_svensecret.jpg", 
			Desc = "Discover the classic medical voiceline",
			Rewards = {
				XP = 500,
				Item = nil
			},
			IsRare = false
		},
		
		Craft_1 = {
			Name = "Crafted it yourself!",
			Mat = "vgui/achievements/hl2_get_gravitygun.png", 
			Desc = "Craft an item for\nthe first time",
			Rewards = {
				XP = 2500,
				Item = nil
			},
			IsRare = false
		},
	},
	
	Custom = {
		The_Beginning = {
			Name = "The Beginning", 
			Mat = "materials/hl2cr/ach_nightmare.jpg", 
			Desc = "Escape the nightmare...\nor did you?",
			Rewards = {
				XP = 500,
				Item = nil
			},
			IsRare = false
		},
		
		The_End = {
			Name = "A bad nightmare",
			Mat = "materials/hl2cr/ach_losehope.jpg",
			Desc = "Escape the hospital\nand the nightmare",
			Rewards = {
				XP = 2000,
				Item = nil
			},
			IsRare = false
		},
		
		Carts_Journey = {
			Name = "A Carts Journey", 
			Mat = "vgui/achievements/ep2_kill_enemies_withcar.png", 
			Desc = "Successfully ride the cart\nwithout dying",
			Rewards = {
				XP = 1500,
				Item = nil
			},
			IsRare = false
		},
		
		Science_Squared = {
			Name = "Science²",
			Mat = "vgui/achievements/hl2_beat_game.png", 
			Desc = "Complete Research and Development",
			Rewards = {
				XP = 5000,
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