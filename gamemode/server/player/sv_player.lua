--Weapons/Items that the map start with upon player connected
SPAWNING_WEAPONS = SPAWNING_WEAPONS or {}
SPAWNING_ITEMS = SPAWNING_ITEMS or {}

--Restrict these weapons from being picked up/used
RESTRICTED_WEAPONS = {
	["weapon_physgun"] = true,
}

--Weapons that shouldn't be given on player spawn
NO_SPAWNING_WEAPONS = {
	["weapon_frag"] = true,
	["weapon_medkit_hl2cr"] = true,
	["weapon_armorkit_hl2cr"] = true,
	["weapon_ammogiver"] = true,
	["weapon_controllable_manhack"] = true,
	["weapon_controllable_drone"] = true,
	["the_anti_rifle"] = true,
	["the_secret_carbine"] = true,
	["the_bfhmg"] = true,
	["the_fire_hazard"] = true,
	["bakkers_blaster"] = true,
	["the_lobotomizer"] = true,
	["weapon_stunstick"] = true,
	["the_swiss_hellbringer"] = true,
	["the_aerosol_ar"] = true,
	["the_multi_purpose_nailgun"] = true,
	["the_turbo_lover"] = true
}

--Takes the name in CurWeaponSlot into a entity weapon
local CONVERT_NAME_TO_ENT = {
	["Flare_gun"] = "the_fire_hazard",
	["Automatic_Pistol"] = "the_swiss_hellbringer",
	["Shredding_Assault_Rifle"] = "the_aerosol_ar",
	["Multi_Grenade_Launcher"] = "bakkers_blaster",
	["The_Nailer_Gun"] = "the_multi_purpose_nailgun",
	["Unstable_Electric_Shotgun"] = "the_turbo_lover",
	[".BMG_Heavy_Sniper"] = "the_anti_rifle",
}

--Super gravity gun maps
SUPERGRAVGUN_MAPS = {
	["d3_citadel_04"] = true,
	["d3_citadel_05"] = true
}

function GM:ShowHelp(ply)
	--StartCoop()
	HL2CR_Voting:PlayerVote(ply, true)
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

hook.Add("PlayerDeathThink", "HL2CR_PlayerDeathThink", function(ply)
	if ply.waitForRespawn and ply.waitForRespawn <= CurTime() and ply:Team() == TEAM_DEAD then
		DisableSpectate(ply)
		ply:Spawn()
	end
	return false
end)

local waitForRespawn = 0
local waitDeath = 0

hook.Add("PostPlayerDeath", "HL2CR_HandlePlayerDeath", function(victim)
	victim:SetTeam(TEAM_DEAD)
	victim.hl2cr.Deaths = victim.hl2cr.Deaths + 1
	victim:SetNWInt("stat_deaths", victim.hl2cr.Deaths)
	
	victim.rewards.bonus["No Deaths"] = false
	
	net.Start("HL2CR_ShouldClientSpectate")
		net.WriteBool(true)
		net.WriteBool(true)
		net.WriteInt(GetConVar("hl2cr_difficulty"):GetInt(), 8)
	net.Send(victim)
	
	victim.waitForRespawn = CurTime() + GetConVar("hl2cr_difficulty"):GetInt() * 10
	victim.waitDeath = CurTime() + 5
end)



hook.Add("Think", "HL2CR_DeathTick", function()
	for _, v in ipairs(player.GetAll()) do 
		
		if not v.waitDeath or v:Team() == TEAM_ALIVE then break end
		
		if v.waitDeath <= CurTime() and not v.IsSpectating then
			EnableSpectate(v)
		end
		
		if v.waitForRespawn and v.waitForRespawn <= CurTime() and v:Team() == TEAM_DEAD then
			DisableSpectate(v)
			v:Spawn()
		end
	end
end)

