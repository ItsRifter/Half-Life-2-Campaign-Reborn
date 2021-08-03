--Weapons that the map start with upon player connected
SPAWNING_WEAPONS = SPAWNING_WEAPONS or {}

--Restrict these weapons from being picked up/used
RESTRICTED_WEAPONS = {
	["weapon_physgun"] = true,
	["weapon_stunstick"] = true
}

--Weapons that shouldn't be given on player spawn
NO_SPAWNING_WEAPONS = {
	["weapon_frag"] = true,
	["weapon_medkit"] = true,
	["hlashotty"] = true
}

--Super gravity gun maps
SUPERGRAVGUN_MAPS = {
	["d3_citadel_03"] = true,
	["d3_citadel_04"] = true,
	["d3_citadel_05"] = true,
	["d3_breen_01"] = true
}

function GM:ShowHelp(ply)
	ShowMapResults(ply)
	--HL2CR_Voting:PlayerVote(ply, true)
end

function GM:ShowTeam(ply)
	HL2CR_Voting:PlayerVote(ply, false)
end

--If on the trainstation maps, do not allow players to use their flashlight else allow them
hook.Add("PlayerSwitchFlashlight", "HL2CR_DisableFlashlight", function(ply, enabled)
	if NOSUIT_MAPS[game.GetMap()] then
		return false
	elseif game.GetMap() == "d1_trainstation_05" and ents.FindByClass("item_suit")[1] then
		return false
	end
	
	return true
end)

hook.Add("PlayerInitialSpawn", "HL2CR_InitialPlayerSpawn", function(ply, transition)
	ply.Rewards = {
		["kills"] = 0,
		["stats"] = {
			["level"] = ply.hl2cr.Level,
			["exp"] = ply.hl2cr.Exp,
			["expReq"] = ply.hl2cr.ReqExp
		},
		["items"] = {},
		["achs"] = {},
	}
end)

--Player spawning
hook.Add("PlayerSpawn", "HL2CR_PlayerSpawn", function(ply)
	ply:SetModel(ply.hl2cr.Model)
	ply:SetupHands()
	ply:SetTeam(TEAM_ALIVE)
	
	ply:SetCustomCollisionCheck(true)
	ply:SetNoCollideWithTeammates(true)
	
	if MAPS_LOBBY[game.GetMap()] and ply:IsAdmin() then	
		ply:Give("weapon_physgun")
	end
	
	for k, wep in pairs(SPAWNING_WEAPONS) do
		ply:Give(wep)
	end
	
	if NOSUIT_MAPS[game.GetMap()] then
		ply:SetWalkSpeed(125)
		ply:SetRunSpeed(200)
	elseif game.GetMap() == "d1_trainstation_05" and ents.FindByClass("item_suit")[1] then
		ply:SetWalkSpeed(100)
		ply:SetRunSpeed(200)
	end
end)

--Stores the weapons for player joining or respawning
function StoreWeapons(newWeapon)
	--If the item is already in the table or is a restricted weapon, do nothing
	if table.HasValue(SPAWNING_WEAPONS, newWeapon) or NO_SPAWNING_WEAPONS[newWeapon] then 
		return
	--Else update it with new weapon
	else
		table.insert(SPAWNING_WEAPONS, newWeapon)
	end
	--Give all players the new weapon that don't have it
	for k, p in pairs(player.GetAll()) do
		if p:Team() == TEAM_AFK or p:Team() == TEAM_COMPLETED_MAP or p:HasWeapon(newWeapon) then break end
		p:Give(newWeapon)
		
		if game.GetMap() == "d1_trainstation_06" and newWeapon == "weapon_crowbar" then
			GrantAchievement(p, "HL2", "Trusty_Hardware")
		end
	end
end

--Bullet Ignoring player code collision so players can't block bullets
hook.Add("EntityFireBullets", "HL2CR_NoBulletPlayer", function(ent, data)
	if ent:IsNPC() then return end 
	for k, v in ipairs(player.GetAll()) do
		data.IgnoreEntity = v
	end
	
	return true
end)

function GM:PlayerCanPickupWeapon(ply, weapon)
	if weapon:GetClass() == "weapon_physgun" and ply:IsAdmin() then
		return true
	end
	
	--If its a restricted weapon, don't pick it up
	if RESTRICTED_WEAPONS[weapon:GetClass()] then 
		weapon:Remove()
		
		--If its a stunstick, give them armor
		if weapon:GetClass() == "weapon_stunstick" then
			
			ply:SetArmor(ply:Armor() + 5)
			
			if ply:Armor() > 100 then
				ply:SetArmor(100)
			end
		end
		
		return false
	end
	
	--if its on a map where super gravgun is enabled, (excluding the gravgun) remove and don't pick up
	if SUPERGRAVGUN_MAPS[game.GetMap()] and weapon:GetClass() ~= "weapon_physcannon" then weapon:Remove() return false end
	
	--Store the weapon
	if weapon:GetClass() then
		StoreWeapons(weapon:GetClass())
	end
	
	return true
end

