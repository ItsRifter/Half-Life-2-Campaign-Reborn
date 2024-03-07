hl2cr_player = hl2cr_player or FindMetaTable( "Player" )

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
	["d3_breen_01"] = true,
	
	--Ep2
	["ep2_outland_01"] = true
}

--Restrict these weapons from being picked up/used
RESTRICTED_WEAPONS = {
	["weapon_physgun"] = true,
	["weapon_stunstick"] = true,
	["weapon_medkit"] = true,

	//Admin stuff
	["swep_construction_kit"] = true,
	
	//HL2 Co-Op RPG stuff
	["admire_hands"] = true,
	["weapon_hl2cr_crowsaw"] = true,
	["weapon_hl2cr_autopistol"] = true,
	["weapon_hl2cr_rampagesmg"] = true,
	["weapon_hl2cr_crossbow"] = true,
	["weapon_hl2cr_medkit"] = true,
	["weapon_hl2cr_ammobox"] = true,
}


DISALLOW_PICKUP = {
	["weapon_stunstick"] = true,
	["weapon_medkit"] = true
}

--[[
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
]]--
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

--[[
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
]]--
local weapon_melees = {
	["weapon_crowbar"] = true,
	--["weapon_hl2cr_crowsaw"] = true,
}

local mapach_setup = {
	["d1_town_01"] = function(ply)
		if table.HasValue(ply.hl2cr.AchProgress, "ZombieChopperActive") or ply:HasAchievement("HL2_Chopper") then return end
		
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

	self:SetModel(newModel)
end

function hl2cr_player:SetUpPlayer()

	if !self.loaded then return end
	self:SetTeam(TEAM_ALIVE)

	self:SetCustomCollisionCheck(true)
	self:SetNoCollideWithTeammates(true)

	self:ChangeModel(self.hl2cr.PMModel)
	
	self:UpdateEquipped()
	table.CopyFromTo( self.hl2cr.Equipped, self.CurrentInv )
	
	timer.Simple(0.5, function()
		if !IsValid(self) or !self:Alive() then return end
		self:SetupHands()
		self:ApplyCosmeticSpawn()
	end)

	if not maps_trainstation[game.GetMap()] then 
		if self.statHP then
			self:SetMaxHealth(self:Health() + self.statHP)
			self:SetHealth(self:GetMaxHealth())
		end
	
		if self.statArmor then
			self:SetMaxArmor(100 + self.statArmor)
		end
	
	end
	
	HL2CR_AUX:SetupAuxPower(self)
	hook.Run("HL2CR_AuxPowerInitialize", self)

end

function hl2cr_player:AdjustSpeed()
	
	if MAPS_NO_SUIT[game.GetMap()] then
		self:SetMaxSpeed(35)
		self:SetWalkSpeed(200)
		self:SetRunSpeed(200)
    elseif game.GetMap() == "d1_trainstation_05" and not GetGlobalBool("HL2CR_GLOBAL_SUIT") then
		self:SetMaxSpeed(35)
		self:SetWalkSpeed(200)
		self:SetRunSpeed(200)
	else
		self:SetMaxSpeed(200)
		self:SetWalkSpeed(200)
		self:SetRunSpeed(350)
	end
end

function hl2cr_player:ApplyCosmeticSpawn()
	--if self.hl2cr.CurCosmetic == "" then return end
	if self.hl2cr.Equipped["HATS"] == "" then return end
	self.hl2cr.CurCosmetic = self.hl2cr.Equipped["HATS"]
	local hat = HL2CR_GetItem("HATS",self.hl2cr.CurCosmetic)
	net.Start("HL2CR_Cosmetic_Use")
		--net.WriteTable(HL2CR_Shared_Cosmetics[self.hl2cr.CurCosmetic])
		net.WriteTable(HL2CR_Shared_Cosmetics[hat.Ref])
		net.WriteEntity(self)
	net.Broadcast()
end

function hl2cr_player:ApplyCosmeticServer(cosmeticToApply)
	if self.hl2cr.CurCosmetic == self.hl2cr.Equipped["HATS"] then return end
	self.hl2cr.CurCosmetic = self.hl2cr.Equipped["HATS"]
	if cosmeticToApply == "" or cosmeticToApply == nil then

		net.Start("HL2CR_Cosmetic_Use")
			net.WriteTable({})
			net.WriteEntity(self)
		net.Broadcast()
		return
	end
	
	local hat = HL2CR_GetItem("HATS",cosmeticToApply)

	self:BroadcastMessage(HL2CR_GreenColour, hat.Name .. translate.Get("Player_CosmeticApply"))

	net.Start("HL2CR_Cosmetic_Use")
		net.WriteTable(HL2CR_Shared_Cosmetics[hat.Ref])
		net.WriteEntity(self)
	net.Broadcast()
end

function hl2cr_player:DisplayAnyWarnings()
	if GetConVar("hl2cr_nosaving"):GetInt() == 1 then
		self:BroadcastMessage(HL2CR_WarningColour, translate.Get("Player_Warning_NoSave"))
	end

	if GetConVar("hl2cr_save_disconnectwipe"):GetInt() == 1 then
		self:BroadcastMessage(HL2CR_WarningColour, translate.Get("Player_Warning_SaveClearDisconnect"))
	end
end

function hl2cr_player:SetUpInitialSpawn()
    if self:IsBot() then self:SetTeam(TEAM_ALIVE) return end

	self:LoadSkills()
	self:SetUpPlayer()

	if mapach_setup[game.GetMap()] then
		mapach_setup[game.GetMap()](self)
	end

	self.damagexp = self.damagexp or 0
	--self.damagexptotal = self.damagexptotal or 0

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
		--self:BroadcastMessage(HL2CR_PlayerColour, translate.Get("Server_Announce_Vortex_Spawn"))
	end

	self:DisplayAnyWarnings()
end

function hl2cr_player:SetUpRespawnRevive()
	if self:IsBot() then self:SetTeam(TEAM_ALIVE) return end
	
	self:SetTeam(TEAM_ALIVE)

	if self.Ragdoll then
		self.Ragdoll:Remove()
		self.Ragdoll = nil 
	end
	
	self:UnSpectate()
	
	self:GiveEquipment()
	self:GiveWeaponsSpawn()
	self:AdjustSpeed()
	self:UpdateClass()
end

function hl2cr_player:SetUpRespawn()
	if self:IsBot() then self:SetTeam(TEAM_ALIVE) return end

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
				if self:HasSkill("Ammo_3") then self:GiveAmmo(HL2CR_GetClipSize(item.Type),item.Type,true) end
			end
		end
	end
end

--function hl2cr_player:SpawnWithActiveWeapons()
--	if MAPS_NO_SUIT[game.GetMap()] or (game.GetMap() == "d1_trainstation_05" and GetGlobalBool("HL2CR_GLOBAL_SUIT") == false) then return end
--	for _, i in ipairs(self.hl2cr.Inventory.Weapons) do
--		if i.Active then
--			self:Give(i.Class)
--		end
--	end
--end

function hl2cr_player:GiveWeaponsSpawn()
	if !self.loaded then return end
	table.CopyFromTo( self.hl2cr.Equipped, self.CurrentInv )
	for _, weapon in ipairs(SPAWNING_WEAPONS) do
		local given = self:Give(weapon)
		if self:HasSkill("Ammo_3") and IsValid(given) then 
			local ammotype = given:GetPrimaryAmmoType()
			if ammotype != -1 then self:GiveAmmo(HL2CR_GetClipSize(ammotype),ammotype,true) end
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
		if ent.hpRegen and ent:Health() < ent:GetMaxHealth() then
			if ent:Health() >= ent:GetMaxHealth() then
				return 
			end

			timer.Create("HL2CR_HPRegen_" .. ent:EntIndex(), 15, 999, function()
				ent:SetHealth(ent:Health() + ent.hpRegen)
				if ent:Health() >= ent:GetMaxHealth() then
					ent:SetHealth(ent:GetMaxHealth())
					timer.Remove("HL2CR_HPRegen_" .. ent:EntIndex())
				end
			end)
		end
	end
end

local storable_weapons = {
	["weapon_crowbar"]=true,
	["weapon_pistol"]=true,
	["weapon_smg1"]=true,
	["weapon_357"]=true,
	["weapon_physcannon"]=true,
	["weapon_shotgun"]=true,
	["weapon_ar2"]=true,
	["weapon_rpg"]=true,
	["weapon_crossbow"]=true
}

--Stores the weapons for player joining or respawning
function StoreWeapons(newWeapon)
	--If this is a restricted weapon, do not store it
	if !storable_weapons[newWeapon] then return end
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
		local newwpn = p:GetRelativeWeapon(newWeapon)
		if p:Team() == TEAM_AFK or p:Team() == TEAM_COMPLETED_MAP or p:HasWeapon(newwpn) then continue end
		
		if game.GetMap() == "d1_trainstation_06" and newWeapon == "weapon_crowbar" then
			--p:GrantAchievement("Trusty Hardware")
			p:GiveAchievement("HL2","HL2_Crowbar")
		end

		p:Give(newwpn)
	end
end

function BroadcastMessageToAll(...)
	net.Start("HL2CR_ChatMessage")
		net.WriteTable({...})
	net.Broadcast()
end

function BroadcastMessageToAdmins(...)	
	for _, v in ipairs(player.GetAll()) do
		if v:IsSuperAdmin() then
			net.Start("HL2CR_ChatMessage")
				net.WriteTable({...})
			net.Send(v)
		end
	end
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

function NotificationAll(text,vector,colour,IType)
	net.Start( "HL2CR_Indicator" )
		net.WriteString(text)	
		net.WriteVector(vector)
		net.WriteUInt(colour,7)	
		net.WriteUInt(IType,5)		
	net.Broadcast()
end

function NotificationRadius(text,vector,colour,IType,radius)
	local plist = {}
	local sqrad = radius * radius
	for _, p in pairs(player.GetAll()) do
		if p:GetPos():DistToSqr( vector) < sqrad then
			table.insert( plist, p )
		end
	end

	net.Start( "HL2CR_Indicator" )
		net.WriteString(text)	
		net.WriteVector(vector)
		net.WriteUInt(colour,7)	
		net.WriteUInt(IType,5)		
	net.Send(plist)
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
------------------------------------------------------------
------------------------------------------------------------
function hl2cr_player:GetAP()
	if self.hl2cr.AP then return self.hl2cr.AP end
	return 0
end

function hl2cr_player:AddAP(amount)
	if !self.hl2cr.AP then self.hl2cr.AP = 0 end
	self.hl2cr.AP = self.hl2cr.AP + amount
	self:SendAP()
end

function hl2cr_player:SendAP()
	net.Start("HL2CR_CL_SENDAP")
		net.WriteUInt(self:GetAP(), 12)
	net.Send(self)
end

------------------------------------------------------------
------------------------------------------------------------
function hl2cr_player:SendItems()
	if self:IsBot() then return end
	--PrintTable(self.hl2cr.Items)
	net.Start( "HL2CR_CL_SendItems" )
		net.WriteTable(self.hl2cr.Items)
	net.Send(self)
end

function hl2cr_player:GiveItem(id)
	if self:IsBot() then return end
	if self:HasItem(id) then return end
	
	table.insert(self.hl2cr.Items, id)
	net.Start( "HL2CR_CL_AddItem" )
		net.WriteString(id)
	net.Send(self)

end

function hl2cr_player:HasItem(id)
	--if true then return true end
	if id == "" then return true end
	return table.HasValue(self.hl2cr.Items, id)
end

function hl2cr_player:UpdateEquipped()
	self:ApplyCosmeticServer(self.hl2cr.Equipped["HATS"])
	net.Start("HL2CR_SendLoadout")
		net.WriteString(self.hl2cr.Equipped["HATS"])
		net.WriteString(self.hl2cr.Equipped["MELEE"])
		net.WriteString(self.hl2cr.Equipped["PISTOL"])
		net.WriteString(self.hl2cr.Equipped["REV"])
		net.WriteString(self.hl2cr.Equipped["SMG"])
		net.WriteString(self.hl2cr.Equipped["SHGUN"])
		net.WriteString(self.hl2cr.Equipped["XBOW"])
	net.Send(self)
end
------------------------------------------------------------
------------------------------------------------------------
function hl2cr_player:GiveNewSkill(skill)
	if !HL2CR_NewSkills[skill] then return end
	local newskill = HL2CR_NewSkills[skill]
	if self:HasSkill(skill) then return end
	if !self:SkillUnlocked(skill) then return end
	if self.hl2cr.SkillPoints < newskill.cost then return end
	table.insert(self.hl2cr.Skills, skill)
	self.hl2cr.SkillPoints = self.hl2cr.SkillPoints - newskill.cost
	net.Start( "HL2CR_CL_AddSkill" )
		net.WriteString(skill)
		net.WriteUInt(self.hl2cr.SkillPoints,12)
	net.Send(self)
end

function hl2cr_player:CreateRagdollBody(dmgInfo)
	local ragdoll = ents.Create("prop_ragdoll")
	ragdoll:SetModel(self:GetModel())
	ragdoll:SetPos(self:GetPos())
	ragdoll:SetAngles(self:GetAngles())
	ragdoll:SetOwner(self)
	ragdoll:Spawn()
	ragdoll:Activate()
	ragdoll:SetCollisionGroup(COLLISION_GROUP_PASSABLE_DOOR)
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
	ply:Flashlight(false)
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
	if not victim:IsBot() then victim.MapStats.Deaths = victim.MapStats.Deaths + 1 end

	--if game.GetMap() == "ep2_outland_02" then
		if victim.NoDeaths then
			if game.GetMap() == "ep2_outland_02" then
				victim:BroadcastMessage(HL2CR_RedColour, translate.Get("Achievement_NoDeath_Failed"), translate.Get("Achievement_EP2_Antlions"))
			elseif game.GetMap() == "d2_prison_07" then
				victim:BroadcastMessage(HL2CR_RedColour, translate.Get("Achievement_NoDeath_Failed"), translate.Get("Achievement_HL2_WardenFreeman_Name"))
			end
			victim.NoDeaths = false
		end
		--victim.NoDeaths = false
	--end

	victim.CanRespawn = false
	victim.TimeDied = (10 * HL2CR_GetDiff()) + CurTime()

	CheckPlayerCompleted()
end

function GM:PlayerDeathThink( ply )
	if ply:IsBot() then return false end

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

function hl2cr_player:GetRelativeWeapon(weaponclass)
	if weaponclass=="weapon_crowbar" then
		local weapon = HL2CR_GetItem("MELEE",self.CurrentInv["MELEE"])
		if weapon then return weapon.Ref end
	elseif weaponclass=="weapon_pistol" then
		local weapon = HL2CR_GetItem("PISTOL",self.CurrentInv["PISTOL"])
		if weapon then return weapon.Ref end
	elseif weaponclass=="weapon_357" then
		local weapon = HL2CR_GetItem("REV",self.CurrentInv["REV"])
		if weapon then return weapon.Ref end
	elseif weaponclass=="weapon_smg1" then
		local weapon = HL2CR_GetItem("SMG",self.CurrentInv["SMG"])
		if weapon then return weapon.Ref end
	elseif weaponclass=="weapon_shotgun" then
		local weapon = HL2CR_GetItem("SHGUN",self.CurrentInv["SHGUN"])
		if weapon then return weapon.Ref end
	elseif weaponclass=="weapon_crossbow" then
		local weapon = HL2CR_GetItem("XBOW",self.CurrentInv["XBOW"])
		if weapon then return weapon.Ref end
	end
	
	return weaponclass
end

hook.Add("PlayerCanPickupWeapon", "HL2CR_WeaponPickup", function(ply, weapon)
	if not ply:IsValid() then return end
	if ply:Team() ~= TEAM_ALIVE then return end

	if weapon:GetClass() == "weapon_physgun" and not ply:IsAdmin() then
		return false
	end
	
	if DISALLOW_PICKUP[weapon:GetClass()] then 
		return false 
	end

	local newwpn = ply:GetRelativeWeapon(weapon:GetClass())

	--Store the weapon
	if weapon:IsValid() then
		StoreWeapons(weapon:GetClass())
	end
	
	if ply:HasWeapon(newwpn) and not weapon_melees[newwpn] then
	--if ply:HasWeapon(weapon:GetClass()) and not weapon_melees[weapon:GetClass()] then
		
		local ammotype = weapon:GetPrimaryAmmoType()
		
		if not ply:CanPickupAmmo(ammotype) then
			return false
		else
			if weapon:GetClass() != newwpn then
				ply:GiveAmmo(HL2CR_GetClipSize(ammotype),ammotype)
				weapon:Remove()
				return false
			end
		end

		--timer.Simple(0.01, function()
		--	ply:CheckAmmo(lastWep)
		--end)
	end

	--if ply:GiveRelativeWeapon(weapon:GetClass()) then weapon:Remove() return false end
	if !ply:HasWeapon(newwpn) and weapon:GetClass() != newwpn then
		ply:Give(newwpn)
		weapon:Remove()
		return false
	end
	
	return true

	--return true
end)

function GM:GravGunPunt( ply, ent )
    if ply:InVehicle() then return false end
	local class = ent:GetClass() 
	if class == "prop_static" or class == "prop_dynamic" then return false end
	if class == "prop_physics" then 
		if !ent:GetPhysicsObject():IsMotionEnabled()then return false end
	end

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
	--self:SetNWInt("hl2cr_stat_skillpoints", self.hl2cr.SkillPoints)

	net.Start( "HL2CR_CL_SendSkills" )
		net.WriteTable(self.hl2cr.Skills)
		net.WriteUInt(self.hl2cr.SkillPoints,12)
	net.Send(self)

	self:SendAchievements()
	self:SendAP()
	self:SendItems()

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

	if XPFARM_MAPS[game.GetMap()] then
		ply:BroadcastMessage(HL2CR_WarningColour, translate.Get("Map_Warning_XPFarm"))
	end

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


concommand.Add( "HL2CR_Lights", function( ply )
	if IsValid(ply.vehicle) and ply:InVehicle() then
		if ply:GetVehicle()!= ply.vehicle then return end
		if IsValid(ply.vehicle.light)then
			if ply.jeeplights then
				ply.vehicle.light:Input( "TurnOff", NULL, NULL, "" )
			else
				ply.vehicle.light:Input( "TurnOn", NULL, NULL, "" )
			end
			ply.jeeplights = !ply.jeeplights
		end
	end
end )


--Only one can exist so moving them here
function GM:ShowHelp(ply)
	if HL2CR_Voting.State then 
		HL2CR_Voting:PlayerVote(ply, true)
	else
		net.Start("HL2CR_HelpMenu")
		net.Send(ply)
	end
end
function GM:ShowTeam(ply)
	HL2CR_Voting:PlayerVote(ply, false)
end

function hl2cr_player:FindSurface()
	local tr = util.TraceLine( {
		start = self:GetPos()+ Vector(0,0,32),
		endpos = self:GetPos() + Vector(0,0,512),
		collisiongroup = COLLISION_GROUP_DEBRIS,
		mask = MASK_SOLID
	} )

	tr = util.TraceLine( {
		start = tr.HitPos,
		endpos = tr.HitPos - Vector(0,0,512),
		collisiongroup = COLLISION_GROUP_DEBRIS,
		mask = MASK_WATER || MASK_SOLID
	} )

	return tr.HitPos
end


hook.Add( "PlayerUse", "HL2CR_PlayerUse", function( ply, ent )
	--if ent:GetClass() == "prop_vehicle_prisoner_pod" and ent.IsPassenger and ply.vehicle then
	if ent.IsPassenger and ent:GetParent() == ply.vehicle then	--Dont climb into own cars side seats
		return false
	end

	if ent:GetOwner() ~= nil then
		ply:SetAllowWeaponsInVehicle(false)
	else
		ply:SetAllowWeaponsInVehicle(true)
	end

	if ent:IsVehicle() and disableVehiclesGlobal then
		if !ply.LastErrorTime then
			ply.LastErrorTime = 0
		end
		
		if ply.LastErrorTime + 2< CurTime() then
			ply.LastErrorTime = CurTime()
			ply:BroadcastMessage(HL2CR_RedColour, translate.Get("Error_Player_Vehicle_Disabled"))
		end
		return false
	end

	if ent:GetClass() == "prop_vehicle_jeep" or ent:GetClass() == "prop_vehicle_airboat" then
	
		if ent:GetOwner():IsValid() and ent:GetOwner() ~= ply then
			return false
		end

		--timer.Simple(0.01, function()
		--	ply:CheckAmmo("item_ammo_smg1")
		--end)
	--elseif ent:GetClass() == "item_ammo_crate" then
	--	timer.Create("hl2cr_itemcrate_wait_" .. ply:EntIndex(), 1, 2, function()
	--		ply:CheckAllAmmo()
	--	end)
	--end
	elseif ent:GetClass() == "item_ammo_crate" then
		if !ply:CanOpenAmmoCrate(ent) then return false end	--blocks people holding ammo crates open when they are full
	end

	return true
end )

function hl2cr_player:AdmireSuitHands()
	self:Give("Admire_Hands")
	self:SetActiveWeapon(self:GetWeapon("admire_hands"))
	timer.Create(self:Nick() .. "_admiring", 4, 1, function()
		self:StripWeapons()
		self:GiveEquipment()
		--self:SpawnWithActiveWeapons()
	end)
end

hook.Add("PlayerCanPickupItem", "HL2CR_ItemAmmoPickup", function(ply, item)
	if item:GetClass() == "item_suit" and game.GetMap() == "d1_trainstation_05" then
		SetGlobalBool( "HL2CR_GLOBAL_SUIT", true )

		for _, v in ipairs(player.GetAll()) do
			 if v:Team() == TEAM_AFK then continue end
			v:AdjustSpeed()
			v:AdmireSuitHands()
		end
	end

	local lastItem = item:GetClass()

	if !ply:CanPickupAmmoBox(item) then return false end

	--if ammo_filter[lastItem] then
	--	if not ply:CanPickupAmmo(lastItem) then
	--		return false
	--	end
		--timer.Simple(0.01, function()
		--	ply:CheckAmmo(lastItem)
		--end)
	--end
	
	if item:GetClass() == "item_battery" then	--Fun battery finding adds flashlight power
		HL2CR_AUX:AddFlashlightPower(ply, 0.4)
	end

	return true
end)

---------------------------------------------------------------

net.Receive("HL2CR_Skills_Purchase", function(len, ply)
	if not ply then return end

	ply:GiveNewSkill(net.ReadString())
end)

net.Receive("HL2CR_Model_Update", function(len, ply)
	if not ply then return end

	local mdl = HL2CR_GetModelFromName(net.ReadString(),net.ReadString(),HL2CR_GetLvlAccess(ply))
	if mdl then ply:UpdateModelNetwork(mdl) end

	--ply:UpdateModelNetwork(mdl)
end)


net.Receive("HL2CR_Item_Purchase", function(len, ply)
	if not ply then return end

	local itemgroup = net.ReadString()
	local itemid = net.ReadString()
	
	local item = HL2CR_GetItem(itemgroup,itemid)
	
	if item then
		if !item.APCOST then return end
		if ply:GetAP() >= item.APCOST then
			ply:GiveItem(itemid)
			ply:AddAP(-item.APCOST)
		end
	
	end

end)


net.Receive("HL2CR_SendLoadout", function(len, ply)
	if not ply then return end
	local id = net.ReadString()
	if ply:HasItem(id) then ply.hl2cr.Equipped["HATS"] = id end
	id = net.ReadString()
	if ply:HasItem(id) then ply.hl2cr.Equipped["MELEE"] = id end
	id = net.ReadString()
	if ply:HasItem(id) then ply.hl2cr.Equipped["PISTOL"] = id end
	id = net.ReadString()
	if ply:HasItem(id) then ply.hl2cr.Equipped["REV"] = id end
	id = net.ReadString()
	if ply:HasItem(id) then ply.hl2cr.Equipped["SMG"] = id end
	id = net.ReadString()
	if ply:HasItem(id) then ply.hl2cr.Equipped["SHGUN"] = id end
	id = net.ReadString()
	if ply:HasItem(id) then ply.hl2cr.Equipped["XBOW"] = id end
	
	ply:UpdateEquipped()
end)