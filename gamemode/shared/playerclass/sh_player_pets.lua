AddCSLuaFile()

local PET_CLASS = {
	["npc_hl2cr_pet_headcrab"] = true,
	["npc_hl2cr_pet_fastheadcrab"] = true,
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

function CreatePet(name, maxLevel, className, desc, model, cost, stats)
	
	local pet = {
		["name"] = name,
		["level"] = 0,
		["maxLevel"] = maxLevel,
		["skillpoints"] = 0,
		["xp"] = 0,
		["reqxp"] = 1500, 
		["class"] = className,
		["desc"] = desc,
		["model"] = model,
		["cost"] = cost,
		["stats"] = stats,
		["curSkills"] = {}
	}
	
	table.insert(GM.PlayerPets, pet)
end

local headcrabStats = {
	["health"] = 100,
	["speed"] = 30,
	["damage"] = 5,
}

local fastheadcrabStats = {
	["health"] = 75,
	["speed"] = 75,
	["damage"] = 3,
}

local headcrab = CreatePet("Headcrab", 6, "npc_hl2cr_pet_headcrab", "The standard pet\ncompletely harmless...\nto you", "models/headcrabclassic.mdl", 10000, headcrabStats)
local fastheadcrab = CreatePet("Fast Headcrab", 6, "npc_hl2cr_pet_fastheadcrab", "A mutated version of the\noriginal headcrab\nfaster but weaker", "models/headcrab.mdl", 11500, fastheadcrabStats)

if SERVER then
	net.Receive("HL2CR_EquipPet", function(len, ply)
		if not ply then return end
			
		if ply.pet then return end
			
		local updatePet = net.ReadString()
		
		for i, v in ipairs(ply.hl2cr.Pets) do
			if v.name == updatePet then 
				
				if not table.IsEmpty(ply.hl2cr.Pets.CurrentPet) then
					for _, s in ipairs(ply.hl2cr.Pets.CurrentPet) do
						if v.class == s.class then
							v.xp = s.xp
							v.reqxp = s.reqxp
							v.level = s.level
						end
					end
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
			end
		end
	end)
	
	net.Receive("HL2CR_SellPet", function(len, ply)
		if not ply then return end
		
		local soldPet = net.ReadString()

		for i, v in ipairs(ply.hl2cr.Pets) do

			if v["class"] == soldPet then 
				if table.HasValue(ply.hl2cr.Pets.CurrentPet, soldPet) then
					table.Empty(ply.hl2cr.Pets.CurrentPet)
				end
				
				table.remove(ply.hl2cr.Pets, i)
				
				ply.hl2cr.Resin = ply.hl2cr.Resin + math.Round(v.cost / 2)
				ply:SetNWInt("currency_resin", ply.hl2cr.Resin)
			end
		end
	end)
end