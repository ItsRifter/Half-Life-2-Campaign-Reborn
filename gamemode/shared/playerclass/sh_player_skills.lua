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

--Passive
CreateSkill("Health Boost", "Increase life expectancy", "Passive", 1, "materials/hl2cr/skill_health.jpg", 10)
CreateSkill("Armor Boost", "Your armor can sustain\nmore damage", "Passive", 1, "materials/hl2cr/skill_armor.jpg", 3)

--Field Medic
CreateSkill("Healing", "Heal more effectively", "Medic", 5, "materials/hl2cr/skill_healing.jpg", 5)
CreateSkill("Revival", "Revive the fallen", "Medic", 10, "materials/hl2cr/skill_revival.jpg", 1)
CreateSkill("Health Recharging", "Recharge and get back\nin the fight", "Medic", 6, "materials/hl2cr/skill_healing_eff.jpg", 5)
CreateSkill("Regeneration", "Taking care of yourself", "Medic", 12, "materials/hl2cr/skill_regen.jpg", 2)

--Repairman
CreateSkill("Recharge", "Recharge and keep\ncharging people", "Repair", 5, "materials/hl2cr/skill_armor_regen.jpg", 5)
CreateSkill("Effective Charge", "Charge armor more effectively", "Repair", 6, "materials/hl2cr/skill_recharge_faster.jpg", 3)
CreateSkill("Group Repair", "Take care of multiple\npeople at the same time", "Repair", 7, "materials/hl2cr/skill_recharge_group.jpg", 5)
CreateSkill("Armor Regen", "Recharges suit power", "Repair", 10, "materials/hl2cr/skill_recharge.jpg", 3)

--Supplier
CreateSkill("Ammo Stock", "Hold more ammo", "Supplier", 5, "materials/hl2cr/skill_ammo_stock.jpg", 5)
CreateSkill("Bigger Supply", "Resupply people\nmore effectively", "Supplier", 7, "materials/hl2cr/skill_ammo_supply.jpg", 4)
CreateSkill("Group Resupply", "Resupply multiple people\nat the same time", "Supplier", 9, "materials/hl2cr/skill_ammo_group.jpg", 4)

--Robot
CreateSkill("Enhanced Exosuit", "Stronger and more powerful", "Robot", 21, "materials/hl2cr/chest_exo.jpg", 3)
CreateSkill("Entity Scanner", "Scan Hostiles status", "Robot", 24, "materials/hl2cr/skill_targetstats.jpg", 1)

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