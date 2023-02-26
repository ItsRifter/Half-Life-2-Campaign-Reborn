-------------------------------------------------------------------------------------------------------
--Shop Icon------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------
local PANEL = {}

function PANEL:Init()
	self.func = nil
	self.lastpress = CurTime()
end

function PANEL:OnMousePressed( keyCode )
	if keyCode == MOUSE_LEFT then
		if self.func and CurTime() < self.lastpress + 0.3 then 
			surface.PlaySound( "buttons/button18.wav" )
			self.func() 
		end
		self.lastpress = CurTime()
	end
end

function PANEL:Setup(group,id)
	local wide = self:GetWide()
	local tall = self:GetTall()
	local item = HL2CR_GetItem(group,id)
	local Icon = vgui.Create("DImage", self)
	Icon:SetSize(tall * 0.66, tall * 0.66)
	Icon:SetPos(tall * 0.17, tall * 0.04)
	Icon:SetImage(item.Icon)
	
	local txt = New_ThemeText(self,wide * 0.5, tall * 0.70,item.Name,"Font2_Small",0.5,0)
	local txt = New_ThemeText(self,wide * 0.5, tall * 0.84,translate.Get("ShopMenu_Cost")..item.APCOST,"Font2_Small",0.5,0)
	
	txt:SetColour(Theme.fontgreen)
	if HL2CR_GetAP() < item.APCOST then
		txt:SetColour(Theme.fontred)
	end
	
	self.Desc = New_ThemeTextBox(self:GetParent():GetParent(),self:GetX()+self:GetParent():GetX()+wide * 0.5, self:GetY()+self:GetParent():GetY()+wide * 1.10,item.Desc,"Font2_Tiny",0.5,0.5)
	if self.Desc:GetX() < 8 then self.Desc:SetX(8) end
	if self.Desc:GetX() + self.Desc:GetWide() > self:GetParent():GetWide() - 32 then 
		self.Desc:SetX(self:GetParent():GetWide() - self.Desc:GetWide() - 32) end
end

function PANEL:Think()
	if self:IsHovered() then
		if !self.Desc:IsVisible() then 
			self.Desc:SetVisible(true) self.Desc:MoveToFront() 
		end
		self.Desc:SetY(self:GetY()+self:GetParent():GetY()+self:GetWide() * 1.10)
	else
		if self.Desc:IsVisible() then self.Desc:SetVisible(false) end
	end
end

function PANEL:Paint()
	local wide = self:GetWide()
	local tall = self:GetTall()
	draw.RoundedBox( 6, 0, 0, wide, tall, Theme.buttonout)

	if self:IsHovered() then
		draw.RoundedBox( 8, 0, 0, self:GetWide(), self:GetTall(), Theme.fontcolhi)
	else
		draw.RoundedBox( 8, 0, 0, self:GetWide(), self:GetTall(), Theme.fontcolout)
	end

	draw.RoundedBox( 8, 2, 2, self:GetWide()-4, self:GetTall()-4, Theme.box)

	return true
end

vgui.Register( "QMenu_ShopIcon", PANEL, "Panel" )

local function New_ShopIcon(parent,itemx, itemy,group,id)
	local scale = parent:GetWide()
	local element = vgui.Create("QMenu_ShopIcon",parent)
	element:SetPos(itemx,itemy)
	element:SetSize(scale*0.23,scale*0.23)
	element:Setup(group,id)
	return element
end

-------------------------------------------------------------------------------------------------------
local PANEL = {}
function PANEL:Init()
	self.cartgr = ""
	self.cartid = ""
end


function PANEL:Setup()
	local wide = self:GetWide()
	local tall = self:GetTall()
	local item = HL2CR_GetItem(group,id)

	self.Icon = vgui.Create("DImage", self)
	self.Icon:SetSize(wide * 0.66, wide * 0.66)
	self.Icon:SetPos(wide * 0.17, tall * 0.05)
	self.Icon:SetImage("materials/hl2cr/misc/locked.jpg")
	self.Icon:SetVisible(false)
	
	self.txt = New_ThemeText(self,wide * 0.5, tall * 0.70,"","Font2_Small",0.5,0)
	self.txt2 = New_ThemeText(self,wide * 0.5, tall * 0.84,"","Font2_Small",0.5,0)

end

function PANEL:Update(group,id)
	if group == "" then
		self.Icon:SetVisible(false)
		
		self.txt:SetText("",nil,0.5,0)
		self.txt2:SetText("",nil,0.5,0)
		self.cartgr = ""
		self.cart = ""
	end

	self.cartgr = group
	self.cartid = id
	local item = HL2CR_GetItem(group,id)
	self.Icon:SetImage(item.Icon)
	self.Icon:SetVisible(true)
	
	self.txt:SetText(item.Name,nil,0.5,0)
	self.txt2:SetText(translate.Get("ShopMenu_Cost")..item.APCOST,nil,0.5,0)
	
	self.txt2:SetColour(Theme.fontgreen)
	if HL2CR_GetAP() < item.APCOST then
		self.txt2:SetColour(Theme.fontred)
	end
