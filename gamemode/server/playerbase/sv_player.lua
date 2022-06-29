local hl2cr_player = FindMetaTable( "Player" )

--Weapons/Items that the map start with upon player connected
SPAWNING_WEAPONS = SPAWNING_WEAPONS or {}
SPAWNING_ITEMS = SPAWNING_ITEMS or {}

--Restrict these weapons from being picked up/used
RESTRICTED_WEAPONS = {
	["weapon_physgun"] = true,
}

function GM:ShowHelp(ply)
	//Used for debugging for now
end

function GM:PlayerShouldTakeDamage( ply, attacker )
	if attacker:IsPlayer() then
		return false
	end

	return true
end

function hl2cr_player:SetUpPlayer()
	self:SetupHands(self)
	self:SetTeam(TEAM_ALIVE)

	self:SetCustomCollisionCheck(true)
	self:SetNoCollideWithTeammates(true)

	if self.hl2cr.ModelType["Type"] == "citizen" then
		if self.hl2cr.ModelType["Gender"] == "male" then
			self:SetModel(CitizenModels["Male"][math.random(1, #CitizenModels["Male"])])
		else
			self:SetModel(CitizenModels["Female"][math.random(1, #CitizenModels["Female"])])
		end
	end
end

function hl2cr_player:SetUpInitialSpawn()
    self:SetUpPlayer()
	self:GiveWeaponsSpawn()
end

function hl2cr_player:SetUpRespawn()
    self:SetUpPlayer()
	self:GiveWeaponsSpawn()
end

function hl2cr_player:SetStats()

end

function hl2cr_player:GiveWeaponsSpawn()
	for _, weapon in ipairs(SPAWNING_WEAPONS) do
		self:Give(weapon)
	end
end

--Force the spawnpoint to be suitable making players not spawn into eachother
function GM:IsSpawnpointSuitable(ply, spawnpoint, makeSuitable)
	return true
end

--Stores the weapons for player joining or respawning
local function StoreWeapons(newWeapon)
	--If the item is already in the table or is a restricted weapon, do nothing
	if table.HasValue(SPAWNING_WEAPONS, newWeapon) then
		return
	--Else update it with new weapon
	else
		table.insert(SPAWNING_WEAPONS, newWeapon)
	end

	--Give all players the new weapon that don't have it
	for k, p in pairs(player.GetAll()) do
		if p:Team() == TEAM_AFK or p:Team() == TEAM_COMPLETED_MAP or p:HasWeapon(newWeapon) then continue end
		
		p:Give(newWeapon)
		
		if game.GetMap() == "d1_trainstation_06" and newWeapon == "weapon_crowbar" then
			//GrantAchievement(p, "HL2", "Trusty_Hardware")
		end
	end
end

function BroadcastMessageToAll(...)
	net.Start("HL2CR_ChatMessage")
		net.WriteTable({...})
	net.Broadcast()
end

function BroadcastSoundToAll(soundPath)
	net.Start("HL2CR_MsgSound")
		net.WriteString(soundPath)
	net.Broadcast()
end

function hl2cr_player:BroadcastMessage(...)
	net.Start("HL2CR_ChatMessage")
		net.WriteTable({...})
	net.Send(self)
end

function hl2cr_player:BroadcastSound(soundPath)
	net.Start("HL2CR_MsgSound")
		net.WriteString(soundPath)
	net.Send(self)
end


--Bullet Ignoring player code collision so players can't block bullets
hook.Add("EntityFireBullets", "HL2CR_NoBulletPlayer", function(ent, data)
	if ent:IsNPC() then return true end 

	if ent:IsPlayer() then
		local tr = util.TraceHull( {
			start = ent:GetShootPos(),
			endpos = ent:GetShootPos() + ( ent:GetAimVector() * 2500 ),
			filter = ent,
			mask = MASK_SHOT_HULL
		} )
		
		if tr.Entity:IsPlayer() then
			data.IgnoreEntity = tr.Entity
		end
	end
	
	return true
end)

hook.Add("PlayerCanPickupWeapon", "HL2CR_WeaponPickup", function(ply, weapon)
	if ply:Team() ~= TEAM_ALIVE then return end
	
	if weapon:GetClass() == "weapon_physgun" and not ply:IsAdmin() then
		return false
	end
	
	--Store the weapon
	if weapon:IsValid() then
		StoreWeapons(weapon:GetClass())
	end
	
	return true
end)

hook.Add("PlayerInitialSpawn", "HL2CR_InitialPlayerSpawn", function(ply, transition)
    ply:SetUpInitialSpawn()
end)

--Player spawning
hook.Add("PlayerSpawn", "HL2CR_PlayerSpawn", function(ply)
    ply:SetUpRespawn()
end)

--If on the trainstation maps, do not allow players to use their flashlight else allow them
hook.Add("PlayerSwitchFlashlight", "HL2CR_CanUseFlashlight", function(ply, enabled)
	if MAPS_NO_SUIT[game.GetMap()] then
		return false
    elseif game.GetMap() == "d1_trainstation_05" and not GetGlobalBool("HL2CR_GLOBAL_SUIT") then
        return false
    end

	return true
end)

hook.Add("PlayerCanPickupItem", "HL2CR_ItemAmmoPickup", function(ply, item)
	if item:GetClass() == "item_suit" then
		SetGlobalBool( "HL2CR_GLOBAL_SUIT", true )
	end
end)