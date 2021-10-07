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
	
	return skill
end

local passive_health = CreateSkill("Health Boost", "Increase life\nexpectancy", "Passive", 1, "materials/hl2cr/skill_health.jpg", 10)
local passive_armor = CreateSkill("Armor Boost", "Your armor\ncan sustain\nmore damage", "Armor", 1, "materials/hl2cr/skill_armor.jpg", 3)

local medic_heal = CreateSkill("Healing", "Heal more\neffectively", "Medic", 5, "materials/hl2cr/skill_healing.jpg", 5)
local medic_revive = CreateSkill("Revival", "Revive the fallen", "Revival", 10, "materials/hl2cr/skill_healing.jpg", 1)

table.insert(GM.PlayerSkills, passive_health)
table.insert(GM.PlayerSkills, passive_armor)

table.insert(GM.PlayerSkills, medic_heal)
table.insert(GM.PlayerSkills, medic_revive)

if SERVER then
	net.Receive("HL2CR_SkillObtain", function(len, ply)
		if not ply then return end
		
		local skillToAdd = net.ReadString()
		local classAssign = net.ReadString()
		
		for i, v in ipairs(GAMEMODE.PlayerSkills) do
			if v.Name == skillToAdd and v.Class == classAssign then
			
				if ply.hl2cr.Skills[classAssign]["CurInvest"] == nil then -- how the fuck it starts from nil
					ply.hl2cr.Skills[classAssign]["CurInvest"] = 1
				else
					ply.hl2cr.Skills[classAssign]["CurInvest"] = ply.hl2cr.Skills[classAssign]["CurInvest"] + 1
				end
				local updateTbl = {
					["Name"] = v.Name,
					["Max"] = v.Max,
					["CurInvest"] = ply.hl2cr.Skills[classAssign]["CurInvest"],
				}
				for i, v in pairs(ply.hl2cr.Skills) do 
			
					for k, l in pairs(v) do
						
					end
				end
				
				if table.IsEmpty(ply.hl2cr.Skills[classAssign]) then
				end
				table.Merge(ply.hl2cr.Skills[classAssign], updateTbl)
				if ply.hl2cr.Skills[classAssign]["CurInvest"] then
				ply.hl2cr.SkillPoints = ply.hl2cr.SkillPoints - 1
				end
				ply:SetNWInt("stat_skillpoints", ply.hl2cr.SkillPoints)
			end
		end	
	end)
end

--[[
	print(v.Max)
	print(v.Name)
	print(ply.hl2cr.Skills[classAssign]["CurInvest"] + 1)	
]]--