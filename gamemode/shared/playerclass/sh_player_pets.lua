AddCSLuaFile()

local PET_CLASS = {
	--Standard Zombie
	["npc_vj_hl2cr_headcrab"] = true,
	["npc_vj_hl2cr_torsozombie"] = true,
	
	--Fast Zombie
	["npc_vj_hl2cr_fastheadcrab"] = true
}

local meta = FindMetaTable( "Entity" )
if not meta then return end

function meta:IsPet()
	if self:IsValid() and PET_CLASS[self:GetClass()] then
		return true
	else
		return false
	end
end

GM.PlayerPets = {}

function CreatePet(name, maxLevel, reqExp, className, desc, model, cost, stats, buyable)
	
	local pet = {
		["name"] = name,
		["level"] = 0,
		["maxLevel"] = maxLevel,
		["skillpoints"] = 0,
		["xp"] = 0,
		["reqxp"] = reqExp, 
		["class"] = className,
		["desc"] = desc,
		["model"] = model,
		["cost"] = cost,
		["stats"] = stats,
		["curSkills"] = {},
		["isBuyable"] = buyable or false
	}
	
	table.insert(GM.PlayerPets, pet)
end

local headcrabStats = {
	["health"] = 350,
	["speed"] = 25,
	["damage"] = 10,
	["attDelay"] = 6,
}

local torsoStats = {
	["health"] = 500,
	["speed"] = 30,
	["damage"] = 15,
	["attDelay"] = 5,
}

local fastheadcrabStats = {
	["health"] = 250,
	["speed"] = 35,
	["damage"] = 6,
	["attDelay"] = 3,
}

local headcrab = CreatePet("Headcrab", 6, 1500, "npc_vj_hl2cr_headcrab", "The standard pet\ncompletely harmless...\nto you", "models/headcrabclassic.mdl", 10000, headcrabStats, true)
local fastheadcrab = CreatePet("Fast Headcrab", 6, 1250, "npc_vj_hl2cr_fastheadcrab", "An alternate version of the\noriginal headcrab\nfaster but weaker", "models/headcrab.mdl", 11500, fastheadcrabStats, true)

local torsoZombie = CreatePet("Torso Zombie", 8, 3000, "npc_vj_hl2cr_torsozombie", "A mutated version of\nthe standard headcrab", "models/zombie/classic_torso.mdl", 20000, torsoStats)

if SERVER then
	net.Receive("HL2CR_EquipPet", function(len, ply)
		if not ply then return end
			
		if ply.pet then return end
			
		local updatePet = net.ReadString()
		
		for i, v in ipairs(ply.hl2cr.Pets) do
			
			if ply.hl2cr.Pets.CurrentPet.name == v.name then
				v.xp = ply.hl2cr.Pets.CurrentPet.xp
				v.skillpoints = ply.hl2cr.Pets.CurrentPet.skillpoints
			end
		end
		
		for i, v in ipairs(ply.hl2cr.Pets) do	
			if v.class == updatePet then 
				if not table.IsEmpty(ply.hl2cr.Pets.CurrentPet) then
					table.Empty(ply.hl2cr.Pets.CurrentPet)
				end
				
				table.Merge(ply.hl2cr.Pets.CurrentPet, v)
				
				ply:SetNWString("pet_name", ply.hl2cr.Pets.CurrentPet["name"])
				ply:SetNWInt("pet_level", ply.hl2cr.Pets.CurrentPet["level"])
				ply:SetNWInt("pet_curxp", ply.hl2cr.Pets.CurrentPet["xp"])
				ply:SetNWInt("pet_curreqxp", ply.hl2cr.Pets.CurrentPet["reqxp"])
				ply:SetNWInt("pet_skillpoints", ply.hl2cr.Pets.CurrentPet["skillpoints"])
			end
		end
	end)
	
	net.Receive("HL2CR_UpdatePet", function(len, ply)
		if not ply then return end
		
		local newPet = net.ReadString()
		
		for i, v in ipairs(GAMEMODE.PlayerPets) do
			if v.name == newPet then 
				table.insert(ply.hl2cr.Pets, v)
				
				ply.hl2cr.Resin = ply.hl2cr.Resin - v.cost
				ply:SetNWInt("currency_resin", ply.hl2cr.Resin)
				
				net.Start("HL2CR_OpenPets")
					net.WriteTable(ply.hl2cr.Pets)
				net.Send(ply)
			end
		end
	end)
	
	net.Receive("HL2CR_SellPet", function(len, ply)
		if not ply then return end
		
		if ply.pet then return end
		
		local soldPet = net.ReadString()

		for i, v in ipairs(ply.hl2cr.Pets) do

			if v["class"] == soldPet then 
				if table.HasValue(ply.hl2cr.Pets.CurrentPet, soldPet) then
					table.Empty(ply.hl2cr.Pets.CurrentPet)
				end
				
				table.remove(ply.hl2cr.Pets, i)
				
				ply.hl2cr.Resin = ply.hl2cr.Resin + math.Round(v.cost / 2)
				ply:SetNWInt("currency_resin", ply.hl2cr.Resin)
				
				net.Start("HL2CR_OpenPets")
					net.WriteTable(ply.hl2cr.Pets)
				net.Send(ply)
			end
		end
	end)
	
	local EVOLVE_TREE = {
		["npc_vj_hl2cr_headcrab"] = "npc_vj_hl2cr_torsozombie"
	}
	
	net.Receive("HL2CR_MutatePet", function(len, ply)
		if not ply then return end
		
		local classEvolvingFrom = net.ReadString()
		
		if not ply.pet then
			MISSING_PET = {
				["Colour"] = Color(250, 230, 45),
				["Message"] = "MissingPetEvolve"
			}
			
			BroadcastMessage(MISSING_PET, ply)
			return 
		end
		
		ply.pet:EmitSound("npc/vort/health_charge.wav", 100, 100)
		ply.pet:SetMaterial("models/props_combine/com_shield001a")
		
		timer.Create("HL2CR_Mutate_" .. ply:Nick(), 5, 1, function()
			local effect = ParticleEffect( "vortigaunt_beam", ply.pet:GetPos(), Angle( 0, 0, 0 ), ply.pet)
			ply.pet:EmitSound("beams/beamstart5.wav", 100, 75)
		
			table.Empty(ply.hl2cr.Pets.CurrentPet)
		
			timer.Simple(0.1, function()
				for i, newPet in ipairs(GAMEMODE.PlayerPets) do
					if newPet.class == classEvolvingFrom then
						table.remove(ply.hl2cr.Pets, i)
					end
					
					if newPet.class == EVOLVE_TREE[classEvolvingFrom] then
						table.insert(ply.hl2cr.Pets, newPet)
						table.Merge(ply.hl2cr.Pets.CurrentPet, newPet)
					end
				end
				
				local lastPos = ply.pet:GetPos()
				
				RemovePet(ply)
				SpawnPet(ply)
				ply.pet:SetPos(lastPos)
				ply:SetNWString("pet_name", ply.hl2cr.Pets.CurrentPet.name)
			end)
		end)

	end)
end