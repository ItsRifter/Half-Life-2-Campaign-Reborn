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

local flaregun = CreateShopItem("Flare_gun", "Used for emergencies...\nso it was", 7500, "materials/hl2cr/weapon_flaregun.jpg", "Weapon")
local grenade_launcher = CreateShopItem("Multi_Grenade_Launcher", "A grenade launcher\nhandle with care", 30000, "materials/hl2cr/weapon_grenadelauncher.jpg", "Weapon")
local heavy_sniper = CreateShopItem(".50_BMG_Heavy_Sniper", "A rather heavy sniper\nwith devastating results", 75000, "materials/hl2cr/weapon_bmgsniper.jpg", "Weapon")
local test = CreateShopItem("Test", "Test Item", 1, "materials/hl2cr/empty.jpg", "Item")

table.insert(GM.ShopItems, flaregun)
table.insert(GM.ShopItems, grenade_launcher)
table.insert(GM.ShopItems, heavy_sniper)
table.insert(GM.ShopItems, test)

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