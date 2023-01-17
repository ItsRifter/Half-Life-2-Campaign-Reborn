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
				if IsValid(ply) and ply:Team() == TEAM_ALIVE then
					ply:SetWalkSpeed(200)
					ply:SetRunSpeed(350)
				end
			end )
		end,
		OnHit = function (npc,ply)
		
		end,
		OnDeath = function (npc)
		
		end,
	
	},

	[2] = {
		Name = "Fire",
		OnSpawn = function (npc)
			npc:SetColor( Color(255, 160, 130, 255) )
		end,
		OnHitPlayer = function (npc,ply)
			ply:Ignite( 2,  0 )
			if timer.Exists( ply:EntIndex().."_firetime" ) then timer.Remove( ply:EntIndex().."_firetime" ) end	
			timer.Create( ply:EntIndex().."_firetime", 2, 1, function() 
				if IsValid(ply) and ply:Team() == TEAM_ALIVE then
					ply:Extinguish()
				end
			end )
		end,
		OnHit = function (npc,ply)
		
		end,
		OnDeath = function (npc)
		
		end,
	
	},
	
	[10] = {
		Name = "Camo",
		OnSpawn = function (npc)
			npc:SetMaterial( "models/effects/vol_light001" )
			local weap = npc:GetWeapons()[1]
			if IsValid(weap) then weap:SetMaterial( "models/effects/vol_light001" ) end
		end,
		OnHitPlayer = function (npc,ply)

		end,
		OnHit = function (npc,ply)
			npc:SetMaterial("")
			local weap = npc:GetWeapons()[1]
			if IsValid(weap) then weap:SetMaterial( "" ) end
			if timer.Exists( npc:EntIndex().."_ghosttime" ) then timer.Remove( npc:EntIndex().."_ghosttime"  ) end	
			timer.Create( npc:EntIndex().."_ghosttime" , 1.5, 1, function() 
				if IsValid(npc) then
					npc:SetMaterial( "models/effects/vol_light001" )
					if IsValid(weap) then weap:SetMaterial( "models/effects/vol_light001" ) end
				end
				
			end )
		end,
		OnDeath = function (npc)
		
		end,
	
	}
}

function hl2cr_npc:OnSpawn()
	if self.Special then self.Special.OnSpawn(self) end
end

function hl2cr_npc:OnHitPlayer(ply)
	if MAPS_NO_SUIT[game.GetMap()] or (game.GetMap() == "d1_trainstation_05" and GetGlobalBool("HL2CR_GLOBAL_SUIT") == false) then return end 
	if self.Special then self.Special.OnHitPlayer(self,ply) end
end

function hl2cr_npc:OnHit(ply)
	if self.Special then self.Special.OnHit(self,ply) end
end

local function RollType()	--To do, make a better roll weight system but for now its just for experimenting
	local value = math.random() * 100
	if value > 80 then return 10 end
	if value > 50 then return 2 end
	return 1
end



hook.Add("OnEntityCreated", "HL2CR_OnNPCCreation2", function(ent)
	if ent:IsNPC() then
		timer.Simple(0.2, function()
        if ent:IsHostile() and !ent:IsPet() then
			--print("rolling for special")
			if math.random() + (HL2CR_GetDiff()+1) * 0.04 >= 1 then
				ent.Special = HL2CR_Specials[RollType()]
				
				--timer.Simple(0.2, function()
					ent:OnSpawn()
				--end)
			end
        end
		end)
    end
end)