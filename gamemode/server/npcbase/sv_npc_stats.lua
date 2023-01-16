local hl2cr_npc = FindMetaTable( "Entity" )

local npc_base_damage = {
	["npc_headcrab"] = {
		["minDMG"] = 1,
		["maxDMG"] = 5
	},

	["npc_zombie"] = {
		["minDMG"] = 5,
		["maxDMG"] = 10
	}
}

function hl2cr_npc:SetStatsTraits()	
	timer.Simple(0.15, function()
		if not self:IsValid() then return end
		if self:IsPet() then return end

		local newHealth = self:Health() * math.abs(1 + ( (HL2CR_GetDiff() - 1) * 0.25) ) 
		self:SetMaxHealth(newHealth)
		self:SetHealth(newHealth)

		if npc_base_damage[self:GetClass()] then
			self.Damage = math.random(npc_base_damage[self:GetClass()].minDMG, npc_base_damage[self:GetClass()].maxDMG) * HL2CR_GetDiff()
		end
	end)
end

function hl2cr_npc:GetCustomDamage()
	return self.Damage
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