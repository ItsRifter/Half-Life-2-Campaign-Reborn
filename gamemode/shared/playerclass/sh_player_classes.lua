AddCSLuaFile()

GM.PlayStyleClass = {}

function CreateClass(name, desc, desc2, level, icon, weapons)
	
	local class = {
		["Name"] = name,
		["Desc"] = desc,
		["EquipmentDesc"] = desc2,
		["LevelReq"] = level,
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

local mechanicWeps = {
	"the_lobotomizer",
}

local grenadierWeps = {
	"weapon_frag",
	"weapon_frag",
	"weapon_frag",
	"weapon_frag",
	"weapon_frag",
}

local dropoutWeps = {
	"weapon_controllable_manhack",
	"weapon_stunstick"
}

local fieldMedic = CreateClass("Field Medic", "A field medic here to help\nthe injured during combat", "EQUIPMENT: Medkit", 5, "materials/hl2cr/class_medic.jpg", medicWeps)

local repairMan = CreateClass("Repairman", "A repair-man who can restore\nlost armor points", "EQUIPMENT: ArmorKit", 5, "materials/hl2cr/class_repairman.jpg", repairWeps)

local supplier = CreateClass("Supplier", "An ammo supplier that gives\nammo for the\ncurrent active weapon", "EQUIPMENT: Ammo Box", 5, "materials/hl2cr/class_supporter.jpg",supplierWeps)

local mechanic = CreateClass("Mechanic", "A mechanic filled with\ndesigns ideas\nincluding his weapon of choice", "EQUIPMENT: Electric\nChain-Blade", 10,"materials/hl2cr/class_mechanic.jpg", mechanicWeps)

local grenadier = CreateClass("Grenadier", "Become more effective with\ngrenades", "EQUIPMENT: Pack of grenades\nGrenade Belt", 10, "materials/hl2cr/class_grenadier.jpg", grenadierWeps)

local dropout = CreateClass("Combine Dropout", "After rethinking their\ncareer choices\nit was time to dropout\nand help the resistance", "EQUIPMENT: Man-Hack\nStunstick", 10, "materials/hl2cr/class_dropout.jpg", dropoutWeps)

table.insert(GM.PlayStyleClass, fieldMedic)
table.insert(GM.PlayStyleClass, repairMan)
table.insert(GM.PlayStyleClass, supplier)
table.insert(GM.PlayStyleClass, grenadier)
table.insert(GM.PlayStyleClass, mechanic)
table.insert(GM.PlayStyleClass, dropout)

if SERVER then
	net.Receive("HL2CR_SelectClass", function(len, ply)
		if not ply then return end
		
		local classToAdd = net.ReadInt(8)
	
		if ply.hl2cr.CurClass == GAMEMODE.PlayStyleClass[classToAdd] then
			BroadcastMessage(ERROR_CLASS_ALREADY_ASSIGNED, ply)
			return
		end	
		
		if ply.classCooldown and ply.classCooldown > CurTime() then
			local ERROR_CLASS_COOLDOWN = {
				["Colour"] = Color(215, 50, 50),
				["Message"] = "You are on a class cooldown, please wait " .. math.Round(ply.classCooldown - CurTime()) .. " seconds"
			}
			
			BroadcastMessage(ERROR_CLASS_COOLDOWN, ply)
			return
		end
		
		ply.classCooldown = CurTime() + GetConVar("hl2cr_cooldown_class"):GetInt()
		
		ply.hl2cr.CurClass = GAMEMODE.PlayStyleClass[classToAdd]
		ply:SetNWString("class_icon", ply.hl2cr.CurClass.Icon)
			
		local ASSIGNED_MESSAGE = {
			["Colour"] = Color(50, 215, 50),
			["Message"] = "ASSIGNED_MESSAGE1",
			["Other"] = {
				["Player"] = "",
				["Time"] = ply.hl2cr.CurClass.Name,
				["CurCompleted"] = "ASSIGNED_MESSAGE2",
			}
		}
		
		BroadcastMessage(ASSIGNED_MESSAGE, ply)
		
	end)
end
