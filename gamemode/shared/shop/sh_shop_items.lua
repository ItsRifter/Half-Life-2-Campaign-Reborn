AddCSLuaFile()

GM.ShopItems = {}

function CreateShopItem(name, desc, cost, icon, typeItem)
	
	local item = {
		["Name"] = name,
		["Desc"] = desc,
		["Cost"] = cost,
		["Icon"] = icon,
		["Type"] = typeItem
	}
	
	return item
end

local flaregun = CreateShopItem("Flare_Gun", "Used for emergencies...\nso it was", 7500, "materials/hl2cr/weapon_flaregun.jpg", "Weapon")
local automatic_pistol = CreateShopItem("Automatic_Pistol", "A pistol that is automatic\nno questions", 14250, "materials/hl2cr/weapon_autopistol.jpg", "Weapon")
local grenade_launcher = CreateShopItem("Multi_Grenade_Launcher", "A grenade launcher\nhandle with care", 40000, "materials/hl2cr/weapon_grenadelauncher.jpg", "Weapon")
local shred_ar = CreateShopItem("Shredding_Assault_Rifle", "This thing shreds people", 77500, "materials/hl2cr/weapon_shreddingar.jpg", "Weapon")
local nailer = CreateShopItem("The_Nailer_Gun", "Nailed it!", 32575, "materials/hl2cr/weapon_nailer.jpg", "Weapon")
local unstable_shotgun = CreateShopItem("Unstable_Electric_Shotgun", "Highly unstable\nImmediately throw after use", 50000, "materials/hl2cr/weapon_unstableshotgun.jpg", "Weapon")
local heavy_sniper = CreateShopItem("BMG_Heavy_Sniper", "A rather heavy sniper\nwith devastating results", 75000, "materials/hl2cr/weapon_bmgsniper.jpg", "Weapon")

local test = CreateShopItem("Test", "Test Item\nYou shouldn't be buying this", 1, "materials/hl2cr/empty.jpg", "Item")

table.insert(GM.ShopItems, flaregun)
table.insert(GM.ShopItems, automatic_pistol)
table.insert(GM.ShopItems, grenade_launcher)
table.insert(GM.ShopItems, shred_ar)
table.insert(GM.ShopItems, nailer)
table.insert(GM.ShopItems, unstable_shotgun)
table.insert(GM.ShopItems, heavy_sniper)


--table.insert(GM.ShopItems, test)

if SERVER then
	
	net.Receive("HL2CR_UpdateSlot", function(len, ply)
		if not ply then return end
		
		local slotToUpdate = net.ReadString()
		
		for i, v in ipairs(GAMEMODE.ShopItems) do
			if v.Name == slotToUpdate then
				
				if v.Type == "Weapon" then
					ply.hl2cr.Inventory.CurWeaponSlot = v.Name
					ply:SetNWString("inv_weaponslot", ply.hl2cr.Inventory.CurWeaponSlot)
				end
			end
		end
	end)
	
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
	end)
end