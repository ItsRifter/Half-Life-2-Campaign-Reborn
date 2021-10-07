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



local testitem_recipe = {
	[1] = "Test_Mat_1",
	[2] = "Test_Mat_2"
}

local testmat = CreateCraftableItem("Test_Result", "A test result, means this worked", "materials/hl2cr/item_stimshot.jpg", testitem_recipe)

table.insert(GM.CraftableItems, testmat)

if SERVER then
	net.Receive("HL2CR_CraftItem", function(len, ply)
		if not ply then return end
		
		local itemToAdd = net.ReadString()
		local removingItems = {}
		
		local removeItem1 = net.ReadString()
		local removeItem2 = net.ReadString()
		local removeItem3 = net.ReadString()
		local removeItem4 = net.ReadString()
		local removeItem5 = net.ReadString()
		local removeItem6 = net.ReadString()
		
		for i = 1, 6 do
			if (removeItem .. i) then
				print(removeItem .. i)
			end
		end
		
		for i, v in ipairs(GAMEMODE.CraftableItems) do
			if v.Name == itemToAdd then
				
				table.insert(ply.hl2cr.Inventory.Slots, v.Name)
				
				ply:SetNWString("inv_slots", table.concat(ply.hl2cr.Inventory.Slots, " "))
			end
		end
	end)
end