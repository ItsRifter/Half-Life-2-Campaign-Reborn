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
    ["Persistent"] = true,
    ["Type"] = "Weapon"
}

AddShopItem(medkit)

local autoPistol = {
    ["Name"] = translate.Get("Shop_Item_AutoPistol_Name"),
    ["Desc"] = translate.Get("Shop_Item_AutoPistol_Desc"),
    ["Icon"] = "materials/hl2cr/misc/placeholder.jpg",
    ["Class"] = "weapon_hl2cr_autopistol",
    ["OnUse"] = function(ply)
        autoPistol.Active = true
    end,
    ["Active"] = false,
    ["Persistent"] = true,
    ["Type"] = "Weapon"
}

AddShopItem(autoPistol)

local rampSMG = {
    ["Name"] = translate.Get("Shop_Item_RampageSMG_Name"),
    ["Desc"] = translate.Get("Shop_Item_RampageSMG_Desc"),
    ["Icon"] = "materials/hl2cr/misc/placeholder.jpg",
    ["Class"] = "weapon_hl2cr_rampagesmg",
    ["OnUse"] = function(ply)
        rampSMG.Active = true
    end,
    ["Active"] = false,
    ["Persistent"] = true,
    ["Type"] = "Weapon"
}

AddShopItem(rampSMG)

local crossbowMK2 = {
    ["Name"] = translate.Get("Shop_Item_Crossbow_Name"),
    ["Desc"] = translate.Get("Shop_Item_Crossbow_Desc"),
    ["Icon"] = "materials/hl2cr/misc/placeholder.jpg",
    ["Class"] = "weapon_hl2cr_crossbow",
    ["OnUse"] = function(ply)
        crossbowMK2.Active = true
    end,
    ["Active"] = false,
    ["Persistent"] = true,
    ["Type"] = "Weapon"
}

AddShopItem(crossbowMK2)