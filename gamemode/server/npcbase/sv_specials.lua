local hl2cr_npc = FindMetaTable( "Entity" )


HL2CR_Specials = {
	[1] = {
		Name = "Ice",
		OnSpawn = function (npc)
			npc:SetColor( Color(130, 160, 255, 255) )
		end,
		OnHitPlayer = function (npc,ply)
			--print(ply)
			--ply:SetWalkSpeed(100)
			ply:SetWalkSpeed(100)
			ply:SetRunSpeed(100)
			if timer.Exists( ply:EntIndex().."_icetime" ) then timer.Remove( ply:EntIndex().."_icetime" ) end	
			timer.Create( ply:EntIndex().."_icetime", 3, 1, function() 
				if !MAPS_NO_SUIT[game.GetMap()] and IsValid(ply) and ply:Team() == TEAM_ALIVE then
					ply:SetWalkSpeed(200)
					ply:SetRunSpeed(350)
				end
			end )
		end,
		OnHit = function (npc,ply)
		
		end,
		OnDeath = function (npc)
		
		end,
	
	}



}

function hl2cr_npc:OnSpawn()
	if self.Special then self.Special.OnSpawn(self) end
end

function hl2cr_npc:OnHitPlayer(ply)
	if self.Special then self.Special.OnHitPlayer(self,ply) end
end

hook.Add("OnEntityCreated", "HL2CR_OnNPCCreation2", function(ent)
	if ent:IsNPC() then
        if ent:IsHostile() then
			--print("rolling for special")
			if math.random() + HL2CR_GetDiff() * 0.04 >= 1 then
				ent.Special = HL2CR_Specials[1]
				
				timer.Simple(0.2, function()
					ent:OnSpawn()
				end)
			end
        end
    end
end)