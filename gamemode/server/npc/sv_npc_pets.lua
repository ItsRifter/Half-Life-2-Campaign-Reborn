local stats = {
	["health"] = 0,
	["speed"] = 0,
	["damage"] = 0
}

local PET_SKILLS_APPLY = {
	["Health Boost"] = 25,
	["Health Boost II"] = 25,
}

local function SetUpPetSkills(ply)
	stats.health = ply.hl2cr.Pets.CurrentPet["stats"]["health"]
	stats.speed = ply.hl2cr.Pets.CurrentPet["stats"]["speed"]
	stats.damage = ply.hl2cr.Pets.CurrentPet["stats"]["damage"]
	
	for i, s in ipairs(ply.hl2cr.Pets.CurrentPet["skills"]) do		
		if string.find(s, "Health") then
			stats.health = stats.health + PET_SKILLS_APPLY[s]
		end
	end
end

function SpawnPet(ply)
	
	local tr = util.TraceHull( {
		start = ply:GetShootPos(),
		endpos = ply:GetShootPos() + ( ply:GetAimVector() * 150 ),
		filter = ply,		
	} )

	local pet = ents.Create(ply.hl2cr.Pets.CurrentPet["class"])
	pet:SetPos(tr.HitPos)
	pet:Spawn()
	pet:SetOwner(ply)
	
	SetUpPetSkills(ply)
	
	pet:SetUpStats(stats)
	
	ply:SetNWInt("pet_level", ply.hl2cr.Pets.CurrentPet["level"])
	ply:SetNWInt("pet_curxp", ply.hl2cr.Pets.CurrentPet["xp"])
	ply:SetNWInt("pet_curreqxp", ply.hl2cr.Pets.CurrentPet["reqxp"])
	
	ply:SetNWInt("pet_skillpoints", ply.hl2cr.Pets.CurrentPet["skillpoints"])
	
	ply:SetNWInt("pet_health", finalPetHP)
	ply:SetNWInt("pet_maxhealth", finalPetHP)
	
	ply.pet = pet
	ply.petcool = 5 + CurTime()
	
	net.Start("HL2CR_SpawnPet")
		net.WriteBool(true)
	net.Send(ply)
	
end

function RemovePet(ply)
	net.Start("HL2CR_SpawnPet")
		net.WriteBool(false)
	net.Send(ply)
	
	ply.petcool = 5 + CurTime()
	ply.pet:Remove()
	ply.pet = nil
	
end