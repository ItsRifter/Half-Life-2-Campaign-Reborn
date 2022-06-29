local hl2cr_npc = FindMetaTable( "Entity" )

function hl2cr_npc:SetStatsTraits()
	if GetConVar("hl2cr_difficulty"):GetInt() == 1 then
		self.level = math.random(1, 5)
	elseif GetConVar("hl2cr_difficulty"):GetInt() == 2 then
		self.level = math.random(6, 13)
	elseif GetConVar("hl2cr_difficulty"):GetInt() == 3 then
		self.level = math.random(14, 25)
	elseif GetConVar("hl2cr_difficulty"):GetInt() == 4 then
		self.level = math.random(26, 50)
	elseif GetConVar("hl2cr_difficulty"):GetInt() == 5 then
		self.level = math.random(51, 75)
	end
	
	self:SetNWInt("HL2CR_NPC_Level", self.level)

	timer.Simple(0.15, function()
		if not self:IsValid() then return end

		local newHealth = self:Health() + (self.level * 2)
		self:SetMaxHealth(newHealth)
		self:SetHealth(newHealth)

	end)
end

//Makes the npc not collide with players
function hl2cr_npc:FixCollisions()
    self:SetCustomCollisionCheck(true)
    self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
end

hook.Add("OnEntityCreated", "HL2CR_OnNPCCreation", function(ent)
	if ent:IsNPC() then
        if ent:IsHostile() then
            ent:SetStatsTraits()
        elseif FRIENDLY_HARMABLE_NPCS[ent:GetClass()] or (ent:GetClass() == "npc_vortigaunt" and not MAPS_VORT_HOSTILE[game.GetMap()]) then
            ent:FixCollisions()
        end
    end
end)