local hl2cr_player = FindMetaTable( "Player" )

--Weapons/Items that the map start with upon player connected
SPAWNING_WEAPONS = SPAWNING_WEAPONS or {}
SPAWNING_ITEMS = SPAWNING_ITEMS or {}

local NO_SUICIDE_MAPS = {
	["hl2cr_lobby_v2"] = true,
	["d1_trainstation_01"] = true,
	["d1_trainstation_02"] = true,
	["d1_trainstation_03"] = true,
	["d1_trainstation_04"] = true,
	["d1_trainstation_05"] = true,
	["d1_eli_01"] = true,
	["d1_eli_02"] = true,
	["d3_breen_01"] = true
}

--Restrict these weapons from being picked up/used
RESTRICTED_WEAPONS = {
	["weapon_physgun"] = true,
	["weapon_stunstick"] = true,
	["weapon_medkit"] = true,
	//Admin stuff
	["swep_construction_kit"] = true,
	//HL2CR weapons
	["admire_hands"] = true,
	["weapon_hl2cr_crowsaw"] = true,
	["weapon_hl2cr_autopistol"] = true,
	["weapon_hl2cr_rampagesmg"] = true,
	["weapon_hl2cr_crossbow"] = true,
	--Class based weapons
	["weapon_hl2cr_medkit"] = true,
	["weapon_hl2cr_ammobox"] = true,
}

DISALLOW_PICKUP = {
	["weapon_stunstick"] = true
}

local ammo_filter = {
	["item_ammo_pistol"] = true,
	["item_ammo_pistol_large"] = true,
	["item_ammo_357"] = true,
	["item_ammo_357_large"] = true,
	["item_ammo_smg1"] = true,
	["item_ammo_smg1_large"] = true,
	["item_ammo_smg1_grenade"] = true,
	["item_ammo_ar2"] = true,
	["item_ammo_ar2_large"] = true,
	["item_ammo_ar2_altfire"] = true,
	["item_box_buckshot"] = true,
	["item_ammo_buckshot_large"] = true,
	["item_ammo_crossbow"] = true,
	["item_rpg_round"] = true,
	["weapon_frag"] = true,
	["weapon_slam"] = true,
}

local ammo_convert_to_id = {
	["item_ammo_pistol"] = "pistol",
	["item_ammo_pistol_large"] = "pistol",
	["item_ammo_357"] = "357",
	["item_ammo_357_large"] = "357",
	["item_ammo_smg1"] = "smg1",
	["item_ammo_smg1_large"] = "smg1",
	["item_ammo_smg1_grenade"] = "smg1_grenade",
	["item_ammo_ar2"] = "ar2",
	["item_ammo_ar2_large"] = "ar2",
	["item_ammo_ar2_altfire"] = "ar2altfire",
	["item_box_buckshot"] = "buckshot",
	["item_ammo_buckshot_large"] = "buckshot",
	["item_ammo_crossbow"] = "xbowbolt",
	["item_rpg_round"] = "rpg_round",
	["weapon_frag"] = "grenade",
	["weapon_slam"] = "slam",
}

local id_convert_to_convar = { 
	[3] = "hl2cr_base_pistol",
	[5] = "hl2cr_base_357",
	[4] = "hl2cr_base_smg1",
	[1] = "hl2cr_base_ar2",
	[7] = "hl2cr_base_buckshot",
	[8] = "hl2cr_base_rpg_round",
	[6] = "hl2cr_base_rpg_round",
	[2] = "hl2cr_base_rpg_round",
	[9] = "hl2cr_base_frags",
	[10] = "hl2cr_base_frags"
}

