local hl2cr_npc = FindMetaTable( "Entity" )


HL2CR_Specials = {
	[1] = {
		Name = "Ice",
		OnSpawn = function (npc)
			npc:SetColor( Color(130, 160, 255, 255) )
		end,
		OnHitPlayer = function (npc,ply)
			ply:SetWalkSpeed(140 - HL2CR_GetDiff()*10)
			ply:SetRunSpeed(140 - HL2CR_GetDiff()*10)
			if timer.Exists( ply:EntIndex().."_icetime" ) then timer.Remove( ply:EntIndex().."_icetime" ) end	
			timer.Create( ply:EntIndex().."_icetime", 1 + HL2CR_GetDiff() * 0.5, 1, function() 
				if IsValid(ply) and ply:Team() == TEAM_ALIVE then
					ply:SetWalkSpeed(200)
					ply:SetRunSpeed(350)
				end
			end )
		end,
		OnHit = function (npc,ent)
		
		end,
		OnDeath = function (npc,ply)
		
		end,
	
	},

	[2] = {
		Name = "Fire",
		OnSpawn = function (npc)
			npc:SetColor( Color(255, 160, 130, 255) )
		end,
		OnHitPlayer = function (npc,ply)
			ply:Ignite( 0.7 + HL2CR_GetDiff() * 0.3,  0 )
			if timer.Exists( ply:EntIndex().."_firetime" ) then timer.Remove( ply:EntIndex().."_firetime" ) end	
			timer.Create( ply:EntIndex().."_firetime", 0.7 + HL2CR_GetDiff() * 0.3, 1, function() 
				if IsValid(ply) and ply:Team() == TEAM_ALIVE then
					ply:Extinguish()
				end
			end )
		end,
		OnHit = function (npc,ent)
		
		end,
		OnDeath = function (npc,ply)
		
		end,
	
	},
	
	
	[9] = {
		Name = "Medic",
		OnSpawn = function (npc)
			npc:SetColor( Color(160, 255, 160, 255) )
			timer.Create( npc:EntIndex().."_healtime", 2, -1, function() 
				if IsValid(npc) and npc:Health() > 0 then
					local search = ents.FindInSphere( npc:GetPos()+Vector(0,0,16), 256)
					local heal = 3 + HL2CR_GetDiff()
					for _, s in ipairs(search) do
						if !s:IsHostile() or s:Health() <=0 then continue end
						if s:Health() < s:GetMaxHealth() then
							xx, yy, zz = s:OBBMaxs():Unpack()
							
							s:SetHealth(math.min(s:Health() + heal,s:GetMaxHealth()))
							NotificationRadius("+"..heal,s:GetPos()+Vector(0,0,zz),2,1,512)
						end
					end
				else
					timer.Remove( npc:EntIndex().."_healtime" ) 
				end
			end )
		end,
		OnHitPlayer = function (npc,ply)
		
		end,
		OnHit = function (npc,ent)
		
		end,
		OnDeath = function (npc,ply)
		
		end,
	
	},
	[10] = {
		Name = "Camo",
		OnSpawn = function (npc)
			npc:SetMaterial( "models/effects/vol_light001" )
			npc:SetColor( Color(120, 120, 120, 255) )
			local weap = npc:GetWeapons()[1]
			if IsValid(weap) then weap:SetMaterial( "models/effects/vol_light001" ) end
		end,
		OnHitPlayer = function (npc,ply)

		end,
		OnHit = function (npc,ent)
			npc:SetMaterial("")
			local weap = npc:GetWeapons()[1]
			if IsValid(weap) then weap:SetMaterial( "" ) end
			if timer.Exists( npc:EntIndex().."_ghosttime" ) then timer.Remove( npc:EntIndex().."_ghosttime"  ) end	
			timer.Create( npc:EntIndex().."_ghosttime" , 1.7 - (HL2CR_GetDiff()*0.2), 1, function() 
				if IsValid(npc) then
					npc:SetMaterial( "models/effects/vol_light001" )
					if IsValid(weap) then weap:SetMaterial( "models/effects/vol_light001" ) end
				end
				
			end )
		end,
		OnDeath = function (npc,ply)
		
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

function hl2cr_npc:OnHit(ent)
	if self.Special then self.Special.OnHit(self,ent) end
end

function hl2cr_npc:OnDeath(ply)
	if self.Special then 
		self.Special.OnHit(self,ply) 
		ply:ProgressAchievement("HL2CR","HL2CR_SPECIAL",1) 
	end
end

local function RollType()	--To do, make a better roll weight system but for now its just for experimenting
	local value = math.random() * 100
	if value > 90 then return 9 end
	if value > 70 then return 10 end
	if value > 35 then return 2 end
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