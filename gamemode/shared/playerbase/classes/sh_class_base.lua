AddCSLuaFile()

HL2CR_Classes = {}

function AddPlayerClass(newClass)
    table.insert(HL2CR_Classes, newClass)
end


local citizen = {
    ["Name"] = translate.Get("Player_Class_Default"),
    ["Desc"] = translate.Get("Player_Class_Default_Desc"),
    ["Icon"] = "materials/hl2cr/achicons/riseshine.jpg",
    ["LevelReq"] = 0,
    ["Buffs"] = {
        [1] = translate.Get("Player_Class_NoBuffDeBuff")
    },
    ["Debuffs"] = {
        [1] = translate.Get("Player_Class_NoBuffDeBuff")
    },
    ["Func"] = function(ply)
        ply.hl2cr.Class = {
            ["Name"] = translate.Get("Player_Class_Default"),
            ["Buffs"] = {
                ["BuffFunc"] = function(ply)
                    table.Empty(ply.hl2cr.Buffs)
                end
            },
            ["Debuffs"] = {
                ["DebuffFunc"] = function(ply)
                    table.Empty(ply.hl2cr.Debuffs)
                end
            },
            ["Weapons"] = {}
        }
        
        ply.hl2cr.ModelType.Type = "Citizen"
    end
}

AddPlayerClass(citizen)

local fieldmedic = {
    ["Name"] = translate.Get("Player_Class_FieldMedic"),
    ["Desc"] = translate.Get("Player_Class_FieldMedic_Desc"),
    ["Icon"] = "materials/hl2cr/class/medic.jpg",
    ["LevelReq"] = 5,
    ["Buffs"] = {
        [1] = translate.Get("Player_Class_Buff_Recovery"),
        [2] = translate.Get("Player_Class_Buff_HealEffective")
    },
    ["Debuffs"] = {
        [1] = translate.Get("Player_Class_Debuff_ArmorReduction") .. 15
    },
    ["Func"] = function(ply)
        ply.hl2cr.Class = {
            ["Name"] = translate.Get("Player_Class_FieldMedic"),
            ["Buffs"] = {
                ["BuffFunc"] = function(ply)
                    ply.hl2cr.Buffs.SelfHealing = true
                    ply.hl2cr.Buffs.MedicalKnowledge = 10
                end
            },
            
            ["Debuffs"] = {
                ["DebuffFunc"] = function(ply)
                    ply:SetMaxArmor(100 - 15)
                end
            },
            
            ["Weapons"] = {
                [1] = "weapon_hl2cr_medkit"
            }
        }
        
        ply.hl2cr.ModelType.Type = "Medic"
    end
}

AddPlayerClass(fieldmedic)