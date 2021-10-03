local CONVERT_NAME_TO_IMAGE = {
	["Flare_gun"] = "materials/hl2cr/weapon_flaregun.jpg",
	["Automatic_Pistol"] = "materials/hl2cr/weapon_autopistol.jpg",
	["Multi_Grenade_Launcher"] = "materials/hl2cr/weapon_grenadelauncher.jpg",
	["Shredding_Assault_Rifle"] = "materials/hl2cr/weapon_shreddingar.jpg",
	["The_Nailer_Gun"] = "materials/hl2cr/weapon_nailer.jpg",
	["Unstable_Electric_Shotgun"] = "materials/hl2cr/weapon_unstableshotgun.jpg",
	["BMG_Heavy_Sniper"] = "materials/hl2cr/weapon_bmgsniper.jpg",
	["Test"] = "materials/hl2cr/empty.jpg"
}

local CONVERT_NAME_TO_PROPER = {
	["Flare_gun"] = "Flare gun",
	["Automatic_Pistol"] = "Automatic Pistol",
	["Multi_Grenade_Launcher"] = "Multiple Grenade Launcher",
	["Shredding_Assault_Rifle"] = "'Shredding' Assault Rifle",
	["Unstable_Electric_Shotgun"] = "'Unstable' Electric Shotgun",
	["The_Nailer_Gun"] = "The 'Nailer' Gun",
	["BMG_Heavy_Sniper"] = "50 BMG Heavy Sniper",
	
	["Test"] = "Test"
}

local CONVERT_NAME_TO_DESC = {
	["Flare_gun"] = "Used for emergencies...\nso it was",
	["Automatic_Pistol"] = "A pistol that is automatic\nno questions",
	["Multi_Grenade_Launcher"] = "A grenade launcher\nhandle with care",
	["Shredding_Assault_Rifle"] = "This thing shreds people",
	["Unstable_Electric_Shotgun"] = "Highly unstable\nImmediately throw after use",
	["The_Nailer_Gun"] = "Nailed it!",
	["BMG_Heavy_Sniper"] = "A rather heavy sniper\nwith devastating results",
	["Test"] = "Test Item\nYou shouldn't be buying this"
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
}