local ammo_convert_to_convar = {
	["item_ammo_pistol"] = "hl2cr_base_pistol",
	["item_ammo_pistol_large"] = "hl2cr_base_pistol",
	["item_ammo_357"] = "hl2cr_base_357",
	["item_ammo_357_large"] = "hl2cr_base_357",
	["item_ammo_smg1"] = "hl2cr_base_smg1",
	["item_ammo_smg1_large"] = "hl2cr_base_smg1",
	["item_ammo_smg1_grenade"] = "hl2cr_base_smg1_grenade",
	["item_ammo_ar2"] = "hl2cr_base_ar2",
	["item_ammo_ar2_large"] = "hl2cr_base_ar2",
	["item_ammo_ar2_altfire"] = "hl2cr_base_ar2_ball",
	["item_box_buckshot"] = "hl2cr_base_buckshot",
	["item_ammo_buckshot_large"] = "hl2cr_base_buckshot",
	["item_ammo_crossbow"] = "hl2cr_base_crossbowbolt",
	["item_rpg_round"] = "hl2cr_base_rpg_round",
	["weapon_frag"] = "hl2cr_base_frags",
	["weapon_slam"] = "hl2cr_base_slam",
}

local stat_convert_to_convar = {
	["Pistol"] = "hl2cr_base_pistol",
	["357"] = "hl2cr_base_357",
	["SMG"] = "hl2cr_base_smg1",
	["AR2"] = "hl2cr_base_ar2",
	["Buckshot"] = "hl2cr_base_buckshot",
	["Crossbow"] = "hl2cr_base_crossbowbolt",
	["RPG"] = "hl2cr_base_rpg_round",
	["Frags"] = "hl2cr_base_frags"
}

local weapon_melees = {
	["weapon_crowbar"] = true
}

local mapach_setup = {
	["d1_town_01"] = function(ply)
		if table.HasValue(ply.hl2cr.AchProgress, "ZombieChopperActive") or ply:HasAchievement("Zombie Chopper") then return end
		
		table.insert(ply.hl2cr.AchProgress, "ZombieChopperActive")
		ply:BroadcastMessage(HL2CR_AchNotifyColour, translate.Get("Achievement_HL2_ZombieChopper_Name"), HL2CR_StandardColour, translate.Get("Achievement_Notify_Begin"))
	end
}

function GM:PlayerShouldTakeDamage( ply, attacker )
	if attacker:IsPlayer() and ply ~= attacker then
		return false
	end

	return true
end

function hl2cr_player:DisplayResults()
	if NO_RESULT_MAPS[game.GetMap()] then return end
	
	net.Start("HL2CR_Endresults")
		net.WriteTable(self.MapStats)
	net.Send(self)
end

function hl2cr_player:UpdateModelNetwork(newMdl)	
	self:BroadcastMessage(Color(240, 135, 0), translate.Get("QMenu_Model_Update"))
	self.hl2cr.PMModel = newMdl
end

function hl2cr_player:ChangeModel(newModel)
	if !self.loaded then 
		self:SetModel("models/player/kleiner.mdl")
		return 
	end

	self:SetModel(newModel)

	//self:SetModel(ServerModels[self.hl2cr.ModelType.Type][self.hl2cr.ModelType.Gender]
	//[math.random(1, #ServerModels[self.hl2cr.ModelType.Type][self.hl2cr.ModelType.Gender])])
end

function hl2cr_player:SetClass(className)
	
	if self.hl2cr.Class.Name == className then
		self:BroadcastMessage(HL2CR_RedColour, translate.Get("Error_Class_AlreadyAssigned"))
		return
	end
	
	local assignClass = nil

	for _, class in ipairs(HL2CR_Classes) do
		if class.Name == className then
			assignClass = class
			break
		end
	end

	if self.hl2cr.Level < assignClass.LevelReq then
		self:BroadcastMessage(HL2CR_RedColour, translate.Get("Error_Class_LowLevel"))
		return
	end

	self.NewClass = assignClass

	self:BroadcastMessage(HL2CR_GreenColour, translate.Get("Class_Assigned"))
end