hook.Add("PlayerInitialSpawn", "HL2CR_InitialPlayerSpawn", function(ply, transition)
	
	ply.rewards = {
		["kills"] = 0,
		["resin"] = 0,
		["stats"] = {
			["exp"] = 0,
		},
		
		["bonus"] = {
			["No Deaths"] = true,
			["Crowbar Only"] = true,
			["Pacifist"] = true,
			["Teamplayer"] = false
		},
		
		["items"] = {},
		["achs"] = {},
	}
end)

--Applies the skill that the player has on spawn
local APPLY_SKILLS_HEALTH = {
	["Health Boost"] = 5,
	["Health Boost II"] = 10,
	["Health Boost III"] = 25
}

local APPLY_SKILLS_CLASS_MEDIC = {
	["Healing Efficiency"] = 10,
	["Healing Efficiency II"] = 20,
	["Healing Efficiency III"] = 40,
}

local APPLY_SKILLS_CLASS_MEDIC_RECHARGE = {
	["Heal Recharge"] = 5,
	["Heal Recharge II"] = 15,
	["Heal Recharge III"] = 30,
}

local APPLY_SKILLS_DEPLOYABLE_MECH = {
	["Controllable Drone"] = "weapon_controllable_drone"
}

--Player spawning
hook.Add("PlayerSpawn", "HL2CR_PlayerSpawn", function(ply)

	net.Start("HL2CR_ShouldClientSpectate")
		net.WriteBool(false)
		net.WriteBool(false)
		net.WriteInt(0, 8)
	net.Send(ply)
	
	ply:SetModel(ply.hl2cr.Model)
	ply:SetupHands()
	ply:SetTeam(TEAM_ALIVE)
	
	ply:SetCustomCollisionCheck(true)
	ply:SetNoCollideWithTeammates(true)
	
	ply:SetNWString("class_icon", ply.hl2cr.CurClass.Icon)
	
	local newMaxHP = 100
	local healing = 0
	local recharge = 0
	
	for k, skill in pairs(ply.hl2cr.Skills) do
		if APPLY_SKILLS_HEALTH[skill] then
			newMaxHP = newMaxHP + APPLY_SKILLS_HEALTH[skill]
			
		elseif APPLY_SKILLS_CLASS_MEDIC[skill] then
			healing = healing + APPLY_SKILLS_CLASS_MEDIC[skill]
			
		elseif APPLY_SKILLS_CLASS_MEDIC_RECHARGE[skill] then
			recharge = recharge + APPLY_SKILLS_CLASS_MEDIC_RECHARGE[skill]
			
		elseif APPLY_SKILLS_DEPLOYABLE_MECH[skill] and ply.hl2cr.CurClass.Name == "Mechanic" then
			ply:Give(APPLY_SKILLS_DEPLOYABLE_MECH[skill])
		end
	end
	
	if game.GetMap() == "d3_citadel_03" and not ON_CITADEL_MAPS then		
		if player.GetAll()[1] == ply then
			for k, wep in pairs(SPAWNING_WEAPONS) do
				ply:Give(wep)
			end
		end
		return
	end
	
	ply.hl2cr.AmmoGrenade = 0
	ply.hl2cr.StunDamage = 0
	
	if ply.hl2cr.CurClass.Name == "Grenadier" then
		ply.hl2cr.AmmoGrenade = ply.hl2cr.AmmoGrenade + 5
	elseif ply.hl2cr.CurClass.Name == "Combine Dropout" then
		ply.hl2cr.StunDamage = ply.hl2cr.StunDamage + 10
	end
	ply:SetNWString("class_icon", ply.hl2cr.CurClass.Icon)

	ply:SetNWInt("skill_healing", healing)
	ply:SetNWInt("skill_recharge", recharge)
	
	ply:SetMaxHealth(newMaxHP)
	ply:SetHealth(newMaxHP)

	if CONVERT_NAME_TO_ENT[ply.hl2cr.Inventory.CurWeaponSlot] and not (NOSUIT_MAPS[game.GetMap()] or SUPERGRAVGUN_MAPS[game.GetMap()] or game.GetMap() == "d1_trainstation_05") and not ON_CITADEL_MAPS then
		ply:Give(CONVERT_NAME_TO_ENT[ply.hl2cr.Inventory.CurWeaponSlot])
	elseif SUPERGRAVGUN_MAPS[game.GetMap()] then
		ply:Give("weapon_physcannon")
	end
	
	if MAPS_LOBBY[game.GetMap()] and ply:IsAdmin() then	
		ply:Give("weapon_physgun")
	end
	
	if NOSUIT_MAPS[game.GetMap()] then
		ply:SetWalkSpeed(125)
		ply:SetRunSpeed(125)
	elseif game.GetMap() == "d1_trainstation_05" and ents.FindByClass("item_suit")[1] then
		ply:SetWalkSpeed(125)
		ply:SetRunSpeed(125)
	else
		local suit = ents.Create("item_suit")
		suit:SetPos(ply:GetPos())
		suit:Spawn()
	end
	

	for k, wep in pairs(SPAWNING_WEAPONS) do
		ply:Give(wep)
	end
	
	for i, items in pairs(SPAWNING_ITEMS) do
		for k, _ in pairs(items) do		
			if SPAWNING_ITEMS[i][k].Type == "Armor" then
				ply:SetArmor(SPAWNING_ITEMS[i][k].Amount)
			else
				ply:GiveAmmo(SPAWNING_ITEMS[i][k].Amount, SPAWNING_ITEMS[i][k].Type, false)
			end
		end
	end
	
	if not table.IsEmpty(ply.hl2cr.CurClass) and not ( NOSUIT_MAPS[game.GetMap()] or SUPERGRAVGUN_MAPS[game.GetMap()] or game.GetMap() == "d1_trainstation_05") and not MAPS_LOBBY[game.GetMap()] then
		for _, classWep in ipairs(ply.hl2cr.CurClass.Weapons) do
			ply:Give(classWep)
		end
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
	if ent:IsNPC() then return false end 
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
	
	if weapon:GetClass() == "weapon_physgun" and ply:IsAdmin() then
		return true
	end
	
	--If its a stunstick, give them armor
	if weapon:GetClass() == "weapon_stunstick" and ply.hl2cr.CurClass.Name ~= "Combine Dropout" and game.GetMap() == "d1_canals_01" then
		weapon:Remove()
		
		ply:SetArmor(ply:Armor() + 5)
		
		if ply:Armor() > 100 then
			ply:SetArmor(100)
		end
		
		return false
	elseif weapon:GetClass() == "weapon_stunstick" and ply.hl2cr.CurClass.Name == "Combine Dropout" then
		return true
	end

	--if its on a map where super gravgun is enabled, (excluding the gravgun) remove and don't pick up
	if (SUPERGRAVGUN_MAPS[game.GetMap()] or game.GetMap() == "d3_breen_01") and weapon:GetClass() ~= "weapon_physcannon" then weapon:Remove() return false end
	
	--Store the weapon
	if weapon:GetClass() then
		StoreWeapons(weapon:GetClass())
	end
	
	return true
end)

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

