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
        ply.statHP = 5
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
        ply.statHP = ply.statHP + 10
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
        ply.statHP = ply.statHP + 15
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
        ply.statArmor = 5
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
        ply.statArmor = 10
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
        ply.statArmor = 20
    end
}

CreateSkillSet(armor_boost_3)

local flashbatt_1 = {
    ["Class"] = "flashbatt_1",
    ["Name"] = translate.Get("Skill_FlashBatt_1_Name"),
    ["Desc"] = translate.Get("Skill_FlashBatt_Desc"),
    ["Icon"] = "materials/hl2cr/skills/flashpower_1.jpg",
    ["Cost"] = 1,
    ["SkillNeeded"] = "armorboost_2",
    ["PosInPanel"] = {
        ["XPos"] = 250,
        ["YPos"] = 225
    },
    ["Func"] = function(ply)
        ply.statFlashBatt = 0.5 
    end
}

CreateSkillSet(flashbatt_1)

local hp_regen_1 = {
    ["Class"] = "hp_regen_1",
    ["Name"] = translate.Get("Skill_HPRegen_1_Name"),
    ["Desc"] = translate.Get("Skill_HPRegen_Desc"),
    ["Icon"] = "materials/hl2cr/misc/placeholder.jpg",
    ["Cost"] = 2,
    ["SkillNeeded"] = "hpboost_3",
    ["PosInPanel"] = {
        ["XPos"] = 375,
        ["YPos"] = 25
    },
    ["Func"] = function(ply)
        ply.hpRegen = 5
    end
}

CreateSkillSet(hp_regen_1)

local hp_regen_2 = {
    ["Class"] = "hp_regen_2",
    ["Name"] = translate.Get("Skill_HPRegen_2_Name"),
    ["Desc"] = translate.Get("Skill_HPRegen_Desc"),
    ["Icon"] = "materials/hl2cr/misc/placeholder.jpg",
    ["Cost"] = 3,
    ["SkillNeeded"] = "hp_regen_1",
    ["PosInPanel"] = {
        ["XPos"] = 500,
        ["YPos"] = 125
    },
    ["Func"] = function(ply)
        ply.hpRegen = ply.hpRegen + 5
    end
}

CreateSkillSet(hp_regen_2)