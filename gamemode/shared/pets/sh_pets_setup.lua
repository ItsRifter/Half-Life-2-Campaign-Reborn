AddCSLuaFile()

HL2CR_Pets = {}

local function AddPet(newPet)
    table.insert(HL2CR_Pets, newPet)
end

local pet_headcrab = {
    Name = "Headcrab",
    Class = "npc_headcrab",
    Active = false,
    Cosmetic = nil,
    Level = 0,
    LevelCap = 7,
    XP = 0,
    ReqXP = 250,
    Stats = {
        HP = 50,
        Damage = 5,
    }
}

AddPet(pet_headcrab)