net.Receive("HL2CR_OpenPets", function()
	local petTabs = vgui.Create("HL2CR_Tab")
	petTabs:SetSize(ScrW() / 1.5, ScrH() / 1.5)
	petTabs:Center()
	petTabs.Paint = function(self, w, h)
		surface.SetDrawColor(HL2CR.Theme.qMenu)
		surface.DrawRect(0, 0, w, h)
	end
	
	local petsPnl = vgui.Create("DPanel", petTabs)
	petsPnl:SetSize(petTabs:GetWide(), petTabs:GetTall())
	petsPnl:SetPos(0, 100)
	
	local petsPnlBG = vgui.Create("DPanel", petsPnl)
	petsPnlBG:SetSize(petsPnl:GetWide(), petsPnl:GetTall())
	petsPnlBG.Paint = function(self, w, h)
		surface.SetDrawColor(HL2CR.Theme.qMenu)
		surface.DrawRect(0, 0, w, h)
	end

	local closePnl = vgui.Create("DPanel", petTabs)
	closePnl:SetSize(petTabs:GetWide(), petTabs:GetTall())
	closePnl:SetPos(0, 100)

	petTabs.navbar:AddTab(translate.Get("Pets_Bar"), petsPnl)
	petTabs.navbar:AddTab(translate.Get("Close"), closePnl)
	petTabs.navbar:SetActive(1)
	
	petTabs.Think = function(pnl)
		if pnl.navbar:GetActive() == closePnl then
			petTabs:Remove()
		end
	end
end)