------------------------------------------------------------------------------------------------
--Item Icon-------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------
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
	Icon:SetSize(tall * 0.74, tall * 0.74)
	Icon:SetPos(tall * 0.13, tall * 0.04)
	Icon:SetImage(item.Icon)
	
	local txt = New_ThemeText(self,wide * 0.5, tall * 0.78,item.Name,"Font2_Micro",0.5,0)
	
	self.Desc = New_ThemeTextBox(self:GetParent():GetParent(),self:GetX()+self:GetParent():GetX()+wide * 0.5, self:GetY()+self:GetParent():GetY()+wide * 1.10,item.Desc,"Font2_Tiny",0.5,0.5)
	
	--self.Desc = New_ThemeTextBox(self:GetParent(),self:GetX()+wide * 0.5, self:GetY()+wide * 1.10,item.Desc,"Font2_Tiny",0.5,0.5)

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

vgui.Register( "QMenu_ItemIcon", PANEL, "Panel" )

local function New_ItemIcon(parent,itemx, itemy,group,id)
	local scale = parent:GetWide()
	local element = vgui.Create("QMenu_ItemIcon",parent)
	element:SetPos(itemx,itemy)
	element:SetSize(scale*0.21,scale*0.21)
	element:Setup(group,id)
	return element
end

------------------------------------------------------------------------------------------------
--Equipped Item-------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------

local PANEL = {}

function PANEL:Init()
	--self.achname = nil
	self.itemid = ""
	self.changed = false
	self.lastpress = CurTime()
end

function PANEL:OnMousePressed( keyCode )
	if keyCode == MOUSE_LEFT then
		if self.itemid != "" and CurTime() < self.lastpress + 0.3 then 
			surface.PlaySound( "buttons/button18.wav" )
			self:GetParent().loadoutchanged = true
			self:Update()
		end
		self.lastpress = CurTime()
	end
end

function PANEL:Setup(text,group,id)
	local wide = self:GetWide()
	local tall = self:GetTall()
	local item = HL2CR_GetItem(group,id)
	
	self.Icon = vgui.Create("DImage", self)
	self.Icon:SetSize(tall * 0.6, tall * 0.6)
	self.Icon:SetPos(tall * 0.04, tall * 0.36)
	
	local txt = New_ThemeText(self,wide * 0.02, tall * 0.02,text,"Font_Tiny",0,0)
	
	if !item then
		self.Icon:SetImage("materials/hl2cr/misc/locked.jpg")
		self.Name = New_ThemeText(self,wide * 0.20, tall * 0.65,translate.Get("InvMenu_Default"),"Font_Small",0,0.5)
	else
		self.itemid = id
		self.Icon:SetImage(item.Icon)
		self.Name = New_ThemeText(self,wide * 0.20, tall * 0.65,item.Name,"Font_Small",0,0.5)
	end

end

function PANEL:Update(group,id)
	local item = HL2CR_GetItem(group,id)

	if !item then
		self.Icon:SetImage("materials/hl2cr/misc/locked.jpg")
		--self.Name:SetColour(Theme.fontyel)
		self.Name:SetText(translate.Get("InvMenu_Default"),nil,0,0.5)
		self.itemid = ""
	else 
		self.Icon:SetImage(item.Icon)
		--self.Name:SetColour(Theme.fontyel)
		self.Name:SetText(item.Name,nil,0,0.5)
		self.itemid = id
	end
	self.Name:SetColour(Theme.fontyel)
	self.changed = true
end

function PANEL:Blink()
	if self.changed then
		self.Name:SetColour(Theme.fontgreen)
		timer.Simple( 0.75, function() if IsValid(self) then self.Name:SetColour(Theme.fontcol)end end )
	end
end

function PANEL:Think()
	if self:IsHovered() then

	end
end

function PANEL:Paint()
	local wide = self:GetWide()
	local tall = self:GetTall()
	draw.RoundedBox( 6, 0, 0, wide, tall, Theme.backcol2)


	return true