function hl2cr_player:SetUpPlayer()	
	if !self.loaded then return end
	self:SetTeam(TEAM_ALIVE)

	self:SetCustomCollisionCheck(true)
	self:SetNoCollideWithTeammates(true)

	self:ChangeModel(self.hl2cr.PMModel)
	
	timer.Simple(2, function()
		self:SetupHands()
		self:ApplyCosmeticSpawn()
	end)

	local cosmetics = {}

	for _, c in ipairs(self.hl2cr.Inventory.Cosmetics) do
		table.insert(cosmetics, c.Name)
	end

	self:SetNWString("hl2cr_items_cosmetics", table.concat(cosmetics, "  "))

	if self.statHP then
		self:SetMaxHealth(self:Health() + self.statHP)
		self:SetHealth(self:GetMaxHealth())
	end

	if self.statArmor then
		self:SetMaxArmor(100 + self.statArmor)
	end

	if not table.IsEmpty(self.hl2cr.Class.Buffs) then
		self.hl2cr.Class.Buffs.BuffFunc(self)
	end

	if not table.IsEmpty(self.hl2cr.Class.Debuffs) then
		self.hl2cr.Class.Debuffs.DebuffFunc(self)
	end

	HL2CR_AUX:SetupAuxPower(self)
	hook.Run("HL2CR_AuxPowerInitialize", self)
end

function hl2cr_player:AdjustSpeed()
	
	if MAPS_NO_SUIT[game.GetMap()] then
		self:SetMaxSpeed(35)
		self:SetRunSpeed(200)
    elseif game.GetMap() == "d1_trainstation_05" and not GetGlobalBool("HL2CR_GLOBAL_SUIT") then
		self:SetMaxSpeed(35)
		self:SetRunSpeed(200)
	else
		self:SetMaxSpeed(200)
		self:SetRunSpeed(350)
	end
end

function hl2cr_player:ApplyCosmeticSpawn()
	if self.hl2cr.CurCosmetic == "" then return end
	
	net.Start("HL2CR_Cosmetic_Use")
		net.WriteTable(HL2CR_Shared_Cosmetics[self.hl2cr.CurCosmetic])
		net.WriteEntity(self)
	net.Broadcast()
end

function hl2cr_player:ApplyCosmeticServer(cosmeticToApply)
	if cosmeticToApply == "" or cosmeticToApply == nil then
		self.hl2cr.CurCosmetic = ""
		local emptyTbl = {}

		net.Start("HL2CR_Cosmetic_Use")
			net.WriteTable(emptyTbl)
			net.WriteEntity(self)
		net.Broadcast()
		return
	end
	
	local apply = nil 
	local tempName = nil
	for _, c in ipairs(HL2CR_Cosmetics) do
		if c.Name == cosmeticToApply then
			apply = c.Class
			tempName = c.Name
			break
		end
	end

	self.hl2cr.CurCosmetic = apply

	self:BroadcastMessage(HL2CR_GreenColour, tempName .. translate.Get("Player_CosmeticApply"))

	net.Start("HL2CR_Cosmetic_Use")
		net.WriteTable(HL2CR_Shared_Cosmetics[apply])
		net.WriteEntity(self)
	net.Broadcast()
end

function hl2cr_player:SetUpInitialSpawn()
    if self:IsBot() then return end
	
	self:LoadSkills()
	self:SetUpPlayer()

	if mapach_setup[game.GetMap()] then
		mapach_setup[game.GetMap()](self)
	end

	self:GiveWeaponsSpawn()
	self:AdjustSpeed()
	self:UpdateClass()

	self.MapStats = {
		["Kills"] = 0,
		["Deaths"] = 0,
		["TotalXP"] = 0,
		["Misc"] = {}
	}

	if VortexBall and VortexBall:IsValid() then
		self:BroadcastMessage(HL2CR_PlayerColour, translate.Get("Server_Announce_Vortex_Spawn"))
	end
end

function hl2cr_player:SetUpRespawnRevive()
	if self:IsBot() then return end
	
	self:SetTeam(TEAM_ALIVE)

	if self.Ragdoll then
		self.Ragdoll:Remove()
		self.Ragdoll = nil 
	end
	
	self:UnSpectate()
	//self:SetObserverMode(OBS_MODE_NONE)
	
	self:GiveEquipment()
	self:GiveWeaponsSpawn()
	self:AdjustSpeed()
	self:UpdateClass()
end

