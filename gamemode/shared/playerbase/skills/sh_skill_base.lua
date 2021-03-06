AddCSLuaFile()

HL2CR_Skills = {}

function CreateSkillSet(newSkill)
    table.insert(HL2CR_Skills, newSkill)
end

local health_boost_1 = {
    ["Class"] = "hpboost_1",
    ["Name"] = translate.Get("Skill_HPBoost_1_Name"),
    ["Desc"] = translate.Get("Skill_HPBoost_Desc") .. 5,
    ["Icon"] = "materials/hl2cr/skills/health_1.jpg",
    ["Cost"] = 1,
    ["SkillNeeded"] = nil,
    ["PosInPanel"] = {
        ["XPos"] = 0,
        ["YPos"] = 0
    },
    ["Func"] = function(ply)
        ply.hl2cr.Statistics.HealthBonus = ply.hl2cr.Statistics.HealthBonus + 5
    end
}

CreateSkillSet(health_boost_1)

local health_boost_2 = {
    ["Class"] = "hpboost_2",
    ["Name"] = translate.Get("Skill_HPBoost_2_Name"),
    ["Desc"] = translate.Get("Skill_HPBoost_Desc") .. 10,
    ["Icon"] = "materials/hl2cr/skills/health_2.jpg",
    ["Cost"] = 1,
    ["SkillNeeded"] = "hpboost_1",
    ["PosInPanel"] = {
        ["XPos"] = 125,
        ["YPos"] = 50
    },
    ["Func"] = function(ply)
        ply.hl2cr.Statistics.HealthBonus = ply.hl2cr.Statistics.HealthBonus + 10
    end
}

CreateSkillSet(health_boost_2)

local health_boost_3 = {
    ["Class"] = "hpboost_3",
    ["Name"] = translate.Get("Skill_HPBoost_3_Name"),
    ["Desc"] = translate.Get("Skill_HPBoost_Desc") .. 15,
    ["Icon"] = "materials/hl2cr/skills/health_3.jpg",
    ["Cost"] = 2,
    ["SkillNeeded"] = "hpboost_2",
    ["PosInPanel"] = {
        ["XPos"] = 250,
        ["YPos"] = 75
    },
    ["Func"] = function(ply)
        ply.hl2cr.Statistics.HealthBonus = ply.hl2cr.Statistics.HealthBonus + 15
    end
}

CreateSkillSet(health_boost_3)

local armor_boost_1 = {
    ["Class"] = "armorboost_1",
    ["Name"] = translate.Get("Skill_Armor_1_Name"),
    ["Desc"] = translate.Get("Skill_Armor_Desc") .. 5,
    ["Icon"] = "materials/hl2cr/skills/armor_1.jpg",
    ["Cost"] = 1,
    ["SkillNeeded"] = nil,
    ["PosInPanel"] = {
        ["XPos"] = 25,
        ["YPos"] = 175
    },
    ["Func"] = function(ply)
        ply.hl2cr.Statistics.SuitBonus = ply.hl2cr.Statistics.SuitBonus + 5
    end
}

CreateSkillSet(armor_boost_1)

local armor_boost_2 = {
    ["Class"] = "armorboost_2",
    ["Name"] = translate.Get("Skill_Armor_2_Name"),
    ["Desc"] = translate.Get("Skill_Armor_Desc") .. 5,
    ["Icon"] = "materials/hl2cr/skills/armor_2.jpg",
    ["Cost"] = 1,
    ["SkillNeeded"] = "armorboost_1",
    ["PosInPanel"] = {
        ["XPos"] = 125,
        ["YPos"] = 225
    },
    ["Func"] = function(ply)
        ply.hl2cr.Statistics.SuitBonus = ply.hl2cr.Statistics.SuitBonus + 5
    end
}

CreateSkillSet(armor_boost_2)

local armor_boost_3 = {
    ["Class"] = "armorboost_3",
    ["Name"] = translate.Get("Skill_Armor_3_Name"),
    ["Desc"] = translate.Get("Skill_Armor_Desc") .. 10,
    ["Icon"] = "materials/hl2cr/skills/armor_3.jpg",
    ["Cost"] = 2,
    ["SkillNeeded"] = "armorboost_2",
    ["PosInPanel"] = {
        ["XPos"] = 150,
        ["YPos"] = 350
    },
    ["Func"] = function(ply)
        ply.hl2cr.Statistics.SuitBonus = ply.hl2cr.Statistics.SuitBonus + 10
    end
}

CreateSkillSet(armor_boost_3)