end

vgui.Register( "QMenu_EquipedPanel", PANEL, "Panel" )

local function New_EquipedPanel(parent,itemx, itemy,text,group)
	local scale = parent:GetWide()
	local element = vgui.Create("QMenu_EquipedPanel",parent)
	element:SetPos(itemx,itemy)
	element:SetSize(parent:GetWide()*0.24,parent:GetTall()*0.11)
	element:Setup(text,group,GAMEMODE.Equipped[group])
	return element
end

------------------------------------------------------------------------------------------------
--------Inventory Tab---------------------------------------------------------------------------
------------------------------------------------------------------------------------------------
local PANEL = {}

function PANEL:Init()
	self.PlayerModel = vgui.Create("DModelPanel", self)


	self:SetVisible( true )
end

function PANEL:CorrectEyes()
	local eyepos = self.PlayerModel.Entity:GetBonePosition(self.PlayerModel.Entity:LookupBone("ValveBiped.Bip01_Head1")) or nil

	if eyepos ~= nil then
		eyepos:Add(Vector(0, 0, -2))
		--self.PlayerModel.Entity:SetPos(self.PlayerModel.Entity:GetPos() + Vector(0, 0, 2.5))
		self.PlayerModel:SetCamPos(eyepos - Vector(-50, 0, 10))
		self.PlayerModel:SetLookAt(eyepos- Vector(0, 0, 17))
	end
end

function PANEL:Setup()

	local wide = self:GetWide()
	local tall = self:GetTall()
	self.modelchanged = false
	self.loadoutchanged = false
-------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------
	
	self.PlayerModel:SetSize(wide * 0.23, tall * 0.82 )
	self.PlayerModel:SetPos(wide * 0.01, tall * 0.12 )
	self.PlayerModel:SetDirectionalLight(BOX_RIGHT, Color(255, 160, 80, 255))
	self.PlayerModel:SetDirectionalLight(BOX_LEFT, Color(80, 160, 255, 255))
	self.PlayerModel:SetAmbientLight(Vector(-64, -64, -64))
	self.PlayerModel:SetModel( LocalPlayer():GetModel() )
	self.PlayerModel:SetFOV( 30)
	--self.PlayerModel.Angles = Angle(0, 25, 0)
	
	self.PlayerModel.Angles = Angle(0, 25, 0)

	function self.PlayerModel:DragMousePress()
		self.PressX, self.PressY = input.GetCursorPos()
		self.Pressed = true
	end

	function self.PlayerModel:DragMouseRelease() self.Pressed = false end	
	self:CorrectEyes()
	
	function self.PlayerModel:LayoutEntity( ent )
		if self.Pressed then
			local mx, my = input.GetCursorPos()
			self.Angles = self.Angles - Angle(0,((self.PressX or mx) - mx) / 2, 0)

			self.PressX, self.PressY = input.GetCursorPos()
			ent:SetAngles(self.Angles)
		end	
	end
	
	local lvlacc = HL2CR_GetLvlAccess()
	
	self.ModelGroup = vgui.Create( "ThemeMultiBox" , self)
	self.ModelGroup:SetSize( wide * 0.23, math.ceil(tall * 0.05))
	self.ModelGroup:SetPos( wide * 0.01, tall * 0.01)
	self.ModelGroup:SetText("","Font_Small",HL2CR_GetModelList(lvlacc),1)
	self.ModelGroup:SetColour(Theme.box3,Theme.box4,Theme.backcol3)
	self.ModelGroup:SetFunc(
		function(value)
			--Client_Config.CrossType = MultiBox.value
			local group = HL2CR_GetModelGroups(self.ModelGroup.Text.Text,lvlacc)
			self.ModelGroup.extended:SetVisible( false ) 
			if group then 
				self.modelchanged = true
				self.PlayerModel:SetModel(HL2CR_GetModelFromGroup(self.ModelGroup.Text.Text))
				self.ModelSelect:SetText("","Font_Small",HL2CR_GetModelGroups(self.ModelGroup.Text.Text,lvlacc),1) 
				self:CorrectEyes()
			end
		end
	)
	
	self.ModelSelect = vgui.Create( "ThemeMultiBox" , self)
	self.ModelSelect:SetSize( wide * 0.23, math.ceil(tall * 0.05))
	self.ModelSelect:SetPos( wide * 0.01, tall * 0.07)
	self.ModelSelect:SetText("","Font_Small",HL2CR_GetModelGroups("Citizens",lvlacc),1)
	self.ModelSelect:SetColour(Theme.box3,Theme.box4,Theme.backcol3)
	self.ModelSelect:SetFunc(
		function(value)
			local mdl = HL2CR_GetModelFromName(self.ModelGroup.Text.Text,self.ModelSelect.Text.Text,lvlacc)
			if mdl then self.modelchanged = true self.PlayerModel:SetModel(mdl) end
			self:CorrectEyes()
		end
	)
	
	local Btn = New_ThemeButton(self, wide * 0.01, tall * 0.94,wide* 0.23,tall* 0.05,translate.Get("InvMenu_SelectM"),"Font_Small")
	Btn:SetFunc(
		function()
			if !self.modelchanged then return end
			surface.PlaySound( "buttons/button14.wav" )
			net.Start("HL2CR_Model_Update")
				net.WriteString(self.ModelGroup.Text.Text)
				net.WriteString(self.ModelSelect.Text.Text)
			net.SendToServer()
			self.modelchanged = false
		end
	)