function hl2cr_player:SetUpRespawn()
	if self:IsBot() then return end

	if self.Ragdoll == nil then
		self:LoadSkills()
		self:UnSpectate()
		self:SetUpPlayer()
		self:GiveWeaponsSpawn()
		self:GiveEquipment()
		self:AdjustSpeed()
		self:UpdateNetworks()
		self:UpdateClass()
		return
	end

	if self.Ragdoll:IsValid() then
		self.Ragdoll:Remove()
		self.Ragdoll = nil 
	end

	self:UnSpectate()

	self:LoadSkills()
	self:SetUpPlayer()
	self:GiveWeaponsSpawn()
	self:GiveEquipment()
	self:AdjustSpeed()
	self:UpdateNetworks()
	self:UpdateClass()
end

function hl2cr_player:LoadSkills()
	if !self.loaded then return end
	for _, gS in ipairs(HL2CR_Skills) do
		for i, s in ipairs(self.hl2cr.Skills) do
			if gS.Class == s then
				gS.Func(self)
			end
		end	
	end
end

function hl2cr_player:UpdateClass()
	if self.NewClass then
		self.NewClass.Func(self)
		self.NewClass = nil
	end
end

function hl2cr_player:GiveEquipment()
	if MAPS_NO_SUIT[game.GetMap()] or (game.GetMap() == "d1_trainstation_05" and GetGlobalBool("HL2CR_GLOBAL_SUIT") == false) then return end
	
	for _, items in ipairs(SPAWNING_ITEMS) do
		for _, item in ipairs(items) do
			if item.Type == "Armor" then
				self:SetArmor(item.Amount)
			else
				self:SetAmmo(item.Amount, item.Type)
			end
		end
	end

	self:CheckAllAmmo()
end

function hl2cr_player:GiveWeaponsSpawn()
	if MAPS_NO_HL2CR_WEAPONS[game.GetMap()] then return end
	
	for _, weapon in ipairs(SPAWNING_WEAPONS) do
		self:Give(weapon)
	end

	if !self.loaded then return end
	if self.hl2cr.Class.Weapons then
		for _, classWep in ipairs(self.hl2cr.Class.Weapons) do
			self:Give(classWep)
		end
	end
end

--Force the spawnpoint to be suitable making players not spawn into eachother
function GM:IsSpawnpointSuitable(ply, spawnpoint, makeSuitable)
	return true
end

function GM:CanPlayerSuicide(ply)
	if ply:Team() ~= TEAM_ALIVE then return false end
	
	if NO_SUICIDE_MAPS[game.GetMap()] then
		ply:BroadcastMessage(HL2CR_RedColour, translate.Get("Error_Player_Suicide_BadMap"))
		return false
	end

	return true
end

function GM:PostEntityTakeDamage( ent, dmg, took )
	if ent:IsPlayer() then
		if ent.hl2cr.Buffs.SelfHealing and ent:Health() < ent:GetMaxHealth() then
			if ent:Health() >= ent:GetMaxHealth() then
				return 
			end

			timer.Create("HL2CR_Selfhealing_" .. ent:EntIndex(), 10, 999, function()
				ent:SetHealth(ent:Health() + 5)
				if ent:Health() >= ent:GetMaxHealth() then
					ent:SetHealth(ent:GetMaxHealth())
					timer.Remove("HL2CR_Selfhealing_" .. ent:EntIndex())
				end
			end)
		end
	end
end

--Stores the weapons for player joining or respawning
local function StoreWeapons(newWeapon)
	//If this is a restricted weapon, do not store it
	if RESTRICTED_WEAPONS[newWeapon] then return end
	
	--If the item is already in the table or is a restricted weapon, do nothing
	if table.HasValue(SPAWNING_WEAPONS, newWeapon) then
		return
	--Else update it with new weapon
	else
		table.insert(SPAWNING_WEAPONS, newWeapon)
	end

	--Give all players the new weapon that don't have it
	for k, p in ipairs(player.GetAll()) do
		if p:Team() == TEAM_AFK or p:Team() == TEAM_COMPLETED_MAP or p:HasWeapon(newWeapon) then continue end
		
		if game.GetMap() == "d1_trainstation_06" and newWeapon == "weapon_crowbar" then
			p:GrantAchievement("Trusty Hardware")
		end

		p:Give(newWeapon)
	end
