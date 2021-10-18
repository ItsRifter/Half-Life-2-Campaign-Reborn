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
	pet:SetCustomCollisionCheck( true )
	
	pet:AddFlags( FL_OBJECT )
	
	local petstats = {
		["speed"] = 30 + (ply.hl2cr.Pets.CurrentPet["baseSpeed"] or 0),
		["damage"] = 5 + (ply.hl2cr.Pets.CurrentPet["baseDMG"] or 0),
	}
	
	pet:SetUpStats(petstats)
	
	ply:SetNWInt("pet_level", ply.hl2cr.Pets.CurrentPet["level"])
	ply:SetNWInt("pet_curxp", ply.hl2cr.Pets.CurrentPet["xp"])
	ply:SetNWInt("pet_curreqxp", ply.hl2cr.Pets.CurrentPet["reqxp"])
	
	ply:SetNWInt("pet_skillpoints", ply.hl2cr.Pets.CurrentPet["skillpoints"])
	
	ply:SetNWInt("pet_health", pet:Health())
	ply:SetNWInt("pet_maxhealth", pet:Health())
	
	ply.pet = pet
	ply.spawnCooldown = 5 + CurTime()
	
	net.Start("HL2CR_SpawnPet")
		net.WriteBool(true)
	net.Send(ply)
	
end

function RemovePet(ply)
	net.Start("HL2CR_SpawnPet")
		net.WriteBool(false)
	net.Send(ply)
	
	ply.spawnCooldown = 5 + CurTime()
	ply.pet:Remove()
	ply.pet = nil
	
	
end