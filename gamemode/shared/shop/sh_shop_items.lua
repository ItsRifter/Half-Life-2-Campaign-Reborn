AddCSLuaFile()

GM.ShopItems = {}

function CreateShopItem(name, desc, cost, icon, typeItem, stackAmount)
	
	local item = {
		["Name"] = name,
		["Desc"] = desc,
		["Cost"] = cost,
		["Icon"] = icon,
		["Type"] = typeItem,
		["stacks"] = stackAmount or 1
	}
	
	table.insert(GM.ShopItems, item)
end

local flaregun = CreateShopItem("Flare_Gun", "Used for emergencies...\nso it was", 7500, "materials/hl2cr/weapon_flaregun.jpg", "Weapon")
local automatic_pistol = CreateShopItem("Automatic_Pistol", "A pistol that is automatic\nno questions", 14250, "materials/hl2cr/weapon_autopistol.jpg", "Weapon")
local grenade_launcher = CreateShopItem("Multi_Grenade_Launcher", "A grenade launcher\nhandle with care", 40000, "materials/hl2cr/weapon_grenadelauncher.jpg", "Weapon")
local shred_ar = CreateShopItem("Shredding_Assault_Rifle", "This thing shreds people", 77500, "materials/hl2cr/weapon_shreddingar.jpg", "Weapon")
local nailer = CreateShopItem("The_Nailer_Gun", "Nailed it!", 32575, "materials/hl2cr/weapon_nailer.jpg", "Weapon")
local unstable_shotgun = CreateShopItem("Unstable_Electric_Shotgun", "Highly unstable\nImmediately throw after use", 50000, "materials/hl2cr/weapon_unstableshotgun.jpg", "Weapon")
local heavy_sniper = CreateShopItem("BMG_Heavy_Sniper", "A rather heavy sniper\nwith devastating results", 75000, "materials/hl2cr/weapon_bmgsniper.jpg", "Weapon")

local suit_buff = CreateShopItem("Suit_PWR_Boost", "Decreases suit power\ncharge speed on 50%", 35000, "materials/hl2cr/item_powerboost.jpg", "Item")

local long_boots = CreateShopItem("Longfall_Boots", "Stolen from Black Mesa's peers\nRESIST: 0.75", 7500, "materials/hl2cr/boot_longfall.jpg", "Boots")
local metal_boots = CreateShopItem("Metal_Boots", "Metal and bulky\nRESIST: 0.35", 3000, "materials/hl2cr/boot_metal.jpg", "Boots")
local lgt_vest = CreateShopItem("Light_Vest", "Lighter alternative than the heavy vest\nRESIST: 0.65", 5000, "materials/hl2cr/chest_vest.jpg", "Chest")
local hvy_vest = CreateShopItem("Heavy_Vest", "Made to stop a bullet\nRESIST: 0.85", 12500, "materials/hl2cr/chest_heavyvest.jpg", "Chest")
local hecu_helm = CreateShopItem("HECU_Helm", "Military grade Gasmask\nRESIST: 0.25", 2000, "materials/hl2cr/helmet_hecu.jpg", "Helmet")
local robo_helm = CreateShopItem("Robo_Helm", "Disasembled and safe to use for humans\nRESIST: 1", 25000, "materials/hl2cr/helmet_robot.jpg", "Helmet")
local exo_pads = CreateShopItem("Exosuit_Shoulders", "Part of an Exosuit\nRESIST: 0.65", 22500, "materials/hl2cr/shoulder_exo.jpg", "Shoulders")
local exo_vest = CreateShopItem("Exosuit_Vest", "Part of an Exosuit\nRESIST: 1.15", 27500, "materials/hl2cr/chest_exo.jpg", "Chest")
local exo_boots = CreateShopItem("Exosuit_Boots", "Part of an Exosuit\nRESIST: 0.45", 20000, "materials/hl2cr/boot_exo.jpg", "Boots")

local iron = CreateShopItem("Iron", "Test Item\nYou shouldn't be buying this", 999999, "materials/hl2cr/mat_iron.jpg", "Material", 30)
local scrap_metal = CreateShopItem("Scrap_Metal", "Test Item\nYou shouldn't be buying this", 999999, "materials/hl2cr/mat_scrap.jpg", "Material", 12)
local morphine = CreateShopItem("Morphine", "Test Item\nYou shouldn't be buying this", 999999, "materials/hl2cr/mat_morphine.jpg", "Material", 3)