-------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------
	
	self.InventoryPanel = New_ThemeVertScroll(self,wide * 0.25,tall * 0.07,wide * 0.49,tall * 0.92)
	
	local invy = tall * 0.01
	local wide2 = self.InventoryPanel:GetWide()
	for k, v in SortedPairsByMemberValue(GAMEMODE.ItemDB, "Index", false) do
		local invx = wide2 * 0.01
		local txt = New_ThemeText(self.InventoryPanel,invx, invy,v.Name,"Font_Normal",0,0)
		invy = invy + wide2 * 0.07
		local count = 0
		local empty = true
		for kk, vv in SortedPairsByMemberValue(v.Items, "Index", false) do
			if !HL2CR_HaveItem(kk) then continue end
			--if vv.Secret and  !HL2CR_HasAchievement(kk) then continue end
			--local txt = New_ThemeText(self.AchPanel,achx, achy,vv.Name,"Font2_Small",0,0)
			if count == 4 then
				invy = invy + wide2 * 0.22
				invx = wide2 * 0.01
				count = 0
			end
			local element = New_ItemIcon(self.InventoryPanel,invx, invy,k,kk)
			element.func = function()
					self.loadoutchanged = true
					self.Equipped[k]:Update(k,kk)
				end
			invx = invx + wide2 * 0.22
			count = count + 1
			empty = false
		end
		
		if !empty then --Handles empty catagories better
			invy = invy + wide2 * 0.22 
		else
			txt:Remove()
			invy = invy - wide2 * 0.07
		end
	end
	self.InventoryPanel:UpdateMaxY(invy)
	
	-------------------------------------------------------------------------------------------------------
	-------------------------------------------------------------------------------------------------------
	local txt = New_ThemeText(self,wide * 0.26, tall * 0.03,translate.Get("InvMenu_Inv"),"Font_Normal",0,0.5)
	
	local txt = New_ThemeText(self,wide * 0.76, tall * 0.03,translate.Get("InvMenu_Equipped"),"Font_Normal",0,0.5)
	
	self.Equipped = {}
	self.Equipped["HATS"] = New_EquipedPanel(self,wide * 0.75, tall * 0.07,translate.Get("ItemGroup_HAT")	,"HATS")
	self.Equipped["MELEE"] = New_EquipedPanel(self,wide * 0.75, tall * 0.19,translate.Get("ItemGroup_MELEE"),"MELEE")
	self.Equipped["PISTOL"] = New_EquipedPanel(self,wide * 0.75, tall * 0.31,translate.Get("ItemGroup_PISTOL"),"PISTOL")
	self.Equipped["REV"] = New_EquipedPanel(self,wide * 0.75, tall * 0.43,translate.Get("ItemGroup_REV")	,"REV")
	self.Equipped["SMG"] = New_EquipedPanel(self,wide * 0.75, tall * 0.55,translate.Get("ItemGroup_SMGS")	,"SMG")
	self.Equipped["SHGUN"] = New_EquipedPanel(self,wide * 0.75, tall * 0.67,translate.Get("ItemGroup_SHGUN"),"SHGUN")
	self.Equipped["XBOW"] = New_EquipedPanel(self,wide * 0.75, tall * 0.79,translate.Get("ItemGroup_XBOW")	,"XBOW")
	
	local Btn = New_ThemeButton(self, wide * 0.75, tall * 0.94,wide* 0.23,tall* 0.05,translate.Get("InvMenu_SetLoad"),"Font_Small")
	Btn:SetFunc(
		function()
			if !self.loadoutchanged then return end
			surface.PlaySound( "buttons/button14.wav" )
			
			self.Equipped["HATS"]:Blink()
			self.Equipped["MELEE"]:Blink()
			self.Equipped["PISTOL"]:Blink()
			self.Equipped["REV"]:Blink()
			self.Equipped["SMG"]:Blink()
			self.Equipped["SHGUN"]:Blink()
			self.Equipped["XBOW"]:Blink()
			
			net.Start("HL2CR_SendLoadout")
				net.WriteString(self.Equipped["HATS"].itemid)
				net.WriteString(self.Equipped["MELEE"].itemid)
				net.WriteString(self.Equipped["PISTOL"].itemid)
				net.WriteString(self.Equipped["REV"].itemid)
				net.WriteString(self.Equipped["SMG"].itemid)
				net.WriteString(self.Equipped["SHGUN"].itemid)
				net.WriteString(self.Equipped["XBOW"].itemid)
			net.SendToServer()
			
			self.loadoutchanged = false
		end
	)
	