end

function BroadcastMessageToAll(...)
	net.Start("HL2CR_ChatMessage")
		net.WriteTable({...})
	net.Broadcast()
end

function BroadcastPitchedSoundToAll(soundPath, pitch)
	net.Start("HL2CR_MsgPitchSound")
		net.WriteString(soundPath)
		net.WriteInt(pitch, 32)
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

function hl2cr_player:UpdateXPClient(amount)
	net.Start("HL2CR_Update_XP")
		net.WriteInt(amount, 32)
	net.Send(self)
end

function hl2cr_player:CanPickupAmmo(ammoType)
	if isnumber(ammoType) then
		if not id_convert_to_convar[ammoType] then return end
		
		if self:GetAmmoCount(ammoType) >= GetConVar(id_convert_to_convar[ammoType]):GetInt() then
			return false
		end
	elseif self:GetAmmoCount(ammo_convert_to_id[ammoType]) >= GetConVar(ammo_convert_to_convar[ammoType]):GetInt() then
		return false
	end

	return true
end

function hl2cr_player:CheckAmmo(ammoType)
	if isnumber(ammoType) then
		if self:GetAmmoCount(ammoType) > GetConVar(id_convert_to_convar[ammoType]):GetInt() then
			self:SetAmmo( GetConVar(id_convert_to_convar[ammoType]):GetInt(), ammoType)
			return
		end
	end
	
	if not ammo_convert_to_id[ammoType] then return end

	if self:GetAmmoCount(ammo_convert_to_id[ammoType]) > GetConVar(ammo_convert_to_convar[ammoType]):GetInt() then
		self:SetAmmo( GetConVar(ammo_convert_to_convar[ammoType]):GetInt(), ammo_convert_to_id[ammoType])
	end
end

function hl2cr_player:CheckAllAmmo()
	for i, a in pairs(self:GetAmmo()) do
		if a > GetConVar(id_convert_to_convar[i]):GetInt() then
			self:SetAmmo(GetConVar(id_convert_to_convar[i]):GetInt(), i)
			return false
		end
	end
end

function hl2cr_player:UpdateSkills(skill)
	
	local updateNetwork = ""

	for _, s in ipairs(HL2CR_Skills) do
		if s.Class == skill then
			self.hl2cr.SkillPoints = self.hl2cr.SkillPoints - s.Cost
			table.insert(self.hl2cr.Skills, s.Class)
			s.Func(self)
			break
		end
	end
	
	self:SetNWInt("hl2cr_stat_skillpoints", self.hl2cr.SkillPoints)
	self:SetNWString("hl2cr_stat_skills", table.concat(self.hl2cr.Skills, " "))
end

function hl2cr_player:CreateRagdollBody(dmgInfo)
	local ragdoll = ents.Create("prop_ragdoll")
	ragdoll:SetModel(self:GetModel())
	ragdoll:SetPos(self:GetPos())
	ragdoll:SetAngles(self:GetAngles())
	ragdoll:SetOwner(self)
	ragdoll:Spawn()
	ragdoll:Activate()
	ragdoll:GetPhysicsObject():SetVelocity(self:GetVelocity())
	
	local num = ragdoll:GetPhysicsObjectCount() - 1
	local v = self:GetVelocity()

	if dmgInfo:IsDamageType(DMG_BULLET) or dmgInfo:IsDamageType(DMG_SLASH) then
	   v = v / 5
	end
 
	for i=0, num do
	   local bone = ragdoll:GetPhysicsObjectNum(i)
	   if IsValid(bone) then
			local bp, ba = self:GetBonePosition(ragdoll:TranslatePhysBoneToBone(i))
			if bp and ba then
				bone:SetPos(bp)
				bone:SetAngles(ba)
			end

			bone:SetVelocity(v)
		end
	end

	self.Ragdoll = ragdoll
end

