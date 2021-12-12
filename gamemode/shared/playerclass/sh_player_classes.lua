AddCSLuaFile()

GM.PlayStyleClass = {}

function CreateClass(name, desc, desc2, desc3, level, icon, weapons)
	
	local class = {
		["Name"] = name,
		["Desc"] = desc,
		["EquipmentDesc"] = desc2,
		["StrWeak"] = desc3,
		["LevelReq"] = level,
		["Icon"] = icon,
		["Weapons"] = weapons,
	}
	
	table.insert(GM.PlayStyleClass, class)
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

local fieldMedic = CreateClass("Field Medic", "A field medic here to help\nthe injured during combat", "EQUIPMENT:\nMedkit", "STRENGTHS:\n25 Health Increase\nWEAKNESSES:\n50 Armor Capacity Reduction", 5, "materials/hl2cr/class_medic.jpg", medicWeps)

local repairMan = CreateClass("Repairman", "A repair-man who can restore\nlost armor points", "EQUIPMENT:\nArmorKit", "STRENGTHS:\n25 Armor Capacity Increase\nWEAKNESSES:\n20 Health Decrease", 5, "materials/hl2cr/class_repairman.jpg", repairWeps)

local supplier = CreateClass("Supplier", "An ammo supplier that gives\nammo for the\ncurrent active weapon", "EQUIPMENT:\nAmmo Box", "WEAKNESSES:\nLess resilient to damage", 5, "materials/hl2cr/class_supporter.jpg",supplierWeps)

local mechanic = CreateClass("Mechanic", "A mechanic filled with\ndesigns ideas\nincluding his weapon of choice", "EQUIPMENT:\nElectric Chain-Blade", "WEAKNESSES:", 10,"materials/hl2cr/class_mechanic.jpg", mechanicWeps)

local grenadier = CreateClass("Grenadier", "Become more effective with\ngrenades", "EQUIPMENT:\nPack of grenades\nGrenade Belt", "WEAKNESSES:", 10, "materials/hl2cr/class_grenadier.jpg", grenadierWeps)

local dropout = CreateClass("Combine Dropout", "After rethinking their\ncareer choices\nit was time to dropout\nand help the resistance", "EQUIPMENT:\nMan-Hack\nStunstick", "WEAKNESSES:", 10, "materials/hl2cr/class_dropout.jpg", dropoutWeps)

local rocketeer = CreateClass("Rocketeer", "A jetpack rebel that\ncan reach the unreachable", "EQUIPMENT:\nJetpack", "WEAKNESSES:\n35 Health Decrease\nLess resilient to damage", 20, "materials/hl2cr/class_rocketeer.jpg", nil)

local robot = CreateClass("Robot", "Created by the resistance\ncares nothing else\nbut the humans", "EQUIPMENT:\nNONE", "STRENGTHS:\nMore resililent to damage\nWEAKNESSES:\nMedkits are ineffective\nCannot be revived", 20, "materials/hl2cr/class_robot.jpg", nil)

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
		
		ply:SetNWString("stat_curclass", ply.hl2cr.CurClass.Name)
		
		local ASSIGNED_MESSAGE = {
			["Colour"] = Color(50, 215, 50),
			["Message"] = "ASSIGNED_MESSAGE1",
			["Other"] = {
				["Player"] = "",
				["Time"] = ply.hl2cr.CurClass.Name,
				["CurCompleted"] = "ASSIGNED_MESSAGE2",
			}
		}
		ply:SetModel("models/player/Group01/male_07.mdl")
		ply.hl2cr.Model = ply:GetModel()
		BroadcastMessage(ASSIGNED_MESSAGE, ply)
	end)
end
