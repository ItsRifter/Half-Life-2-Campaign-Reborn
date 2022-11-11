ACHIEVEMENT = {
    Malcontent = {
        Name = translate.Get("Achievement_HL2_Malcontent_Name"),
        Mat = "vgui/achievements/hl2_escape_apartmentraid.png", 
        Desc = translate.Get("Achievement_HL2_Malcontent_Desc"),
        Rewards = {
            XP = 500,
            Items = nil
        },
        IsRare = false
    },
    
    Submissive = {
        Name = translate.Get("Achievement_HL2_Submissive_Name"),
        Mat = "vgui/achievements/hl2_put_canintrash.png", 
        Desc = translate.Get("Achievement_HL2_Submissive_Desc"),
        Rewards = {
            XP = 500,
            Items = nil
        },
        IsRare = false
    },
    
    Defiant = {
        Name = translate.Get("Achievement_HL2_Defiant_Name"),
        Mat = "vgui/achievements/hl2_hit_cancop_withcan.png", 
        Desc = translate.Get("Achievement_HL2_Defiant_Desc"),
        Rewards = {
            XP = 500,
            Items = nil
        },
        IsRare = false
    },
    
    Barney_Wish = {
        Name = translate.Get("Achievement_HL2_BarneyWish_Name"), 
        Mat = "vgui/achievements/hl2_beat_game.png", 
        Desc = translate.Get("Achievement_HL2_BarneyWish_Desc"),
        Rewards = {
            XP = 500,
            Items = nil
        },
        IsRare = false
    },
    
    Trusty_Hardware = {
        Name = translate.Get("Achievement_HL2_TrustyHardware_Name"), 
        Mat = "vgui/achievements/hl2_get_crowbar.png", 
        Desc = translate.Get("Achievement_HL2_TrustyHardware_Desc"),
        Rewards = {
            XP = 500,
            Items = nil
        },
        IsRare = false
    },
    
    Keep_Off_Sand = {
        Name = translate.Get("Achievement_HL2_KeepOffSand_Name"), 
        Mat = "vgui/achievements/hl2_beat_donttouchsand.png", 
        Desc = translate.Get("Achievement_HL2_KeepOffSand_Desc"),
        Rewards = {
            XP = 5000,
            Items = nil
        },
        IsRare = false
    },
    
    Warden_Freeman = {
        Name = translate.Get("Achievement_HL2_WardenFreeman_Name"), 
        Mat = "vgui/achievements/hl2_beat_turretstandoff2.png", 
        Desc = translate.Get("Achievement_HL2_WardenFreeman_Desc"),
        Rewards = {
            XP = 1500,
            Items = nil
        },
        IsRare = false
    },
    
    Follow_Freeman = {
        Name = translate.Get("Achievement_HL2_FollowFreeman_Name"), 
        Mat = "vgui/achievements/hl2_followfreeman.png", 
        Desc = translate.Get("Achievement_HL2_FollowFreeman_Desc"),
        Rewards = {
            XP = 1500,
            Items = nil
        },
        IsRare = false
    },
    
    Cubbage = {
        Name = translate.Get("Achievement_HL2_CubbageTrends_Name"), 
        Mat = "vgui/achievements/hl2_kill_odessagunship.png", 
        Desc = translate.Get("Achievement_HL2_CubbageTrends_Desc"),
        Rewards = {
            XP = 2500,
            Items = nil
        },
        IsRare = false
    },
    
    Radiation_Levels = {
        Name = translate.Get("Achievement_HL2_Radiation_Name"),
        Mat = "vgui/achievements/hl2_beat_toxictunnel.png", 
        Desc = translate.Get("Achievement_HL2_Radiation_Desc"),
        Rewards = {
            XP = 1500,
            Items = nil
        },
        IsRare = false
    },
    
    What_Baby = {
        Name = translate.Get("Achievement_HL2_WhatBaby_Name"), 
        Mat = "vgui/achievements/hl2_break_miniteleporter.png", 
        Desc = translate.Get("Achievement_HL2_WhatBaby_Desc"),
        Rewards = {
            XP = 2250,
            Items = function(ply)
                local hat = nil 

                for _, h in ipairs(HL2CR_Cosmetics) do
                    if h.Class == "hat_dollhead" then
                        hat = h
                        break
                    end
                end

                table.insert(ply.hl2cr.Inventory.Cosmetics, hat)
            end
        },
        IsRare = false
    },
    
    Zero_Point_Energy = {
        Name = translate.Get("Achievement_HL2_ZeroEnergy_Name"),
        Mat = "vgui/achievements/hl2_get_gravitygun.png", 
        Desc = translate.Get("Achievement_HL2_ZeroEnergy_Desc"),
        Rewards = {
            XP = 1000,
            Items = nil
        },
        IsRare = false
    },
    
    Two_Points = {
        Name = translate.Get("Achievement_HL2_TwoPoints_Name"),
        Mat = "vgui/achievements/hl2_get_gravitygun.png", 
        Desc = translate.Get("Achievement_HL2_TwoPoints_Desc"),
        Rewards = {
            XP = 2500,
            Items = nil
        },
        IsRare = false
    },
    
    Hallowed_Ground = {
        Name = translate.Get("Achievement_HL2_HallowGround_Name"),
        Mat = "vgui/achievements/hl2_beat_cemetery.png", 
        Desc = translate.Get("Achievement_HL2_HallowGround_Desc"),
        Rewards = {
            XP = 1250,
            Items = nil
        },
        IsRare = false
    },
    
    Zombie_Chopper = {
        Name = translate.Get("Achievement_HL2_ZombieChopper_Name"),
        Mat = "vgui/achievements/hl2_beat_ravenholm_noweapons.png",
        Desc = translate.Get("Achievement_HL2_ZombieChopper_Desc"),
        Rewards = {
            XP = 1250,
            Items = nil
        },
        IsRare = false
    },
    
    Barnacle_Bowling = {
        Name = translate.Get("Achievement_HL2_BarnacleBowling_Name"),
        Mat = "vgui/achievements/hl2_kill_barnacleswithbarrel.png", 
        Desc = translate.Get("Achievement_HL2_BarnacleBowling_Desc"),
        Rewards = {
            XP = 3500,
            Items = nil
        },
        IsRare = false
    },
    
    Raven_Ball = {
        Name = translate.Get("Achievement_HL2_RavenBall_Name"),
        Mat = "vgui/achievements/hl2_get_gravitygun.png", 
        Desc = translate.Get("Achievement_HL2_RavenBall_Desc"),
        Rewards = {
            XP = 12500,
            Items = function(ply)
                local hat = nil 

                for _, h in ipairs(HL2CR_Cosmetics) do
                    if h.Class == "hat_ballhead" then
                        hat = h
                        break
                    end
                end

                table.insert(ply.hl2cr.Inventory.Cosmetics, hat)
                ply:BroadcastMessage(HL2CR_StandardColour, translate.Get("Hat_Unlocked") .. translate.Get("Hat_Ballhead_Name"))
            end
        },
        IsRare = false
    },
    
    Flushed = {
        Name = translate.Get("Achievement_HL2_Flushed_Name"),
        Mat = "vgui/achievements/hl2_kill_enemy_withtoilet.png", 
        Desc = translate.Get("Achievement_HL2_Flushed_Desc"),
        Rewards = {
            XP = 2500,
            Items = nil
        },
        IsRare = false
    },
    
    Hack_Attack = {
        Name = translate.Get("Achievement_HL2_HackAttack_Name"),
        Mat = "vgui/achievements/hlx_kill_enemies_withmanhack.png", 
        Desc = translate.Get("Achievement_HL2_HackAttack_Desc"),
        Rewards = {
            XP = 3500,
            Items = nil
        },
        IsRare = false
    },
    
    What_Cat = {
        Name = translate.Get("Achievement_HL2_WhatCat_Name"), 
        Mat = "vgui/achievements/hl2_break_miniteleporter.png", 
        Desc = translate.Get("Achievement_HL2_WhatCat_Desc"),
        Rewards = {
            XP = 2500,
            Items = nil
        },
        IsRare = false
    },
    
    Blast_From_The_Past = {
        Name = translate.Get("Achievement_HL2_BlastPast_Name"),
        Mat = "vgui/achievements/hl2_find_hevfaceplate.png", 
        Desc = translate.Get("Achievement_HL2_BlastPast_Desc"),
        Rewards = {
            XP = 1750,
            Items = nil
        },
        IsRare = false
    },
    
    Beat_HL2 = {
        Name = translate.Get("Achievement_HL2_BeatGame_Name"),
        Mat = "vgui/achievements/hl2_beat_game.png", 
        Desc = translate.Get("Achievement_HL2_BeatGame_Desc"),
        Rewards = {
            XP = 5000,
            Items = nil
        },
        IsRare = false
    },
    
    Giant_Killer = {
        Name = translate.Get("Achievement_HL2_GiantKiller_Name"),
        Mat = "vgui/achievements/hl2_beat_c1713striderstandoff.png", 
        Desc = translate.Get("Achievement_HL2_GiantKiller_Desc"),
        Rewards = {
            XP = 2500,
            Items = nil
        },
        IsRare = false
    },
    
    Lambda_Locator = {
        Name = translate.Get("Achievement_HL2_LambdaLocator_Name"),
        Mat = "vgui/achievements/hl2_find_alllambdas.png", 
        Desc =  translate.Get("Achievement_HL2_LambdaLocator_Desc"),
        Rewards = {
            XP = 17500,
            Items = nil
        },
        IsRare = false,
        Value = 0,
        Update = 1,
        Max = 45,
        Maps = {}
    },
}