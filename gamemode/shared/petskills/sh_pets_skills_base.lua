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
	local SKILLS_TBL = {
		["npc_hl2cr_pet_headcrab"] = {
		
			["Health Boost"] = function(ply)
				ply.hl2cr.Pets.CurrentPet["stats"]["health"] = ply.hl2cr.Pets.CurrentPet["stats"]["health"] + 25
			end,
			
			["Health Boost II"] = function(ply)
				ply.hl2cr.Pets.CurrentPet["stats"]["health"] = ply.hl2cr.Pets.CurrentPet["stats"]["health"] + 50
			end,
			
			["Strength Buff"] = function(ply)
				ply.hl2cr.Pets.CurrentPet["stats"]["damage"] = ply.hl2cr.Pets.CurrentPet["stats"]["damage"] + 5
			end,
			
			["Agility Increase"] = function(ply)
				ply.hl2cr.Pets.CurrentPet["stats"]["speed"] = ply.hl2cr.Pets.CurrentPet["stats"]["speed"] + 15
			end,
			
			["Strength Buff II"] = function(ply)
				ply.hl2cr.Pets.CurrentPet["stats"]["damage"] = ply.hl2cr.Pets.CurrentPet["stats"]["damage"] + 5
			end,
			
			["Genetic Evolution"] = function(ply)
				--TODO: evolve in a better pet
			end,
		},
		
		["npc_hl2cr_pet_fastheadcrab"] = {
			["Agility Increase"] = function(ply)
				ply.hl2cr.Pets.CurrentPet["stats"]["speed"] = ply.hl2cr.Pets.CurrentPet["stats"]["speed"] + 7
			end,
			
			["Agility Increase II"] = function(ply)
				ply.hl2cr.Pets.CurrentPet["stats"]["speed"] = ply.hl2cr.Pets.CurrentPet["stats"]["speed"] + 10
			end,
			
			["Health Boost"] = function(ply)
				ply.hl2cr.Pets.CurrentPet["stats"]["health"] = ply.hl2cr.Pets.CurrentPet["stats"]["health"] + 25
			end,
			
			["Strength Buff"] = function(ply)
				ply.hl2cr.Pets.CurrentPet["stats"]["speed"] = ply.hl2cr.Pets.CurrentPet["stats"]["speed"] + 5
			end,
			
			["Health Boost II"] = function(ply)
				ply.hl2cr.Pets.CurrentPet["stats"]["health"] = ply.hl2cr.Pets.CurrentPet["stats"]["health"] + 25
			end,
			
			["Genetic Evolution"] = function(ply)
				--TODO: evolve in a better pet
			end,
		},
	}	
	
	local function UpdatePetSkills(ply)
		for _, skill in ipairs(ply.hl2cr.Pets.CurrentPet["curSkills"]) do
			if SKILLS_TBL[ply.hl2cr.Pets.CurrentPet.class][skill] then
				SKILLS_TBL[ply.hl2cr.Pets.CurrentPet.class][skill](pet)
			end
		end
	end
	
	net.Receive("HL2CR_UpdatePetSkill", function(len, ply)
		if not ply then return end
	
		local skillToAdd = net.ReadString()

		for i, v in ipairs(GAMEMODE.PlayerPetSkills) do
			if v.Name == skillToAdd then 
				if table.HasValue(ply.hl2cr.Pets.CurrentPet["curSkills"], skillToAdd) then return end
				
				table.insert(ply.hl2cr.Pets.CurrentPet["curSkills"], skillToAdd)
				
				ply.hl2cr.Pets.CurrentPet["skillpoints"] = ply.hl2cr.Pets.CurrentPet["skillpoints"] - 1
				
				UpdatePetSkills(ply)
			end
		end
	end)
end