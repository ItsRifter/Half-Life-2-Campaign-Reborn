AddCSLuaFile()

GM.ShopItems = {}

function AddShopItem(itemTbl)
    table.insert(GM.ShopItems, itemTbl)
end

//Weapons
local medkit = {
    ["Name"] = translate.Get("Shop_Item_Medkit_Name"),
    ["Desc"] = translate.Get("Shop_Item_Medkit_Desc"),
    ["Icon"] = "materials/hl2cr/misc/placeholder.jpg",
    ["Class"] = "weapon_hl2cr_medkit",
    ["OnUse"] = function(ply)
        medkit.Active = true
    end,
    ["Active"] = false,
    ["Persistent"] = true
}

AddShopItem(medkit)