function GM:DoPlayerDeath(ply, att, dmgInfo)
	ply:CreateRagdollBody(dmgInfo)
	ply:Spectate( OBS_MODE_CHASE )
	ply:SpectateEntity(ply.Ragdoll)

	local notifyTbl = {
		["victim"] = ply,
		["attacker"] = att,
		["inflictor"] = dmgInfo:GetInflictor(),
	}

	net.Start("HL2CR_Player_NotifyKilled")
		net.WriteTable(notifyTbl)
	net.Broadcast()
end

function GM:PlayerDeath( victim, inflictor, attacker )
	victim:SetTeam(TEAM_DEAD)
	victim.MapStats.Deaths = victim.MapStats.Deaths + 1

	victim.CanRespawn = false
	victim.TimeDied = (10 * GetConVar("hl2cr_difficulty"):GetInt()) + CurTime()

	CheckPlayerCompleted()
end

function GM:PlayerDeathThink( ply )

	ply:SetNWInt("hl2cr_respawntimer", math.Round(ply.TimeDied - CurTime()))

	if ply.TimeDied < CurTime() and ply:Team() == TEAM_DEAD and not ply.CanRespawn then
		ply.CanRespawn = true
		ply:BroadcastSound("hl2cr/standardbeep.wav")
	end

	return false

end

hook.Add("KeyPress", "HL2CR_Key_Respawn", function( ply, key )
	if key == IN_ATTACK and ply:Team() == TEAM_DEAD and ply.CanRespawn then
		ply:Spawn()
		ply.CanRespawn = nil
	end
end)

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
		
		if tr.Entity:IsPlayer() or (tr.Entity:IsNPC() and tr.Entity:IsFriendly()) then
			data.IgnoreEntity = tr.Entity
		end
	end
	
	return true
end)

hook.Add("PlayerCanPickupWeapon", "HL2CR_WeaponPickup", function(ply, weapon)
	if not ply:IsValid() then return end
	if ply:Team() ~= TEAM_ALIVE then return end

	if weapon:GetClass() == "weapon_physgun" and not ply:IsAdmin() then
		return false
	end
	
	if DISALLOW_PICKUP[weapon:GetClass()] then 
		return false 
	end

	--Store the weapon
	if weapon:IsValid() then
		StoreWeapons(weapon:GetClass())
	end
	
	if ply:HasWeapon(weapon:GetClass()) and not weapon_melees[weapon:GetClass()] then
		
		local lastWep = weapon:GetPrimaryAmmoType()
		
		if not ply:CanPickupAmmo(lastWep) then
			return false
		end

		timer.Simple(0.01, function()
			ply:CheckAmmo(lastWep)
		end)
	end

	return true
end)

function GM:GravGunPunt( ply, ent )
    if ply:InVehicle() then return false end

	for _, v in ipairs(player.GetAll()) do
		if v == ply then continue end
		
		if ent == v.vehicle then return false end
	end

    return true
end

function hl2cr_player:UpdateNetworks()
	self:SetNWInt("hl2cr_stat_level", self.hl2cr.Level)
	self:SetNWInt("hl2cr_stat_exp", self.hl2cr.Exp)
	self:SetNWInt("hl2cr_stat_expreq", self.hl2cr.ReqExp)
	self:SetNWInt("hl2cr_stat_skillpoints", self.hl2cr.SkillPoints)
	self:SetNWString("hl2cr_stat_skills", table.concat(self.hl2cr.Skills, " ") )
	self:SetNWString("hl2cr_achievements", table.concat(self.hl2cr.Achievements, " ") )
	self:SetNWString("hl2cr_class", self.hl2cr.Class.Name)
	self:SetNWInt("hl2cr_inv_weight", self.hl2cr.Inventory.Weight)
	self:SetNWInt("hl2cr_inv_curweight", self.hl2cr.Inventory.CurWeight)

	if not table.IsEmpty(self.hl2cr.Pets) then
		local activePet = nil

		for _, p in ipairs(self.hl2cr.Pets) do
            if p.Active then
                activePet = p
                break
            end
        end

		if activePet == nil then return end
		
		self:SetNWString("hl2cr_petstat_name", activePet.Name)
		self:SetNWInt("hl2cr_petstat_xp", activePet.XP)
		self:SetNWInt("hl2cr_petstat_reqxp", activePet.ReqXP)
		self:SetNWInt("hl2cr_petstat_level", activePet.Level)
	end
