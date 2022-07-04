local hl2cr_player = FindMetaTable( "Player" )

--Weapons/Items that the map start with upon player connected
SPAWNING_WEAPONS = SPAWNING_WEAPONS or {}
SPAWNING_ITEMS = SPAWNING_ITEMS or {}

--Restrict these weapons from being picked up/used
RESTRICTED_WEAPONS = {
	["weapon_physgun"] = true,
	["weapon_stunstick"] = true,
	//Admin stuff
	["swep_construction_kit"] = true,
	//HL2CR weapons
	["admire_hands"] = true,
	["weapon_hl2cr_crowsaw"] = true,
	["weapon_hl2cr_autopistol"] = true,
	["weapon_hl2cr_rampagesmg"] = true,
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

function GM:PlayerShouldTakeDamage( ply, attacker )
	if attacker:IsPlayer() and ply ~= attacker then
		return false
	end

	return true
end

function hl2cr_player:DisplayResults()
	net.Start("HL2CR_Endresults")
		net.WriteTable(ply.MapStats)
	net.Send(ply)
end

function hl2cr_player:UpdateModelNetwork(type, gender)
	local newType = self.hl2cr.ModelType.Type
	local newGender = self.hl2cr.ModelType.Gender
	
	if type ~= "" then
		newType = type
	end

	if gender ~= "" then
		newGender = gender
		self:BroadcastMessage(Color(240, 135, 0), translate.Get("QMenu_Gender_Update"))
	end

	self.hl2cr.ModelType = {
		["Type"] = newType,
		["Gender"] = newGender
	}
end

function hl2cr_player:ChangeModel()
	if self.hl2cr.ModelType.Type == "citizen" then
		if self.hl2cr.ModelType.Gender == "male" then
			self:SetModel(CitizenModels["Male"][math.random(1, #CitizenModels["Male"])])
		elseif self.hl2cr.ModelType.Gender == "female" then
			self:SetModel(CitizenModels["Female"][math.random(1, #CitizenModels["Female"])])
		end
	end
end


function hl2cr_player:SetUpPlayer()	
	self:SetTeam(TEAM_ALIVE)

	self:SetCustomCollisionCheck(true)
	self:SetNoCollideWithTeammates(true)

	self:ChangeModel()

	self:SetNWInt("hl2cr_stat_level", self.hl2cr.Level)
	self:SetNWInt("hl2cr_stat_exp", self.hl2cr.Exp)
	self:SetNWInt("hl2cr_stat_expreq", self.hl2cr.ReqExp)
	self:SetNWInt("hl2cr_stat_skillpoints", self.hl2cr.SkillPoints)
	self:SetNWString("hl2cr_stat_skills", table.concat(self.hl2cr.Skills, " "))
	self:SetNWString("hl2cr_class", self.hl2cr.Class.Name)

	if self.hl2cr.Statistics.HealthBonus > 0 then
		self:SetMaxHealth(self:Health() + self.hl2cr.Statistics.HealthBonus)
		self:SetHealth(self:GetMaxHealth())
	end
end

function hl2cr_player:AdjustSpeed()
	
	if MAPS_NO_SUIT[game.GetMap()] then
		self:SetMaxSpeed(35)
		self:SetRunSpeed(200)
		self:SprintDisable()
    elseif game.GetMap() == "d1_trainstation_05" and not GetGlobalBool("HL2CR_GLOBAL_SUIT") then
		self:SetMaxSpeed(35)
		self:SetRunSpeed(200)
		self:SprintDisable()
	else
		self:SetMaxSpeed(200)
		self:SetRunSpeed(350)
		self:SprintEnable()
	end
end

function hl2cr_player:SetUpInitialSpawn()
    if self:IsBot() then return end

	self:SetUpPlayer()
	self:GiveWeaponsSpawn()
	self:AdjustSpeed()

	HL2CR_AUX:SetupAuxPower(self)
	hook.Run("HL2CR_AuxPowerInitialize", self)

	self.MapStats = {
		["Kills"] = 0,
		["Deaths"] = 0,
		["TotalXP"] = 0,
		["Misc"] = {}
	}
end

function hl2cr_player:SetUpRespawn()
    if self:IsBot() then return end
	
	self:SetUpPlayer()
	self:GiveWeaponsSpawn()
	self:AdjustSpeed()

	HL2CR_AUX:SetupAuxPower(self)
	hook.Run("HL2CR_AuxPowerInitialize", self)
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

function GM:CanPlayerSuicide(ply)
	if ply:Team() ~= TEAM_ALIVE then return false end
	
	if NO_SUICIDE_MAPS[game.GetMap()] then
		ply:BroadcastMessage(HL2CR_RedColour, translate.Get("Error_Player_Suicide_BadMap"))
		return false
	end

	return true
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

function GM:PlayerDeath( victim, inflictor, attacker )
	victim:SetTeam(TEAM_DEAD)
	victim.MapStats.Deaths = victim.MapStats.Deaths + 1
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

	if ent:GetClass() == "prop_vehicle_jeep" then
	
		if ent:GetOwner() ~= ply then
			return false
		end

		timer.Simple(0.01, function()
			ply:CheckAmmo("item_ammo_smg1")
		end)
	elseif ent:GetClass() == "item_ammo_crate" then
		timer.Create("hl2cr_itemcrate_wait_" .. ply:EntIndex(), 0.85, 1, function()
			ply:CheckAllAmmo()
		end)
	end

	return true
end )

function hl2cr_player:AdmireSuitHands()
	self:Give("Admire_Hands")

	timer.Create(self:Nick() .. "_admiring", 4, 1, function()
		self:StripWeapons()
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

	return true
end)

net.Receive("HL2CR_Skills_Purchase", function(len, ply)
	if not ply then return end

	ply:UpdateSkills(net.ReadString())
end)

net.Receive("HL2CR_Model_Update", function(len, ply)
	if not ply then return end

	ply:UpdateModelNetwork(net.ReadString(), net.ReadString())
end)

concommand.Add("hl2cr_test", function(ply)
	net.Start("HL2CR_Endresults")
		net.WriteTable(ply.MapStats)
	net.Send(ply)
end)