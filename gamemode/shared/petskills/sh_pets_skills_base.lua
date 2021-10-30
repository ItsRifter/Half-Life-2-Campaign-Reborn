AddCSLuaFile()

GM.PlayerPetSkills = {}

function CreatePetSkill(name, desc, class, skillNeeded, icon, xPos, yPos)
	
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
	
	table.insert(GM.PlayerPetSkills, petSkill)
end

if SERVER then
	net.Receive("HL2CR_UpdatePetSkill", function(len, ply)
		if not ply then return end
	
		local skillToAdd = net.ReadString()
		
		for i, v in ipairs(GAMEMODE.PlayerPetSkills) do
			if v.Name == skillToAdd then 
				
				print("Yay")
				print(skillToAdd)
			end
		end
	end)
end