end

--Player spawning
hook.Add("PlayerInitialSpawn", "HL2CR_InitialPlayerSpawn", function(ply, transition)
    ply:SetUpInitialSpawn()

	for _, v in ipairs(player.GetAll()) do
		if not v.activePet then continue end
		v.activePet:UpdatePlayerRelationship(ply)
	end
end)

function GM:PlayerSpawn(ply)
    ply:SetUpRespawn()
end

--If on the trainstation maps, do not allow players to use their flashlight else allow them
hook.Add("PlayerSwitchFlashlight", "HL2CR_CanUseFlashlight", function(ply, enabled)
	if ply:Team() ~= TEAM_ALIVE then 
		return false
	end
	
	if MAPS_NO_SUIT[game.GetMap()] then
		ply:SetCanZoom(false)
		return false
    elseif game.GetMap() == "d1_trainstation_05" and not GetGlobalBool("HL2CR_GLOBAL_SUIT") then
		ply:SetCanZoom(false)
		return false
    end

	ply:SetCanZoom(true)
	return true
end)

hook.Add( "PlayerUse", "HL2CR_PlayerUse", function( ply, ent )
	if ent:GetClass() == "prop_vehicle_prisoner_pod" and ent.IsPassenger and ply.vehicle then
		return false
	end

	if ent:GetOwner() ~= nil then
		ply:SetAllowWeaponsInVehicle(false)
	else
		ply:SetAllowWeaponsInVehicle(true)
	end

	if ent:GetClass() == "prop_vehicle_jeep" or ent:GetClass() == "prop_vehicle_airboat" then
	
		if ent:GetOwner():IsValid() and ent:GetOwner() ~= ply then
			return false
		end

		timer.Simple(0.01, function()
			ply:CheckAmmo("item_ammo_smg1")
		end)
	elseif ent:GetClass() == "item_ammo_crate" then
		timer.Create("hl2cr_itemcrate_wait_" .. ply:EntIndex(), 1, 2, function()
			ply:CheckAllAmmo()
		end)
	end

	return true
end )

function hl2cr_player:AdmireSuitHands()
	self:Give("Admire_Hands")
	self:SetActiveWeapon(self:GetWeapon("Admire_Hands"))
	timer.Create(self:Nick() .. "_admiring", 4, 1, function()
		self:StripWeapons()
		self:GiveEquipment()
	end)
end

hook.Add("PlayerCanPickupItem", "HL2CR_ItemAmmoPickup", function(ply, item)
	if item:GetClass() == "item_suit" and game.GetMap() == "d1_trainstation_05" then
		SetGlobalBool( "HL2CR_GLOBAL_SUIT", true )

		for _, v in ipairs(player.GetAll()) do
			v:AdjustSpeed()
			v:AdmireSuitHands()
		end
	end

	local lastItem = item:GetClass()

	if ammo_filter[lastItem] then
		if not ply:CanPickupAmmo(lastItem) then
			return false
		end
		timer.Simple(0.01, function()
			ply:CheckAmmo(lastItem)
		end)
	end
	if item:GetClass() == "item_healthkit" or item:GetClass() == "item_healthvial" then
		if ply.hl2cr.Buffs.MedicalKnowledge then
			ply:SetHealth(math.Clamp(ply:Health() + ply.hl2cr.Buffs.MedicalKnowledge, 1, ply:GetMaxHealth()))
		end
	end

	return true
end)

net.Receive("HL2CR_Skills_Purchase", function(len, ply)
	if not ply then return end

	ply:UpdateSkills(net.ReadString())
end)

net.Receive("HL2CR_Model_Update", function(len, ply)
	if not ply then return end

	ply:UpdateModelNetwork(net.ReadString())
end)

net.Receive("HL2CR_Class_Update", function(len, ply)
	if not ply then return end

	ply:SetClass(net.ReadString())
end)

net.Receive("HL2CR_Cosmetic", function(len, ply)
	if not ply then return end

	ply:ApplyCosmeticServer(net.ReadString())
end)