if SERVER then
	
	local CONVERT_CRAFT_TO_WEAPON = {
		["Test_Result"] = "weapon_stimshot_health",
	}
	
	local SELL_CRAFTABLES = {
		[1] = "Test_Result"
	}
	
	net.Receive("HL2CR_SellSlot", function(len, ply)
		if not ply then return end
		
		local slotToSell = net.ReadString()
		
		for i, v in ipairs(GAMEMODE.ShopItems) do
			if v.Name == slotToSell then
			
				table.RemoveByValue(ply.hl2cr.Inventory.Slots, v.Name)
				ply:SetNWString("inv_slots", table.concat(ply.hl2cr.Inventory.Slots, " "))
				
				if v.Cost then return end
					
				ply.hl2cr.Resin = ply.hl2cr.Resin + math.ceil(v.Cost / 3)
				ply:SetNWInt("currency_resin", ply.hl2cr.Resin)
				
				if ply:GetNWString("inv_armorslot_helmet") == slotToSell then
					ply:SetNWString("inv_armorslot_helmet", "")
				end
				
				if ply:GetNWString("inv_armorslot_shoulders") == slotToSell then
					ply:SetNWString("inv_armorslot_shoulders", "")
				end
				
				if ply:GetNWString("inv_armorslot_chest") == slotToSell then
					ply:SetNWString("inv_armorslot_chest", "")
				end
				
				if ply:GetNWString("inv_armorslot_boots") == slotToSell then
					ply:SetNWString("inv_armorslot_boots", "")
				end
				
				if ply:GetNWString("inv_weaponslot") == slotToSell then
					ply:SetNWString("inv_weaponslot", "")
				end
				
			elseif SELL_CRAFTABLES[i] == slotToSell then
				table.RemoveByValue(ply.hl2cr.Inventory.Slots, slotToSell)
				ply:SetNWString("inv_slots", table.concat(ply.hl2cr.Inventory.Slots, " "))
			end
		end
	end)
	
	net.Receive("HL2CR_UpdateSlot", function(len, ply)
		if not ply then return end
		
		local slotToUpdate = net.ReadString()
		local isUsable = net.ReadBool() or false

		if isUsable then
			for i, v in ipairs(GAMEMODE.CraftableItems) do
				if v.Name == slotToUpdate and not ply:HasWeapon(CONVERT_CRAFT_TO_WEAPON[v.Name]) then
					ply:Give(CONVERT_CRAFT_TO_WEAPON[v.Name])
					table.RemoveByValue(ply.hl2cr.Inventory.Slots, v.Name)
					ply:SetNWString("inv_slots", table.concat(ply.hl2cr.Inventory.Slots, " "))
				end
			end
			
			return
		end
		
		for i, v in ipairs(GAMEMODE.ShopItems) do
			if v.Name == slotToUpdate and v.Type == "Weapon" then
				ply.hl2cr.Inventory.CurWeaponSlot = v.Name
				ply:SetNWString("inv_weaponslot", ply.hl2cr.Inventory.CurWeaponSlot)
				
			elseif v.Name == slotToUpdate and v.Type == "Item" then
				ply.hl2cr.Inventory.CurItemSlot = v.Name
				ply:SetNWString("inv_itemslot", ply.hl2cr.Inventory.CurItemSlot)
				
			elseif v.Name == slotToUpdate and v.Type == "Helmet" then
				ply.hl2cr.Inventory.ArmorSlots["Helmet"] = v.Name
				ply:SetNWString("inv_armorslot_helmet", ply.hl2cr.Inventory.ArmorSlots["Helmet"])
				
			elseif v.Name == slotToUpdate and v.Type == "Shoulders" then
				ply.hl2cr.Inventory.ArmorSlots["Shoulders"] = v.Name
				ply:SetNWString("inv_armorslot_shoulders", ply.hl2cr.Inventory.ArmorSlots["Shoulders"])
				
			elseif v.Name == slotToUpdate and v.Type == "Chest" then
				ply.hl2cr.Inventory.ArmorSlots["Chest"] = v.Name
				ply:SetNWString("inv_armorslot_chest", ply.hl2cr.Inventory.ArmorSlots["Chest"])
				
			elseif v.Name == slotToUpdate and v.Type == "Boots" then
				ply.hl2cr.Inventory.ArmorSlots["Boots"] = v.Name
				ply:SetNWString("inv_armorslot_boots", ply.hl2cr.Inventory.ArmorSlots["Boots"])
			end
		end
		
		SetUpPlayerArmorStats(ply)
	end)
	
	net.Receive("HL2CR_ObtainItem", function(len, ply)
		if not ply then return end
		
		local itemToAdd = net.ReadString()
		
		for i, v in ipairs(GAMEMODE.ShopItems) do
			if v.Name == itemToAdd then
				
				table.insert(ply.hl2cr.Inventory.Slots, v.Name)
				
				ply:SetNWString("inv_slots", table.concat(ply.hl2cr.Inventory.Slots, " "))
				
				ply.hl2cr.Resin = ply.hl2cr.Resin - v.Cost
				ply:SetNWInt("currency_resin", ply.hl2cr.Resin)
			end
		end
	end)
	--[[
	net.Receive("HL2CR_PurchaseItem", function(len, ply)
		if not ply then return end
		
		local itemToAdd = net.ReadString()
		
		for i, v in ipairs(GAMEMODE.ShopItems) do
			if v.Name == itemToAdd then
				
				table.insert(ply.hl2cr.Inventory.Slots, v.Name)
				
				ply:SetNWString("inv_slots", table.concat(ply.hl2cr.Inventory.Slots, " "))
				
				ply.hl2cr.Resin = ply.hl2cr.Resin - v.Cost
				ply:SetNWInt("currency_resin", ply.hl2cr.Resin)
			end
		end
	end)--]]
end