hook.Add("GravGunPunt", "HL2CR_PreventPunting", function(ply, ent)
	if ent and ent:GetClass() == "sent_controllable_manhack" then
		return false
	end
end)

hook.Add("EntityTakeDamage", "HL2CR_PVPOff", function(ent, dmgInfo)
	local att = dmgInfo:GetAttacker()
	
	--If the attacker is a player (dead or alive) and attacker isn't the player themselves, return 0
	if ent:IsPlayer() and att:IsPlayer() and (att:Team() == TEAM_ALIVE or att:Team() == TEAM_DEAD) and ent:Team() == TEAM_ALIVE and ent ~= att then
		dmgInfo:SetDamage(0)
		if ent:Armor() < 100 then
			ent:SetArmor(ent:Armor() + 1)
		end
	elseif ent:IsPlayer() and att.Owner and att.Owner:IsPlayer() then
		dmgInfo:SetDamage(0)
	end
	
	if att:IsNPC() and att:GetClass() == "npc_rollermine" and game.GetMap() == "d1_eli_02" then
		dmgInfo:SetDamage(0)
	end
	
	if ent:IsPlayer() and att:IsFriendly() then
		dmgInfo:SetDamage(0)
	end
	
	if ent:GetClass() == "sent_controllable_manhack" and att:IsPlayer() then
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
		
		if p:GetAmmoCount("Grenade") > (GetConVar("hl2cr_max_frags"):GetInt() + p.hl2cr.AmmoGrenade) then
			p:RemoveAmmo( p:GetAmmoCount("Grenade") - (GetConVar("hl2cr_max_frags"):GetInt() + p.hl2cr.AmmoGrenade), "Grenade" )
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

	if item:GetClass() == "weapon_frag" and ply:GetAmmoCount("Grenade") >= (GetConVar("hl2cr_max_frags"):GetInt() + ply.hl2cr.AmmoGrenade) then		
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
		for _, p in ipairs(player.GetAll()) do
			p:SetWalkSpeed(200)
			p:SetRunSpeed(350)
			if game.GetMap() == "d1_trainstation_05" then
				p:Give("admire_hands")
				timer.Simple(0.1, function()
					p:SelectWeapon("admire_hands")
				end)
				
				timer.Simple(5, function()
					p:StripWeapon("admire_hands")
	
	
					if p.hl2cr.CurClass.Weapons then
						for _, classWep in ipairs(p.hl2cr.CurClass.Weapons) do
							if classWep then
								p:Give(classWep)
							end
						end
					end
					if p.hl2cr.Inventory.CurWeaponSlot then
						p:Give(CONVERT_NAME_TO_ENT[p.hl2cr.Inventory.CurWeaponSlot])
					end
				end)
			end	
		end
	end

	return true
end)

