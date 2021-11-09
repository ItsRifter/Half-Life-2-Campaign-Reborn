local CONVERT_NAME_TO_IMAGE = {
	["Flare_Gun"] = "materials/hl2cr/weapon_flaregun.jpg",
	["Automatic_Pistol"] = "materials/hl2cr/weapon_autopistol.jpg",
	["Multi_Grenade_Launcher"] = "materials/hl2cr/weapon_grenadelauncher.jpg",
	["Shredding_Assault_Rifle"] = "materials/hl2cr/weapon_shreddingar.jpg",
	["The_Nailer_Gun"] = "materials/hl2cr/weapon_nailer.jpg",
	["Unstable_Electric_Shotgun"] = "materials/hl2cr/weapon_unstableshotgun.jpg",
	["BMG_Heavy_Sniper"] = "materials/hl2cr/weapon_bmgsniper.jpg",
	["Test"] = "materials/hl2cr/weapon_nailer.jpg",
	["Suit_PWR_Boost"] = "materials/hl2cr/weapon_bmgsniper.jpg",
	["Exosuit_Boots"] = "materials/hl2cr/boot_exo.jpg",
	["Longfall_Boots"] = "materials/hl2cr/boot_longfall.jpg",
	["Metal_Boots"] = "materials/hl2cr/boot_metal.jpg",
	["Exosuit_Vest"] = "materials/hl2cr/chest_exo.jpg",
	["Heavy_Vest"] = "materials/hl2cr/chest_heavyvest.jpg",
	["Light_Vest"] = "materials/hl2cr/chest_vest.jpg",
	["HECU_Helm"] = "materials/hl2cr/helmet_hecu.jpg",
	["Robo_Helm"] = "materials/hl2cr/helmet_robot.jpg",
	["Exosuit_Shoulders"] = "materials/hl2cr/shoulder_exo.jpg",
	["Test_Mat_1"] = "materials/hl2cr/mat_iron.jpg",
	["Test_Mat_2"] = "materials/hl2cr/mat_scrap.jpg",
	["Test_Mat_3"] = "materials/hl2cr/mat_morphine.jpg",
	["Test_Result"] = "materials/hl2cr/item_stimshot.jpg"
}

local CONVERT_IMAGE_TO_CRAFT = {
	["materials/hl2cr/mat_iron.jpg"] = "Test_Mat_1",
	["materials/hl2cr/mat_scrap.jpg"] = "Test_Mat_2",
	["materials/hl2cr/mat_morphine.jpg"] = "Test_Mat_3",
}

local CONVERT_CRAFTED_TO_IMAGE = {
	["Test_Result"] = "materials/hl2cr/item_stimshot.jpg",
}

local MENU_CRAFTABLES_RECIPE = {
	[1] = {
		[1] = "Test_Mat_1",
		[2] = "Test_Mat_1",
	}
}

local MENU_CRAFTABLES_RESULT = {
	[1] = "Test_Result",
}

local MENU_CRAFTABLE_TAKEITEMS = {
	["materials/hl2cr/item_stimshot.jpg"] = {
		[1] = "Test_Mat_1",
		[2] = "Test_Mat_1",
	}
}



local ITEM_TYPE = {
	["Flare_Gun"] = "weapon",
	["Automatic_Pistol"] = "weapon",
	["Multi_Grenade_Launcher"] = "weapon",
	["Shredding_Assault_Rifle"] = "weapon",
	["Unstable_Electric_Shotgun"] = "weapon",
	["The_Nailer_Gun"] = "weapon",
	["BMG_Heavy_Sniper"] = "weapon",
	["Test"] = "item",
	["Suit_PWR_Boost"] = "item",
	["Exosuit_Boots"] = "boot",
	["Longfall_Boots"] = "boot",
	["Metal_Boots"] = "boot",
	["Exosuit_Vest"] = "chest",
	["Heavy_Vest"] = "chest",
	["Light_Vest"] = "chest",
	["HECU_Helm"] = "helmet",
	["Robo_Helm"] = "helmet",
	["Exosuit_Shoulders"] = "shoulder",
	["Test_Mat_1"] = "mat",
	["Test_Mat_2"] = "mat",
	["Test_Mat_3"] = "mat",
	["Test_Result"] = "usable"
}

local CONVERT_NAME_TRANSLATION = {
	["Flare_Gun"] = function()
		return translate.Get("Flare_Gun")
	end,
	
	["Automatic_Pistol"] = function()
		return translate.Get("Automatic_Pistol")
	end,
	
	["Shredding_Assault_Rifle"] = function()
		return translate.Get("Shredding_Assault_Rifle")
	end,
	
	["Multi_Grenade_Launcher"] = function()
		return translate.Get("Multi_Grenade_Launcher")
	end,
	
	["Unstable_Electric_Shotgun"] = function()
		return translate.Get("Unstable_Electric_Shotgun")
	end,
	
	["The_Nailer_Gun"] = function()
		return translate.Get("The_Nailer_Gun")
	end,
	
	["BMG_Heavy_Sniper"] = function()
		return translate.Get("BMG_Heavy_Sniper")
	end,
	
	["Test"] = function()
		return translate.Get("Flare_Gun")
	end,

	["Suit_PWR_Boost"] = function()
		return translate.Get("SuitPower")
	end,

	["Exosuit_Boots"] = function()
		return translate.Get("SuitPower")
	end,
	["Longfall_Boots"] = function()
		return translate.Get("SuitPower")
	end,
	["Metal_Boots"] = function()
		return translate.Get("SuitPower")
	end,
	["Exosuit_Vest"] = function()
		return translate.Get("SuitPower")
	end,
	["Heavy_Vest"] = function()
		return translate.Get("SuitPower")
	end,
	["Light_Vest"] = function()
		return translate.Get("SuitPower")
	end,
	["HECU_Helm"] = function()
		return translate.Get("SuitPower")
	end,
	["Robo_Helm"] = function()
		return translate.Get("SuitPower")
	end,
	["Exosuit_Shoulders"] = function()
		return translate.Get("SuitPower")
	end,
}

