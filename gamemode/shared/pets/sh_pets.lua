AddCSLuaFile()

local hl2cr_pet = FindMetaTable("Entity")

function hl2cr_pet:IsPet()
    if self:GetNWBool("hl2cr_pet", false) then
        return true
    else
        return false
    end
end

HL2CR_Pets = {}

if SERVER then
    
    function hl2cr_pet:SpawnPet()
        
    end
end