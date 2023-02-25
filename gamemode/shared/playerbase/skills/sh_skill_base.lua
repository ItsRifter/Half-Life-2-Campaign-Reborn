AddCSLuaFile()

HL2CR_Skills = {}

function CreateSkillSet(newSkill)
    table.insert(HL2CR_Skills, newSkill)
end

local SKILL = {
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
CreateSkillSet(SKILL)

local SKILL = {
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
CreateSkillSet(SKILL)

local SKILL = {
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
CreateSkillSet(SKILL)

local SKILL = {
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
CreateSkillSet(SKILL)

local SKILL = {
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
CreateSkillSet(SKILL)

local SKILL = {
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
CreateSkillSet(SKILL)

local SKILL = {
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
        ply.statFlashBatt = 0.5		--Drain Rate Multiplier instead 
    end
}
CreateSkillSet(SKILL)

local SKILL = {
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
CreateSkillSet(SKILL)

local SKILL = {
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
CreateSkillSet(SKILL)


HL2CR_NewSkills = {
	["hpboost_1"] = {
		name = translate.Get("Skill_HPBoost_1_Name"),
		desc = translate.Get("Skill_HPBoost_Desc")..5,
		icon = "materials/hl2cr/skills/health_1.jpg",
		cost = 1,
		requires = nil,
		pos = {x=0.15,y=0.15},
		func = function(ply)
			ply.statHP = 5
		end
	},
	["hpboost_2"] = {
		name = translate.Get("Skill_HPBoost_2_Name"),
		desc = translate.Get("Skill_HPBoost_Desc")..10,
		icon = "materials/hl2cr/skills/health_1.jpg",
		cost = 2,
		requires = {"hpboost_1"},
		pos = {x=0.15,y=0.35},
		func = function(ply)
			ply.statHP = ply.statHP + 10
		end
	},
	["hpboost_3"] = {
		name = translate.Get("Skill_HPBoost_3_Name"),
		desc = translate.Get("Skill_HPBoost_Desc")..15,
		icon = "materials/hl2cr/skills/health_1.jpg",
		cost = 3,
		requires = {"hpboost_2"},
		pos = {x=0.15,y=0.65},
		func = function(ply)
			ply.statHP = ply.statHP + 15
		end
	},
	["armorboost_1"] = {
		name = translate.Get("Skill_Armor_1_Name"),
		desc = translate.Get("Skill_Armor_Desc")..5,
		icon = "materials/hl2cr/skills/armor_1.jpg",
		cost = 1,
		requires = nil,
		pos = {x=0.75,y=0.15},
		func = function(ply)
			ply.statArmor = 5
		end
	},
	["armorboost_2"] = {
		name = translate.Get("Skill_Armor_2_Name"),
		desc = translate.Get("Skill_Armor_Desc")..5,
		icon = "materials/hl2cr/skills/armor_2.jpg",
		cost = 2,
		requires = {"armorboost_1"},
		pos = {x=0.75,y=0.40},
		func = function(ply)
			ply.statArmor = 10
		end
	},
	["armorboost_3"] = {
		name = translate.Get("Skill_Armor_3_Name"),
		desc = translate.Get("Skill_Armor_Desc")..10,
		icon = "materials/hl2cr/skills/armor_3.jpg",
		cost = 3,
		requires = {"armorboost_2"},
		pos = {x=0.75,y=0.65},
		func = function(ply)
			ply.statArmor = 20
		end
	},
	["flashbatt_1"] = {
		name = translate.Get("Skill_FlashBatt_1_Name"),
		desc = translate.Get("Skill_FlashBatt_Desc"),
		icon = "materials/hl2cr/skills/flashpower_1.jpg",
		cost = 1,
		requires = {"hpboost_1"},
		pos = {x=0.35,y=0.15},
		func = function(ply)
			ply.statFlashBatt = 0.5
		end
	},
	["hp_regen_1"] = {
		name = translate.Get("Skill_HPRegen_1_Name"),
		desc = translate.Get("Skill_HPRegen_Desc"),
		icon = "materials/hl2cr/misc/placeholder.jpg",
		cost = 2,
		requires = {"hpboost_2"},
		pos = {x=0.35,y=0.35},
		func = function(ply)
			ply.hpRegen = 5
		end
	},
	["hp_regen_2"] = {
		name = translate.Get("Skill_HPRegen_2_Name"),
		desc = translate.Get("Skill_HPRegen_Desc"),
		icon = "materials/hl2cr/misc/placeholder.jpg",
		cost = 3,
		requires = {"hp_regen_1","hpboost_3","armorboost_3"},
		pos = {x=0.35,y=0.55},
		func = function(ply)
			ply.hpRegen = ply.hpRegen + 5
		end
	},
	["Ammo_1"] = {
		name = translate.Get("Skill_Ammo_1_Name"),
		desc = translate.Get("Skill_Ammo_1_Desc"),
		icon = "materials/hl2cr/skills/ammo_starter_1.jpg",
		cost = 1,
		requires = {"armorboost_1"},
		pos = {x=0.55,y=0.15}
	},
	["Ammo_2"] = {
		name = translate.Get("Skill_Ammo_2_Name"),
		desc = translate.Get("Skill_Ammo_2_Desc"),
		icon = "materials/hl2cr/skills/ammo_starter_2.jpg",
		cost = 2,
		requires = {"armorboost_2","Ammo_1"},
		pos = {x=0.55,y=0.40}
	},
	["Ammo_3"] = {
		name = translate.Get("Skill_Ammo_3_Name"),
		desc = translate.Get("Skill_Ammo_3_Desc"),
		icon = "materials/hl2cr/skills/ammo_starter_3.jpg",
		cost = 3,
		requires = {"armorboost_3","Ammo_2","hpboost_3"},
		pos = {x=0.55,y=0.75}
	},
}

if CLIENT then	-----------------------------------------------------------------

	net.Receive( "HL2CR_CL_SendSkills", function( length)
		GAMEMODE.SkillsList = net.ReadTable()
		GAMEMODE.skillPoints = net.ReadUInt( 12 )
		if IsValid(HL2CR_SkillPanel) then HL2CR_SkillPanel:Refresh() end
	end )
	
	net.Receive( "HL2CR_CL_AddSkill", function( length)
		local skill = net.ReadString()
		if skill != "" and !HL2CR_SkillsBought(skill) then table.insert(GAMEMODE.SkillsList, skill) end
		GAMEMODE.skillPoints = net.ReadUInt( 12 )
		if IsValid(HL2CR_SkillPanel) then HL2CR_SkillPanel:Refresh() end
	end )
	
	function HL2CR_SkillsBought(skill)
		return table.HasValue( GAMEMODE.SkillsList,skill)
	end
	
	function HL2CR_SkillsUnlocked(skill)
		if !HL2CR_NewSkills[skill].requires then return true end
		for k, v in pairs(HL2CR_NewSkills[skill].requires)do
			if !HL2CR_SkillsBought(v) then return false end
		end
		return true
	end
	
	function HL2CR_SkillsPoints()
		return GAMEMODE.skillPoints or 0
	end

elseif SERVER then -----------------------------------------------------------------

	function hl2cr_player:HasSkill(skill)
		return table.HasValue( self.hl2cr.Skills,skill)
	end

	function hl2cr_player:SkillUnlocked(skill)
		if !HL2CR_NewSkills[skill].requires then return true end
		for k, v in pairs(HL2CR_NewSkills[skill].requires)do
			if !self:HasSkill(v) then return false end
		end
		return true
	end

end