--Force the spawnpoint to be suitable making players not spawn into eachother
function GM:IsSpawnpointSuitable(ply, spawnpoint, makeSuitable)
	return true
end

--Stores the weapons for player joining or respawning
function StoreWeapons(newWeapon)

	--If the item is already in the table or is a restricted weapon, do nothing
	if table.HasValue(SPAWNING_WEAPONS, newWeapon) or NO_SPAWNING_WEAPONS[newWeapon] then 
		return
	--Else update it with new weapon
	else
		table.insert(SPAWNING_WEAPONS, newWeapon)
	end
	--Give all players the new weapon that don't have it
	for k, p in pairs(player.GetAll()) do
		if p:Team() == TEAM_AFK or p:Team() == TEAM_COMPLETED_MAP or p:HasWeapon(newWeapon) then break end
		p:Give(newWeapon)
		
		if game.GetMap() == "d1_trainstation_06" and newWeapon == "weapon_crowbar" then
			GrantAchievement(p, "HL2", "Trusty_Hardware")
		end
	end
end

hook.Add("EntityTakeDamage", "HL2CR_PVPOff", function(ent, dmgInfo)
	local att = dmgInfo:GetAttacker()
	
	--If the attacker is a player (dead or alive) and attacker isn't the player themselves, return 0
	if ent:IsPlayer() and att:IsPlayer() and (att:Team() == TEAM_ALIVE or att:Team() == TEAM_DEAD) and ent:Team() == TEAM_ALIVE and ent ~= att then
		dmgInfo:SetDamage(0)
	end
	
	if att:IsNPC() and att:GetClass() == "npc_rollermine" and att:GetName("ball") then
		dmgInfo:SetDamage(0)
	end
	
	if ent:IsPlayer() and att:IsFriendly() then
		dmgInfo:SetDamage(0)
	end
end)

hook.Add("Tick", "HL2CR_AmmoLimiter", function()
	for k, p in ipairs(player.GetAll()) do
		if p:GetAmmoCount("357") > GetConVar("hl2cr_max_357"):GetInt() then		
			p:RemoveAmmo( p:GetAmmoCount("357") -GetConVar("hl2cr_max_357"):GetInt(), "357" )
		end

		if p:GetAmmoCount("AR2") > GetConVar("hl2cr_max_AR2"):GetInt() then		
			p:RemoveAmmo( p:GetAmmoCount("AR2") -GetConVar("hl2cr_max_AR2"):GetInt(), "AR2" )
		end

		if p:GetAmmoCount("AR2AltFire") > GetConVar("hl2cr_max_ar2_ball"):GetInt() then		
			p:RemoveAmmo( p:GetAmmoCount("AR2AltFire") -GetConVar("hl2cr_max_ar2_ball"):GetInt(), "AR2AltFire" )
		end

		if p:GetAmmoCount("Buckshot") > GetConVar("hl2cr_max_Buckshot"):GetInt() then		
			p:RemoveAmmo( p:GetAmmoCount("Buckshot") -GetConVar("hl2cr_max_Buckshot"):GetInt(), "Buckshot" )
		end

		if p:GetAmmoCount("XBowBolt") > GetConVar("hl2cr_max_crossbowbolt"):GetInt() then		
			p:RemoveAmmo( p:GetAmmoCount("XBowBolt") -GetConVar("hl2cr_max_crossbowbolt"):GetInt(), "XBowBolt" )
		end
		
		if p:GetAmmoCount("Grenade") > GetConVar("hl2cr_max_grenade"):GetInt() then		
			p:RemoveAmmo( p:GetAmmoCount("Grenade") -GetConVar("hl2cr_max_grenade"):GetInt(), "Grenade" )
		end
			if p:GetAmmoCount("slam") > GetConVar("hl2cr_max_slam"):GetInt() then		
			p:RemoveAmmo( p:GetAmmoCount("slam") -GetConVar("hl2cr_max_slam"):GetInt(), "slam" )
		end

		if p:GetAmmoCount("Pistol") > GetConVar("hl2cr_max_Pistol"):GetInt() then		
			p:RemoveAmmo( p:GetAmmoCount("Pistol") -GetConVar("hl2cr_max_Pistol"):GetInt(), "Pistol" )
		end

		if p:GetAmmoCount("RPG_Round") > GetConVar("hl2cr_max_RPG_Round"):GetInt() then		
			p:RemoveAmmo( p:GetAmmoCount("RPG_Round") -GetConVar("hl2cr_max_RPG_Round"):GetInt(), "RPG_Round" )
		end

		if p:GetAmmoCount("SMG1") > GetConVar("hl2cr_max_SMG1"):GetInt() then		
			p:RemoveAmmo( p:GetAmmoCount("SMG1") -GetConVar("hl2cr_max_SMG1"):GetInt(), "SMG1" )
		end

		if p:GetAmmoCount("SMG1_Grenade") > GetConVar("hl2cr_max_SMG1_Grenade"):GetInt() then		
			p:RemoveAmmo( p:GetAmmoCount("SMG1_Grenade") - GetConVar("hl2cr_max_SMG1_Grenade"):GetInt(), "SMG1_Grenade" )
		end
		
		if p:GetAmmoCount("Grenade") > GetConVar("hl2cr_max_frags"):GetInt() then
			p:RemoveAmmo( p:GetAmmoCount("Grenade") - GetConVar("hl2cr_max_frags"):GetInt(), "Grenade" )
		end
	end
end)