hook.Add( "CanPlayerSuicide", "HL2CR_CanSuicide", function( ply )
	if ply:Team() ~= TEAM_ALIVE then return false end
	
	if NO_SUICIDE_MAPS[game.GetMap()] then 
		ply:ChatPrint("Suiciding is currently disabled")
		return false 
	end
	
	return true
end)


local function createIndicator(rewardAmount, position, player)
	
	net.Start("HL2CR_SpawnIndicators")
	
	net.WriteInt(rewardAmount, 32)
	
	net.WriteVector(position)
	
	if player == nil then
		net.Broadcast()
	else
		net.Send(player)
	end
	
end

RANDOM_XP_BASED_NPC = {
	["npc_headcrab"] = {xpMin = 5, xpMax = 15},
	["npc_headcrab_fast"] = {xpMin = 12, xpMax = 27},
	["npc_headcrab_black"] = {xpMin = 13, xpMax = 28},
	["npc_headcrab_poison"] = {xpMin = 13, xpMax = 28},
	["npc_zombie_torso"] = {xpMin = 10, xpMax = 35},
	["npc_zombie"] = {xpMin = 25, xpMax = 65},
	["npc_fastzombie"] = {xpMin = 32, xpMax = 75},
	["npc_poisonzombie"] = {xpMin = 40, xpMax = 90},
	["npc_cscanner"] = {xpMin = 15, xpMax = 30},
	["npc_metropolice"] = {xpMin = 30, xpMax = 80},
	["npc_manhack"] = {xpMin = 25, xpMax = 70},
	["npc_combine_s"] = {xpMin = 40, xpMax = 135},
	["npc_antlionguard"] = {xpMin = 125, xpMax = 275},
	["npc_antlionguardian"] = {xpMin = 125, xpMax = 275},
	["npc_barnacle"] = {xpMin = 5, xpMax = 25},
	["npc_turret_ground"] = {xpMin = 5, xpMax = 25},
}

local RESTRICT_MAPS_ANTLIONS = {
	
}

