AddCSLuaFile()

local tempicon = "materials/hl2cr/misc/placeholder.jpg"

GM.ItemDB = {}
---------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------
local Group = {
	Name = translate.Get("ItemGroup_HAT"),
	Index = 1,
	Items ={
		["HAT_BABY"] ={
			Name = translate.Get("HAT_Baby"),
			Desc = translate.Get("HAT_Baby_Desc"),
			Ref = "hat_dollhead",
			Icon = tempicon,
			Index = 1,
			OnHitFunc = function(ply, attacker, dmgType)
				ply:EmitSound("ambient/creatures/teddy.wav", 75, math.random(75, 130))
				end
		},
		["HAT_BALL"] ={
			Name = translate.Get("HAT_Ball"),
			Desc = translate.Get("HAT_Ball_Desc"),
			Ref = "hat_ballhead",
			Icon = tempicon,
			Index = 2,
			OnHitFunc = function(ply, attacker, dmgType)
				if dmgType ~= DMG_SLASH and dmgType ~= DMG_GENERIC then return end
				
				dmgInfo = DamageInfo()
				dmgInfo:SetDamageType(DMG_SHOCK)
				dmgInfo:SetDamage(5)
				dmgInfo:SetAttacker(ply)
				dmgInfo:SetReportedPosition( attacker:GetPos() )

				attacker:TakeDamageInfo(dmgInfo)
				attacker:EmitSound("npc/roller/mine/rmine_explode_shock1.wav", 100, math.random(80, 120))
						end
		},
		["HAT_MONITOR"] ={
			Name = translate.Get("HAT_Monitor"),
			Desc = translate.Get("HAT_Monitor_Desc"),
			Ref = "hat_monitor",
			Icon = tempicon,
			Index = 3,
			APCOST = 50
		},
	}
}
GM.ItemDB["HATS"] = Group

---------------------------------------------------------------------------------------------
local Group = {
	Name = translate.Get("ItemGroup_MELEE"),
	Index = 9,
	Items ={
		["MELEE_CROWSAW"] ={
			Name = translate.Get("MELEE_Crowsaw_Name"),
			Desc = translate.Get("MELEE_Crowsaw_Desc"),
			Ref = "weapon_hl2cr_crowsaw",
			Icon = tempicon,
			Index = 1
		},
	}
}
GM.ItemDB["MELEE"] = Group

---------------------------------------------------------------------------------------------
local Group = {
	Name = translate.Get("ItemGroup_PISTOL"),
	Index = 10,
	Items ={
		["PISTOL_AUTO"] ={
			Name = translate.Get("PISTOL_Auto_Name"),
			Desc = translate.Get("PISTOL_Auto_Desc"),
			Ref = "weapon_hl2cr_autopistol",
			Icon = tempicon,
			Index = 1,
			APCOST = 100
		},
		
	}
}
GM.ItemDB["PISTOL"] = Group
---------------------------------------------------------------------------------------------
local Group = {
	Name = translate.Get("ItemGroup_REV"),
	Index = 11,
	Items ={
	}
}
GM.ItemDB["REV"] = Group

---------------------------------------------------------------------------------------------
local Group = {
	Name = translate.Get("ItemGroup_SMGS"),
	Index = 12,
	Items ={
		["SMG_AUTO"] ={
			Name = translate.Get("SMG_Rampage_Name"),
			Desc = translate.Get("SMG_Rampage_Desc"),
			Ref = "weapon_hl2cr_rampagesmg",
			Icon = tempicon,
			Index = 1,
			APCOST = 160
		},
		
	}
}
GM.ItemDB["SMG"] = Group

---------------------------------------------------------------------------------------------
local Group = {
	Name = translate.Get("ItemGroup_SHGUN"),
	Index = 13,
	Items ={
	}
}
GM.ItemDB["SHGUN"] = Group

---------------------------------------------------------------------------------------------
local Group = {
	Name = translate.Get("ItemGroup_XBOW"),
	Index = 14,
	Items ={
		["XBOW_EXTENDED"] ={
			Name = translate.Get("XBOW_Ext_Name"),
			Desc = translate.Get("XBOW_Ext_Desc"),
			Ref = "weapon_hl2cr_crossbow",
			Icon = tempicon,
			Index = 1,
			APCOST = 200
		},
	
	
	}
}
GM.ItemDB["XBOW"] = Group
-------------------------------------------
-------------------------------------------
-------------------------------------------

function HL2CR_GetItem(group,id)
	if !GAMEMODE.ItemDB[group] then return nil end
	if !GAMEMODE.ItemDB[group].Items[id] then return nil end
	return GAMEMODE.ItemDB[group].Items[id]
end

if CLIENT then	-----------------------------------------------------------------

	net.Receive( "HL2CR_CL_SendItems", function( length)
		GAMEMODE.ItemsList = net.ReadTable()
	end )
	
	net.Receive( "HL2CR_CL_AddItem", function( length)
		local id = net.ReadString()
		if !HL2CR_HaveItem(id) then 
			surface.PlaySound( "buttons/blip2.wav" )
			table.insert(GAMEMODE.ItemsList, id) 
			if IsValid(HL2CR_ShopPanel) then
				HL2CR_ShopPanel:Refresh()
			end
		end

	end )
	
	function HL2CR_HaveItem(id)
		if id == "" then return true end
		if !GAMEMODE.ItemsList then return end
		return table.HasValue( GAMEMODE.ItemsList,id)
	end
	
	
end