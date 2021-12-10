AddCSLuaFile()
--[[ SKILL TEMPLATES
	local health = CreatePetSkill("Health Boost", 
		"Your pet can live\nfor longer", 
		"npc_hl2cr_pet_headcrab", nil, 
		"materials/hl2cr/skill_pet_health.jpg", 
		50, 100
	)

	local dmg = CreatePetSkill("Strength Buff", 
		"Your pet deals more\ndamage to opponents", 
		"npc_hl2cr_pet_headcrab", nil, 
		"materials/hl2cr/skill_pet_dmg.jpg", 
		250, 100
	)

	local speed = CreatePetSkill("Agility Increase", 
		"Your pet can move\nand attack faster", 
		"npc_hl2cr_pet_headcrab", nil, 
		"materials/hl2cr/skill_pet_speed.jpg", 
		350, 100
	)

	local genEvo = CreatePetSkill("Genetic Evolution", 
		"Mutate your pet into\nsomething better", 
		"npc_hl2cr_pet_headcrab", nil, 
		"materials/hl2cr/skill_pet_genetics.jpg", 
		550, 100
	)
--]]

local speed_1 = CreatePetSkill("Agility Increase", 
	"Your pet can move\nand attack faster", 
	"npc_vj_hl2cr_fastheadcrab", nil, 
	"materials/hl2cr/skill_pet_speed.jpg", 
	50, 100
)

local speed_2 = CreatePetSkill("Agility Increase II", 
	"Your pet can move\nand attack faster", 
	"npc_vj_hl2cr_fastheadcrab", "Agility Increase", 
	"materials/hl2cr/skill_pet_speed.jpg", 
	150, 100
)

local health_1 = CreatePetSkill("Health Boost", 
	"Your pet can live\nfor longer", 
	"npc_vj_hl2cr_fastheadcrab", "Agility Increase II", 
	"materials/hl2cr/skill_pet_health.jpg", 
	250, 100
)

local dmg_1 = CreatePetSkill("Strength Buff", 
	"Your pet deals more\ndamage to opponents", 
	"npc_vj_hl2cr_fastheadcrab", "Health Boost", 
	"materials/hl2cr/skill_pet_dmg.jpg", 
	350, 100
)

local health_2 = CreatePetSkill("Health Boost II", 
	"Your pet can live\nfor longer", 
	"npc_vj_hl2cr_fastheadcrab", "Strength Buff", 
	"materials/hl2cr/skill_pet_health.jpg", 
	450, 100
)

local genEvo = CreatePetSkill("Genetic Evolution", 
	"Mutate your pet into\nsomething better", 
	"npc_vj_hl2cr_fastheadcrab", "Health Boost II", 
	"materials/hl2cr/skill_pet_genetics.jpg", 
	550, 100
)