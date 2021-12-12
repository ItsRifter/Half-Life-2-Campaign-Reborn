function ShowPetStatMenu(shouldOpen)
	if not LocalPlayer():Alive() then return end
	
	if shouldOpen then
		petFrame = vgui.Create("DFrame")
		petFrame:SetSize(200, 150)
		petFrame:SetPos(0, ScrH() / 2.25)
		petFrame:SetTitle("")
		petFrame:ShowCloseButton(false)
		
		petFrame.Paint = function(pnl, w, h)
			surface.SetDrawColor(0, 0, 0, 0)
			surface.DrawRect(0, 0, w, h)
		end
		
		local petStatusLabel = vgui.Create("DLabel", petFrame)
		petStatusLabel:SetFont("HL2CR_Pets_Name")
		petStatusLabel:SetPos(0, 0)
		petStatusLabel:SetText("Pet: " .. LocalPlayer():GetNWString("pet_name") )
		petStatusLabel:SizeToContents()
		
		local petHealthBar = vgui.Create("DPanel", petFrame)
		petHealthBar:SetSize(100, 25)
		petHealthBar:SetPos(0, 35)
		petHealthBar.Paint = function(self, w, h)
			surface.SetDrawColor(0, 0, 0, 255)
			surface.DrawRect(0, 0, w, h)
		end
		
		local petHealthBarFill = vgui.Create("DPanel", petHealthBar)
		petHealthBarFill:SetSize(petHealthBar:GetWide(), petHealthBar:GetTall())
		petHealthBarFill.Paint = function(self, w, h)
			surface.SetDrawColor(0, 170, 0, 255)
			surface.DrawRect(0, 0, w, h)
		end
		
		local petHealthLabel = vgui.Create("DLabel", petHealthBar)
		petHealthLabel:SetPos(0, petHealthBar:GetTall() / 6)
		petHealthLabel:SetFont("HL2CR_Pets_Desc")
		petHealthLabel:SetText("Health")
		petHealthLabel:SizeToContents()
		
		local petXPBar = vgui.Create("DPanel", petFrame)
		petXPBar:SetSize(125, 25)
		petXPBar:SetPos(0, 70)
		petXPBar.Paint = function(self, w, h)
			surface.SetDrawColor(0, 0, 0, 255)
			surface.DrawRect(0, 0, w, h)
		end
		
		local petXPBarFill = vgui.Create("DPanel", petXPBar)
		petXPBarFill:SetSize(0, petXPBar:GetTall())
		petXPBarFill.Paint = function(self, w, h)
			surface.SetDrawColor(0, 155, 155, 255)
			surface.DrawRect(0, 0, w, h)
		end
		
		local petXPLabel = vgui.Create("DLabel", petXPBar)
		petXPLabel:SetPos(0, petXPBar:GetTall() / 6)
		petXPLabel:SetFont("HL2CR_Pets_Desc")
		petXPLabel:SetText("XP")
		--petXPLabel:SetTextColor(Color(0, 0, 0))
		petXPLabel:SizeToContents()
		
		petFrame.Think = function(pnl)
			if LocalPlayer():GetNWInt("pet_health") <= 0 then pnl:Close() end
			petStatusLabel:SetText("Pet: " .. LocalPlayer():GetNWString("pet_name") )
			petStatusLabel:SizeToContents()
			
			petHealthBarFill:SetSize(LocalPlayer():GetNWInt("pet_health"), 25)
			--petHealthBarFill:SetSize(math.Clamp(LocalPlayer():GetNWInt("pet_health") * petHealthBar:GetWide(), 0, LocalPlayer():GetNWInt("pet_maxhealth")), 25)
			
			petXPBarFill:SetSize(math.Clamp(LocalPlayer():GetNWInt("pet_curxp") / LocalPlayer():GetNWInt("pet_curreqxp") * petXPBar:GetWide(), 0, LocalPlayer():GetNWInt("pet_curreqxp")), 25)
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


