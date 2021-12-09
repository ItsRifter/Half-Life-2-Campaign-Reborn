AddCSLuaFile()

GM.QuestsSystem = {
	All = {
		[1] = {
			Name = "Kill 250 Zombies",
			Mat = "vgui/achievements/ep1_beat_game_onebullet.png",
			Desc = "Kill a total of 250 zombies\non any campaign",
			LevelReq = 2,
			Rewards = {
				XP = 3500,
				Resin = 2500,
			},
		},
	},
	
	HL2 = {
		[1] = {
			Name = "Survival - Medium",
			Mat = "vgui/achievements/ep1_beat_game.png",
			Desc = "Beat 5 maps in a row without\ndying on Medium difficulty\nin Half-Life 2",
			LevelReq = 3,
			Rewards = {
				XP = 4000,
				Resin = 2750,
			},
		},
	}
}