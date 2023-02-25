local AmmoData = {		--ClipSize is used for bonus clip, bonus is for bonus carry
	[1] = {	--AR2 Ammo
		Max = 60,
		ClipSize = 30,
		BonusSize = 30
	},
	[2] = {	--AR2 Alt Ammo
		Max = 3,
		ClipSize = 1,
		BonusSize = 1
	},
	[3] = {	--Pistol Ammo
		Max = 150,
		ClipSize = 18,
		BonusSize = 30
	},
	[4] = {	--Smg1 Ammo
		Max = 225,
		ClipSize = 45,
		BonusSize = 90
	},
	[5] = {	--357 Ammo
		Max = 12,
		ClipSize = 6,
		BonusSize = 6
	},
	[6] = {	--Crossbow Bolts
		Max = 9,
		ClipSize = 1,
		BonusSize = 3
	},
	[7] = {	--Buckshot Shells
		Max = 30,
		ClipSize = 6,
		BonusSize = 12
	},
	[8] = {	--RPG Round
		Max = 3,
		ClipSize = 1,
		BonusSize = 1
	},
	[9] = {	--Smg1 Grenade
		Max = 3,
		ClipSize = 1,
		BonusSize = 1
	},
	[10] = {--Grenades
		Max = 5,
		ClipSize = 1,
		BonusSize = 1
	},

}


function GM:PlayerAmmoChanged( ply, ammoID, oldCount, newCount )
	if oldCount > newCount then return end
	if AmmoData[ammoID] and ply:GetAmmoCount( ammoID ) > ply:GetAmmoMax( ammoID ) then
		ply:SetAmmo(ply:GetAmmoMax( ammoID ), ammoID)
		--return false
	end

end

local AmmoBoxData = {
	["item_ammo_pistol"] = {AmmoType = 3, AmmoAmount = 20},
	["item_ammo_pistol_large"] = {AmmoType = 3, AmmoAmount = 100},
	["item_ammo_357"] = {AmmoType = 5, AmmoAmount = 6},
	["item_ammo_357_large"] = {AmmoType = 5, AmmoAmount = 12},
	["item_ammo_smg1"] = {AmmoType = 4, AmmoAmount = 45},
	["item_ammo_smg1_large"] = {AmmoType = 4, AmmoAmount = 225},
	["item_ammo_smg1_grenade"] = {AmmoType = 9, AmmoAmount = 1},
	["item_ammo_ar2"] = {AmmoType = 1, AmmoAmount = 20},
	["item_ammo_ar2_large"] = {AmmoType = 1, AmmoAmount = 60},
	["item_ammo_ar2_altfire"] = {AmmoType = 2, AmmoAmount = 1},
	["item_box_buckshot"] = {AmmoType = 7, AmmoAmount = 20},
	["item_ammo_buckshot_large"] = {AmmoType = 7, AmmoAmount = 40},
	["item_ammo_crossbow"] = {AmmoType = 6, AmmoAmount = 6},
	["item_rpg_round"] = {AmmoType = 8, AmmoAmount = 1},
	["weapon_frag"] = {AmmoType = 10, AmmoAmount = 1},
}

--0/Pistol 1/smg 2/Ar2Pulse 3/rpg 4/shotgun 5/grenades X-6/357magnum X-7/crossbow X-8/Ar2Balls 9/SmgNades
local CrateToType = {
	[0] = 3,
	[1] = 4,
	[2] = 1,
	[3] = 8,
	[4] = 7,
	[5] = 10,
	[6] = 5,
	[7] = 6,
	[8] = 2,
	[9] = 9,
}

local Enum_To_Type = {
	["Pistol"] = 3,
	["357"] = 5,
	["SMG1"] = 4,
	["SMG1_Grenade"] = 9,
	["AR2"] = 1,
	["AR2AltFire"] = 2,
	["Buckshot"] = 7,
	["Grenade"] = 10,
	["XBowBolt"] = 6,
	["RPG"] = 8,
}

function HL2CR_AmmoTypeValid(id)
	if AmmoData[id] then return true end
	return false
end



function hl2cr_player:CanPickupAmmoBox(boxent)
	local class = boxent:GetClass()
	if AmmoBoxData[class] then	--Only checking known ammo boxes
		local ammo = AmmoBoxData[class]
		local currentamount = self:GetAmmoCount(ammo.AmmoType)
		local maxammo = self:GetAmmoMax( ammo.AmmoType)
		if currentamount >= maxammo   then return false end
		
		local boxamount = ammo.AmmoAmount
		if boxent.spent then boxamount = boxamount - boxent.spent else boxent.spent = 0 end
		if currentamount + boxamount > maxammo then 
			local taken = maxammo - currentamount
			boxent.spent = boxent.spent + taken
			self:GiveAmmo( taken, ammo.AmmoType, false )
			if boxent.spent >= ammo.AmmoAmount or !self:HasSkill("Ammo_1") then
				boxent:Remove()
			end
		else
			self:GiveAmmo( boxamount, ammo.AmmoType, false )
			boxent:Remove()
		end
		return false 
	end

	return true
end


function hl2cr_player:CanOpenAmmoCrate(boxent)
	local boxtype = tonumber(boxent:GetInternalVariable( "ammotype" ))
	local ammotype = CrateToType[boxtype]
	if ammotype then	
		local currentamount = self:GetAmmoCount(ammotype)
		if currentamount >= self:GetAmmoMax(ammotype) then return false end
	end

	return true
end

function hl2cr_player:GetAmmoMax(ammotype)
	if Enum_To_Type[ammotype] then ammotype = Enum_To_Type[ammotype] end
	local ammo = AmmoData[ammotype]
	if self:HasSkill("Ammo_2") then return ammo.Max + ammo.BonusSize end
	return ammo.Max
end

function HL2CR_GetClipSize(ammotype)
	if Enum_To_Type[ammotype] then ammotype = Enum_To_Type[ammotype] end
	local ammo = AmmoData[ammotype]
	return ammo.ClipSize
end