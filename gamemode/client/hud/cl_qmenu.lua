
local toggleOpen = toggleOpen or false
local timeLastOpen = 0
local qMenuFrame = qMenuFrame or nil

local PANEL = {}

function PANEL:Init()
	local varH = ScrH() * 0.75
	local varW = varH * 1.5
	self:SetPos( (ScrW()- varW)*0.5, (ScrH()- varH)*0.25)
	self:SetSize( varW, varH )
	
	self:MakePopup()
	local wide = self:GetWide()
	local tall = self:GetTall()
	
	self.tabs = {}
	self:AddTab(Create_QMenu_Inventory(self))
	self:AddTab(Create_QMenu_Skills(self))
	self:AddTab(Create_QMenu_Shop(self))
	self:AddTab(Create_QMenu_Achievements(self))
	
	local Btn = New_ThemeButton(self, tall * 0.01, tall * 0.01,wide* 0.13,tall* 0.06,translate.Get("QMenu_Panels_Main"),"Font_Small")
	Btn:SetFunc(
		function()
			self:SetTab(1)
		end
	)
	
	local Btn = New_ThemeButton(self, tall * 0.01 + wide* 0.14, tall * 0.01,wide* 0.13,tall* 0.06,translate.Get("QMenu_Panels_Skills"),"Font_Small")
	Btn:SetFunc(
		function()
			self:SetTab(2)
		end
	)
	
	local Btn = New_ThemeButton(self, tall * 0.01+ wide* 0.28, tall * 0.01,wide* 0.13,tall* 0.06,translate.Get("QMenu_Panels_Shop"),"Font_Small")
	Btn:SetFunc(
		function()
			self:SetTab(3)
		end
	)
	
	local Btn = New_ThemeButton(self, wide* 0.82 - tall * 0.01, tall * 0.01,wide* 0.18,tall* 0.06,translate.Get("QMenu_Panels_Achievements"),"Font_Small")
	Btn:SetFunc(
		function()
			self:SetTab(4)
		end
	)
	
	self:SetVisible( true )
end

function PANEL:SetTab(value)
	for i, e in ipairs(self.tabs) do
		if !IsValid(e) then continue end
		if i == value then 
			e:SetVisible(true)
		else
			e:SetVisible(false)
		end
	end
end

function PANEL:AddTab(element)
	table.insert(self.tabs,element)
end

function PANEL:Paint()

	draw.RoundedBoxEx( 8, 0, 0, self:GetWide(), self:GetTall() * 0.08-1, Theme.backcol,true, true,false,false)
	

	return true
end
vgui.Register( "QMenu_Main", PANEL, "Panel" )


function StartQMenu(toggleOpen)

    timeLastOpen = 0.3 + CurTime()

	if toggleOpen then 
		--if not LocalPlayer():Alive() then return end -- simple fix w/o using "Think".
		if GAMEMODE.qMenuFrame then
			GAMEMODE.qMenuFrame:Remove()

		end
		
		if ( GAMEMODE.HelpMenu ) then GAMEMODE.HelpMenu:Remove() gui.EnableScreenClicker( false ) end
		
		GAMEMODE.qMenuFrame = vgui.Create("QMenu_Main")

	else
		if GAMEMODE.qMenuFrame then
			GAMEMODE.qMenuFrame:Remove()
		end
	end
end

function GM:OnSpawnMenuOpen()
	StartQMenu(true)
end

function GM:OnSpawnMenuClose()
	StartQMenu(false)
end