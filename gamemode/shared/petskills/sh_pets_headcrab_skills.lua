AddCSLuaFile()

local health_1 = CreatePetSkill("Health Boost", 
	"Your pet can live\nfor longer\n+25HP", 
	"npc_hl2cr_pet_headcrab", nil, 
	"materials/hl2cr/skill_pet_health.jpg", 
	50, 100
)

local health_2 = CreatePetSkill("Health Boost II", 
	"Your pet can live\nfor longer\n+25HP", 
	"npc_hl2cr_pet_headcrab", "Health Boost", 
	"materials/hl2cr/skill_pet_health.jpg", 
	150, 100
)