local CONVERT_DESC_TRANSLATION = {
	["Flare_Gun"] = function()
		return translate.Get("Flare_Gun_desc")
	end,
	
	["Automatic_Pistol"] = function()
		return translate.Get("Automatic_Pistol_desc")
	end,
	
	["Shredding_Assault_Rifle"] = function()
		return translate.Get("Shredding_Assault_Rifle_desc")
	end,
	
	["Multi_Grenade_Launcher"] = function()
		return translate.Get("Multi_Grenade_Launcher_desc")
	end,
	
	["Unstable_Electric_Shotgun"] = function()
		return translate.Get("Unstable_Electric_Shotgun_desc")
	end,
	
	["The_Nailer_Gun"] = function()
		return translate.Get("The_Nailer_Gun_desc")
	end,
	
	["BMG_Heavy_Sniper"] = function()
		return translate.Get("BMG_Heavy_Sniper_desc")
	end,
	
	["Test"] = function()
		return translate.Get("Flare_Gun_desc")
	end,

	["Suit_PWR_Boost"] = function()
		return translate.Get("SuitPower_desc")
	end,

	["Exosuit_Boots"] = function()
		return translate.Get("SuitPower_desc")
	end,
	
	["Longfall_Boots"] = function()
		return translate.Get("SuitPower_desc")
	end,
	
	["Metal_Boots"] = function()
		return translate.Get("SuitPower_desc")
	end,
	["Exosuit_Vest"] = function()
		return translate.Get("SuitPower_desc")
	end,
	
	["Heavy_Vest"] = function()
		return translate.Get("SuitPower_desc")
	end,
	
	["Light_Vest"] = function()
		return translate.Get("SuitPower_desc")
	end,
	
	["HECU_Helm"] = function()
		return translate.Get("SuitPower_desc")
	end,
	
	["Robo_Helm"] = function()
		return translate.Get("SuitPower_desc")
	end,
	
	["Exosuit_Shoulders"] = function()
		return translate.Get("SuitPower_desc")
	end,
	
	["Test_Mat_1"] = function()
		return translate.Get("SuitPower_desc")
	end,
	
	["Test_Mat_2"] = function()
		return translate.Get("SuitPower_desc")
	end,
	
	["Test_Mat_3"] = function()
		return translate.Get("SuitPower_desc")
	end,
	
	["Test_Result"] = function()
		return translate.Get("SuitPower_desc")
	end,
}

local PLAYERMODELS = {
	["Standard"] = {
		[1] = "models/player/Group01/male_01.mdl",
		[2] = "models/player/Group01/male_02.mdl",
		[3] = "models/player/Group01/male_03.mdl",
		[4] = "models/player/Group01/male_04.mdl",
		[5] = "models/player/Group01/male_05.mdl",
		[6] = "models/player/Group01/male_06.mdl",
		[7] = "models/player/Group01/male_07.mdl",
		[8] = "models/player/Group01/male_08.mdl",
		[9] = "models/player/Group01/female_01.mdl",
		[10] = "models/player/Group01/female_02.mdl",
		[11] = "models/player/Group01/female_03.mdl",
		[12] = "models/player/Group01/female_04.mdl",
		[13] = "models/player/Group01/female_05.mdl",
		[14] = "models/player/Group01/female_06.mdl"
	},
	
	["Field Medic"] = {
		[1] = "models/player/Group03m/male_01.mdl",
		[2] = "models/player/Group03m/male_02.mdl",
		[3] = "models/player/Group03m/male_03.mdl",
		[4] = "models/player/Group03m/male_04.mdl",
		[5] = "models/player/Group03m/male_05.mdl",
		[6] = "models/player/Group03m/male_06.mdl",
		[7] = "models/player/Group03m/male_07.mdl",
		[8] = "models/player/Group03m/female_01.mdl",
		[9] = "models/player/Group03m/female_02.mdl",
		[10] = "models/player/Group03m/female_03.mdl",
		[11] = "models/player/Group03m/female_04.mdl",
		[12] = "models/player/Group03m/female_05.mdl",
		[13] = "models/player/Group03m/female_06.mdl",
	},
	
	["Combine Dropout"] = {
		[1] = "models/player/police.mdl",
		[2] = "models/player/police_fem.mdl"
	},
	
	["Robot"] = {
		[1] = "models/player/mc/robo/Robo.mdl"
	},
}

net.Receive("HL2CR_QMenuUpdate", function()
	local skillsTbl = net.ReadTable()
	StartQMenu(net.ReadBool(), skillsTbl)
end)

