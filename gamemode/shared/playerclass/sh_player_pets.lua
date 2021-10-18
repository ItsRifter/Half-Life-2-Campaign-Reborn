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

local function CreatePet(name, className, desc, model, cost)
	
	local pet = {
		["name"] = name,
		["level"] = 0,
		["skillpoints"] = 0,
		["xp"] = 0,
		["reqxp"] = 1500, 
		["class"] = className,
		["desc"] = desc,
		["model"] = model,
		["cost"] = cost
	}
	
	return pet
end

local headcrab = CreatePet("Headcrab", "npc_hl2cr_pet_headcrab", "The standard pet\ncompletely harmless...\nto you", "models/headcrabclassic.mdl", 10000)
local fastheadcrab = CreatePet("Fast Headcrab", "npc_hl2cr_pet_fastheadcrab", "A mutated version of the\noriginal headcrab\nfaster but weaker", "models/headcrab.mdl", 11500)

table.insert(GM.PlayerPets, headcrab)
table.insert(GM.PlayerPets, fastheadcrab)

if SERVER then
	net.Receive("HL2CR_EquipPet", function(len, ply)
		if not ply then return end
		
		local updatePet = net.ReadString()
		
		for i, v in ipairs(GAMEMODE.PlayerPets) do
			if v.name == updatePet then 
				
				if not table.IsEmpty(ply.hl2cr.Pets.CurrentPet) then
					table.Empty(ply.hl2cr.Pets.CurrentPet)
				end
				
				table.Merge(ply.hl2cr.Pets.CurrentPet, v)

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
end