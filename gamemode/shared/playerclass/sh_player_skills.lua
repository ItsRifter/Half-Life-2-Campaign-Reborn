AddCSLuaFile()

GM.PlayerSkills = {}

function CreateSkill(name, desc, class, level, icon, requirement, pos1, pos2)
	
	local skill = {
		["Name"] = name,
		["Desc"] = desc,
		["Class"] = class,
		["Level"] = level,
		["Icon"] = icon,
		["Requirements"] = requirement,
		["Pos"] = {
			[1] = pos1,
			[2] = pos2,
		}
	}
	
	return skill
end

local passive_health_mk1 = CreateSkill("Health Boost", "Increase life expectancy", "Passive", 1, "materials/hl2cr/skill_health_mk1.jpg", "", 25, 150)
local passive_health_mk2 = CreateSkill("Health Boost II", "Increase life expectancy", "Passive", 2, "materials/hl2cr/skill_health_mk2.jpg", "Health Boost", 125, 150)
local passive_health_mk3 = CreateSkill("Health Boost III", "Increase life expectancy", "Passive", 3, "materials/hl2cr/skill_health_mk3.jpg", "Health Boost II", 225, 150)

local efficient_medic_mk1 = CreateSkill("Healing Efficiency", "Heal people more effectively", "Medic", 6, "materials/hl2cr/skill_healing_mk1.jpg", "", 25, 50)
local efficient_medic_mk2 = CreateSkill("Healing Efficiency II", "Heal people more effectively", "Medic", 7, "materials/hl2cr/skill_healing_mk2.jpg", "Healing Efficiency", 125, 50)
local efficient_medic_mk3 = CreateSkill("Healing Efficiency III", "Heal people more effectively", "Medic", 8, "materials/hl2cr/skill_healing_mk3.jpg", "Healing Efficiency II", 225, 50)

local recharge_medic_mk1 = CreateSkill("Heal Recharge", "Medkit recharges faster", "Medic", 6, "materials/hl2cr/skill_healing_mk1.jpg", "", 25, 150)
local recharge_medic_mk2 = CreateSkill("Heal Recharge II", "Medkit recharges faster", "Medic", 7, "materials/hl2cr/skill_healing_mk1.jpg", "Heal Recharge", 125, 150)
local recharge_medic_mk3 = CreateSkill("Heal Recharge III", "Medkit recharges faster", "Medic", 8, "materials/hl2cr/skill_healing_mk1.jpg", "Heal Recharge II", 225, 150)

local efficient_repairman_mk1 = CreateSkill("Repair Efficiency", "Repair armor more effectively", "Repair", 7, "materials/hl2cr/skill_healing_mk1.jpg", "", 25, 150)
local efficient_repairman_mk2 = CreateSkill("Repair Efficiency II", "Repair armor more effectively", "Repair", 8, "materials/hl2cr/skill_healing_mk1.jpg", "Repair Efficiency", 125, 150)
local efficient_repairman_mk3 = CreateSkill("Repair Efficiency III", "Repair armor more effectively", "Repair", 10, "materials/hl2cr/skill_healing_mk1.jpg", "Repair Efficiency II", 225, 150)

local recharge_repairman_mk1 = CreateSkill("Repair Recharge", "Repair Kit recharges faster", "Repair", 7, "materials/hl2cr/skill_recharge_mk1.jpg", "", 25, 150)
local recharge_repairman_mk2 = CreateSkill("Repair Recharge II", "Repair Kit recharges faster", "Repair", 8, "materials/hl2cr/skill_recharge_mk2.jpg", "Repair Recharge", 125, 150)
local recharge_repairman_mk3 = CreateSkill("Repair Recharge III", "Repair Kit recharges faster", "Repair", 10, "materials/hl2cr/skill_recharge_mk3.jpg", "Repair Recharge II", 225, 150)

local access_drone_mechanic = CreateSkill("Controllable Drone", "A drone you can control\nwith a built-in gun", "Mechanic", 11, "materials/hl2cr/skill_drone.jpg", "", 25, 150)



table.insert(GM.PlayerSkills, passive_health_mk1)
table.insert(GM.PlayerSkills, passive_health_mk2)
table.insert(GM.PlayerSkills, passive_health_mk3)

table.insert(GM.PlayerSkills, efficient_medic_mk1)
table.insert(GM.PlayerSkills, efficient_medic_mk2)
table.insert(GM.PlayerSkills, efficient_medic_mk3)
table.insert(GM.PlayerSkills, recharge_medic_mk1)
table.insert(GM.PlayerSkills, recharge_medic_mk2)
table.insert(GM.PlayerSkills, recharge_medic_mk3)

table.insert(GM.PlayerSkills, efficient_repairman_mk1)
table.insert(GM.PlayerSkills, efficient_repairman_mk2)
table.insert(GM.PlayerSkills, efficient_repairman_mk3)
table.insert(GM.PlayerSkills, recharge_repairman_mk1)
table.insert(GM.PlayerSkills, recharge_repairman_mk2)
table.insert(GM.PlayerSkills, recharge_repairman_mk3)

table.insert(GM.PlayerSkills, access_drone_mechanic)


if SERVER then
	net.Receive("HL2CR_SkillObtain", function(len, ply)
		if not ply then return end
		
		local skillToAdd = net.ReadString()
		
		for i, v in ipairs(GAMEMODE.PlayerSkills) do
			if v.Name == skillToAdd then
				
				table.insert(ply.hl2cr.Skills, v.Name)
				
				ply:SetNWString("stat_curskills", table.concat(ply.hl2cr.Skills, " "))
				
				ply.hl2cr.SkillPoints = ply.hl2cr.SkillPoints - 1
				ply:SetNWInt("stat_skillpoints", ply.hl2cr.SkillPoints)
			end
		end	
	end)
end