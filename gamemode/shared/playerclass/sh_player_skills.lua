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

local passive_health = CreateSkill("Health Boost", "Increase life expectancy", "Passive", 1, "materials/hl2cr/skill_health.jpg", 10)

local medic_revive = CreateSkill("Revival", "Revive the fallen players", "Medic", 1, "materials/hl2cr/skill_health.jpg", 1)

table.insert(GM.PlayerSkills, passive_health)

table.insert(GM.PlayerSkills, medic_revive)

if SERVER then
	net.Receive("HL2CR_SkillObtain", function(len, ply)
		if not ply then return end
		
		local skillToAdd = net.ReadString()
		local classAssign = net.ReadString()
		
		for i, v in ipairs(GAMEMODE.PlayerSkills) do
			if v.Name == skillToAdd and v.Class == classAssign then
			
				if not ply.hl2cr.Skills[classAssign]["CurInvest"] then
					ply.hl2cr.Skills[classAssign]["CurInvest"] = 1
				else
					ply.hl2cr.Skills[classAssign]["CurInvest"] = ply.hl2cr.Skills[classAssign]["CurInvest"] + 1
				end
				local updateTbl = {
					["Name"] = v.Name,
					["CurInvest"] = ply.hl2cr.Skills[classAssign]["CurInvest"]
				}
				
				table.Merge(ply.hl2cr.Skills[classAssign], updateTbl)
				
				--ply.hl2cr.SkillPoints = ply.hl2cr.SkillPoints - 1
				--ply:SetNWInt("stat_skillpoints", ply.hl2cr.SkillPoints)
			end
		end	
	end)
end