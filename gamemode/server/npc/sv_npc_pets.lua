function SpawnPet(ply)
	local tr = util.TraceHull( {
		start = ply:GetShootPos(),
		endpos = ply:GetShootPos() + ( ply:GetAimVector() * 150 ),
		filter = ply,		
	} )

	local pet = ents.Create(ply.hl2cr.Pets.CurrentPet["class"])
	pet:SetPos(tr.HitPos)
	pet:SetAngles(ply:GetAngles())
	pet:Spawn()
	pet:SetOwner(ply)

	ply:SetNWEntity("hl2cr_pet", pet)

	pet:SetUpStats(ply.hl2cr.Pets.CurrentPet["stats"])
	
	ply:SetNWInt("pet_level", ply.hl2cr.Pets.CurrentPet["level"])
	ply:SetNWInt("pet_curxp", ply.hl2cr.Pets.CurrentPet["xp"])
	ply:SetNWInt("pet_curreqxp", ply.hl2cr.Pets.CurrentPet["reqxp"])
	
	ply:SetNWInt("pet_skillpoints", ply.hl2cr.Pets.CurrentPet["skillpoints"])
	
	ply.pet = pet
	ply.petcool = 5 + CurTime()
	
	timer.Simple(0.1, function()
		net.Start("HL2CR_SpawnPet")
			net.WriteBool(true)
		net.Send(ply)
	end)
end

function RemovePet(ply)
	ply:SetNWEntity("hl2cr_pet", nil)
	
	net.Start("HL2CR_SpawnPet")
		net.WriteBool(false)
	net.Send(ply)
	
	ply.petcool = 5 + CurTime()
	ply.pet:Remove()
	ply.pet = nil
end