hook.Add("OnNPCKilled", "HL2CR_NPCKilled", function(npc, attacker, inflictor)
	
	local player = nil
	
	if attacker:IsPlayer() then
		player = attacker
	elseif npc.Attacker then
		player = npc.Attacker
	end
	
	if player then
		
		if not RANDOM_XP_BASED_NPC[npc:GetClass()] then return end
		
		local totalXP = CalculateXP(player, math.random(RANDOM_XP_BASED_NPC[npc:GetClass()].xpMin * npc.level, RANDOM_XP_BASED_NPC[npc:GetClass()].xpMax * npc.level))
		
		if totalXP <= 0 then return end
		
		AddXP(player, totalXP)
		
		createIndicator(totalXP, npc:GetPos(), player)
		
		player.rewards["kills"] = player.rewards["kills"] + 1
		player.hl2cr.Kills = player.hl2cr.Kills + 1
		player:SetNWInt("stat_kills", player.hl2cr.Kills)
		
		if game.GetMap() == "d1_canals_01a" and npc:GetClass() == "npc_barnacle" then
			player.barnacleBowlCount = player.barnacleBowlCount or 0
			
			player.barnacleBowlCount = player.barnacleBowlCount + 1
			
			timer.Simple(0.5, function()
				player.barnacleBowlCount = 0
			end)
			
			if player.barnacleBowlCount >= 5 then
				GrantAchievement(player, "HL2", "Barnacle_Bowling")
			end		
		end
		
		player.rewards.bonus["Pacifist"] = false
		
		if player:GetActiveWeapon():GetClass() ~= "weapon_crowbar" then
			player.rewards.bonus["Crowbar Only"] = false
		end
		
		if inflictor:GetClass() == "npc_manhack" and npc:GetClass() ~= "npc_manhack" then
			player.hackCount = (player.hackCount or 0) + 1
			
			if player.hackCount >= 5 then
				GrantAchievement(player, "HL2", "Hack_Attack")
			end
		end
		
		if inflictor:GetModel() == "models/props_wasteland/prison_toilet01.mdl" then
			GrantAchievement(player, "HL2", "Flushed")
		end
		
		
	elseif attacker:IsNextBot() and attacker:GetOwner():IsPlayer() and attacker:GetOwner().pet then
		if not RANDOM_XP_BASED_NPC[npc:GetClass()] then return end
		
		local totalXP = CalculateXP(attacker:GetOwner(), math.random(RANDOM_XP_BASED_NPC[npc:GetClass()].xpMin * npc.level, RANDOM_XP_BASED_NPC[npc:GetClass()].xpMax * npc.level))
		
		if totalXP <= 0 then return end
		
		AddXP(attacker:GetOwner(), totalXP)

		createIndicator(totalXP, npc:GetPos(), attacker:GetOwner())
		
		attacker:GetOwner().rewards["kills"] = attacker:GetOwner():GetOwner().rewards["kills"] + 1
		attacker:GetOwner().rewards["stats"]["exp"] = attacker:GetOwner().rewards["stats"]["exp"] + totalXP
		attacker:GetOwner().hl2cr.Kills = attacker:GetOwner().hl2cr.Kills + 1
		attacker:GetOwner():SetNWInt("stat_kills", attacker:GetOwner().hl2cr.Kills)
	
	end
end)

hook.Add("PlayerEnteredVehicle", "HL2CR_EnableVehicleOnEnter", function(ply, veh, role)
	if game.GetMap() == "d1_canals_05" and not canSpawnAirboatGlobal then
		canSpawnAirboatGlobal = true	
		
		BroadcastMessage(ENABLED_AIRBOAT)
	end
	
	if game.GetMap() == "d2_coast_01" and not canSpawnJeepGlobal then
		canSpawnJeepGlobal = true
		
		BroadcastMessage(ENABLED_JEEP)
	end	
end)

hook.Add("ShouldCollide", "HL2CR_IgnoreCollisionPet", function( ply, pet )
	if ply:IsPlayer() and (pet:IsNextBot() and pet:IsPet()) then
		return false
	end
	
	return true
end)

