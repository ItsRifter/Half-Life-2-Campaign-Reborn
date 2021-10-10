AddCSLuaFile()

local PET_CLASS = {
	["npc_hl2cr_pet_headcrab"] = true,
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
		["class"] = className,
		["desc"] = desc,
		["model"] = model,
		["cost"] = cost
	}
	
	return pet
end

local headcrab = CreatePet("Headcrab", "npc_hl2cr_pet_headcrab", "The standard pet\ncompletely harmless...\nto you", "models/headcrabclassic.mdl", 2500)
local fastheadcrab = CreatePet("Fast Headcrab", "npc_hl2cr_pet_headcrab", "A mutated version of the\noriginal headcrab\nfaster but weaker", "models/headcrab.mdl", 3000)

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
			end
		end
	end)
	
	net.Receive("HL2CR_UpdatePet", function(len, ply)
		if not ply then return end
		
		local newPet = net.ReadString()
		
		for i, v in ipairs(GAMEMODE.PlayerPets) do
			if v.name == newPet then 
				table.insert(ply.hl2cr.Pets, v)
			end
		end
	end)
end