-------------------------------------------------------------------------------------------------------
--Achievements Tab-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------
local PANEL = {}

function PANEL:Init()
	self:SetMouseInputEnabled(true)
end

function PANEL:Setup(group,id)
	local wide = self:GetWide()
	local tall = self:GetTall()
	local ach = HL2CR_GetAchievement(group,id)
	self.value = HL2CR_GetProgress(id)
	self.max = ach.Max or 1
	if ach.Secret then self.Secret = true end
	if HL2CR_HasAchievement(id) then self.value = self.max end
	
	self.Name = New_ThemeText(self,tall * 0.82, tall * 0.03,ach.Name,"Font2_Small",0,0)
	
	local Icon = vgui.Create("DImage", self)
	Icon:SetSize(tall * 0.74, tall * 0.74)
	Icon:SetPos(tall * 0.04, tall * 0.04)
	
	if self.value == self.max then
	--if true then
		local txt = New_ThemeTextMulti(self,tall * 0.82, tall * 0.28,ach.Desc,"Font2_Micro",0,0,2)
		Icon:SetImage(ach.Mat)
	else
		local txt = New_ThemeText(self,tall * 0.82, tall * 0.28,"???","Font2_Micro",0,0)
		Icon:SetImage("materials/hl2cr/misc/locked.jpg")
	end
	

	--Icon:SetImage(ach.Mat)
	
	if self.max > 1 and self.value != self.max and self.value > 0 then
		local txt = New_ThemeText(self,wide * 0.5, tall * 0.77,self.value.."/"..self.max,"Font2_Tiny",0.5,0)
	end

end

function PANEL:Paint()
	local wide = self:GetWide()
	local tall = self:GetTall()
	draw.RoundedBox( 6, 0, 0, wide, tall, Theme.buttonout)
	if self.Secret then
		draw.RoundedBoxEx( 6, 2, 2, wide-4, tall * 0.25, Theme.secret1,true,true,false,false)
		draw.RoundedBoxEx( 6, 2, 2+tall * 0.25, wide-4, tall * 0.75-4, Theme.secret2,false,false,true,true)
	else
		draw.RoundedBoxEx( 6, 2, 2, wide-4, tall * 0.25, Theme.box,true,true,false,false)
		draw.RoundedBoxEx( 6, 2, 2+tall * 0.25, wide-4, tall * 0.75-4, Theme.box3,false,false,true,true)
	end
	
	draw.RoundedBox( 6, 3, tall * 0.8-1, wide-6, tall * 0.17+2, Theme.buttonout)
	if self.value == self.max then
		draw.RoundedBox( 6, 4, tall * 0.8, wide-8, tall * 0.17, Theme.fontgreen)
	elseif self.value > 0 then
		local size = math.floor((wide-8)/self.max*self.value)
		draw.RoundedBoxEx( 6, 4, tall * 0.8, size, tall * 0.17, Theme.fontgreen,true,false,true,false)
	end

	return true
end

vgui.Register( "QMenu_AchPanel", PANEL, "Panel" )

local function New_ThemeAchievement(parent,achx, achy,group,id)
	local scale = parent:GetWide()
	local element = vgui.Create("QMenu_AchPanel",parent)
	element:SetPos(achx,achy)
	element:SetSize(scale*0.31,scale*0.1)
	element:Setup(group,id)
	return element
end

-------------------------------------------------------------------------------------------------------
local PANEL = {}

function PANEL:Init()
	self:SetVisible( false )
end

function PANEL:Setup()
	local wide = self:GetWide()
	local tall = self:GetTall()

	self.AchPanel = New_ThemeVertScroll(self,tall * 0.02,tall * 0.02,wide - tall * 0.04,tall * 0.96)
	
	local achy = tall * 0.01
	local wide2 = self.AchPanel:GetWide()
	for k, v in SortedPairsByMemberValue(GAMEMODE.Achievements, "Index", false) do
		local achx = tall * 0.01
		local txt = New_ThemeText(self.AchPanel,achx, achy,v.Name,"Font_Normal",0,0)
		achy = achy + wide2 * 0.035
		local count = 0
		for kk, vv in SortedPairsByMemberValue(v.Achievements, "Index", false) do
			if vv.Secret and  !HL2CR_HasAchievement(kk) then continue end
			--local txt = New_ThemeText(self.AchPanel,achx, achy,vv.Name,"Font2_Small",0,0)
			if count == 3 then
				achy = achy + wide2 * 0.105
				achx = tall * 0.01
				count = 0
			end
			New_ThemeAchievement(self.AchPanel,achx, achy,k,kk)
			achx = achx + wide2 * 0.32
			count = count + 1
		end
		achy = achy + wide2 * 0.105
	end
	self.AchPanel:UpdateMaxY(achy)

	
end

function PANEL:Paint()
	draw.RoundedBoxEx( 8, 0, 0, self:GetWide(), self:GetTall(), Theme.backcol2,false, false,true,true)
	return true
end

vgui.Register( "QMenu_Achievements", PANEL, "Panel" )

function Create_QMenu_Achievements(parent)
	local element = vgui.Create("QMenu_Achievements",parent)
	element:SetPos( 0, parent:GetTall() * 0.08)
	element:SetSize( parent:GetWide(), parent:GetTall() * 0.92 )
	element:Setup()
	return element
end