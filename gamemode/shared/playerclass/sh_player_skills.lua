AddCSLuaFile()

GM.PlayerSkills = {}

function CreateSkill(name, desc, class, level, icon, maxLevel)
	
	local skill = {
		["Name"] = name,
		["Desc"] = desc,
		["Class"] = class,
		["LevelReq"] = level,
		["Icon"] = icon,
		["Invested"] = 0,
		["Max"] = maxLevel
	}
	
	table.insert(GM.PlayerSkills, skill)
end

local passive_health = CreateSkill("Health Boost", "Increase life\nexpectancy", "Passive", 1, "materials/hl2cr/skill_health.jpg", 10)
local passive_armor = CreateSkill("Armor Boost", "Your armor\ncan sustain\nmore damage", "Passive", 1, "materials/hl2cr/skill_armor.jpg", 3)

local medic_heal = CreateSkill("Healing", "Heal more\neffectively", "Medic", 5, "materials/hl2cr/skill_healing.jpg", 5)
local medic_revive = CreateSkill("Revival", "Revive the fallen", "Medic", 10, "materials/hl2cr/skill_revival.jpg", 1)
local medic_recharge = CreateSkill("Health Recharging", "Recharge and\nget back in\nthe fight", "Medic", 6, "materials/hl2cr/skill_healing_eff.jpg", 5)
local medic_regen = CreateSkill("Regeneration", "Taking care of yourself", "Medic", 12, "materials/hl2cr/skill_regen.jpg", 2)

local repair_recharge = CreateSkill("Recharge", "Recharge and keep\ncharging people", "Repair", 5, "materials/hl2cr/skill_armor_regen.jpg", 5)
local repair_group = CreateSkill("Group Repair", "Take care of multiple\npeople at the same time", "Repair", 7, "materials/hl2cr/skill_recharge_group.jpg", 5)
local repair_regen = CreateSkill("Armor Regen", "Recharges suit power", "Repair", 10, "materials/hl2cr/skill_recharge.jpg", 3)

local supply_stock = CreateSkill("Ammo Stock", "Hold more ammo", "Supplier", 5, "materials/hl2cr/class_supporter.jpg", 5)
local supply_biggerstock = CreateSkill("Bigger Supply", "Resupply people\nmore effectively", "Supplier", 7, "materials/hl2cr/class_supporter.jpg", 4)
local supply_group = CreateSkill("Group Resupply", "Resupply multiple people\nat the same time", "Supplier", 9, "materials/hl2cr/skill_recharge_group.jpg", 4)

local robot_scanner = CreateSkill("Enhanced Exosuit", "Stronger and more powerful", "Robot", 21, "materials/hl2cr/chest_exo.jpg", 3)
local robot_scanner = CreateSkill("Entity Scanner", "Scan Hostiles status", "Robot", 24, "materials/hl2cr/skill_targetstats.jpg", 1)

if SERVER then
	net.Receive("HL2CR_SkillObtain", function(len, ply)
		if not ply then return end
		
		local skillToAdd = net.ReadString()
		local classAssign = net.ReadString()
		local skillToInsert = nil
		local skillIndex = -1
		
		for i, v in ipairs(GAMEMODE.PlayerSkills) do
			if v.Name == skillToAdd then
				skillToInsert = v
				skillIndex = i
			end
		end
		
		if not skillIndex or not skillToInsert then return end
		
		if ply.hl2cr.Skills[skillIndex] and ply.hl2cr.Skills[skillIndex].Invested >= skillToInsert.Max then return end
		
		if ply.hl2cr.Skills[skillIndex] then
			ply.hl2cr.Skills[skillIndex].Invested = ply.hl2cr.Skills[skillIndex].Invested + 1
		else
			table.insert(ply.hl2cr.Skills, skillIndex, skillToInsert)
			ply.hl2cr.Skills[skillIndex].Invested = 1
		end
		
		ply.hl2cr.SkillPoints = ply.hl2cr.SkillPoints - 1

		ply:SetNWInt("stat_skillpoints", ply.hl2cr.SkillPoints)
		SetUpPlayerStats(ply)
	end)
end