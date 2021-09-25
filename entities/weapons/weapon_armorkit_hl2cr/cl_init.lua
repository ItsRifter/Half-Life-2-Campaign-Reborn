include("shared.lua")
include("animations.lua")

SWEP.Category = "Other"

SWEP.UseHands = true
SWEP.DrawAmmo = true
SWEP.DrawCrosshair = true
SWEP.ViewModelFOV = 60

SWEP.Slot = 5
SWEP.SlotPos = 3

SWEP.ShowWorldModel = false--true
SWEP.ShowViewModel = false

SWEP.WCustom = false--true
SWEP.WBone = "ValveBiped.Bip01_R_Hand"
SWEP.WPos = Vector(4,2,3)
SWEP.WAng = Angle(180,-90-45,15)

SWEP.VElements = {
	--["armorkit"] = { type = "Model", model = "models/items/battery.mdl", bone = "ValveBiped.Grenade_body", rel = "", pos = Vector(0,0,1.5), angle = Angle(180,180,0), size = Vector(0.7, 0.7, 0.7), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	["armorkit"] = { type = "Model", model = "models/items/battery.mdl", bone = "medkit_bone", rel = "", pos = Vector(-0.5,4,-1.5), angle = Angle(90,185,90), size = Vector(0.7, 0.7, 0.7), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["armorkit+"] = { type = "Model", model = "models/items/battery.mdl", bone = "medkit_bone", rel = "armorkit", pos = Vector(0,3,0), angle = Angle(0,90,0), size = Vector(0.7, 0.7, 0.7), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["armorkit++"] = { type = "Model", model = "models/items/battery.mdl", bone = "medkit_bone", rel = "armorkit", pos = Vector(0,-3,0), angle = Angle(0,-90,0), size = Vector(0.7, 0.7, 0.7), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
}

SWEP.WElements = {
--	["armorkit"] = { type = "Model", model = "models/items/battery.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.5,3,2), angle = Angle(180,180,0), size = Vector(0.7, 0.7, 0.7), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	["armorkit"] = { type = "Model", model = "models/items/battery.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4,5.5,2.5), angle = Angle(190,20,-10), size = Vector(0.7, 0.7, 0.7), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["armorkit+"] = { type = "Model", model = "models/items/battery.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "armorkit", pos = Vector(0,3,0), angle = Angle(0,90,0), size = Vector(0.7, 0.7, 0.7), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["armorkit++"] = { type = "Model", model = "models/items/battery.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "armorkit", pos = Vector(0,-3,0), angle = Angle(0,-90,0), size = Vector(0.7, 0.7, 0.7), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
}

function SWEP:OnRemove()
	self:Anim_OnRemove()
end

function SWEP:ViewModelDrawn()
	self:Anim_ViewModelDrawn()
end

function SWEP:PreDrawViewModel(vm)
	if self.ShowViewModel == false then
		render.SetBlend(0)
	end
end

function SWEP:PostDrawViewModel(vm)
	if self.ShowViewModel == false then
		render.SetBlend(1)
	end
end

function SWEP:DrawWorldModel()
	self:Anim_DrawWorldModel()
end
