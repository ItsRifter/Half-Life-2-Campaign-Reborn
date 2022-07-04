AddCSLuaFile()

HL2CR_Skills = {}

function CreateSkillSet(newSkill)
    table.insert(HL2CR_Skills, newSkill)
end

local health_boost_1 = {
    ["Class"] = "hpboost_1",
    ["Name"] = translate.Get("Skill_HPBoost_1_Name"),
    ["Desc"] = translate.Get("Skill_HPBoost_1_Desc"),
    ["Icon"] = "materials/hl2cr/skills/health_1.jpg",
    ["Cost"] = 1,
    ["SkillNeeded"] = nil,
    ["UnlockSkills"] = "hpboost_2",
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
    ["Desc"] = translate.Get("Skill_HPBoost_2_Desc"),
    ["Icon"] = "materials/hl2cr/skills/health_2.jpg",
    ["Cost"] = 1,
    ["SkillNeeded"] = "hpboost_1",
    ["UnlockSkills"] = "hpboost_3",
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
    ["Desc"] = translate.Get("Skill_HPBoost_3_Desc"),
    ["Icon"] = "materials/hl2cr/skills/health_3.jpg",
    ["Cost"] = 2,
    ["SkillNeeded"] = "hpboost_2",
    ["UnlockSkills"] = nil,
    ["PosInPanel"] = {
        ["XPos"] = 250,
        ["YPos"] = 75
    },
    ["Func"] = function(ply)
        ply.hl2cr.Statistics.HealthBonus = ply.hl2cr.Statistics.HealthBonus + 15
    end
}

CreateSkillSet(health_boost_3)