local PROJ_IGNORE = {
	["grenade_ar2"] = true,
	["crossbow_bolt"] = true,
	["prop_combine_ball"] = true,
	["rpg_missile"] = true,
	["npc_grenade_frag"] = true
}
hook.Add("ShouldCollide", "HL2CR_IgnoreCollisionProjectile", function( ent, other )
	if ent:IsPlayer() and PROJ_IGNORE[other:GetClass()] then
		return false
	end
end)

hook.Add("EntityTakeDamage", "HL2CR_VehicleFix", function( target, dmgInfo )
	local att = dmgInfo:GetAttacker()
	
	if target:IsPlayer() then

		if dmgInfo:GetDamageType() == 17 or dmgInfo:GetDamageType() == 1 then 
			dmgInfo:SetDamage(0) 
			return
		end
	end
end)

hook.Add("EntityTakeDamage", "HL2CR_SlashDMGBuff", function( target, dmgInfo )
	local att = dmgInfo:GetAttacker()
	local dmgType = dmgInfo:GetDamageType()
	
	if target:IsPlayer() and att:IsNPC() then
		if dmgType == DMG_SLASH and (att:GetClass() ~= "npc_headcrab_black" or att:GetClass() ~= "npc_headcrab_poison") then
			dmgInfo:ScaleDamage(GetConVar("hl2cr_difficulty"):GetInt() * 1.25)
		end
	end
end)

hook.Add("ScalePlayerDamage", "HL2CR_PlayerDamageScale", function( ply, hitgroup, dmgInfo )
		
	local hitMulti = GetConVar("hl2cr_difficulty"):GetInt() - 1
	
	if hitMulti <= 0 then return end

	if hitgroup == HITGROUP_HEAD then
		hitMulti = hitMulti * 1.25
	elseif hitgroup == HITGROUP_CHEST or hitgroup == HITGROUP_STOMACH then
		hitMulti = hitMulti * 1
	elseif hitgroup == HITGROUP_LEFTARM or hitgroup == HITGROUP_RIGHTARM then
		hitMulti = hitMulti * 0.5
	elseif hitgroup == HITGROUP_LEFTLEG or hitgroup == HITGROUP_RIGHTLEG then
		hitMulti = hitMulti * 0.25	
	end
	
	dmgInfo:ScaleDamage(hitMulti)
end)

function BroadcastMessage(msgTbl, player)
	if player == nil then
		net.Start("HL2CR_Message")
			net.WriteTable(msgTbl)
		net.Broadcast()
	else
		net.Start("HL2CR_Message")
			net.WriteTable(msgTbl)
		net.Send(player)
	end
end

function BroadcastSound(soundPath, player)
	if player == nil then
		net.Start("HL2CR_MsgSound")
			net.WriteString(soundPath)
		net.Broadcast()
	else
		net.Start("HL2CR_MsgSound")
			net.WriteString(soundPath)
		net.Send(player)
	end
end

local NO_GRAV_PICKUPS = {
	["sent_controllable_manhack"] = true,
	["sent_controllable_drone"] = true,
}

hook.Add("GravGunPickupAllowed", "HL2CR_AllowGravPickup", function(ply, ent)
	if NO_GRAV_PICKUPS[ent:GetClass()] then
		return false
	end
	
	return true
end)

hook.Add("GravGunOnPickedUp", "HL2CR_BlastAch", function(ply, ent)
	if ent and ent:GetClass() == "shot_nade" then
		ent.Owner = ply
	end
end)

net.Receive("HL2CR_UpdateModel", function(len, ply)
	if not ply then return end
	
	local model = net.ReadString()
	
	ply.hl2cr.Model = model
	
	ply:SetModel(ply.hl2cr.Model)
	ply:SetNWString("stat_model", ply.hl2cr.Model)
end)

