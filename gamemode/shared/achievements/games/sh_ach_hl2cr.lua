local achgroup = {
	Name = translate.Get("AchGroup_HL2CR"),
	Index = 0,
	Achievements ={
		["HL2CR_RAS"] ={
			Name = translate.Get("Achievement_Misc_RiseShine_Name"),
			Mat = "materials/hl2cr/achicons/riseshine.jpg", 
			Desc = translate.Get("Achievement_Misc_RiseShine_Desc"),
			Rewards = {
				XP = 200,
				--Items = {}
			},
			--IsRare = false,
			--Value = 0,
			--Max = 0,
			Index = 0
		},
		["HL2CR_VORTEX"] ={
			Name = translate.Get("Achievement_Misc_Vortex_Name"),
			Mat = "materials/hl2cr/misc/placeholder.jpg", 
			Desc = translate.Get("Achievement_Misc_Vortex_Desc"),
			Rewards = {
				XP = 2000,
			},
			Count = true,
			Interval = 10,
			Max = 100,
			Index = 50
		},
		["HL2CR_CIVIL"] ={
			Name = translate.Get("Achievement_Misc_CivilUnrest_Name"),
			Mat = "materials/hl2cr/misc/placeholder.jpg", 
			Desc = translate.Get("Achievement_Misc_CivilUnrest_Desc"),
			Rewards = {
				XP = 2000,
			},
			Count = true,
			Interval = 10,
			Max = 100,
			Index = 100
		},
		["HL2CR_SPECIAL"] ={
			Name = translate.Get("Achievement_Misc_Special_Name"),
			Mat = "materials/hl2cr/misc/placeholder.jpg", 
			Desc = translate.Get("Achievement_Misc_Special_Desc"),
			Rewards = {
				XP = 2000,
			},
			Count = true,
			Interval = 10,
			Max = 100,
			Index = 101
		},
		["HL2CR_LAVA"] ={
			Name = translate.Get("Achievement_Misc_Lava_Name"),
			Mat = "materials/hl2cr/misc/placeholder.jpg", 
			Desc = translate.Get("Achievement_Misc_Lava_Desc"),
			Rewards = {
				XP = 50,
				--Items = {}
			},
			Secret = true,
			Index = 666
		},
	}
}

GM.Achievements["HL2CR"] = achgroup