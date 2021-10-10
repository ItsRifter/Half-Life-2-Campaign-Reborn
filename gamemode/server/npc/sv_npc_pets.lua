function SpawnPet(ply)
	local tr = util.TraceHull( {
		start = ply:GetShootPos(),
		endpos = ply:GetShootPos() + ( ply:GetAimVector() * 150 ),
		filter = ply,		
	} )
	print(ply.hl2cr.Pets.CurrentPet["class"])

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
	
	ply.pet = pet
	ply.spawnCooldown = 5 + CurTime()
	
end

function RemovePet(ply)
	ply.spawnCooldown = 5 + CurTime()
	ply.pet:Remove()
	ply.pet = nil
end