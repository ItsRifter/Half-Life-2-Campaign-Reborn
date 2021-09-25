AddCSLuaFile()

GM.PlayStyleClass = {}

function CreateClass(name, desc, desc2, icon, weapons)
	
	local class = {
		["Name"] = name,
		["Desc"] = desc,
		["EquipmentDesc"] = desc2,
		["Icon"] = icon,
		["Weapons"] = weapons,
	}
	
	return class
end

local medicWeps = {
	"weapon_medkit_hl2cr",
}

local repairWeps = {
	"weapon_armorkit_hl2cr",
}

local supplierWeps = {
	"weapon_ammogiver",
}

local fieldMedic = CreateClass("Field Medic", "A field medic here to help\nthe injured during combat", "EQUIPMENT:\nMedkit", "materials/hl2cr/class_medic.jpg", medicWeps)

local repairMan = CreateClass("Repairman", "A repair-man who can restore\nlost armor points", "EQUIPMENT:\nArmorKit", "materials/hl2cr/weapon_toolbox.jpg", repairWeps)

local supplier = CreateClass("Supplier", "An ammo supplier that gives\nammo for the\ncurrent active weapon", "EQUIPMENT:\nAmmo Box","materials/hl2cr/class_supporter.jpg", supplierWeps)

table.insert(GM.PlayStyleClass, fieldMedic)
table.insert(GM.PlayStyleClass, repairMan)
table.insert(GM.PlayStyleClass, supplier)

if SERVER then
	net.Receive("HL2CR_SelectClass", function(len, ply)
		if not ply then return end
		
		local classToAdd = net.ReadInt(8)
	
		if ply.hl2cr.CurClass == GAMEMODE.PlayStyleClass[classToAdd] then
			ply:ChatPrint("You are already assigned to this class!")
			return
		end	
		
		if ply.classCooldown and ply.classCooldown > CurTime() then
			ply:ChatPrint("You are on a class cooldown, please wait " .. math.Round(ply.classCooldown - CurTime()) .. " seconds")
			return
		end
		
		ply.classCooldown = CurTime() + GetConVar("hl2cr_cooldown_class"):GetInt()
		
		ply.hl2cr.CurClass = GAMEMODE.PlayStyleClass[classToAdd]
		ply:SetNWString("class_icon", ply.hl2cr.CurClass.Icon)
			
		ply:ChatPrint("You have been assigned as '" .. ply.hl2cr.CurClass.Name .. "'")
		ply:ChatPrint("You will obtain your equipment next respawn")
		
	end)
end
