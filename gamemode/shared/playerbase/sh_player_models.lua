AddCSLuaFile()

if SERVER then
    CitizenModels = {
        ["Female"] = {
            [1] = "models/player/group01/female_01.mdl",
            [2] = "models/player/group01/female_02.mdl", 
            [3] = "models/player/group01/female_03.mdl",
            [4] = "models/player/group01/female_04.mdl",
            [5] = "models/player/group01/female_05.mdl",
            [6] = "models/player/group01/female_06.mdl"
        },

        ["Male"] = {
            [1] = "models/player/group01/male_01.mdl",
            [2] = "models/player/group01/male_02.mdl",
            [3] = "models/player/group01/male_03.mdl",
            [4] = "models/player/group01/male_04.mdl",
            [5] = "models/player/group01/male_05.mdl",
            [6] = "models/player/group01/male_06.mdl",
            [7] = "models/player/group01/male_07.mdl",
            [8] = "models/player/group01/male_08.mdl",
            [9] = "models/player/group01/male_09.mdl"
        }
    }

    RebelModels = {
        ["Female"] = {

        },

        ["Male"] = {
            
        }
    }

    Robot = {
        ["Misc"] = "models/player/mc/robo/Robo.mdl"
    }

    HEVSuit = {
        ["Misc"] = "models/player/SGG/hev_helmet.mdl"
    }

    GordonFreeman = {
        ["Misc"] = "models/Inaki/Characters/gordon_freeman.mdl"
    }
end

if CLIENT then 
    Client_CitizenModels = {
        ["models/player/group01/female_01.mdl"] = true,
        ["models/player/group01/female_02.mdl"] = true, 
        ["models/player/group01/female_03.mdl"] = true,
        ["models/player/group01/female_04.mdl"] = true,
        ["models/player/group01/female_05.mdl"] = true,
        ["models/player/group01/female_06.mdl"] = true,
    
        ["models/player/group01/male_01.mdl"] = false,
        ["models/player/group01/male_02.mdl"] = false,
        ["models/player/group01/male_03.mdl"] = false,
        ["models/player/group01/male_04.mdl"] = false,
        ["models/player/group01/male_05.mdl"] = false,
        ["models/player/group01/male_06.mdl"] = false,
        ["models/player/group01/male_07.mdl"] = false,
        ["models/player/group01/male_08.mdl"] = false,
        ["models/player/group01/male_09.mdl"] = false
    }
end


