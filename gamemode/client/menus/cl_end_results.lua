local FINAL_MAPS = {
	["d3_breen_01"] = true
}

function TimerScreen()
	
	local timerFrame = vgui.Create("DFrame")
	timerFrame:SetSize(ScrW(), ScrH())
	timerFrame:SetTitle("")
	timerFrame:ShowCloseButton(false)
	timerFrame.Paint = function(self, w, h) return end
	
	local timerPanel = vgui.Create("DPanel", timerFrame)
	timerPanel:SetSize(340, 75)
	timerPanel:SetPos(ScrW() / 2.5, -375)
	timerPanel.Paint = function(self, w, h)
		draw.RoundedBoxEx( 12, 0, 0, w, h, Color(0, 0, 0, 175), false, false, true, true )
	end
	
	timerPanel:MoveTo(ScrW() / 2.5, 0, 1.5, 0, -1, nil )
	
	if FINAL_MAPS[game.GetMap()] then
		timer.Create("HL2CR_Client_Timeleft", 40, 1, function() 
			timerFrame:Close()
		end)
	else
		timer.Create("HL2CR_Client_Timeleft", 20, 1, function() 
			timerFrame:Close()
		end)
	end
	
	specTimeLabel = vgui.Create("DLabel", timerPanel)
	specTimeLabel:SetText(translate.Get("TimeLeft") .. math.Round(timer.TimeLeft("HL2CR_Client_Timeleft") ) )
	specTimeLabel:SetFont("HL2CR_SpectatePlayer")
	specTimeLabel:SizeToContents()
	specTimeLabel:SetPos(timerPanel:GetWide() / 50, 0)

	specTimeLabel.Think = function(pnl)
		pnl:SetText(translate.Get("TimeLeft") .. math.Round(timer.TimeLeft("HL2CR_Client_Timeleft") ) )
	end
end

local animTime = 1.4

function ResultScreen(tblResults)

	local startLerp = SysTime()
	if LocalPlayer():GetNWBool("config_shouldendmusicplay") then
		surface.PlaySound("hl2cr/endrewards_" .. math.random(1, 3) .. ".wav")
	end
	local endFrame = vgui.Create("DFrame")
	endFrame:SetSize(ScrW(), ScrH())
	endFrame:SetTitle("")
	endFrame:SetDraggable(false)
	endFrame:ShowCloseButton(false)
	endFrame:MakePopup()
	endFrame.Paint = function(pnl, w, h)
		surface.SetDrawColor(0, 0, 0, 215)
		surface.DrawRect(0, 0, w, h)
	end

	local killLabel = vgui.Create("DLabel", endFrame)
	killLabel:SetPos(ScrW() / 2.232555, 25)
	killLabel:SetAlpha(0)
	killLabel:SetText(translate.Get("TotalKills"))
	killLabel:SetFont("HL2CR_EndMapStats")
	killLabel:SizeToContents()
	killLabel.Think = function(pnl)
		killLabel:SetText("Total Kills: " .. math.Round(Lerp( (SysTime() - startLerp) / animTime - 1, 0, tblResults["kills"])))
		killLabel:SizeToContents()
	end
	
	killLabel:AlphaTo(255, 2, 0, nil)
	killLabel:MoveTo(ScrW() / 2.232555, 150, 1, 0, 0.5, nil)
	
	local xpLabel = vgui.Create("DLabel", endFrame)
	xpLabel:SetPos(ScrW() / 2.3703703, 100)
	xpLabel:SetAlpha(0)
	xpLabel:SetText(translate.Get("StatXP"))
	xpLabel:SetFont("HL2CR_EndMapStats")
	xpLabel:SizeToContents()
	xpLabel.Think = function(pnl)
		pnl:SetText(translate.Get("StatXP") .. math.Round(Lerp( (SysTime() - startLerp) / animTime - 3, 0, tblResults["stats"]["exp"])))
		pnl:SizeToContents()
	end
	
	xpLabel:AlphaTo(255, 2, 0, nil)
	xpLabel:MoveTo(ScrW() / 2.3703703, 200, 1, 0, 0.5, nil)
	
	local totalAchNames = ""
	
	for _, name in ipairs(tblResults["achs"]) do
		totalAchNames = totalAchNames .. name .. "\n"
	end
	
	local totalBonuses = "\n"
	
	for i, bonus in pairs(tblResults["bonus"]) do
		if bonus then
			totalBonuses = totalBonuses .. i .. "\n"
		end
	end
	
	local resinLabel = vgui.Create("DLabel", endFrame)
	resinLabel:SetPos(ScrW() / 2.299399, 100)
	resinLabel:SetAlpha(0)
	resinLabel:SetText(translate.Get("StatResin"))
	resinLabel:SetFont("HL2CR_EndMapStats")
	resinLabel:SizeToContents()
	resinLabel.Think = function(pnl)
		pnl:SetText(translate.Get("StatResin") .. math.Round(Lerp( (SysTime() - startLerp) / animTime - 5, 0, tblResults["resin"])))
		pnl:SizeToContents()
	end
	
	resinLabel:AlphaTo(255, 2, 0, nil)
	resinLabel:MoveTo(ScrW() / 2.299399, 250, 1, 0, 0.5, nil)
	
	if totalAchNames != "\n" then
		local achsLabel = vgui.Create("DLabel", endFrame)
		achsLabel:SetPos(ScrW() / 2.61224, 100)
		achsLabel:SetAlpha(0)
		achsLabel:SetText("Achievements Earned: " .. totalAchNames)
		achsLabel:SetFont("HL2CR_EndMapStats")
		achsLabel:SizeToContents()
		
		achsLabel:AlphaTo(255, 2, 0, nil)
		achsLabel:MoveTo(ScrW() / 2.61224, 500, 1, 0, 0.5, nil)
	end
	
	if totalBonuses != "" then
		local bonusesLabel = vgui.Create("DLabel", endFrame)
		bonusesLabel:SetPos(ScrW() / 2.3703703, 100)
		bonusesLabel:SetAlpha(0)
		bonusesLabel:SetText("Bonuses Earned: " .. totalBonuses)
		bonusesLabel:SetFont("HL2CR_EndMapStats")
		bonusesLabel:SizeToContents()
		
		bonusesLabel:AlphaTo(255, 2, 0, nil)
		bonusesLabel:MoveTo(ScrW() / 2.3703703, 600, 1, 0, 0.5, nil)
	end
	
	local closeBtn = vgui.Create("DButton", endFrame)
	closeBtn:SetText("Close")
	closeBtn:SetFont("HL2CR_EndMapStats")
	closeBtn:SetSize(175, 50)
	closeBtn:SetPos(ScrW() / 2.181818, ScrH() / 1.285713)
	
	closeBtn.DoClick = function()
		endFrame:Close()
		StartClientSpectate(true)
	end
end

net.Receive("HL2CR_ClientMapResults", function() 
	local resultTbl = net.ReadTable()
	ResultScreen(resultTbl)
end)
