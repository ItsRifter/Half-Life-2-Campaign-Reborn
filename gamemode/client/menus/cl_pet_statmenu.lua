function ShowPetStatMenu(shouldOpen)
	
	if shouldOpen then
		if not LocalPlayer():GetNWEntity("hl2cr_pet") then return end
		petFrame = vgui.Create("DFrame")
		petFrame:SetSize(165, 125)
		petFrame:SetPos(15, ScrH() / 2.25)
		petFrame:SetTitle("")
		petFrame:ShowCloseButton(false)
		
		petFrame.Paint = function(pnl, w, h)
			surface.SetDrawColor(0, 0, 0, 0)
			surface.DrawRect(0, 0, w, h)
		end
		
		local petStatusLabel = vgui.Create("DLabel", petFrame)
		petStatusLabel:SetFont("HL2CR_Pets_Name")
		petStatusLabel:SetPos(0, 0)
		petStatusLabel:SetText(LocalPlayer():GetNWString("pet_name") )
		petStatusLabel:SizeToContents()
		
		local petHealthBar = vgui.Create("DPanel", petFrame)
		petHealthBar:SetSize(LocalPlayer():GetNWEntity("hl2cr_pet"):GetMaxHealth(), 25)
		petHealthBar:SetPos(0, 35)
		petHealthBar.Paint = function(self, w, h)
			surface.SetDrawColor(0, 0, 0, 255)
			surface.DrawRect(0, 0, w, h)
		end
		
		local petHealthBarFill = vgui.Create("DPanel", petHealthBar)
		petHealthBarFill:SetSize(LocalPlayer():GetNWEntity("hl2cr_pet"):Health(), petHealthBar:GetTall())
		petHealthBarFill.Paint = function(self, w, h)
			surface.SetDrawColor(0, 170, 0, 255)
			surface.DrawRect(0, 0, w, h)
		end
				
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
		
		petFrame.Think = function(pnl)
			if not LocalPlayer():GetNWEntity("hl2cr_pet") then pnl:Close() end
			if LocalPlayer():GetNWEntity("hl2cr_pet"):Health() <= 0 then pnl:Close() end
			petStatusLabel:SetText(LocalPlayer():GetNWString("pet_name") )
			petStatusLabel:SizeToContents()
			
			petHealthBarFill:SetSize(LocalPlayer():GetNWEntity("hl2cr_pet"):Health(), 25)
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