function StartQMenu(shouldOpen, skillsTbl)
	if not LocalPlayer():Alive() or (LocalPlayer():Team() == 2 or LocalPlayer():Team() == 5) then return end
	
	if shouldOpen then 
		qMenuTabs = vgui.Create("HL2CR_Tab")
		qMenuTabs:SetSize(ScrW() / 1.5, ScrH() / 1.5)
		qMenuTabs:Center()
		qMenuTabs:MakePopup()
		qMenuTabs:SetKeyboardInputEnabled(false)
		
		local invPnl = vgui.Create("DPanel", qMenuTabs)
		invPnl:SetSize(qMenuTabs:GetWide(), qMenuTabs:GetTall())
		
		local invPnlBG = vgui.Create("DPanel", invPnl)
		invPnlBG:SetSize(invPnl:GetWide(), invPnl:GetTall())
		
		invPnlBG.Paint = function(self, w, h)
			surface.SetDrawColor(HL2CR.Theme.qMenu)
			surface.DrawRect(0, 0, w, h)
		end
		
		local invPnlPlayer = vgui.Create("DPanel", invPnl)
		invPnlPlayer:SetPos(invPnl:GetWide() / 1.6, -invPnl:GetTall() / 32 - 32)
		invPnlPlayer:SetSize(invPnl:GetWide() / 4.2, invPnl:GetTall() )
		invPnlPlayer.Paint = function(self, w, h)
			surface.SetDrawColor(HL2CR.Theme.qMenu2)
			surface.DrawRect(0, 0, w, h)
		end
		
		local invPnlPlayerModel = vgui.Create( "DModelPanel", invPnlPlayer )
		invPnlPlayerModel:SetSize(invPnlPlayer:GetWide() * 3.3, invPnlPlayer:GetTall())
		invPnlPlayerModel:SetPos(-invPnlPlayerModel:GetWide()/2.9, invPnlPlayerModel:GetTall() / 500)
		invPnlPlayerModel:SetDirectionalLight(BOX_RIGHT, Color(255, 160, 80, 255))
		invPnlPlayerModel:SetDirectionalLight(BOX_LEFT, Color(80, 160, 255, 255))
		invPnlPlayerModel:SetAmbientLight(Vector(-64, -64, -64))
		invPnlPlayerModel:SetModel( LocalPlayer():GetModel() )
		invPnlPlayerModel.Angles = Angle(0, 0, 0)
		function invPnlPlayerModel:DragMousePress()
			self.PressX, self.PressY = gui.MousePos()
			self.Pressed = true
		end
		function invPnlPlayerModel:DragMouseRelease() self.Pressed = false end
		function invPnlPlayerModel:LayoutEntity(ent)
			if (self.bAnimated) then self:RunAnimation() end

			if (self.Pressed) then
				local mx, my = gui.MousePos()
				self.Angles = self.Angles - Angle(0,((self.PressX or mx) - mx) / 2, 0)

				self.PressX, self.PressY = gui.MousePos()
			end

			ent:SetAngles(self.Angles)
		end
		
		local slots = string.Explode(" ", LocalPlayer():GetNWString("inv_slots"))
		
		local invPnlSlotsPnl = vgui.Create("DPanel", invPnl)
		invPnlSlotsPnl:SetSize(invPnl:GetWide() / 2.2, invPnl:GetTall())
		invPnlSlotsPnl:SetPos(15, 16)
		invPnlSlotsPnl.Paint = function() end
		
		local invLayout = vgui.Create("DIconLayout", invPnlSlotsPnl)
		invLayout:Dock(FILL)
		invLayout:SetSpaceX(10)
		invLayout:SetSpaceY(5)
		
		local craftPnlSlotsPnl = vgui.Create("DPanel", invPnl)
		craftPnlSlotsPnl:SetSize(invPnl:GetWide() / 2.2, invPnl:GetTall())
		craftPnlSlotsPnl:SetPos(15, 256)
		craftPnlSlotsPnl.Paint = function() end
		
		local craftLayout = vgui.Create("DIconLayout", craftPnlSlotsPnl)
		craftLayout:Dock(FILL)
		craftLayout:SetSpaceX(10)
		craftLayout:SetSpaceY(5)

		local weaponSlotPnl = vgui.Create("DPanel", invPnl)
		weaponSlotPnl:SetPos(invPnl:GetWide() / 1.95, 50)
		weaponSlotPnl:SetSize(invPnl:GetWide() / (ScrW() / 102), invPnl:GetWide() / (ScrW() / 102) )
		
		weaponSlotPnl.Paint = function(pnl, w, h)
			surface.SetDrawColor(HL2CR.Theme.qMenu2)
			surface.DrawRect(0, 0, w, h)
		end
		
		local weaponSlotImage = vgui.Create("DImage", weaponSlotPnl)
		weaponSlotImage:SetSize(weaponSlotPnl:GetWide(), weaponSlotPnl:GetTall())
		if CONVERT_NAME_TO_IMAGE[LocalPlayer():GetNWString("inv_weaponslot")] then
			weaponSlotImage:SetImage(CONVERT_NAME_TO_IMAGE[LocalPlayer():GetNWString("inv_weaponslot")])
		else
			weaponSlotImage:SetImage("materials/hl2cr/empty_weapon.jpg")
		end

		local totalArmorLabel = vgui.Create("DLabel", invPnl)
		totalArmorLabel:SetPos(invPnl:GetWide() - 160, 25)
		totalArmorLabel:SetText(translate.Get("ArmorPoints") .. (LocalPlayer():GetNWInt("stat_armorpoints", 0)))
		totalArmorLabel:SetFont("HL2CR_ArmorPoints")
		totalArmorLabel:SizeToContents()

        local ArmorHeadSlotPnl = vgui.Create("DPanel", invPnl)
		ArmorHeadSlotPnl:SetPos(invPnl:GetWide() / 1.12, 150)
		ArmorHeadSlotPnl:SetSize(invPnl:GetWide() / (ScrW() / 102), invPnl:GetWide() / (ScrW() / 102) )
		
		ArmorHeadSlotPnl.Paint = function(pnl, w, h)
			surface.SetDrawColor(HL2CR.Theme.qMenu2)
			surface.DrawRect(0, 0, w, h)
		end
		
		local ArmorHeadSlotImage = vgui.Create("DImage", ArmorHeadSlotPnl)
		ArmorHeadSlotImage:SetSize(ArmorHeadSlotPnl:GetWide(), ArmorHeadSlotPnl:GetTall())
		if CONVERT_NAME_TO_IMAGE[LocalPlayer():GetNWString("inv_armorslot_helmet")] then
			ArmorHeadSlotImage:SetImage(CONVERT_NAME_TO_IMAGE[LocalPlayer():GetNWString("inv_armorslot_helmet")])
		else
			ArmorHeadSlotImage:SetImage("materials/hl2cr/empty_helmet.jpg")
		end

		local ArmorShouldersSlotPnl = vgui.Create("DPanel", invPnl)
		ArmorShouldersSlotPnl:SetPos(invPnl:GetWide() / 1.12, 250)
		ArmorShouldersSlotPnl:SetSize(invPnl:GetWide() / (ScrW() / 102), invPnl:GetWide() / (ScrW() / 102) )
		
		ArmorShouldersSlotPnl.Paint = function(pnl, w, h)
			surface.SetDrawColor(HL2CR.Theme.qMenu2)
			surface.DrawRect(0, 0, w, h)
		end
		
		local ArmorShouldersSlotImage = vgui.Create("DImage", ArmorShouldersSlotPnl)
		ArmorShouldersSlotImage:SetSize(ArmorShouldersSlotPnl:GetWide(), ArmorShouldersSlotPnl:GetTall())
		if CONVERT_NAME_TO_IMAGE[LocalPlayer():GetNWString("inv_armorslot_shoulders")] then
			ArmorShouldersSlotImage:SetImage(CONVERT_NAME_TO_IMAGE[LocalPlayer():GetNWString("inv_armorslot_shoulders")])
		else
			ArmorShouldersSlotImage:SetImage("materials/hl2cr/empty_shoulders.jpg")
		end
		
		local ArmorChestSlotPnl = vgui.Create("DPanel", invPnl)
		ArmorChestSlotPnl:SetPos(invPnl:GetWide() / 1.12, 350)
		ArmorChestSlotPnl:SetSize(invPnl:GetWide() / (ScrW() / 102), invPnl:GetWide() / (ScrW() / 102) )
		
		ArmorChestSlotPnl.Paint = function(pnl, w, h)
			surface.SetDrawColor(HL2CR.Theme.qMenu2)
			surface.DrawRect(0, 0, w, h)
		end
		
		local ArmorChestSlotImage = vgui.Create("DImage", ArmorChestSlotPnl)
		ArmorChestSlotImage:SetSize(ArmorChestSlotPnl:GetWide(), ArmorChestSlotPnl:GetTall())
		if CONVERT_NAME_TO_IMAGE[LocalPlayer():GetNWString("inv_armorslot_chest")] then
			ArmorChestSlotImage:SetImage(CONVERT_NAME_TO_IMAGE[LocalPlayer():GetNWString("inv_armorslot_chest")])
		else
			ArmorChestSlotImage:SetImage("materials/hl2cr/empty_chest.jpg")
		end
		
		local ArmorBootsSlotPnl = vgui.Create("DPanel", invPnl)
		ArmorBootsSlotPnl:SetPos(invPnl:GetWide() / 1.12, 450)
		ArmorBootsSlotPnl:SetSize(invPnl:GetWide() / (ScrW() / 102), invPnl:GetWide() / (ScrW() / 102) )
		
		ArmorBootsSlotPnl.Paint = function(pnl, w, h)
			surface.SetDrawColor(HL2CR.Theme.qMenu2)
			surface.DrawRect(0, 0, w, h)
		end
		
		local ArmorBootsSlotImage = vgui.Create("DImage", ArmorBootsSlotPnl)
		ArmorBootsSlotImage:SetSize(ArmorBootsSlotPnl:GetWide(), ArmorBootsSlotPnl:GetTall())
		if CONVERT_NAME_TO_IMAGE[LocalPlayer():GetNWString("inv_armorslot_boots")] then
			ArmorBootsSlotImage:SetImage(CONVERT_NAME_TO_IMAGE[LocalPlayer():GetNWString("inv_armorslot_boots")])
		else
			ArmorBootsSlotImage:SetImage("materials/hl2cr/empty_boots.jpg")
		end

		local itemSlotPanel = vgui.Create("DPanel", invPnl)
		itemSlotPanel:SetPos(invPnl:GetWide() / 1.12, 50)
		itemSlotPanel:SetSize(invPnl:GetWide() / (ScrW() / 102), invPnl:GetWide() / (ScrW() / 102) )
		
		itemSlotPanel.Paint = function(pnl, w, h)
			surface.SetDrawColor(HL2CR.Theme.qMenu2)
			surface.DrawRect(0, 0, w, h)
		end
		
		local itemSlotImage = vgui.Create("DImage", itemSlotPanel)
		itemSlotImage:SetSize(itemSlotPanel:GetWide(), itemSlotPanel:GetTall())
		if CONVERT_NAME_TO_IMAGE[LocalPlayer():GetNWString("inv_itemslot")] then
			itemSlotImage:SetImage(CONVERT_NAME_TO_IMAGE[LocalPlayer():GetNWString("inv_itemslot")])
		else
			itemSlotImage:SetImage("materials/hl2cr/empty_item.jpg")
		end
		
		local CraftingResultPnl = vgui.Create("DPanel", invPnl)
		CraftingResultPnl:SetPos(155, invPnl:GetWide() / (ScrW() / 600))
		CraftingResultPnl:SetSize(invPnl:GetWide() / (ScrW() / 102), invPnl:GetWide() / (ScrW() / 102) )
		
		CraftingResultPnl.Paint = function(pnl, w, h)
			surface.SetDrawColor(HL2CR.Theme.qMenu2)
			surface.DrawRect(0, 0, w, h)
		end
		
		CraftingResultImage = vgui.Create("DImageButton", CraftingResultPnl)
		CraftingResultImage:SetSize(CraftingResultPnl:GetWide(), CraftingResultPnl:GetTall())
		CraftingResultImage:SetImage("materials/hl2cr/mystery.jpg")

		CraftingResultImage.DoClick = function(pnl)
			if pnl:GetImage() == "materials/hl2cr/mystery.jpg" then 
				surface.PlaySound("buttons/button16.wav")
			else
				if #slots >= 15 then surface.PlaySound("buttons/button16.wav") return end
				
				surface.PlaySound("hl1/ambience/steamburst1.wav")
				net.Start("HL2CR_CraftItem")
				net.WriteString(pnl:GetImage())
				
				for i = 1, #MENU_CRAFTABLE_TAKEITEMS[pnl:GetImage()] do
					net.WriteString(MENU_CRAFTABLE_TAKEITEMS[pnl:GetImage()][i])
				end
				
				net.SendToServer()
				qMenuTabs:Remove()
					
			end
		end

		local totalSlots = LocalPlayer():GetNWInt("inv_totalslots")
		
		local pl = LocalPlayer()
		pl.Inv = {}

        pl.Craft = {}
		for i = 1, 6 do
			pl.Craft[i] = craftLayout:Add("HL2CR_InvSlot")
			pl.Craft[i]:SetSize(50, 50)
			
			pl.Craft[i].Icon = vgui.Create("DImageButton", pl.Craft[i])
			pl.Craft[i].Icon:SetSize(pl.Craft[i]:GetWide(), pl.Craft[i]:GetTall())
		end
		
		local totalItemsInCraft = 1
		
		local recipes = table.Copy(MENU_CRAFTABLES_RECIPE)
		
		for i = 1, totalSlots do
			pl.Inv[i] = invLayout:Add("HL2CR_InvSlot")
			pl.Inv[i]:SetSize(62, 62)
			
			if slots[i] and CONVERT_NAME_TO_IMAGE[slots[i]] then
				
				pl.Inv[i].Icon = vgui.Create("DImageButton", pl.Inv[i])
				pl.Inv[i].Icon:SetImage(CONVERT_NAME_TO_IMAGE[slots[i]])
				pl.Inv[i].Icon:SetToolTip(CONVERT_DESC_TRANSLATION[slots[i]]())
				pl.Inv[i].Icon:SetSize(pl.Inv[i]:GetWide(), pl.Inv[i]:GetTall())
				
				pl.Inv[i].ComboBox = vgui.Create("DComboBox", pl.Inv[i])
				
				--Weird thing, 
				if ITEM_TYPE[slots[i]] == "mat" then
					pl.Inv[i].ComboBox:AddChoice("Use")
					
				elseif ITEM_TYPE[slots[i]] == "usable" then
					pl.Inv[i].ComboBox:AddChoice("Equip")
				else
					pl.Inv[i].ComboBox:AddChoice("Equip")
				end
				
				pl.Inv[i].ComboBox:AddChoice("Sell")
				pl.Inv[i].ComboBox:SetVisible(false)
				
				pl.Inv[i].Icon.DoClick = function(pnl)
					pl.Inv[i].ComboBox:SetVisible(true)
				end
				
				pl.Inv[i].ComboBox.OnSelect = function( self, index, value )
					if value == "Equip" then
					
						local equipUsable = false
						
						surface.PlaySound("hl2cr/standardbeep.wav")
						self:SetVisible(false)
						self:SetValue("")
						
						if ITEM_TYPE[slots[i]] == "weapon" then
							weaponSlotImage:SetImage(CONVERT_NAME_TO_IMAGE[slots[i]])
							
						elseif ITEM_TYPE[slots[i]] == "item" then
							itemSlotImage:SetImage(CONVERT_NAME_TO_IMAGE[slots[i]])
							
						elseif ITEM_TYPE[slots[i]] == "helmet" then
							ArmorHeadSlotImage:SetImage(CONVERT_NAME_TO_IMAGE[slots[i]])
							
						elseif ITEM_TYPE[slots[i]] == "shoulder" then
							ArmorShouldersSlotImage:SetImage(CONVERT_NAME_TO_IMAGE[slots[i]])
							
						elseif ITEM_TYPE[slots[i]] == "chest" then
							ArmorChestSlotImage:SetImage(CONVERT_NAME_TO_IMAGE[slots[i]])
							
						elseif ITEM_TYPE[slots[i]] == "boot" then
							ArmorBootsSlotImage:SetImage(CONVERT_NAME_TO_IMAGE[slots[i]])
							
						elseif ITEM_TYPE[slots[i]] == "usable" then
							pl.Inv[i].Icon:SetImage("materials/hl2cr/empty.jpg")
							equipUsable	= true
						end
						
						net.Start("HL2CR_UpdateSlot")
							net.WriteString(slots[i])
							net.WriteBool(equipUsable)
						net.SendToServer()
						
					elseif value == "Sell" then
						surface.PlaySound("hl2cr/standardbeep.wav")
						self:SetVisible(false)
						self:SetValue("")
						pl.Inv[i].Icon:Remove()
						
						if LocalPlayer():GetNWString("inv_armorslot_helmet") and CONVERT_NAME_TO_IMAGE[LocalPlayer():GetNWString("inv_armorslot_helmet")] then
							ArmorHeadSlotImage:SetImage("materials/hl2cr/empty_helmet.jpg")
						elseif LocalPlayer():GetNWString("inv_armorslot_shoulders") and CONVERT_NAME_TO_IMAGE[LocalPlayer():GetNWString("inv_armorslot_shoulders")] then
							ArmorShouldersSlotImage:SetImage("materials/hl2cr/empty_shoulders.jpg")
						elseif LocalPlayer():GetNWString("inv_armorslot_chest") and CONVERT_NAME_TO_IMAGE[LocalPlayer():GetNWString("inv_armorslot_chest")] then
							ArmorChestSlotImage:SetImage("materials/hl2cr/empty_chest.jpg")
						elseif LocalPlayer():GetNWString("inv_armorslot_boots") and CONVERT_NAME_TO_IMAGE[LocalPlayer():GetNWString("inv_armorslot_boots")] then
							ArmorBootsSlotImage:SetImage("materials/hl2cr/empty_boots.jpg")
						elseif LocalPlayer():GetNWString("inv_weaponslot") and CONVERT_NAME_TO_IMAGE[LocalPlayer():GetNWString("inv_weaponslot")] then 
							weaponSlotImage:SetImage("materials/hl2cr/empty_weapon")
						end
						
						
						net.Start("HL2CR_SellSlot")
							net.WriteString(slots[i])
						net.SendToServer()
					elseif value == "Use" then
						if totalItemsInCraft > 6 then return end
						
						pl.Craft[totalItemsInCraft].Icon:SetImage(pl.Inv[i].Icon:GetImage())
						for k = 1, #MENU_CRAFTABLES_RECIPE do
							if not recipes[k] then continue end
							
							if CONVERT_IMAGE_TO_CRAFT[pl.Craft[totalItemsInCraft].Icon:GetImage()] == recipes[k][totalItemsInCraft] then
							
								recipes[k][totalItemsInCraft] = nil
								local finalResult = MENU_CRAFTABLES_RESULT[k]
								
								recipes[k]["Result"] = nil
								
								if table.IsEmpty(recipes[k]) then
									CraftingResultImage:SetImage(CONVERT_CRAFTED_TO_IMAGE[finalResult])
								end
							end
						end
						
						surface.PlaySound("hl2cr/standardbeep.wav")
						self:SetVisible(false)
						self:SetValue("")

						totalItemsInCraft = totalItemsInCraft + 1
						pl.Inv[i].Icon:Remove()
						
					end
				end
			end
		end
		
		local modelHorizontalScroll = vgui.Create("DHorizontalScroller", invPnl)
		modelHorizontalScroll:SetSize(qMenuTabs:GetWide() / 2.22, 64)
		modelHorizontalScroll:SetPos(0, invPnl:GetTall() - 168)
		
		local curClass = LocalPlayer():GetNWString("stat_curclass")
		for name, v in pairs(PLAYERMODELS) do
			for i, p in ipairs(v) do
				if name == curClass or name == "Standard" then
					local playermodelBtn = modelHorizontalScroll:Add("SpawnIcon")
					playermodelBtn:SetModel(v[i])
					playermodelBtn:SetSize(64, 64)
					
					modelHorizontalScroll:AddPanel(playermodelBtn)
					
					playermodelBtn.DoClick = function(pnl)
						net.Start("HL2CR_UpdateModel")
							net.WriteString(v[i])
						net.SendToServer()

						invPnlPlayerModel:SetModel( v[i] )
					end
				end
			end
		end
			
		local skillsPnl = vgui.Create("DPanel", qMenuTabs)
		skillsPnl:SetSize(qMenuTabs:GetWide(), qMenuTabs:GetTall())
		skillsPnl:SetPos(0, 100)
		
		local skillsPnlBG = vgui.Create("DPanel", skillsPnl)
		skillsPnlBG:SetSize(skillsPnl:GetWide(), skillsPnl:GetTall())
		skillsPnlBG.Paint = function() return end

		local skillsSelectionPnl = vgui.Create("HL2CR_Tab", skillsPnlBG)
		skillsSelectionPnl:SetSize(skillsPnl:GetWide(), skillsPnl:GetTall())
		skillsSelectionPnl:SetPos(0, -35)
		skillsSelectionPnl:SetKeyboardInputEnabled(false)

		skillsSelectionPnl.Paint = function(pnl, w, h)
			surface.SetDrawColor(HL2CR.Theme.qMenu)
			surface.DrawRect(0, 0, w, h)
		end
		
		local passiveSkillsPnl = vgui.Create("DPanel", skillsSelectionPnl)
		passiveSkillsPnl:SetSize(skillsSelectionPnl:GetWide(), skillsSelectionPnl:GetTall())
		
		local skillHorizontalScroll = vgui.Create("DHorizontalScroller", passiveSkillsPnl)
		skillHorizontalScroll:Dock(FILL)
		skillHorizontalScroll:SetOverlap( -75 )
		
		local passiveSkillsLayout = vgui.Create("DIconLayout", skillHorizontalScroll)
		passiveSkillsLayout:Dock(FILL)
		
		local medicSkillsPnl = vgui.Create("DPanel", skillsSelectionPnl)
		medicSkillsPnl:SetSize(skillsSelectionPnl:GetWide() * 1.60, skillsSelectionPnl:GetTall())

		local medicHorizontalScroll = vgui.Create("DHorizontalScroller", medicSkillsPnl)
		medicHorizontalScroll:Dock(FILL)
		medicHorizontalScroll:SetOverlap( 0 )
		
		local medicSkillsLayout = vgui.Create("DIconLayout", medicHorizontalScroll)
		medicSkillsLayout:Dock(FILL)
		
		local repairSkillsPnl = vgui.Create("DPanel", skillsSelectionPnl)
		repairSkillsPnl:SetSize(skillsSelectionPnl:GetWide() * 1.6, skillsSelectionPnl:GetTall())
		
		local repairHorizontalScroll = vgui.Create("DHorizontalScroller", repairSkillsPnl)
		repairHorizontalScroll:Dock(FILL)
		repairHorizontalScroll:SetOverlap( 0 )
		
		local repairSkillsLayout = vgui.Create("DIconLayout", repairHorizontalScroll)
		repairSkillsLayout:Dock(FILL)
		
		local robotSkillsPnl = vgui.Create("DPanel", skillsSelectionPnl)
		robotSkillsPnl:SetSize(skillsSelectionPnl:GetWide() * 1.6, skillsSelectionPnl:GetTall())
		
		local robotHorizontalScroll = vgui.Create("DHorizontalScroller", robotSkillsPnl)
		robotHorizontalScroll:Dock(FILL)
		robotHorizontalScroll:SetOverlap( 0 )
		
		local robotSkillsLayout = vgui.Create("DIconLayout", robotHorizontalScroll)
		robotSkillsLayout:Dock(FILL)
		
		local mechSkillsPnl = vgui.Create("DPanel", skillsSelectionPnl)
		mechSkillsPnl:SetSize(skillsSelectionPnl:GetWide(), skillsSelectionPnl:GetTall())

		local skillPoints = LocalPlayer():GetNWInt("stat_skillpoints")
		
		for i, skill in pairs(GAMEMODE.PlayerSkills) do
			
			local statusPnl
			
			if skill.Class == "Passive" then
				statusPnl = vgui.Create("DPanel", passiveSkillsLayout)
				statusPnl:SetSize(passiveSkillsPnl:GetWide() / 5, passiveSkillsPnl:GetTall())
			elseif skill.Class == "Medic" then
				statusPnl = vgui.Create("DPanel", medicSkillsLayout)
				statusPnl:SetSize(medicSkillsPnl:GetWide() / 8, medicSkillsPnl:GetTall())
			elseif skill.Class == "Repair" then
				statusPnl = vgui.Create("DPanel", repairSkillsLayout)
				statusPnl:SetSize(repairSkillsPnl:GetWide() / 8, repairSkillsPnl:GetTall())
			elseif skill.Class == "Mechanic" then
				statusPnl = vgui.Create("DPanel", mechSkillsPnl)
				statusPnl:SetSize(mechSkillsPnl:GetWide() / 8, mechSkillsPnl:GetTall())
			elseif skill.Class == "Robot" then
				statusPnl = vgui.Create("DPanel", robotSkillsPnl)
				statusPnl:SetSize(robotSkillsPnl:GetWide() / 8, robotSkillsPnl:GetTall())
			end
			
			local skillPnlShowcase = vgui.Create("DLabel", statusPnl)
			skillPnlShowcase:SetText(skill.Name)
			skillPnlShowcase:SetFont("HL2CR_Class_TitleFont")
			skillPnlShowcase:DockMargin(10, 0, 0, 0)
			skillPnlShowcase:SetPos( (statusPnl:GetWide()/skillPnlShowcase:GetWide())*14, 25)
			skillPnlShowcase:SizeToContents()
			skillPnlShowcase:SetTextColor(Color(0, 0, 0, 255))
			
			local skillPnlDesc = vgui.Create("DLabel", statusPnl)
			skillPnlDesc:SetText(skill.Desc)
			skillPnlDesc:SetPos((statusPnl:GetWide()/skillPnlDesc:GetWide())*15, 62.5)
			skillPnlDesc:SetFont("HL2CR_Class_DescFont")
			skillPnlDesc:SizeToContents()
			skillPnlDesc:SetTextColor(Color(0, 0, 0, 255))
			
			local skillPnlLevel = vgui.Create("DLabel", statusPnl)
			skillPnlLevel:SetPos((statusPnl:GetWide()/skillPnlDesc:GetWide())*35, 125)
			skillPnlLevel:SetFont("HL2CR_Skill_Level")
			skillPnlLevel:SizeToContents()
			skillPnlLevel:SetTextColor(Color(0, 0, 0, 255))
			skillPnlLevel:SetText("0/" .. skill.Max)
			
			if skillsTbl[i] then
				skillPnlLevel:SetText( (skillsTbl[i].Invested ) .. "/" .. skill.Max)
			end
			skillPnlLevel:SizeToContents()
			
			statusPnl.Paint = function() return end
			
			skillBtn = vgui.Create("DImageButton", statusPnl)
			skillBtn:SetSize(92, 92)
			skillBtn:SetPos(statusPnl:GetWide() / 4, statusPnl:GetWide())
		
			if LocalPlayer():GetNWInt("stat_level") < skill.LevelReq then
				skillBtn:SetImage("materials/hl2cr/locked.jpg")
				continue
			end
			
			skillBtn:SetImage(skill.Icon)
			
			skillBtn.DoClick = function(pnl)
				if LocalPlayer():GetNWInt("stat_level") < skill.LevelReq then
					surface.PlaySound("buttons/button16.wav")
					return
				end

				if skillsTbl[i] and (skillsTbl[i].Invested or skill.Invested) >= skill.Max then 
					surface.PlaySound("buttons/button16.wav")
					return
				end
			
				if skillPoints <= 0 then
					surface.PlaySound("buttons/button16.wav")
					return
				end
				
				skillPoints = skillPoints - 1
				
				net.Start("HL2CR_SkillObtain")
					net.WriteString(skill.Name)
				net.SendToServer()
				
				if skillsTbl[i] then
					skillsTbl[i].Invested = (skillsTbl[i].Invested or 0) + 1
					skillPnlLevel:SetText( (skillsTbl[i].Invested or 0 ) .. "/" .. skill.Max)
					skillPnlLevel:SizeToContents()
				else
					skill.Invested = skill.Invested + 1
					skillPnlLevel:SetText( (skill.Invested) .. "/" .. skill.Max)
					skillPnlLevel:SizeToContents()
				end
				
				surface.PlaySound("buttons/button5.wav")
			end
		end
			
		skillsSelectionPnl.navbar:AddTab(translate.Get("SKILLS_PASSIVE"), passiveSkillsPnl)
		skillsSelectionPnl.navbar:AddTab(translate.Get("SKILLS_MEDIC"), medicSkillsPnl)
		skillsSelectionPnl.navbar:AddTab(translate.Get("SKILLS_REPAIRMAN"), repairSkillsPnl)
		skillsSelectionPnl.navbar:AddTab(translate.Get("SKILLS_ROBOT"), robotSkillsPnl)
	    skillsSelectionPnl.navbar:AddTab(translate.Get("SKILLS_MECHANIC"), mechSkillsPnl)
		skillsSelectionPnl.navbar:SetActive(1)
		
		local shopPnl = vgui.Create("DPanel", qMenuTabs)
		shopPnl:SetSize(qMenuTabs:GetWide(), qMenuTabs:GetTall())
		shopPnl:SetPos(0, 100)
		
		local shopPnlBG = vgui.Create("DPanel", shopPnl)
		shopPnlBG:SetSize(shopPnl:GetWide(), shopPnl:GetTall())
		shopPnlBG.Paint = function(self, w, h)
			surface.SetDrawColor(HL2CR.Theme.qMenu)
			surface.DrawRect(0, 0, w, h)
		end
		
		local shopWeaponsPnl = vgui.Create("DPanel", shopPnlBG)
		shopWeaponsPnl:SetSize(256, 256)
		shopWeaponsPnl:SetPos(12.5, 50)
		shopWeaponsPnl.Paint = function() return end
				
		local shopWeaponsScroll = vgui.Create("DScrollPanel", shopWeaponsPnl)
		shopWeaponsScroll:Dock(FILL)
		
		local weaponsLayout = vgui.Create("DIconLayout", shopWeaponsScroll)
		weaponsLayout:Dock(FILL)
		
		local curResinLabel = vgui.Create("DLabel", shopPnl)
		curResinLabel:SetText(translate.Get("ResinAmount") .. LocalPlayer():GetNWInt("currency_resin"))
		curResinLabel:SetFont("HL2CR_ShopResin")
		curResinLabel:SizeToContents()
		curResinLabel:SetPos(9, 0)
		curResinLabel:SetTextColor(Color(0, 0, 0))
		
		for k, wep in pairs(GAMEMODE.ShopItems) do
			if wep.Type ~= "Weapon" then continue end
			
			if string.find(LocalPlayer():GetNWString("inv_slots"), wep.Name) then continue end
			
			local wepBtn = weaponsLayout:Add("DImageButton")
			wepBtn:SetSize(64, 64)
			wepBtn:SetImage(wep.Icon)
			wepBtn:SetToolTip(CONVERT_NAME_TRANSLATION[wep.Name]().. "\n\n" .. CONVERT_DESC_TRANSLATION[wep.Name]() .. translate.Get("WeaponCost") .. wep.Cost .. translate.Get("Resin"))
			
			wepBtn.DoClick = function(pnl)			

				if LocalPlayer():GetNWInt("currency_resin") < wep.Cost then
					surface.PlaySound("buttons/button16.wav")
					return
				end
				
				net.Start("HL2CR_ObtainItem")
					net.WriteString(wep.Name)
				net.SendToServer()
				
				pnl:Remove()
				
				surface.PlaySound("buttons/button5.wav")
				curResinLabel:SetText(translate.Get("ResinAmount") .. LocalPlayer():GetNWInt("currency_resin") - wep.Cost)
			end
		end
		
		local shopItemsPnl = vgui.Create("DPanel", shopPnlBG)
		shopItemsPnl:SetSize(256, 128)
		shopItemsPnl:SetPos(shopPnl:GetWide() / 2.47, 50)
		shopItemsPnl.Paint = function() return end
				
		local shopItemsScroll = vgui.Create("DScrollPanel", shopItemsPnl)
		shopItemsScroll:Dock(FILL)
		
		local itemsLayout = vgui.Create("DIconLayout", shopItemsScroll)
		itemsLayout:Dock(FILL)
		
		for k, item in pairs(GAMEMODE.ShopItems) do
			
			if item.Type ~= "Item" then continue end
			if string.find(LocalPlayer():GetNWString("inv_slots"), item.Name) then continue end
			
			local itemBtn = itemsLayout:Add("DImageButton")
			itemBtn:SetSize(64, 64)
			itemBtn:SetImage(item.Icon)
			itemBtn:SetToolTip(CONVERT_NAME_TRANSLATION[item.Name]().. "\n\n" .. CONVERT_DESC_TRANSLATION[item.Name]() .. translate.Get("WeaponCost") .. item.Cost .. translate.Get("Resin"))
			
			itemBtn.DoClick = function(pnl)			

				if LocalPlayer():GetNWInt("currency_resin") < item.Cost then
					surface.PlaySound("buttons/button16.wav")
					return
				end
				
				net.Start("HL2CR_ObtainItem")
					net.WriteString(item.Name)
				net.SendToServer()
				
				pnl:Remove()
				
				surface.PlaySound("buttons/button5.wav")
				curResinLabel:SetText(translate.Get("ResinAmount") .. LocalPlayer():GetNWInt("currency_resin") - item.Cost)
			end
		end

		
		
		local shoparmorPnl = vgui.Create("DPanel", shopPnlBG)
		shoparmorPnl:SetSize(192, 192)
		shoparmorPnl:SetPos(12.5, 320)
		shoparmorPnl.Paint = function() return end
				
		local shoparmorScroll = vgui.Create("DScrollPanel", shoparmorPnl)
		shoparmorScroll:Dock(FILL)
			
		local armorLayout = vgui.Create("DIconLayout", shoparmorScroll)
		armorLayout:Dock(FILL)
		
		for k, item in pairs(GAMEMODE.ShopItems) do
			
			if item.Type ~= "Chest" && item.Type ~= "Boots" && item.Type ~= "Helmet" && item.Type ~= "Shoulders" then continue end
			
			local armorBtn = armorLayout:Add("DImageButton")
			armorBtn:SetSize(64, 64)
			armorBtn:SetImage(item.Icon)
			armorBtn:SetToolTip(CONVERT_NAME_TRANSLATION[item.Name]().. "\n\n" .. CONVERT_DESC_TRANSLATION[item.Name]() .. translate.Get("WeaponCost") .. item.Cost .. translate.Get("Resin"))
			armorBtn.DoClick = function(pnl)			

				if LocalPlayer():GetNWInt("currency_resin") < item.Cost then
					surface.PlaySound("buttons/button16.wav")
					return
				end
				
				net.Start("HL2CR_ObtainItem")
					net.WriteString(item.Name)
				net.SendToServer()
				
				pnl:Remove()
				
				surface.PlaySound("buttons/button5.wav")
				curResinLabel:SetText(translate.Get("ResinAmount") .. LocalPlayer():GetNWInt("currency_resin") - item.Cost)
			end
		end
		
		
		local shopMatsPnl = vgui.Create("DPanel", shopPnlBG)
		shopMatsPnl:SetSize(256, 128)
		shopMatsPnl:SetPos(shopPnl:GetWide() / 1.47, 50)
		shopMatsPnl.Paint = function() return end
				
		local shopMatsScroll = vgui.Create("DScrollPanel", shopMatsPnl)
		shopMatsScroll:Dock(FILL)
		
		local matsLayout = vgui.Create("DIconLayout", shopMatsScroll)
		matsLayout:Dock(FILL)
		
		for k, mat in pairs(GAMEMODE.ShopItems) do
			
			if mat.Type ~= "Material" then continue end
			
			local matBtn = matsLayout:Add("DImageButton")
			matBtn:SetSize(64, 64)
			matBtn:SetImage(mat.Icon)
			--matBtn:SetToolTip(CONVERT_NAME_TRANSLATION[mat.Name]().. "\n\n" .. CONVERT_DESC_TRANSLATION[mat.Name]() .. translate.Get("WeaponCost") .. mat.Cost .. translate.Get("Resin"))
			matBtn:SetToolTip("Test".. "\n\n" .. "Blah" .. translate.Get("WeaponCost") .. mat.Cost .. translate.Get("Resin"))
			
			matBtn.DoClick = function(pnl)			

				if LocalPlayer():GetNWInt("currency_resin") < mat.Cost then
					surface.PlaySound("buttons/button16.wav")
					return
				end
				
				net.Start("HL2CR_ObtainItem")
					net.WriteString(mat.Name)
				net.SendToServer()
				
				surface.PlaySound("buttons/button5.wav")
				curResinLabel:SetText(translate.Get("ResinAmount") .. LocalPlayer():GetNWInt("currency_resin") - mat.Cost)
			end
		end
		
		local classPnl = vgui.Create("DPanel", qMenuTabs)
		classPnl:SetSize(qMenuTabs:GetWide(), qMenuTabs:GetTall())
		classPnl:SetPos(0, 100)
		
		local classPnlBG = vgui.Create("DPanel", classPnl)
		classPnlBG:SetSize(classPnl:GetWide(), classPnl:GetTall())
		classPnlBG.Paint = function(self, w, h)
			surface.SetDrawColor(HL2CR.Theme.qMenu)
			surface.DrawRect(0, 0, w, h)
		end

		local classHorizontalScroll = vgui.Create("DHorizontalScroller", classPnlBG)
		classHorizontalScroll:Dock(FILL)
		classHorizontalScroll:SetOverlap( -35 )

		if LocalPlayer():GetNWInt("stat_level") >= 5 then
			for i, class in pairs(GAMEMODE.PlayStyleClass) do
				if LocalPlayer():GetNWInt("stat_level") < class.LevelReq then break end
				
				local classShowPanel = vgui.Create("DPanel", classHorizontalScroll)
				classShowPanel:SetSize(250, classPnl:GetTall())
				classShowPanel:DockMargin(25, 0, 0, 0)
				classShowPanel:DockPadding(50, 0, 0, 0)
				classShowPanel:Dock(LEFT)
				classShowPanel.Paint = function(pnl, w, h)
					surface.SetDrawColor(225, 160, 0, 255)
					surface.DrawRect(0, 0, w, h)
				end
				
				local classPnlShowcase = vgui.Create("DLabel", classShowPanel)
				classPnlShowcase:SetText(class.Name)
				classPnlShowcase:SetFont("HL2CR_Class_TitleFont")
				classPnlShowcase:DockMargin(10, 0, 0, 0)
				classPnlShowcase:Dock(TOP)
				classPnlShowcase:SizeToContents()
				classPnlShowcase:SetTextColor(Color(0, 0, 0, 255))
				
				local classPnlDesc = vgui.Create("DLabel", classShowPanel)
				classPnlDesc:SetText(class.Desc .. "\n" .. class.EquipmentDesc .. "\n" .. class.StrWeak)
				classPnlDesc:SetPos( (classShowPanel:GetWide() / classPnlDesc:GetWide() ) + 25, 50)
				classPnlDesc:SetFont("HL2CR_Class_DescFont")
				classPnlDesc:SizeToContents()
				classPnlDesc:SetTextColor(Color(0, 0, 0, 255))
				
				local classIcon = vgui.Create("DImage", classShowPanel)
				classIcon:SetImage(class.Icon)
				classIcon:SetSize(138, 138)
				classIcon:SetPos(classShowPanel:GetWide() / 5, ScrH() / 3.5)
				
				local classBtn = vgui.Create("DButton", classShowPanel)
				classBtn:SetText(translate.Get("PickClass"))
				classBtn:SetSize(138, 35)
				classBtn:SetPos(classIcon:GetWide()/2.75, classShowPanel:GetTall() / 1.5)
				
				classBtn.DoClick = function()
					net.Start("HL2CR_SelectClass")
						net.WriteInt(i, 8)
					net.SendToServer()
					surface.PlaySound("hl2cr/standardbeep.wav")
					qMenuTabs:Remove()
				end
				
				classHorizontalScroll:AddPanel(classShowPanel)
				
				local curClassCount = 0
				
				for i, v in ipairs(player.GetAll()) do
					if v:GetNWString("stat_curclass") == class.Name then
						curClassCount = curClassCount + 1
					end
				end
				
				local curSessionClasses = vgui.Create("DLabel", classShowPanel)
				curSessionClasses:SetText(curClassCount .. " " .. class.Name)
				curSessionClasses:SetPos(classShowPanel:GetWide() / 3 - 10, classShowPanel:GetTall() )
				curSessionClasses:SetFont("HL2CR_Class_DescFont")
				curSessionClasses:SizeToContents()
				curSessionClasses:SetTextColor(Color(0, 0, 0, 255))
			end
		else
			local classPnlLocked = vgui.Create("DLabel", classPnl)
			classPnlLocked:SetText(translate.Get("Class_Locked"))
			classPnlLocked:SetFont("HL2CR_Class_TitleFont")
			classPnlLocked:SizeToContents()
			classPnlLocked:SetPos( classPnlBG:GetWide() / 2 - 135, 50)
			classPnlLocked:SetTextColor(Color(0, 0, 0, 255))
		end
		
		local statsPnl = vgui.Create("DPanel", qMenuTabs)
		statsPnl:SetSize(qMenuTabs:GetWide(), qMenuTabs:GetTall())
		statsPnl:SetPos(0, 100)
		
		local statsPnlBG = vgui.Create("DPanel", statsPnl)
		statsPnlBG:SetSize(statsPnl:GetWide(), statsPnl:GetTall())
		statsPnlBG.Paint = function(self, w, h)
			surface.SetDrawColor(HL2CR.Theme.qMenu)
			surface.DrawRect(0, 0, w, h)
		end
		
		local fixInf = 0
		
		if LocalPlayer():GetNWInt("stat_deaths") == 0 then
			fixInf = 1
		end
		
		local averageStat = LocalPlayer():GetNWInt("stat_kills") / (LocalPlayer():GetNWInt("stat_deaths") + fixInf)
		
		statsPnlLabelBasic = vgui.Create("DLabel", statsPnl)
		statsPnlLabelBasic:SetText(translate.Get("Kills") .. LocalPlayer():GetNWInt("stat_kills") .. translate.Get("Deaths") .. LocalPlayer():GetNWInt("stat_deaths") .. translate.Get("Average") .. math.Round(averageStat, 2))
		statsPnlLabelBasic:SetFont("HL2CR_Menu_Stats")
		statsPnlLabelBasic:SetPos(0, 25)
		statsPnlLabelBasic:SizeToContents()
		
		local totalAchs = table.Count(GAMEMODE.Achievements["HL2"]) + table.Count(GAMEMODE.Achievements["Misc"])
		
		statsPnlLabelAch = vgui.Create("DLabel", statsPnl)
		statsPnlLabelAch:SetPos(0, 75)
		statsPnlLabelAch:SetText(translate.Get("Achievs") .. LocalPlayer():GetNWInt("stat_totalachs", -1) .. "/" .. totalAchs)
		statsPnlLabelAch:SetFont("HL2CR_Menu_Stats")
		statsPnlLabelAch:SizeToContents()
		
		statsPnlLabelQuest = vgui.Create("DLabel", statsPnl)
		statsPnlLabelQuest:SetPos(0, 125)
		statsPnlLabelQuest:SetText(translate.Get("Quests_Done") .. LocalPlayer():GetNWInt("stat_quests_completed", -1))
		statsPnlLabelQuest:SetFont("HL2CR_Menu_Stats")
		statsPnlLabelQuest:SizeToContents()
		
		qMenuTabs.navbar:AddTab(translate.Get("Inv_Bar"), invPnl)
		qMenuTabs.navbar:AddTab(translate.Get("Class_Bar"), classPnl)
		qMenuTabs.navbar:AddTab(translate.Get("Skills_Bar"), skillsPnl)
		qMenuTabs.navbar:AddTab(translate.Get("Shop_Bar"), shopPnl)
		qMenuTabs.navbar:AddTab(translate.Get("Statistics_Bar"), statsPnl)
		
		qMenuTabs.navbar:SetActive(1)
	else
		if qMenuTabs and qMenuTabs:IsValid() then
			qMenuTabs:Remove()
		end
	end
end