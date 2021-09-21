function GM:OnSpawnMenuOpen()
	if not LocalPlayer():GetNWBool( "Loaded" ) then return end
	if LocalPlayer():Alive() then
		GAMEMODE.InvSlot = GAMEMODE.InvSlot or vgui.Create("InvSlot")
		GAMEMODE.InvSlot:Center()
		GAMEMODE.InvSlot:SetTargetAlpha(255)
		GAMEMODE.InvSlot.Frame:SetVisible(true)
		gui.EnableScreenClicker(true)
		RestoreCursorPosition()
	end
end

function GM:OnSpawnMenuClose()
	if !LocalPlayer().Data or !GAMEMODE.InvSlot then return end
	GAMEMODE.InvSlot:SetTargetAlpha(0)
	if GAMEMODE.DraggingGhost then
		GAMEMODE.DraggingPanel = nil
	end
	if GAMEMODE.ActiveMenu then GAMEMODE.ActiveMenu:Remove() GAMEMODE.ActiveMenu = nil end
end

local ply = LocalPlayer()
ply.Inv = {}
ply.Inv.Backpack = {} --The actual backpack.
ply.Inv.Equipped = {} --This is the equipped items, assuming it's going to be Diablo-Style.
ply.Inv.Weight = 0

for i=1,8 do --8 being the width of the backpack.
      ply.Inv.Backpack[i] = {}
end
for k,v in pairs(ply.Inv.Backpack)do
    for i=1,4 do --4 being the height of the backpack.
        ply.Inv.Backpack[k][i] = false --False is a placeholder here. We'll overwrite that later.
    end
end

local plymeta = FindMetaTable("Player")
function plymeta:GetInvItem(x,y)
    return self.Inv.Backpack[x][y]
end

local PANEL = {}

AccessorFunc(PANEL, "m_ItemPanel", "ItemPanel")
AccessorFunc(PANEL, "m_Color", "Color")

function PANEL:Init()
    self.m_Coords = {x=0,y=0}
    self:SetSize(30,30)
    self:SetColor(Color(250, 184, 12, 255))
    self:SetItemPanel(false)

    self:Receiver("invitem", function(pnl, item, drop, i, x, y) --Drag-drop
	if drop then
		item = item[1]
		local x1,y1 = pnl:GetPos()
		local x2,y2 = item:GetPos()
		if math.Dist(x1,y1,x2,y2) <= 30 then --Find the top left slot.
			if not pnl:GetItemPanel() then
				local itm = item:GetItem()
				local x,y = pnl:GetCoords()
				local itmw, itmh = itm:GetSize() --GetSize needs to be a function in your items system.
				local full = false
				for i1=x, (x+itmw)-1 do
					if full then break end
					for i2=y, (y+itmh)-1 do
						if LocalPlayer():GetInvItem(i1,i2):GetItemPanel() then --check if the panels in the area are full.
							full = true
							break
						end
					end
				end
				if not full then --If none of them are full then
					for i1=x, (x+itmw)-1 do
						for i2=y, (y+itmh)-1 do
							LocalPlayer():GetInvItem(i1,i2):SetItemPanel(item) -- Tell all the things below it that they are now full of this item.
						end
					end
					item:SetRoot(pnl) --like a parent, but not a parent.
					item:SetPos(pnl:GetPos()) --move the item.
				end
			end
		end
	else
		--Something about coloring of hovered slots.
	end
end, {})
end

function PANEL:SetCoords(x,y)
     self.m_Coords.x = x
     self.m_Coords.y = y
end

function PANEL:GetCoords()
     return self.m_Coords.x, self.m_Coords.y
end

local col
function PANEL:Paint(w,h)
     draw.NoTexture()
     col = self:GetColor()
     surface.SetDrawColor(col.r,col.g,col.b,255)
     surface.DrawRect(0,0,w-2,h-2) --main square
     surface.SetDrawColor(70,70,70,255)
     surface.DrawRect(w-2,0,2,h) --borders
     surface.DrawRect(0,h-2,w,2) -- ^
end
vgui.Register("InvSlot", PANEL, "DPanel")

local dfram = vgui.Create("DFrame")
dfram:SetSize(ScrW()/2, ScrH()/2)
dfram:Center()
dfram:MakePopup()
for k,v in pairs(ply.Inv.Backpack)do
     for i=1,4 do --4 being the height of the backpack.
          ply.Inv.Backpack[k][i] = vgui.Create("InvSlot", dfram)
          ply.Inv.Backpack[k][i]:SetPos((k*30)+100,(i*30)+100) --The icon is 30x30.
          ply.Inv.Backpack[k][i]:SetCoords(k,i)
     end
end

PANEL = {}

AccessorFunc(PANEL, "m_Item", "Item")
AccessorFunc(PANEL, "m_Root", "Root")

function PANEL:Init()
     self:SetSize(30,30)
     self:SetItem(false) --false means no item.
     self:SetColor(Color(100,100,100))
     self:SetDroppable("invitem")
end

function PANEL:PaintOver(w,h)
     draw.NoTexture()
     if self:GetItem() then
          surface.SetMaterial(self:GetItem():GetIcon()) --Your items must have a :GetIcon function.
          surface.DrawTexturedRect(0,0,w,h)
     end
end

local col
function PANEL:Paint(w,h)
     draw.NoTexture()
     col = self:GetColor()
     surface.SetDrawColor(col.r,col.g,col.b,180)
     surface.DrawRect(0,0,w,h) --background square
end
vgui.Register("InvItem", PANEL, "DPanel")

function IsRoomFor(item) --note that item must be an actual item, not a InvItem panel.
	for k,v in ipairs(LocalPlayer().Inv.Backpack) do
		for k2, pnl in ipairs(LocalPlayer().Inv.Backpack[k]) do
			if not pnl:GetItemPanel() then
				local x,y = pnl:GetCoords()
				local itmw, itmh = item:GetSize() --GetSize needs to be a function in your items system.
				local full = false
				for i1=x, (x+itmw)-1 do
					if full then break end
					for i2=y, (y+itmh)-1 do
						if LocalPlayer():GetInvItem(i1,i2):GetItemPanel() then --check if the panels in the area are full.
							full = true
							break
						end
					end
				end
				if full then
					return pnl --If there's room then return the open panel.
				end
			end
		end
	end
	return false --if not, then return false.
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
