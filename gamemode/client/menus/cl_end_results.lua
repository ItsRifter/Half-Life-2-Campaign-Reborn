function TimerScreen()
	
	local timerFrame = vgui.Create("DFrame")
	timerFrame:SetSize(ScrW(), ScrH())
	timerFrame:SetTitle("")
	timerFrame:ShowCloseButton(false)
	timerFrame.Paint = function(self, w, h) return end
	
	local timerPanel = vgui.Create("DPanel", timerFrame)
	timerPanel:SetSize(ScrW() / 4, 150)
	timerPanel:SetPos(ScrW() / 2 - 200, -250)
	timerPanel.Paint = function(self, w, h)
		draw.RoundedBoxEx( 12, 0, 0, w, h, Color(0, 0, 0, 175), false, false, true, true )
	end
	
	timerPanel:MoveTo(ScrW() / 2 - 200, ScrH() / 2 - 550, 1.5, 0, -1, nil )
	
	timer.Create("HL2CR_Client_Timeleft", 20, 1, function() 
		timerFrame:Close()
	end)
	
	specTimeLabel = vgui.Create("DLabel", timerPanel)
	specTimeLabel:SetText("Time left: " .. math.Round(timer.TimeLeft("HL2CR_Client_Timeleft") ) )
	specTimeLabel:SetFont("HL2CR_SpectatePlayer")
	specTimeLabel:SizeToContents()
	specTimeLabel:SetPos(timerPanel:GetWide() / 2 - 150, 30)
	
	specTimeLabel.Think = function(pnl)
		pnl:SetText("Time left: " .. math.Round(timer.TimeLeft("HL2CR_Client_Timeleft") ) )
	end
end

local animTime = 1.4

function ResultScreen(tblResults)

	local startLerp = SysTime()
	
	surface.PlaySound("hl2cr/endrewards_" .. math.random(1, 3) .. ".wav")
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
	
	levelUpDisplay = vgui.Create("DLabel", endFrame)
	levelUpDisplay:SetPos(ScrW() / 2 - 75, 725)
	levelUpDisplay:SetAlpha(0)
	levelUpDisplay:SetText("Level Up!")
	levelUpDisplay:SetFont("HL2CR_EndMapStats")
	levelUpDisplay:SizeToContents()
	
	local killLabel = vgui.Create("DLabel", endFrame)
	killLabel:SetPos(ScrW() / 2 - 100, 25)
	killLabel:SetAlpha(0)
	killLabel:SetText("Total Kills: ...")
	killLabel:SetFont("HL2CR_EndMapStats")
	killLabel:SizeToContents()
	killLabel.Think = function(pnl)
		killLabel:SetText("Total Kills: " .. math.Round(Lerp( (SysTime() - startLerp) / animTime - 1, 0, tblResults["kills"])))
		killLabel:SizeToContents()
	end
	
	killLabel:AlphaTo(255, 2, 0, nil)
	killLabel:MoveTo(ScrW() / 2 - 100, 150, 1, 0, 0.5, nil)
	
	local xpLabel = vgui.Create("DLabel", endFrame)
	xpLabel:SetPos(ScrW() / 2 - 150, 100)
	xpLabel:SetAlpha(0)
	xpLabel:SetText("Total XP Gained: ...")
	xpLabel:SetFont("HL2CR_EndMapStats")
	xpLabel:SizeToContents()
	xpLabel.Think = function(pnl)
		pnl:SetText("Total XP Gained: " .. math.Round(Lerp( (SysTime() - startLerp) / animTime - 3, 0, tblResults["stats"]["exp"])))
		pnl:SizeToContents()
	end
	
	xpLabel:AlphaTo(255, 2, 0, nil)
	xpLabel:MoveTo(ScrW() / 2 - 150, 200, 1, 0, 0.5, nil)
	
	local closeBtn = vgui.Create("DButton", endFrame)
	closeBtn:SetText("Close")
	closeBtn:SetFont("HL2CR_EndMapStats")
	closeBtn:SetSize(175, 50)
	closeBtn:SetPos(ScrW() / 2 - 80, ScrH() / 2 + 300)
	
	closeBtn.DoClick = function()
		endFrame:Close()
		StartClientSpectate(true)
	end
end

net.Receive("HL2CR_ClientMapResults", function() 
	local resultTbl = net.ReadTable()
	ResultScreen(resultTbl)
end)
