AddCSLuaFile()

GM.PlayerSkills = {}

local function CreateSkill(name, desc, class, level, icon, maxLevel)
	
	local skill = {
		["Name"] = name,
		["Desc"] = desc,
		["Class"] = class,
		["LevelReq"] = level,
		["Icon"] = icon,
		["Invested"] = 0,
		["Max"] = maxLevel
	}
	
	return skill
end

local passive_health = CreateSkill("Health Boost", "Increase life\nexpectancy", "Passive", 1, "materials/hl2cr/skill_health.jpg", 10)
local passive_armor = CreateSkill("Armor Boost", "Your armor\ncan sustain\nmore damage", "Passive", 1, "materials/hl2cr/skill_armor.jpg", 3)

local medic_heal = CreateSkill("Healing", "Heal more\neffectively", "Medic", 5, "materials/hl2cr/skill_healing.jpg", 5)
local medic_revive = CreateSkill("Revival", "Revive the fallen", "Medic", 10, "materials/hl2cr/skill_revival.jpg", 1)

table.insert(GM.PlayerSkills, passive_health)
table.insert(GM.PlayerSkills, passive_armor)

table.insert(GM.PlayerSkills, medic_heal)
table.insert(GM.PlayerSkills, medic_revive)

local testTbl = {}

if SERVER then
	net.Receive("HL2CR_SkillObtain", function(len, ply)
		if not ply then return end
		
		local skillToAdd = net.ReadString()
		local classAssign = net.ReadString()
		
		for i, v in ipairs(GAMEMODE.PlayerSkills) do
			if v.Name == skillToAdd and v.Class == classAssign then

				--ply.hl2cr.Skills[classAssign]["Invested"] = ply.hl2cr.Skills[classAssign]["Invested"] + 1
				
				if IsValid(testTbl) and table.HasValue(testTbl, v) then
				--if IsValid(ply.hl2cr.Skills[classAssign]) and table.HasValue(ply.hl2cr.Skills[classAssign].Name, v.Name) then
					print("Has skill already")
					--table.Merge(ply.hl2cr.Skills[classAssign])
				else
					print("Doesn't have skill already")
					table.insert(testTbl, v)
					
					PrintTable(testTbl)
				end
				
				--if ply.hl2cr.Skills[classAssign]["Invested"] < v.Max then
					--ply.hl2cr.SkillPoints = ply.hl2cr.SkillPoints - 1
				--end
		
				ply:SetNWInt("stat_skillpoints", ply.hl2cr.SkillPoints)
			end
		end	
	end)
end