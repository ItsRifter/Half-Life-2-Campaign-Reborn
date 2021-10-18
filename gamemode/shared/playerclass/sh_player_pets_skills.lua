AddCSLuaFile()

GM.PlayerPetSkills = {}

local function CreatePetSkill(name, desc, class, skillNeeded, icon, xPos, yPos)
	
	local petSkill = {
		["Name"] = name,
		["Desc"] = desc,
		["Class"] = class,
		["SkillReq"] = skillNeeded,
		["Icon"] = icon,
		["Pos"] = {
			["x"] = xPos,
			["y"] = yPos,
		}
	}
	
	return petSkill
end

local pet_health = CreatePetSkill("Health Boost", "Your pet can live\nfor longer", "hl2cr_pet_headcrab", nil, "materials/hl2cr/skill_health.jpg", 50, 100)

table.insert(GM.PlayerPetSkills, pet_health)

if SERVER then
	net.Receive("HL2CR_UpdatePetSkill", function(len, ply)
		if not ply then return end
	
		local skillToAdd = net.ReadString()
	end)
end