net.Receive("HL2CR_ApplySettings", function(len, ply)
	if not ply then return end
	
	local playerDraw = net.ReadInt(32)
	local endMusicToggle = net.ReadBool()
	local playerFont = net.ReadString()
	
	local npcDraw = net.ReadInt(32)
	local npcFont = net.ReadString()
	local npcColoursEasy = net.ReadString()
	local npcColoursMedium = net.ReadString()
	local npcColoursHard = net.ReadString()
	
	local fixColourEasy = string.ToColor(npcColoursEasy)
	local fixColourMedium = string.ToColor(npcColoursMedium)
	local fixColourHard = string.ToColor(npcColoursHard)
	
	--Update Player Config
	ply.hl2cr.Config.PlayerSettings["PlayerDrawDistance"] = playerDraw
	ply.hl2cr.Config.PlayerSettings["ShouldPlayEndMusic"] = endMusicToggle
	ply.hl2cr.Config.PlayerSettings["PlayerFont"] = playerFont

	--Update NPC Config	
	ply.hl2cr.Config.NPCSettings["NPCDrawDistance"] = npcDraw
	ply.hl2cr.Config.NPCSettings["NPCFont"] = npcFont
	
	--Set Player Config
	ply:SetNWInt("config_playerdrawdist", ply.hl2cr.Config.PlayerSettings["PlayerDrawDistance"])
	ply:SetNWBool("config_shouldendmusicplay", ply.hl2cr.Config.PlayerSettings["ShouldPlayEndMusic"])
	ply:SetNWString("config_playerfont", ply.hl2cr.Config.PlayerSettings["PlayerFont"])

	--SET NPC Config	
	ply:SetNWInt("config_npcdrawdist", ply.hl2cr.Config.NPCSettings["NPCDrawDistance"])
	ply:SetNWInt("config_npcfont", ply.hl2cr.Config.NPCSettings["NPCFont"])
	
	ply.hl2cr.Config.NPCSettings["Colours"][1].r = fixColourEasy.r
	ply.hl2cr.Config.NPCSettings["Colours"][1].g = fixColourEasy.g
	ply.hl2cr.Config.NPCSettings["Colours"][1].b = fixColourEasy.b

	ply:SetNWString("config_npccolours_easy", ply.hl2cr.Config.NPCSettings["Colours"][1].r .. " ".. ply.hl2cr.Config.NPCSettings["Colours"][1].g .. " " ..  ply.hl2cr.Config.NPCSettings["Colours"][1].b .. " 255")
	
	ply.hl2cr.Config.NPCSettings["Colours"][2].r = fixColourMedium.r
	ply.hl2cr.Config.NPCSettings["Colours"][2].g = fixColourMedium.g
	ply.hl2cr.Config.NPCSettings["Colours"][2].b = fixColourMedium.b

	ply:SetNWString("config_npccolours_medium", ply.hl2cr.Config.NPCSettings["Colours"][2].r .. " ".. ply.hl2cr.Config.NPCSettings["Colours"][2].g .. " " ..  ply.hl2cr.Config.NPCSettings["Colours"][2].b .. " 255")
	
	ply.hl2cr.Config.NPCSettings["Colours"][3].r = fixColourHard.r
	ply.hl2cr.Config.NPCSettings["Colours"][3].g = fixColourHard.g
	ply.hl2cr.Config.NPCSettings["Colours"][3].b = fixColourHard.b

	ply:SetNWString("config_npccolours_hard", ply.hl2cr.Config.NPCSettings["Colours"][3].r .. " ".. ply.hl2cr.Config.NPCSettings["Colours"][3].g .. " " ..  ply.hl2cr.Config.NPCSettings["Colours"][3].b .. " 255")
end)

hook.Add("PlayerSwitchWeapon", "HL2CR_Supplier_WeaponChange", function(ply, oldWeapon, newWeapon)
	ply.ammoCount = newWeapon:GetPrimaryAmmoType()
end)

hook.Add("PlayerAmmoChanged", "HL2CR_Supplier_AmmoChange", function(ply, ammoID, oldCount, newCount )
	ply.ammoCount = newCount
end)

hook.Add("PlayerButtonDown", "HL2CR_ConfirmVoice", function(ply, btn)
	if btn == KEY_Q then
		net.Start("HL2CR_QMenuUpdate")
			net.WriteTable(ply.hl2cr.Skills)
		net.Send(ply)
	end
end)