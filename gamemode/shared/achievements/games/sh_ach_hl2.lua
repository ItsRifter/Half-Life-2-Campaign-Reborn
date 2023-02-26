local achgroup = {
	Name = translate.Get("AchGroup_HL2"),
	Index = 1,
	Achievements ={
		["HL2_Subm"] ={
			Name = translate.Get("Achievement_HL2_Submissive_Name"),
			Mat = "vgui/achievements/hl2_put_canintrash.png", 
			Desc = translate.Get("Achievement_HL2_Submissive_Desc"),
			Rewards = {
				XP = 120,
				AP = 5
			},
			Secret = true,
			Index = 1
		},
		["HL2_Defi"] ={
			Name = translate.Get("Achievement_HL2_Defiant_Name"),
			Mat = "vgui/achievements/hl2_hit_cancop_withcan.png", 
			Desc = translate.Get("Achievement_HL2_Defiant_Desc"),
			Rewards = {
				XP = 120,
				AP = 5
			},
			Secret = true,
			Index = 2
		},
		["HL2_Mal"] ={
			Name = translate.Get("Achievement_HL2_Malcontent_Name"),
			Mat = "vgui/achievements/hl2_escape_apartmentraid.png", 
			Desc = translate.Get("Achievement_HL2_Malcontent_Desc"),
			Rewards = {
				XP = 500,
				AP = 20
			},
			Interval = 99,
			Max = 4,
			Index = 3
		},
		["HL2_WCat"] ={
			Name = translate.Get("Achievement_HL2_WhatCat_Name"),
			Mat = "vgui/achievements/hl2_break_miniteleporter.png", 
			Desc = translate.Get("Achievement_HL2_WhatCat_Desc"),
			Rewards = {
				XP = 250,
				AP = 5
			},
			Secret = true,
			Index = 4
		},
		["HL2_WBaby"] ={
			Name = translate.Get("Achievement_HL2_WhatBaby_Name"),
			Mat = "vgui/achievements/hl2_break_miniteleporter.png", 
			Desc = translate.Get("Achievement_HL2_WhatBaby_Desc"),
			Rewards = {
				XP = 450,
				Items = {"HAT_BABY"},
				AP = 15
			},
			Index = 5
		},
		["HL2_Crowbar"] ={
			Name = translate.Get("Achievement_HL2_TrustyHardware_Name"),
			Mat = "vgui/achievements/hl2_get_crowbar.png", 
			Desc = translate.Get("Achievement_HL2_TrustyHardware_Desc"),
			Rewards = {
				XP = 300,
				AP = 5
			},
			Index = 6
		},
		["HL2_Barnacle"] ={
			Name = translate.Get("Achievement_HL2_BarnacleBowling_Name"),
			Mat = "vgui/achievements/hl2_kill_barnacleswithbarrel.png", 
			Desc = translate.Get("Achievement_HL2_BarnacleBowling_Desc"),
			Rewards = {
				XP = 500,
				AP = 5
			},
			Index = 7
		},
		["HL2_Canals"] ={
			Name = translate.Get("Achievement_HL2_Canals_Name"),
			Mat = "vgui/achievements/hl2_get_airboat.png", 
			Desc = translate.Get("Achievement_HL2_Canals_Desc"),
			Rewards = {
				XP = 3000,
				AP = 65
			},
			Interval = 99,
			Max = 13,
			Index = 8
		},
		["HL2_Gravgun"] ={
			Name = translate.Get("Achievement_HL2_ZeroEnergy_Name"),
			Mat = "vgui/achievements/hl2_get_gravitygun.png", 
			Desc = translate.Get("Achievement_HL2_ZeroEnergy_Desc"),
			Rewards = {
				XP = 250,
				AP = 10
			},
			Index = 9
		},
		["HL2_HevPlate"] ={
			Name = translate.Get("Achievement_HL2_BlastPast_Name"),
			Mat = "vgui/achievements/hl2_find_hevfaceplate.png", 
			Desc = translate.Get("Achievement_HL2_BlastPast_Desc"),
			Rewards = {
				XP = 200,
				AP = 5
			},
			Secret = true,
			Index = 10
		},
		["HL2_TwoPoint"] ={
			Name = translate.Get("Achievement_HL2_TwoPoints_Name"),
			Mat = "vgui/achievements/hl2_get_gravitygun.png", 
			Desc = translate.Get("Achievement_HL2_TwoPoints_Desc"),
			Rewards = {
				XP = 250,
				AP = 5
			},
			Secret = true,
			Index = 11
		},
		["HL2_Chopper"] ={
			Name = translate.Get("Achievement_HL2_ZombieChopper_Name"),
			Mat = "vgui/achievements/hl2_beat_ravenholm_noweapons.png", 
			Desc = translate.Get("Achievement_HL2_ZombieChopper_Desc"),
			Rewards = {
				XP = 1000,
				Items = {"MELEE_CROWSAW"},
				AP = 30
			},
			Index = 20
		},
		["HL2_Hallow"] ={
			Name = translate.Get("Achievement_HL2_HallowGround_Name"),
			Mat = "vgui/achievements/hl2_beat_cemetery.png", 
			Desc = translate.Get("Achievement_HL2_HallowGround_Desc"),
			Rewards = {
				XP = 300,
				AP = 10
			},
			Index = 21
		},
		["HL2_RavenBall"] ={
			Name = translate.Get("Achievement_HL2_RavenBall_Name"),
			Mat = "vgui/achievements/hl2_get_gravitygun.png", 
			Desc = translate.Get("Achievement_HL2_RavenBall_Desc"),
			Rewards = {
				XP = 900,
				Items = {"HAT_BALL"},
				AP = 30
			},
			Interval = 99,	--Dont want it to show till finished anyway
			Max = 8,
			Index = 22
		},
------------------------------------------------------------------------------
------------------------------------------------------------------------------
		["HL2_Cubbage"] ={
			Name = translate.Get("Achievement_HL2_CubbageTrends_Name"),
			Mat = "vgui/achievements/hl2_kill_odessagunship.png", 
			Desc = translate.Get("Achievement_HL2_CubbageTrends_Desc"),
			Rewards = {
				XP = 400,
				AP = 15
			},
			Index = 30
		},
		["HL2_Sand"] ={
			Name = translate.Get("Achievement_HL2_KeepOffSand_Name"),
			Mat = "vgui/achievements/hl2_beat_donttouchsand.png", 
			Desc = translate.Get("Achievement_HL2_KeepOffSand_Desc"),
			Rewards = {
				XP = 400,
				AP = 10
			},
			Index = 31
		},
		["HL2_Coast"] ={
			Name = translate.Get("Achievement_HL2_Coast_Name"),
			Mat = "materials/hl2cr/misc/placeholder.jpg", 
			Desc = translate.Get("Achievement_HL2_Coast_Desc"),
			Rewards = {
				XP = 4000,
				AP = 60
			},
			Interval = 99,
			Max = 11,
			Index = 32
		},
		
		["HL2_Warden"] ={
			Name = translate.Get("Achievement_HL2_WardenFreeman_Name"),
			Mat = "vgui/achievements/hl2_beat_turretstandoff2.jpg", 
			Desc = translate.Get("Achievement_HL2_WardenFreeman_Desc"),
			Rewards = {
				XP = 1200,
				AP = 25
			},
			Index = 33
		},

------------------------------------------------------------------------------
------------------------------------------------------------------------------
		["HL2_RadTunnel"] ={
			Name = translate.Get("Achievement_HL2_Radiation_Name"),
			Mat = "vgui/achievements/hl2_beat_toxictunnel.jpg", 
			Desc = translate.Get("Achievement_HL2_Radiation_Desc"),
			Rewards = {
				XP = 200,
				AP = 5
			},
			Index = 40
		},
		
		["HL2_FollowFree"] ={
			Name = translate.Get("Achievement_HL2_FollowFreeman_Name"),
			Mat = "vgui/achievements/hl2_followfreeman.jpg", 
			Desc = translate.Get("Achievement_HL2_FollowFreeman_Desc"),
			Rewards = {
				XP = 4000,
				AP = 80
			},
			Interval = 99,
			Max = 16,
			Index = 45
		},
		
		["HL2_BarneyWish"] ={
			Name = translate.Get("Achievement_HL2_BarneyWish_Name"),
			Mat = "vgui/achievements/hl2_beat_game.jpg", 
			Desc = translate.Get("Achievement_HL2_BarneyWish_Desc"),
			Rewards = {
				XP = 200,
				AP = 10
			},
			Secret = true,
			Index = 46
		},
		
		["HL2_BeatHL2"] ={
			Name = translate.Get("Achievement_HL2_BeatGame_Name"),
			Mat = "vgui/achievements/hl2_beat_game.jpg", 
			Desc = translate.Get("Achievement_HL2_BeatGame_Desc"),
			Rewards = {
				XP = 10000,
				AP = 200
			},
			Interval = 99,
			Max = 69,
			Index = 50
		},

------------------------------------------------------------------------------
------------------------------------------------------------------------------
		["HL2_Lambda"] ={
			Name = translate.Get("Achievement_HL2_LambdaLocator_Name"),
			Mat = "vgui/achievements/hl2_find_alllambdas.png", 
			Desc = translate.Get("Achievement_HL2_LambdaLocator_Desc"),
			Rewards = {
				XP = 15000,
				AP = 100
			},
			Max = 45,
			Index = 99
		},

	}	
}

GM.Achievements["HL2"] = achgroup