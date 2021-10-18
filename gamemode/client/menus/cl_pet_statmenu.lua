function ShowPetStatMenu(shouldOpen)
	if not LocalPlayer():Alive() then return end
	
	if shouldOpen then
		petFrame = vgui.Create("DFrame")
		petFrame:SetSize(150, 150)
		petFrame:SetPos(0, ScrH() / 2.25)
		petFrame:SetTitle("")
		petFrame:ShowCloseButton(false)
		
		petFrame.Paint = function(pnl, w, h)
			surface.SetDrawColor(0, 0, 0, 185)
			surface.DrawRect(0, 0, w, h)
		end
		
		local petStatusLabel = vgui.Create("DLabel", petFrame)
		petStatusLabel:SetFont("HL2CR_Pets_Name")
		petStatusLabel:SetPos(0, 0)
		petStatusLabel:SetText("Pet: " .. (LocalPlayer():GetNWString("pet_name") or "['Insert Name']"))
		petStatusLabel:SizeToContents()
		
		local petHealthLabel = vgui.Create("DLabel", petFrame)
		petHealthLabel:SetFont("HL2CR_Pets_Desc")
		petHealthLabel:SetPos(0, 35)
		
		local petXPLabel = vgui.Create("DLabel", petFrame)
		petXPLabel:SetFont("HL2CR_Pets_Desc")
		petXPLabel:SetPos(0, 80)
		
		petFrame.Think = function(pnl)
			petStatusLabel:SetText("Pet: " .. (LocalPlayer():GetNWString("pet_name") or "['Insert Name']"))
			petStatusLabel:SizeToContents()
			
			petHealthLabel:SetText("Health\n" .. LocalPlayer():GetNWInt("pet_health") .. "/" .. LocalPlayer():GetNWInt("pet_maxhealth"))
			petHealthLabel:SizeToContents()
		
			petXPLabel:SetText("XP:\n" .. LocalPlayer():GetNWInt("pet_curxp") .. "/" .. LocalPlayer():GetNWInt("pet_curreqxp"))
			petXPLabel:SizeToContents()
		end
	else
		if petFrame and petFrame:IsValid() then
			petFrame:Close()
		end
	end
end

net.Receive("HL2CR_SpawnPet", function()
	local shouldOpen = net.ReadBool()
	ShowPetStatMenu(shouldOpen)
end)

