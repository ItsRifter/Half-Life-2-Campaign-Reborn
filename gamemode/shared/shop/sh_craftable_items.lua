AddCSLuaFile()

GM.CraftableItems = {}

function CreateCraftableItem(name, desc, icon, recipe)
	
	local craftitem = {
		["Name"] = name,
		["Desc"] = desc,
		["Icon"] = icon,
		["Recipe"] = recipe
	}
	
	return craftitem
end

local stimshot_recipe = {
	[1] = "Morphine",
	[2] = "Scrap_Metal"
}

local stim = CreateCraftableItem("Stim_Shot", "A syringe filled with morphine\nto keep a fighter going", "materials/hl2cr/item_stimshot.jpg", stimshot_recipe)

table.insert(GM.CraftableItems, stim)

if SERVER then
	net.Receive("HL2CR_CraftItem", function(len, ply)
		if not ply then return end
		
		local itemToAdd = net.ReadString()
		local removingItems = {}
		
		local removeItem1 = net.ReadString() or nil
		local removeItem2 = net.ReadString() or nil
		local removeItem3 = net.ReadString() or nil
		local removeItem4 = net.ReadString() or nil
		local removeItem5 = net.ReadString() or nil
		local removeItem6 = net.ReadString() or nil
				
		for i, v in ipairs(GAMEMODE.CraftableItems) do
			if v.Icon == itemToAdd and table.HasValue(ply.hl2cr.Inventory.Slots, removeItem1) then
				
				if removeItem1 ~= nil then
					table.RemoveByValue(ply.hl2cr.Inventory.Slots, removeItem1)
				end
				
				if removeItem2 ~= nil then
					table.RemoveByValue(ply.hl2cr.Inventory.Slots, removeItem2)
				end
				
				if removeItem3 ~= nil then
					table.RemoveByValue(ply.hl2cr.Inventory.Slots, removeItem3)
				end
				
				if removeItem4 ~= nil then
					table.RemoveByValue(ply.hl2cr.Inventory.Slots, removeItem4)
				end
				
				if removeItem5 ~= nil then
					table.RemoveByValue(ply.hl2cr.Inventory.Slots, removeItem5)
				end
				
				if removeItem6 ~= nil then
					table.RemoveByValue(ply.hl2cr.Inventory.Slots, removeItem6)
				end
				
				table.insert(ply.hl2cr.Inventory.Slots, v.Name)
				
				ply:SetNWString("inv_slots", table.concat(ply.hl2cr.Inventory.Slots, " "))
			end
		end
	end)
end