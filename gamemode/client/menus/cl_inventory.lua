local plymeta = FindMetaTable("Player")

function plymeta:GetInvItem(x,y)
	return self.Inv.Backpack[x][y]
end

hook.Add("OnSpawnMenuOpen", "HL2CR_InventoryOpen", function()
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
	
	if LocalPlayer():Alive() then
		dfram = vgui.Create("DFrame")
		dfram:SetSize(ScrW()/2, ScrH()/2)
		dfram:Center()
		dfram:MakePopup()
		
		for k,v in pairs(ply.Inv.Backpack)do
			 for i=1,4 do --4 being the height of the backpack.
				  ply.Inv.Backpack[k][i] = vgui.Create("HL2CR_InvSlot", dfram)
				  ply.Inv.Backpack[k][i]:SetPos((k*30)+100,(i*30)+100)
				  ply.Inv.Backpack[k][i]:SetCoords(k,i)
			 end
		end
	end
end)

hook.Add("OnSpawnMenuClose", "HL2CR_InventoryClose", function()
	if dfram and dfram:IsValid() then
		dfram:Close()
	end
end)

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