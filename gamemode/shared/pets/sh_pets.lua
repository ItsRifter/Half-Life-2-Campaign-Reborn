AddCSLuaFile()

local hl2cr_pet = FindMetaTable("Entity")

function hl2cr_pet:IsPet()
    if self:GetNWBool("hl2cr_pet", false) and self:IsNPC() then
        return true
    else
        return false
    end
end

if SERVER then
    local pet_hostiles = {
        [1] = "npc_headcrab D_HT 99",
        [2] = "npc_headcrab_fast D_HT 99",
        [3] = "npc_headcrab_black D_HT 99",
        [4] = "npc_headcrab_poison D_HT 99",
        [5] = "npc_zombie_torso D_HT 99",
        [6] = "npc_zombie D_HT 99",
        [7] = "npc_fastzombie D_HT 99",
        [8] = "npc_poisonzombie D_HT 99",
        [9] = "npc_zombine D_HT 99 ",
        [10] = "npc_cscanner D_HT 99",
        [11] = "npc_metropolice D_HT 99",
        [12] = "npc_manhack D_HT 99",
        [13] = "npc_combine_s D_HT 99",
        [15] = "npc_antlionguard D_HT 99",
        [16] = "npc_antlionguardian D_HT 99",
        [17] = "npc_barnacle D_HT 99",
        [18] = "npc_turret_ground D_HT 99",
        [19] = "npc_antlion D_HT 99",
        [20] = "npc_antlion_worker D_HT 99"
    }

    local pet_friendly = {
        [1] = "npc_kleiner D_LI 99",
        [2] = "npc_dog D_LI 99",
        [3] = "npc_eli D_LI 99",
        [4] = "npc_monk D_LI 99",
        [5] = "npc_alyx D_LI 99",
        [6] = "npc_barney D_LI 99",
        [7] = "npc_fisherman D_LI 99",
        [8] = "npc_mossman D_LI 99",
        [9] = "npc_gman D_LI 99",
        [10] = "npc_breen D_LI 99"
    }
    
    function SpawnPet(spawner)
        if table.IsEmpty(spawner.hl2cr.Pets) then return nil end
        local petClass = nil

        for _, p in ipairs(spawner.hl2cr.Pets) do
            if p.Active then
                petClass = p.Class
                break
            end
        end
        
        if petClass == nil then return nil end

        local pet = ents.Create(petClass)
        pet:SetNWBool("hl2cr_pet", true)
        pet:Spawn()
        pet:SetOwner(spawner)
        pet:SetPos(spawner:GetPos())
        pet:SetHealth(25)

        return pet
    end

    function hl2cr_pet:UpdatePlayerRelationship(pl)
        self:AddEntityRelationship(pl, D_LI, 99)
    end

    function hl2cr_pet:UpdateRelationships()
        self:AddEntityRelationship(self:GetOwner(), D_LI, 99)
        
        for _, v in ipairs(player.GetAll()) do
            if v == self:GetOwner() then continue end
            self:AddEntityRelationship(v, D_LI, 99)
        end

        for i, h in ipairs(pet_hostiles) do
            self:AddRelationship(pet_hostiles[i], D_HT, 99)
        end

        for i, f in ipairs(pet_friendly) do
            self:AddRelationship(pet_friendly[i], D_LI, 99)
        end
    end

    function hl2cr_pet:UpdatePlayerRelation(pl)
        self:AddEntityRelationship(pl, D_LI, 99)
    end

    function hl2cr_pet:RemovePet()
        if self:GetOwner().activePet then
            self:GetOwner().activePet = nil
            self:Remove()
        end
    end

    function hl2cr_pet:MakeFriendlyNotFear(friend)
        friend:AddEntityRelationship(self, D_LI, 99)
    end

    function hl2cr_pet:MakeFriendlyTowardsPet(pet)
        self:AddEntityRelationship(pet, D_LI, 99)
        pet:AddEntityRelationship(self, D_LI, 99)
    end


    function hl2cr_pet:MakeHostileTarget(hostile)
        hostile:AddEntityRelationship(self, D_HT, 99)
    end

    local timeSinceTele = 0

    function BringPetToPlayer(ply)
        if not ply.activePet then return end

        if timeSinceTele > CurTime() then return end

        timeSinceTele = 5 + CurTime()

        ply.activePet:SetPos(ply:GetPos())
    end

    function CreatePet(ply)
        if ply.activePet then return end

        if MAPS_NO_PETS[game.GetMap()] then return end

        ply.activePet = SpawnPet(ply)

        if ply.activePet == nil then return end

        ply.activePet:UpdateRelationships()
        ply.activePet:SetCollisionGroup(COLLISION_GROUP_WEAPON)
        
        for _, npc in ipairs(ents.FindByClass("npc_*")) do
            if npc:IsNPC() then
               if npc:IsFriendly() then ply.activePet:MakeFriendlyNotFear(npc) end

               if npc:IsHostile() then ply.activePet:MakeHostileTarget(npc) end

               if npc:IsPet() then ply.activePet:MakeFriendlyTowardsPet(npc) end
            end
        end
    end

    concommand.Add("hl2cr_pet_spawn", function(ply)
        CreatePet(ply)
    end)

    concommand.Add("hl2cr_pet_bring", function(ply)
        BringPetToPlayer(ply)
    end)

    concommand.Add("hl2cr_pet_remove", function(ply)
        if ply.activePet then
            ply.activePet:RemovePet()
        end
    end)

    hook.Add( "OnEntityCreated", "HL2CR_Pet_UpdateRelation", function( ent )
        if not ent:IsPet() then return end
        
        timer.Simple(0.1, function()
            for _, v in ipairs(player.GetAll()) do
                if not v.activePet then continue end
                
                if ent:IsFriendly() then
                    v.activePet:MakeFriendlyNotFear(ent)
                elseif ent:IsPet() then 
                    v.activePet:MakeFriendlyTowardsPet(ent)
                elseif ent:IsHostile() then
                    v.activePet:MakeHostileTarget(ent)
                end
            end
        end)
    end)

    hook.Add( "GravGunOnPickedUp", "HL2CR_Pet_PreventGravPickup", function(ply, ent)
        if ent:GetNWBool("hl2cr_pet") then return false end
    end)
    
    hook.Add( "GravGunPunt", "HL2CR_Pet_PreventGravPunt", function(ply, ent)
        if ent:GetNWBool("hl2cr_pet") then return false end
    end)
    
    hook.Add( "OnNPCKilled", "HL2CR_Pet_Death", function( npc, attacker, inflictor )
        if npc:GetOwner():IsPlayer() and npc:GetNWBool("hl2cr_pet") then
            npc:RemovePet()
        end
    end)
end