end


function PANEL:Paint()
	local wide = self:GetWide()
	local tall = self:GetTall()
	draw.RoundedBox( 6, 0, 0, wide, tall, Theme.backcol2)

	return true
end

vgui.Register( "QMenu_ShopBuy", PANEL, "Panel" )

local function New_BuyPanel(parent,posx, posy)
	--local scale = parent:GetWide()
	local element = vgui.Create("QMenu_ShopBuy",parent)
	element:SetPos(posx,posy)
	element:SetSize(parent:GetWide()*0.24,parent:GetTall()*0.40)
	element:Setup()
	return element
end

-------------------------------------------------------------------------------------------------------
--Shop Tab-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------
local PANEL = {}

function PANEL:Init()
	self:SetVisible( false )
	HL2CR_ShopPanel = self
end

function PANEL:Setup()
	local wide = self:GetWide()
	local tall = self:GetTall()

	local txt = New_ThemeText(self,wide * 0.02, tall * 0.03,translate.Get("ShopMenu_Name"),"Font_Normal",0,0.5)
	local txt = New_ThemeText(self,wide * 0.87, tall * 0.03,translate.Get("ShopMenu_Cart"),"Font_Normal",0.5,0.5)

	self.txtap = New_ThemeText(self,wide * 0.87, tall * 0.48,translate.Get("ShopMenu_AP")..HL2CR_GetAP(),"Font_Normal",0.5,0)
	self.BuyPanel = New_BuyPanel(self,wide * 0.75, tall * 0.07)

	local buybutton = New_ThemeButton(self,wide * 0.75,tall * 0.54,wide* 0.24,tall*0.08,translate.Get("ShopMenu_Buy"),"Font_Normal")
	buybutton:SetFunc(
		function()
			if self.BuyPanel.cartgr != "" then
				net.Start("HL2CR_Item_Purchase")
					net.WriteString(self.BuyPanel.cartgr)
					net.WriteString(self.BuyPanel.cartid)
				net.SendToServer()
			end
		end)

	self:Refresh()
end

function PANEL:Refresh()
	local wide = self:GetWide()
	local tall = self:GetTall()
	if IsValid(self.ShopPanel) then self.ShopPanel:Remove() end
	self.ShopPanel = New_ThemeVertScroll(self,wide * 0.01,tall * 0.07,wide * 0.73,tall * 0.92)
	
	local invy = tall * 0.01
	local wide2 = self.ShopPanel:GetWide()
	for k, v in SortedPairsByMemberValue(GAMEMODE.ItemDB, "Index", false) do
		local invx = wide2 * 0.01
		local txt = New_ThemeText(self.ShopPanel,invx, invy,v.Name,"Font_Normal",0,0)
		invy = invy + wide2 * 0.05
		local count = 0
		local empty = true
		for kk, vv in SortedPairsByMemberValue(v.Items, "Index", false) do
			if HL2CR_HaveItem(kk) or !vv.APCOST then continue end
			--if vv.Secret and  !HL2CR_HasAchievement(kk) then continue end
			--local txt = New_ThemeText(self.AchPanel,achx, achy,vv.Name,"Font2_Small",0,0)
			if count == 4 then
				invy = invy + wide2 * 0.24
				invx = wide2 * 0.01
				count = 0
			end
			local element = New_ShopIcon(self.ShopPanel,invx, invy,k,kk)
			element.func = function()
				self.BuyPanel:Update(k,kk)
				end
			invx = invx + wide2 * 0.24
			count = count + 1
			empty = false
		end
		
		if !empty then --Handles empty catagories better
			invy = invy + wide2 * 0.24 
		else
			txt:Remove()
			invy = invy - wide2 * 0.05
		end
	end
	self.ShopPanel:UpdateMaxY(invy+48)
end


function PANEL:Paint()
	local wide = self:GetWide()
	local tall = self:GetTall()
	draw.RoundedBoxEx( 8, 0, 0, wide, tall, Theme.backcol2,false, false,true,true)
	
	draw.RoundedBox( 4, wide * 0.01,tall * 0.01,wide * 0.73,tall * 0.05, Theme.backcol)	
	
	draw.RoundedBox( 4, wide * 0.75,tall * 0.01,wide * 0.24,tall * 0.05, Theme.backcol)	
	
	draw.RoundedBox( 4, wide * 0.75,tall * 0.48,wide * 0.24,tall * 0.05, Theme.backcol)	
	
	return true
end

vgui.Register( "QMenu_Shop", PANEL, "Panel" )

function Create_QMenu_Shop(parent)
	local element = vgui.Create("QMenu_Shop",parent)
	element:SetPos( 0, parent:GetTall() * 0.08)
	element:SetSize( parent:GetWide(), parent:GetTall() * 0.92 )
	element:Setup()
	return element
end


net.Receive( "HL2CR_CL_SENDAP", function( length)
	GAMEMODE.APAmount = net.ReadUInt(12)
end )

function HL2CR_GetAP()
	return GAMEMODE.APAmount or 0
end