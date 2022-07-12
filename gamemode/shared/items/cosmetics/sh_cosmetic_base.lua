AddCSLuaFile()

HL2CR_Cosmetics = {}

function CreateCosmetic(newCosmetic)
    table.insert(HL2CR_Cosmetics, newCosmetic)
end

local dollhead = {
    ["Name"] = translate.Get("Hat_Dollhead_Name"),
    ["Class"] = "hat_dollhead",
    ["TakeDamageFunc"] = function(ply, attacker, dmgType)
        ply:EmitSound("ambient/creatures/teddy.wav", 75, math.random(75, 130))
    end
}

CreateCosmetic(dollhead)

local ravenhead = {
    ["Name"] = translate.Get("Hat_Ballhead_Name"),
    ["Class"] = "hat_ballhead",
    ["TakeDamageFunc"] = function(ply, attacker, dmgType)
        if dmgType ~= DMG_SLASH then return end
        
        dmgInfo = DamageInfo()
        dmgInfo:SetDamageType(DMG_SHOCK)
        dmgInfo:SetDamage(20)
        dmgInfo:SetAttacker(ply)

        attacker:TakeDamageInfo(dmgInfo)
        attacker:EmitSound("npc/roller/mine/rmine_explode_shock1.wav", 100, math.random(80, 120))
    end
}

CreateCosmetic(ravenhead)

if SERVER then
    concommand.Add("hl2cr_hat_test", function(ply)
        table.Empty(ply.hl2cr.Inventory.Cosmetics)
        table.insert(ply.hl2cr.Inventory.Cosmetics, dollhead)

        local cosmetics = {}

        for _, c in ipairs(ply.hl2cr.Inventory.Cosmetics) do
            table.insert(cosmetics, c.Name)
        end

        ply:SetNWString("hl2cr_items_cosmetics", table.concat(cosmetics, " "))

    end)
end

if CLIENT then
    pastOutfit = pastOutfit or nil

    function ApplyCosmetic(outfit, owner)
        pac.SetupENT(owner)

        if pastOutfit then
            owner:RemovePACPart(pastOutfit)
        end
        
        if outfit ~= nil then
            pastOutfit = outfit
            owner:AttachPACPart(outfit)
        end
    end

    net.Receive("HL2CR_Cosmetic_Use", function(len, ply)
        ApplyCosmetic(net.ReadTable(), net.ReadEntity())
    end)
end