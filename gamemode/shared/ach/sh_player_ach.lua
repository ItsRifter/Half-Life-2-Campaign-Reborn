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
			Desc = "Use DOG's ball to make a basket",
			Rewards = {
				XP = 5000,
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
			Desc = "Kill five barnacles with one barrel",
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
		
		What_Cat = {
			Name = "What Cat?", 
			Mat = "vgui/achievements/hl2_beat_game.png", 
			Desc = "Break Dr.Kleiner's mini-teleporter",
			Rewards = {
				XP = 2500,
				Item = nil
			},
			IsRare = false
		},
		Blast_From_The_Past = {
			Name = "Blast from the past", 
			Mat = "vgui/achievements/hl2_find_hevfaceplate.png", 
			Desc = "Find the old H.E.V suit charger",
			Rewards = {
				XP = 1750,
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
	
	Misc = {
		New_Arrival = {
			Name = "New Arrival", 
			Mat = "vgui/achievements/hl2_beat_cemetery.png", 
			Desc = "Play the gamemode\nfor the first time",
			Rewards = {
				XP = 0,
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