hook.Add("PlayerCanPickupItem", "HL2CR_AmmoPickup", function(ply, item)
	if (item:GetClass() == "item_ammo_357" or item:GetClass() == "item_ammo_357_large") and ply:GetAmmoCount("357") >= GetConVar("hl2cr_max_357"):GetInt() then
		ply:RemoveAmmo( ply:GetAmmoCount("357") -GetConVar("hl2cr_max_357"):GetInt(), "357" )
		return false
	end
	
	if (item:GetClass() == "item_ammo_ar2" or item:GetClass() == "item_ammo_ar2_large") and ply:GetAmmoCount("AR2") >= GetConVar("hl2cr_max_AR2"):GetInt() then		
		ply:RemoveAmmo( ply:GetAmmoCount("AR2") -GetConVar("hl2cr_max_AR2"):GetInt(), "AR2" )
		return false
	end
	
	if item:GetClass() == "item_ammo_ar2_altfire" and ply:GetAmmoCount("AR2AltFire") >= GetConVar("hl2cr_max_ar2_ball"):GetInt() then		
		ply:RemoveAmmo( ply:GetAmmoCount("AR2AltFire") -GetConVar("hl2cr_max_ar2_ball"):GetInt(), "AR2AltFire" )
		return false
	end
	
	if (item:GetClass() == "item_box_buckshot" or item:GetClass() == "item_ammo_buckshot_large") and ply:GetAmmoCount("Buckshot") >= GetConVar("hl2cr_max_Buckshot"):GetInt() then		
		ply:RemoveAmmo( ply:GetAmmoCount("Buckshot") -GetConVar("hl2cr_max_Buckshot"):GetInt(), "Buckshot" )
		return false
	end
	
	if item:GetClass() == "item_ammo_crossbow" and ply:GetAmmoCount("XBowBolt") >= GetConVar("hl2cr_max_crossbowbolt"):GetInt() then		
		ply:RemoveAmmo( ply:GetAmmoCount("XBowBolt") -GetConVar("hl2cr_max_crossbowbolt"):GetInt(), "XBowBolt" )
		return false
	end

	if item:GetClass() == "weapon_frag" and ply:GetAmmoCount("Grenade") >= GetConVar("hl2cr_max_grenade"):GetInt() then		
		ply:RemoveAmmo( ply:GetAmmoCount("Grenade") -GetConVar("hl2cr_max_grenade"):GetInt(), "Grenade" )
		return false
	end

	if item:GetClass() == "weapon_slam" and ply:GetAmmoCount("slam") >= GetConVar("hl2cr_max_slam"):GetInt() then		
		ply:RemoveAmmo( ply:GetAmmoCount("slam") -GetConVar("hl2cr_max_slam"):GetInt(), "slam" )
		return false
	end
	
	if (item:GetClass() == "item_ammo_pistol" or item:GetClass() == "item_ammo_pistol_large") and ply:GetAmmoCount("Pistol") >= GetConVar("hl2cr_max_Pistol"):GetInt() then		
		ply:RemoveAmmo( ply:GetAmmoCount("Pistol") -GetConVar("hl2cr_max_Pistol"):GetInt(), "Pistol" )
		return false
	end
	
	if item:GetClass() == "item_rpg_round" and ply:GetAmmoCount("RPG_Round") >= GetConVar("hl2cr_max_RPG_Round"):GetInt() then		
		ply:RemoveAmmo( ply:GetAmmoCount("RPG_Round") -GetConVar("hl2cr_max_RPG_Round"):GetInt(), "RPG_Round" )
		return false
	end
	
	if (item:GetClass() == "item_ammo_smg1" or item:GetClass() == "item_ammo_smg1_large") and ply:GetAmmoCount("SMG1") >= GetConVar("hl2cr_max_SMG1"):GetInt() then		
		ply:RemoveAmmo( ply:GetAmmoCount("SMG1") -GetConVar("hl2cr_max_SMG1"):GetInt(), "SMG1" )
		return false
	end
	
	if item:GetClass() == "item_ammo_smg1_grenade" and ply:GetAmmoCount("SMG1_Grenade") >= GetConVar("hl2cr_max_SMG1_Grenade"):GetInt() then		
		ply:RemoveAmmo( ply:GetAmmoCount("SMG1_Grenade") - GetConVar("hl2cr_max_SMG1_Grenade"):GetInt(), "SMG1_Grenade" )
		return false
	end

	if item:GetClass() == "item_suit" then
		for k, p in ipairs(player.GetAll()) do
			p:SetWalkSpeed(200)
			p:SetRunSpeed(350)
			if game.GetMap() == "d1_trainstation_05" then
				p:Give("admire_hands")
			end
		end
	end

	return true
end)