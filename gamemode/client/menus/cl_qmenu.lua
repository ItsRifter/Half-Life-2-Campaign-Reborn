local plymeta = FindMetaTable("Player")

function plymeta:GetInvItem(x,y)
	return self.Inv.Backpack[x][y]
end
--[[
local function ShowConfirmScreen(classIndex)

	local confirmFrame = vgui.Create("DFrame")
	confirmFrame:SetBackgroundBlur( true )
	confirmFrame:SetSize(350, 250)
	confirmFrame:Center()
	confirmFrame:MakePopup()
	confirmFrame:SetTitle("")
	confirmFrame:ShowCloseButton(false)
	
	local confirmLabel = vgui.Create("DLabel", confirmFrame)
	confirmLabel:SetText("Are you sure?")
	confirmLabel:SetPos(confirmFrame:GetWide() / 4, 25)
	confirmLabel:SetFont("HL2CR_Class_TitleFont")
	confirmLabel:SizeToContents()
	
	local confirmDescLabel = vgui.Create("DLabel", confirmFrame)
	confirmDescLabel:SetText("Once you have selected this class\nYou won't be able to select a different class\nuntil you prestige")
	confirmDescLabel:SetPos(confirmFrame:GetWide() / 6 - 35, 75)
	confirmDescLabel:SetFont("HL2CR_Class_DescFont")
	confirmDescLabel:SizeToContents()
	
	local cancelBtn = vgui.Create("DButton", confirmFrame)
	cancelBtn:SetSize(125, 50)
	cancelBtn:SetPos(confirmFrame:GetWide() / 4 - 75, 150)
	cancelBtn:SetText("Cancel")
	cancelBtn.DoClick = function()
		confirmFrame:Close()
	end
	
	local acceptBtn = vgui.Create("DButton", confirmFrame)
	acceptBtn:SetSize(125, 50)
	acceptBtn:SetPos(confirmFrame:GetWide() / 2 + 35, 150)
	acceptBtn:SetText("Confirm")
	acceptBtn.DoClick = function()
		confirmFrame:Close()
		net.Start("HL2CR_SelectClass")
			net.WriteInt(classIndex, 8)
		net.SendToServer()
	end
end
--]]
hook.Add("OnSpawnMenuOpen", "HL2CR_InventoryOpen", function()
	local pl = LocalPlayer()
	pl.Inv = {}
	pl.Inv.Backpack = {}

	for i = 1, 5 do
		pl.Inv.Backpack[i] = {}
	end

	if LocalPlayer():Alive() then
		menuFrame = vgui.Create("HL2CR_Tab")
		menuFrame:SetSize(ScrW() / 2, ScrH() / 2)
		menuFrame:Center()
		menuFrame:MakePopup()
		
		local invPnl = vgui.Create("DPanel", menuFrame)
		invPnl:SetSize(ScrW() / 2, ScrH() / 2)
		invPnl:SetPos(0, 100)
		
		local invPnlBG = vgui.Create("DPanel", invPnl)
		invPnlBG:SetSize(invPnl:GetWide(), invPnl:GetTall())
		
		invPnlBG.Paint = function(self, w, h)
			surface.SetDrawColor(GAMEMODE.Colours.QMenu)
			surface.DrawRect(0, 0, w, h)
		end
		
		local invPnlPlayer = vgui.Create("DPanel", invPnl)
		invPnlPlayer:SetPos(invPnl:GetWide() - 285, 5)
		invPnlPlayer:SetSize(invPnl:GetWide() / 3.5, invPnl:GetTall() / 1.35)
		invPnlPlayer.Paint = function(self, w, h)
			surface.SetDrawColor(Color(138, 87, 43, 255))
			surface.DrawRect(0, 0, w, h)
		end
		
		local invPnlPlayerModel = vgui.Create( "DModelPanel", invPnlPlayer )
		invPnlPlayerModel:SetSize(invPnlPlayer:GetWide() * 2.75, invPnlPlayer:GetTall() * 2.25)
		invPnlPlayerModel:SetPos(-invPnlPlayer:GetWide() / 1.15, -invPnlPlayer:GetTall() / 2.5)
		invPnlPlayerModel:SetModel( LocalPlayer():GetModel() )
		function invPnlPlayerModel:LayoutEntity( Entity ) return end
		
		--Sets the Width
		for k, v in pairs(pl.Inv.Backpack)do
			for i= 1, 4 do
				pl.Inv.Backpack[k][i] = false
			end
		end
		
		--Sets the Height
		for k, v in pairs(pl.Inv.Backpack)do
			 for i = 1, 3 do
				  pl.Inv.Backpack[k][i] = vgui.Create("HL2CR_InvSlot", invPnl)
				  pl.Inv.Backpack[k][i]:SetPos((k*50)-25,(i*50)-25)
				  pl.Inv.Backpack[k][i]:SetSize(48, 48)
				  pl.Inv.Backpack[k][i]:SetCoords(k, i)
			 end
		end
		
		local skillsPnl = vgui.Create("DPanel", menuFrame)
		skillsPnl:SetSize(ScrW() / 1.45, ScrH() / 2)
		skillsPnl:SetPos(0, 100)
		
		local skillsPnlBG = vgui.Create("DPanel", skillsPnl)
		skillsPnlBG:SetSize(skillsPnl:GetWide(), skillsPnl:GetTall())
		skillsPnlBG.Paint = function(self, w, h)
			surface.SetDrawColor(GAMEMODE.Colours.QMenu)
			surface.DrawRect(0, 0, w, h)
		end
		
		local petsPnl = vgui.Create("DPanel", menuFrame)
		petsPnl:SetSize(ScrW() / 1.45, ScrH() / 2)
		petsPnl:SetPos(0, 100)
		
		local petsPnlBG = vgui.Create("DPanel", petsPnl)
		petsPnlBG:SetSize(petsPnl:GetWide(), petsPnl:GetTall())
		petsPnlBG.Paint = function(self, w, h)
			surface.SetDrawColor(GAMEMODE.Colours.QMenu)
			surface.DrawRect(0, 0, w, h)
		end
		
		local classPnl = vgui.Create("DPanel", menuFrame)
		classPnl:SetSize(ScrW() / 2.15, ScrH() / 2)
		classPnl:SetPos(0, 100)
		
		local classPnlBG = vgui.Create("DPanel", classPnl)
		classPnlBG:SetSize(classPnl:GetWide(), classPnl:GetTall())
		classPnlBG.Paint = function(self, w, h)
			surface.SetDrawColor(GAMEMODE.Colours.QMenu)
			surface.DrawRect(0, 0, w, h)
		end
	
		if LocalPlayer():GetNWInt("stat_level") >= 5 then
			for i, class in pairs(GAMEMODE.PlayStyleClass) do
				local classShowPanel = vgui.Create("DPanel", classPnl)
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
				classIcon:SetSize(128, 128)
				classIcon:SetPos(classShowPanel:GetWide() / 4, classShowPanel:GetTall() / 3)
				
				local classBtn = vgui.Create("DButton", classShowPanel)
				classBtn:SetText("Pick Class")
				classBtn:SetSize(125, 35)
				classBtn:SetPos(classShowPanel:GetWide() / 4, classShowPanel:GetTall() / 1.5)
				
				classBtn.DoClick = function()
					net.Start("HL2CR_SelectClass")
						net.WriteInt(i, 8)
					net.SendToServer()
					menuFrame:Remove()
				end
			end
		else
			local classPnlLocked = vgui.Create("DLabel", classPnl)
			classPnlLocked:SetText("LOCKED: Reach Level 5")
			classPnlLocked:SetFont("HL2CR_Class_TitleFont")
			classPnlLocked:SizeToContents()
			classPnlLocked:SetPos( classPnlBG:GetWide() / 2 - 135, 50)
			classPnlLocked:SetTextColor(Color(0, 0, 0, 255))
		end
		
		local statsPnl = vgui.Create("DPanel", menuFrame)
		statsPnl:SetSize(ScrW() / 2.5, ScrH() / 2)
		statsPnl:SetPos(0, 100)
		
		local statsPnlBG = vgui.Create("DPanel", statsPnl)
		statsPnlBG:SetSize(statsPnl:GetWide(), statsPnl:GetTall())
		statsPnlBG.Paint = function(self, w, h)
			surface.SetDrawColor(GAMEMODE.Colours.QMenu)
			surface.DrawRect(0, 0, w, h)
		end
		
		local fixInf = 0
		
		if LocalPlayer():GetNWInt("stat_deaths") == 0 then
			fixInf = 1
		end
		
		local averageStat = LocalPlayer():GetNWInt("stat_kills") / (LocalPlayer():GetNWInt("stat_deaths") + fixInf)
		
		statsPnlLabelBasic = vgui.Create("DLabel", statsPnl)
		statsPnlLabelBasic:SetText("            Kills: " .. LocalPlayer():GetNWInt("stat_kills") .. "     Deaths: " .. LocalPlayer():GetNWInt("stat_deaths") .. "     Avg: " .. math.Round(averageStat, 2))
		statsPnlLabelBasic:SetFont("HL2CR_Menu_Stats")
		statsPnlLabelBasic:SizeToContents()
		
		local totalAchs = table.Count(GAMEMODE.Achievements["HL2"]) + table.Count(GAMEMODE.Achievements["Misc"])
		
		statsPnlLabelAch = vgui.Create("DLabel", statsPnl)
		statsPnlLabelAch:SetPos(statsPnl:GetWide() / 5, 75)
		statsPnlLabelAch:SetText("Total Achievements: " .. LocalPlayer():GetNWInt("stat_totalachs", -1) .. "/" .. totalAchs)
		statsPnlLabelAch:SetFont("HL2CR_Menu_Stats")
		statsPnlLabelAch:SizeToContents()
		
		
		statsPnlLabelQuest = vgui.Create("DLabel", statsPnl)
		statsPnlLabelQuest:SetPos(statsPnl:GetWide() / 5, 125)
		statsPnlLabelQuest:SetText("     Quests completed: " .. LocalPlayer():GetNWInt("stat_quests_completed", -1))
		statsPnlLabelQuest:SetFont("HL2CR_Menu_Stats")
		statsPnlLabelQuest:SizeToContents()
		
		menuFrame.navbar:AddTab("Inv", invPnl)
		menuFrame.navbar:AddTab("Skills", skillsPnl)
		menuFrame.navbar:AddTab("Pets", petsPnl)
		menuFrame.navbar:AddTab("Class", classPnl)
		menuFrame.navbar:AddTab("Statistics", statsPnl)
		
		menuFrame.navbar:SetActive(1)
		
		menuFrame.Think = function(pnl)
			if pnl.navbar:GetActive() == invPnl then
				pnl:SetSize(ScrW() / 2, pnl:GetTall())
				pnl:Center()
			end
			
			if pnl.navbar:GetActive() == skillsPnl then
				pnl:SetSize(ScrW() / 1.45, pnl:GetTall())
				pnl:Center()
			end
			
			if pnl.navbar:GetActive() == petsPnl then
				pnl:SetSize(ScrW() / 1.45, pnl:GetTall())
				pnl:Center()
			end
			if pnl.navbar:GetActive() == classPnl then
				pnl:SetSize(ScrW() / 2.15, pnl:GetTall())
				pnl:Center()
			end
			
			if pnl.navbar:GetActive() == statsPnl then
				pnl:SetSize(ScrW() / 2.5, pnl:GetTall())
				pnl:Center()
			end
		end
	end
end)