local PLAYERMODELS = {
	[0] = {
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
	
	[5] = {
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
	
	[10] = {
		[1] = "models/player/police.mdl",
		[2] = "models/player/police_fem.mdl"
	}
}

net.Receive("HL2CR_QMenuUpdate", function()
	local skillsTbl = net.ReadTable()
	StartQMenu(net.ReadBool(), skillsTbl)
end)

function StartQMenu(shouldOpen, skillsTbl)

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
		invPnlPlayer:SetPos(invPnl:GetWide() / 1.3, -invPnl:GetTall() / 32 + 16)
		invPnlPlayer:SetSize(invPnl:GetWide(), invPnl:GetTall() )
		invPnlPlayer.Paint = function(self, w, h)
			surface.SetDrawColor(HL2CR.Theme.qMenu2)
			surface.DrawRect(0, 0, w, h)
		end
		
		local invPnlPlayerModel = vgui.Create( "DModelPanel", invPnlPlayer )
		invPnlPlayerModel:SetSize(invPnlPlayer:GetWide(), invPnlPlayer:GetTall() + 100)
		invPnlPlayerModel:SetPos(-invPnlPlayerModel:GetWide() / 2.6, invPnlPlayerModel:GetTall() / 500)
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
		
		local invPnlSlotsPnl = vgui.Create("DPanel", invPnl)
		invPnlSlotsPnl:SetSize(invPnl:GetWide() / 2, invPnl:GetTall())
		invPnlSlotsPnl:SetPos(15, 16)
		invPnlSlotsPnl.Paint = function() end
		
		local invLayout = vgui.Create("DIconLayout", invPnlSlotsPnl)
		invLayout:Dock(FILL)
		invLayout:SetSpaceX(10)
		invLayout:SetSpaceY(5)

		local weaponSlotPnl = vgui.Create("DPanel", invPnl)
		weaponSlotPnl:SetPos(invPnl:GetWide() / 1.55, 50)
		weaponSlotPnl:SetSize(invPnl:GetWide() / (ScrW() / 102), invPnl:GetWide() / (ScrW() / 102) )
		
		weaponSlotPnl.Paint = function(pnl, w, h)
			surface.SetDrawColor(HL2CR.Theme.qMenu2)
			surface.DrawRect(0, 0, w, h)
		end
		
		weaponSlotImage = vgui.Create("DImage", weaponSlotPnl)
		weaponSlotImage:SetSize(weaponSlotPnl:GetWide(), weaponSlotPnl:GetTall())
		if CONVERT_NAME_TO_IMAGE[LocalPlayer():GetNWString("inv_weaponslot")] then
			weaponSlotImage:SetImage(CONVERT_NAME_TO_IMAGE[LocalPlayer():GetNWString("inv_weaponslot")])
		else
			weaponSlotImage:SetImage("materials/hl2cr/empty.jpg")
		end
		
		local slots = string.Explode(" ", LocalPlayer():GetNWString("inv_slots"))

		local totalSlots = LocalPlayer():GetNWInt("inv_totalslots")
		
		local pl = LocalPlayer()
		pl.Inv = {}
		
		for i = 1, totalSlots do
			pl.Inv[i] = invLayout:Add("HL2CR_InvSlot")
			pl.Inv[i]:SetSize(62, 62)
			
			if slots[i] and CONVERT_NAME_TO_IMAGE[slots[i]] then
				pl.Inv[i].Icon = vgui.Create("DImageButton", pl.Inv[i])
				pl.Inv[i].Icon:SetImage(CONVERT_NAME_TO_IMAGE[slots[i]])
				pl.Inv[i].Icon:SetToolTip(CONVERT_NAME_TO_DESC[slots[i]])
				pl.Inv[i].Icon:SetSize(pl.Inv[i]:GetWide(), pl.Inv[i]:GetTall())
				pl.Inv[i].Icon.DoClick = function()
					net.Start("HL2CR_UpdateSlot")
						net.WriteString(slots[i])
					net.SendToServer()
					
					surface.PlaySound("hl2cr/standardbeep.wav")
					
					weaponSlotImage:SetImage(CONVERT_NAME_TO_IMAGE[slots[i]])
				end
			end
		end
		
		local modelHorizontalScroll = vgui.Create("DHorizontalScroller", invPnl)
		modelHorizontalScroll:SetSize(512, 64)
		modelHorizontalScroll:SetPos(0, invPnl:GetTall() - 168)
		
		for level, v in pairs(PLAYERMODELS) do
			for i, p in ipairs(v) do
				if LocalPlayer():GetNWInt("stat_level") >= level then
					local playermodelBtn = vgui.Create("SpawnIcon", modelHorizontalScroll)
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
		
		local passiveSkillsPnl = vgui.Create("DPanel", skillsPnl)
		passiveSkillsPnl:SetSize(skillsSelectionPnl:GetWide(), skillsSelectionPnl:GetTall())
		
		local skillHorizontalScroll = vgui.Create("DHorizontalScroller", passiveSkillsPnl)
		skillHorizontalScroll:Dock(FILL)
		skillHorizontalScroll:SetOverlap( -75 )
		
		local passiveSkillsLayout = vgui.Create("DIconLayout", skillHorizontalScroll)
		passiveSkillsLayout:Dock(FILL)
		
		local medicSkillsPnl = vgui.Create("DPanel", skillsPnl)
		medicSkillsPnl:SetSize(skillsSelectionPnl:GetWide() * 1.60, skillsSelectionPnl:GetTall())
		
		local medicSkillHorizontalScroll = vgui.Create("DHorizontalScroller", medicSkillsPnl)
		medicSkillHorizontalScroll:Dock(FILL)
		medicSkillHorizontalScroll:SetOverlap( -35 )
		
		local medicSkillsLayout = vgui.Create("DIconLayout", medicSkillHorizontalScroll)
		medicSkillsLayout:Dock(FILL)
		
		local repairSkillsPnl = vgui.Create("DPanel", skillsPnl)
		repairSkillsPnl:SetSize(skillsSelectionPnl:GetWide(), skillsSelectionPnl:GetTall())
		
		local mechSkillsPnl = vgui.Create("DPanel", skillsPnl)
		mechSkillsPnl:SetSize(skillsSelectionPnl:GetWide(), skillsSelectionPnl:GetTall())
		
		for i, skill in pairs(GAMEMODE.PlayerSkills) do
			
			local statusPnl
			
			if skill.Class == "Passive" then
				statusPnl = vgui.Create("DPanel", passiveSkillsLayout)
				statusPnl:SetSize(passiveSkillsPnl:GetWide() / 5, passiveSkillsPnl:GetTall())
			elseif skill.Class == "Medic" then
				statusPnl = vgui.Create("DPanel", medicSkillsLayout)
				statusPnl:SetSize(medicSkillsPnl:GetWide() / 8, medicSkillsPnl:GetTall())
			elseif skill.Class == "Repair" then
				statusPnl = vgui.Create("DPanel", repairSkillsPnl)
				statusPnl:SetSize(repairSkillsPnl:GetWide() / 8, repairSkillsPnl:GetTall())
			elseif skill.Class == "Mechanic" then
				statusPnl = vgui.Create("DPanel", mechSkillsPnl)
				statusPnl:SetSize(mechSkillsPnl:GetWide() / 8, mechSkillsPnl:GetTall())
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
			
			if skill.Name == skillsTbl[skill.Class].Name then
				skillPnlLevel:SetText( (skillsTbl[skill.Class].CurInvest ) .. "/" .. skill.Max)
			end
			skillPnlLevel:SizeToContents()
			
			statusPnl.Paint = function(pnl, w, h)
				surface.SetDrawColor(HL2CR.Theme.skillFill)
				surface.DrawRect(0, 0, w, h)
			end
			
			skillBtn = vgui.Create("DImageButton", statusPnl)
			skillBtn:SetSize(92, 92)
			skillBtn:SetPos(statusPnl:GetWide() / 4, statusPnl:GetWide())
		
			if LocalPlayer():GetNWInt("stat_level") < skill.LevelReq then
				skillBtn:SetImage("vgui/hud/icon_locked.png")
				continue
			end
			
			skillBtn:SetImage(skill.Icon)
			
			local skillPoints = LocalPlayer():GetNWInt("stat_skillpoints")
			
			skillBtn.DoClick = function(pnl)
				if LocalPlayer():GetNWInt("stat_level") < skill.LevelReq then
					surface.PlaySound("buttons/button16.wav")
					return
				end
				
				if skill.Name == skillsTbl[skill.Class].Name and skillsTbl[skill.Class].CurInvest >= skill.Max then
					surface.PlaySound("buttons/button16.wav")
					return
				end
			
				if skillPoints <= 0 then
					surface.PlaySound("buttons/button16.wav")
					return
				end
				
				net.Start("HL2CR_SkillObtain")
					net.WriteString(skill.Name)
					net.WriteString(skill.Class)
				net.SendToServer()
				
				skillPoints = skillPoints - 1
				
				skillsTbl[skill.Class].CurInvest = (skillsTbl[skill.Class].CurInvest or 0) + 1
				skillPnlLevel:SetText( (skillsTbl[skill.Class].CurInvest or 0 ) .. "/" .. skill.Max)
				skillPnlLevel:SizeToContents()
				
				surface.PlaySound("buttons/button5.wav")
			end
		end
			
		skillsSelectionPnl.navbar:AddTab(translate.Get("SKILLS_PASSIVE"), passiveSkillsPnl)
		skillsSelectionPnl.navbar:AddTab(translate.Get("SKILLS_MEDIC"), medicSkillsPnl)
		skillsSelectionPnl.navbar:AddTab(translate.Get("SKILLS_REPAIRMAN"), repairSkillsPnl)
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
		shopWeaponsPnl.Paint = function(self, w, h)
			surface.SetDrawColor(HL2CR.Theme.qMenu3)
			surface.DrawRect(0, 0, w, h)
		end
				
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
		
		for k, item in pairs(GAMEMODE.ShopItems) do
			if item.Type ~= "Weapon" then continue end
			if string.find(LocalPlayer():GetNWString("inv_slots"), item.Name) then continue end
			
			local itemBtn = weaponsLayout:Add("DImageButton")
			itemBtn:SetSize(64, 64)
			itemBtn:SetImage(item.Icon)
			itemBtn:SetToolTip(CONVERT_NAME_TRANSLATION[item.Name]().. "\n\n" .. CONVERT_DESC_TRANSLATION[item.Name]() .. translate.Get("WeaponCost") .. item.Cost .. translate.Get("Resin"))
			
			itemBtn.DoClick = function(pnl)			

				if LocalPlayer():GetNWInt("currency_resin") < item.Cost then
					surface.PlaySound("buttons/button16.wav")
					return
				end
				
				net.Start("HL2CR_PurchaseItem")
					net.WriteString(item.Name)
				net.SendToServer()
				
				pnl:Remove()
				
				surface.PlaySound("buttons/button5.wav")
				curResinLabel:SetText(translate.Get("ResinAmount") .. LocalPlayer():GetNWInt("currency_resin") - item.Cost)
			end
		end
		local shopItemsPnl = vgui.Create("DPanel", shopPnlBG)
		shopItemsPnl:SetSize(256, 128)
		shopItemsPnl:SetPos(shopPnl:GetWide() / 1.47, 50)
		shopItemsPnl.Paint = function(self, w, h)
			surface.SetDrawColor(HL2CR.Theme.qMenu3)
			surface.DrawRect(0, 0, w, h)
		end
				
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
				
				net.Start("HL2CR_PurchaseItem")
					net.WriteString(item.Name)
				net.SendToServer()
				
				pnl:Remove()
				
				surface.PlaySound("buttons/button5.wav")
				curResinLabel:SetText(translate.Get("ResinAmount") .. LocalPlayer():GetNWInt("currency_resin") - item.Cost)
			end
		end
		
		local petsPnl = vgui.Create("DPanel", qMenuTabs)
		petsPnl:SetSize(qMenuTabs:GetWide(), qMenuTabs:GetTall())
		petsPnl:SetPos(0, 100)
		
		local petsPnlBG = vgui.Create("DPanel", petsPnl)
		petsPnlBG:SetSize(petsPnl:GetWide(), petsPnl:GetTall())
		petsPnlBG.Paint = function(self, w, h)
			surface.SetDrawColor(HL2CR.Theme.qMenu)
			surface.DrawRect(0, 0, w, h)
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
				classPnlDesc:SetText(class.Desc .. "\n\n" .. class.EquipmentDesc)
				classPnlDesc:SetPos( (classShowPanel:GetWide() / classPnlDesc:GetWide() ) + 25, 50)
				classPnlDesc:SetFont("HL2CR_Class_DescFont")
				classPnlDesc:SizeToContents()
				classPnlDesc:SetTextColor(Color(0, 0, 0, 255))
				
				local classIcon = vgui.Create("DImage", classShowPanel)
				classIcon:SetImage(class.Icon)
				classIcon:SetSize(138, 138)
				classIcon:SetPos(classShowPanel:GetWide() / 5, ScrH() / 5)
				
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
		
		local achsPnl = vgui.Create("DPanel", qMenuTabs)
		achsPnl:SetSize(qMenuTabs:GetWide(), qMenuTabs:GetTall())
		
		local achsPnlBG = vgui.Create("DPanel", achsPnl)
		achsPnlBG:SetSize(qMenuTabs:GetWide(), qMenuTabs:GetTall())
		achsPnlBG.Paint = function(self, w, h)
			surface.SetDrawColor(HL2CR.Theme.qMenu)
			surface.DrawRect(0, 0, w, h)
		end
		
		local achsSelectionPnl = vgui.Create("HL2CR_Tab", achsPnlBG)
		achsSelectionPnl:SetSize(achsPnl:GetWide(), achsPnl:GetTall())
		achsSelectionPnl:SetPos(0, -35)
		achsSelectionPnl:SetKeyboardInputEnabled(false)
		
		local hl2Pnl = vgui.Create("DPanel", achsSelectionPnl)

		local hl2ScrollPnl = vgui.Create("DScrollPanel", hl2Pnl)
		hl2ScrollPnl:SetSize(achsSelectionPnl:GetWide(), achsSelectionPnl:GetTall() / 1.40)
		
		local hl2AchList = vgui.Create("DIconLayout", hl2ScrollPnl)
		hl2AchList:SetPos(hl2Pnl:GetWide() - 50, achsSelectionPnl:GetTall() / 26 - (-hl2Pnl:GetTall() + 25))
		hl2AchList:SetSize(achsSelectionPnl:GetWide(), achsSelectionPnl:GetTall())
		hl2AchList:SetSpaceY(10)
		hl2AchList:SetSpaceX(30)
		
		local achIndex = 0
		
		for k, v in pairs(GAMEMODE.Achievements["HL2"]) do
			achIndex = achIndex + 1
			
			local achPnl = hl2AchList:Add("DPanel")
			achPnl:SetSize(achsPnl:GetWide() / 3.5, 75)
			achPnl.Paint = function(pnl, w, h)
				surface.SetDrawColor(HL2CR.Theme.qMenu2)
				surface.DrawRect(0, 0, w, h)
			end
			
			local achName = vgui.Create("DLabel", achPnl)
			achName:SetPos(75, 0)
			achName:SetFont("HL2CR_AchTitle")
			achName:SetText(translate.Get("Ach_Locked"))
			
			local achDesc = vgui.Create("DLabel", achPnl)
			achDesc:SetPos(75, 20)
			achDesc:SetFont("HL2CR_AchDesc")
			achDesc:SetText("")
			
			local achIcon = vgui.Create("DImage", achPnl)
			achIcon:SetSize(75, 75)
			achIcon:SetImage("vgui/hud/icon_locked.png")
			
			if string.find(LocalPlayer():GetNWString("stat_achievements"), v.Name) then
				achName:SetText(v.Name)
				achDesc:SetText(v.Desc)
				achIcon:SetImage(v.Mat)
			end

			achName:SizeToContents()
			achDesc:SizeToContents()
		end
		
		local miscPnl = vgui.Create("DPanel", achScreenPnl)
		
		local miscScrollPnl = vgui.Create("DScrollPanel", miscPnl)
		miscScrollPnl:SetSize(achsSelectionPnl:GetWide(), achsSelectionPnl:GetTall() / 1.60 + 10)
		
		local miscAchList = vgui.Create("DIconLayout", miscScrollPnl)
		miscAchList:SetPos(hl2Pnl:GetWide() - 50, achsSelectionPnl:GetTall() / 26 - (-hl2Pnl:GetTall() + 25))
		miscAchList:SetSize(achsSelectionPnl:GetWide(), achsSelectionPnl:GetTall())
		miscAchList:SetSpaceY(10)
		miscAchList:SetSpaceX(30)
		
		achIndex = 0
		
		for k, v in pairs(GAMEMODE.Achievements["Misc"]) do
			achIndex = achIndex + 1
			
			local achPnl = miscAchList:Add("DPanel")
			achPnl:SetSize(achsPnl:GetWide() / 3.5, 75)
			achPnl.Paint = function(pnl, w, h)
				surface.SetDrawColor(HL2CR.Theme.qMenu2)
				surface.DrawRect(0, 0, w, h)
			end
			
			local achName = vgui.Create("DLabel", achPnl)
			achName:SetPos(75, 0)
			achName:SetFont("HL2CR_AchTitle")
			achName:SetText(translate.Get("Ach_Locked"))
			
			local achDesc = vgui.Create("DLabel", achPnl)
			achDesc:SetPos(75, 20)
			achDesc:SetFont("HL2CR_AchDesc")
			achDesc:SetText("")
			
			local achIcon = vgui.Create("DImage", achPnl)
			achIcon:SetSize(75, 75)
			achIcon:SetImage("vgui/hud/icon_locked.png")

			if string.find(LocalPlayer():GetNWString("stat_achievements"), v.Name) then
				achName:SetText(v.Name)
				achDesc:SetText(v.Desc)
				achIcon:SetImage(v.Mat)
			end
			
			achName:SizeToContents()
			achDesc:SizeToContents()	
		end
		
		achsSelectionPnl.navbar:AddTab("Half-Life 2", hl2Pnl)
		achsSelectionPnl.navbar:AddTab("Misc", miscPnl)
		achsSelectionPnl.navbar:SetActive(1)
		
		qMenuTabs.navbar:AddTab(translate.Get("Inv_Bar"), invPnl)
		qMenuTabs.navbar:AddTab(translate.Get("Class_Bar"), classPnl)
		qMenuTabs.navbar:AddTab(translate.Get("Achievements_Bar"), achsPnl)
		qMenuTabs.navbar:AddTab(translate.Get("Skills_Bar"), skillsPnl)
		qMenuTabs.navbar:AddTab(translate.Get("Shop_Bar"), shopPnl)
		qMenuTabs.navbar:AddTab(translate.Get("Pets_Bar"), petsPnl)
		qMenuTabs.navbar:AddTab(translate.Get("Statistics_Bar"), statsPnl)
		
		qMenuTabs.navbar:SetActive(1)
	else
		if qMenuTabs and qMenuTabs:IsValid() then
			qMenuTabs:Remove()
		end
	end
end
--[[
hook.Add("OnSpawnMenuOpen", "HL2CR_QMenuOpen", function()
	StartQMenu(true)
end)

hook.Add("OnSpawnMenuClose", "HL2CR_QMenuClose", function()
	StartQMenu(false)
end)
--]]