end


function PANEL:Paint()
	
	local wide = self:GetWide()
	local tall = self:GetTall()
	
	draw.RoundedBoxEx( 8, 0, 0, wide, tall, Theme.backcol2,false, false,true,true)
	
	draw.RoundedBox( 4, wide * 0.25,tall * 0.01,wide * 0.49,tall * 0.05, Theme.backcol)
	draw.RoundedBox( 4, wide * 0.75,tall * 0.01,wide * 0.24,tall * 0.05, Theme.backcol)
	
	--draw.RoundedBox( 4, wide * 0.75,tall * 0.07,wide * 0.24,tall * 0.86, Theme.backcol2)
	
	return true
end

vgui.Register( "QMenu_Inventory", PANEL, "Panel" )

function Create_QMenu_Inventory(parent)
	local element = vgui.Create("QMenu_Inventory",parent)
	element:SetPos( 0, parent:GetTall() * 0.08)
	element:SetSize( parent:GetWide(), parent:GetTall() * 0.92 )
	element:Setup()
	return element
end

GM.Equipped = GM.Equipped or {}

net.Receive("HL2CR_SendLoadout", function(len)
	print("recieved loadout on client")
	GAMEMODE.Equipped["HATS"] = net.ReadString()
	GAMEMODE.Equipped["MELEE"] = net.ReadString() 
	GAMEMODE.Equipped["PISTOL"] = net.ReadString()
	GAMEMODE.Equipped["REV"] = net.ReadString() 
	GAMEMODE.Equipped["SMG"] = net.ReadString()
	GAMEMODE.Equipped["SHGUN"] = net.ReadString()
	GAMEMODE.Equipped["XBOW"] = net.ReadString()
end)