hook.Add("OnSpawnMenuClose", "HL2CR_InventoryClose", function()
	if menuFrame and menuFrame:IsValid() then
		menuFrame:Remove()
	end
end)

function IsRoomFor(item)
	for k,v in ipairs(LocalPlayer().Inv.Backpack) do
		for k2, pnl in ipairs(LocalPlayer().Inv.Backpack[k]) do
			if not pnl:GetItemPanel() then
				local x,y = pnl:GetCoords()
				local itmw, itmh = item:GetSize()
				local full = false
				for i1=x, (x+itmw)-1 do
					if full then break end
					for i2=y, (y+itmh)-1 do
						if LocalPlayer():GetInvItem(i1,i2):GetItemPanel() then
							full = true
							break
						end
					end
				end
				if full then
					return pnl
				end
			end
		end
	end
	return false
end

function PickupItem(item)
	local place = IsRoomFor(item)
	if place then
		
		local itm = vgui.Create("InvItem") --create a new item panel.
		itm:SetItem(item)
		itm:SetRoot(place)
		itm:SetPos(place:GetPos())
		
		local x,y = place:GetCoords()
		local itmw, itmh = item:GetSize() --GetSize needs to be a function in your items system.
		for i1=x, (x+itmw)-1 do
			for i2=y, (y+itmh)-1 do
				LocalPlayer():GetInvItem(i1,i2):SetItemPanel(itm) -- Tell all the things below it that they are now full of this item.
			end
		end
		
		return true --successfully picked item up.
		
	else
		return false --no room.
	end
end