AddCSLuaFile()
--[[ SKILL TEMPLATES
	local health = CreatePetSkill("Health Boost", 
		"Your pet can live\nfor longer", 
		"npc_vj_hl2cr_torsozombie", nil, 
		"materials/hl2cr/skill_pet_health.jpg", 
		0, 0
	)

	local dmg = CreatePetSkill("Strength Buff", 
		"Your pet deals more\ndamage to opponents", 
		"npc_vj_hl2cr_torsozombie", nil, 
		"materials/hl2cr/skill_pet_dmg.jpg", 
		0, 0
	)

	local speed = CreatePetSkill("Agility Increase", 
		"Your pet can move\nand attack faster", 
		"npc_vj_hl2cr_torsozombie", nil, 
		"materials/hl2cr/skill_pet_speed.jpg", 
		0, 0
	)

	local genEvo = CreatePetSkill("Genetic Evolution", 
		"Mutate your pet into\nsomething better", 
		"npc_vj_hl2cr_torsozombie", nil, 
		"materials/hl2cr/skill_pet_genetics.jpg", 
		0, 0
	)
--]]

CreatePetSkill("Strength Buff", 
	"Your pet deals more\ndamage to opponents", 
	"npc_vj_hl2cr_torsozombie", nil, 
	"materials/hl2cr/skill_pet_dmg.jpg", 
	50, 100
)

CreatePetSkill("Strength Buff II", 
	"Your pet deals more\ndamage to opponents", 
	"npc_vj_hl2cr_torsozombie", "Strength Buff", 
	"materials/hl2cr/skill_pet_dmg.jpg", 
	125, 100
)

CreatePetSkill("Agility Increase", 
	"Your pet can move\nand attack faster", 
	"npc_vj_hl2cr_torsozombie", "Strength Buff II", 
	"materials/hl2cr/skill_pet_speed.jpg", 
	200, 100
)

CreatePetSkill("Health Boost", 
	"Your pet can live\nfor longer", 
	"npc_vj_hl2cr_torsozombie", "Agility Increase", 
	"materials/hl2cr/skill_pet_health.jpg", 
	275, 100
)


CreatePetSkill("Strength Buff III", 
	"Your pet deals more\ndamage to opponents", 
	"npc_vj_hl2cr_torsozombie", "Health Boost", 
	"materials/hl2cr/skill_pet_dmg.jpg", 
	350, 100
)

CreatePetSkill("Health Boost II", 
	"Your pet can live\nfor longer", 
	"npc_vj_hl2cr_torsozombie", "Strength Buff III", 
	"materials/hl2cr/skill_pet_health.jpg", 
	425, 100
)

CreatePetSkill("Health Boost III", 
	"Your pet can live\nfor longer", 
	"npc_vj_hl2cr_torsozombie", "Health Boost II", 
	"materials/hl2cr/skill_pet_health.jpg", 
	500, 100
)

CreatePetSkill("Genetic Evolution", 
	"Mutate your pet into\nsomething better", 
	"npc_vj_hl2cr_torsozombie", "Health Boost III", 
	"materials/hl2cr/skill_pet_genetics.jpg", 
	575, 100
)