local animTime = 1.4

function ResultScreen(tblResults)
	local randMusic = math.random(1, 3)
	local startLerp = SysTime()
	
	--surface.PlaySound("hl2cr/endrewards_" .. randMusic .. ".wav")
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
		xpLabel:SetText("Total XP Gained: " .. math.Round(Lerp( (SysTime() - startLerp) / animTime - 3, 0, tblResults["stats"]["exp"])))
		xpLabel:SizeToContents()
	end
	
	xpLabel:AlphaTo(255, 2, 0, nil)
	xpLabel:MoveTo(ScrW() / 2 - 150, 200, 1, 0, 0.5, nil)
	
	local xpLabelCompare = vgui.Create("DLabel", endFrame)
	xpLabelCompare:SetPos(ScrW() / 2 - 65, 450)
	xpLabelCompare:SetAlpha(0)
	xpLabelCompare:SetText("499/500")
	xpLabelCompare:SetFont("HL2CR_EndMapStats")
	
	xpLabelCompare:AlphaTo(255, 2, 0, nil)
	xpLabelCompare:MoveTo(ScrW() / 2 - 65, 700, 1, 0, 0.5, nil)
	
	xpLabelCompare:SizeToContents()
	
	local xpBarBorder = vgui.Create("DPanel", endFrame)
	xpBarBorder:SetPos(ScrW() / 2 - 240, 500)
	xpBarBorder:SetSize( 500, 50 )
	xpBarBorder:SetAlpha(0)
	
	xpBarBorder:AlphaTo(255, 2, 0, nil)
	xpBarBorder:MoveTo(ScrW() / 2 - 240, 750, 1, 0, 0.5, nil)
	
	local xpBarFill = vgui.Create("DPanel", xpBarBorder)
	xpBarFill:SetSize( 50, 50 )
	xpBarFill:SetBackgroundColor(Color(250, 184, 12, 255))
	xpBarFill.Think = function(self)
		self:SetSize(Lerp( (SysTime() - startLerp) / animTime - 3, 0, 250), 50)
	end

	local closeBtn = vgui.Create("DButton", endFrame)
	closeBtn:SetText("Close")
	closeBtn:SetFont("HL2CR_EndMapStats")
	closeBtn:SetSize(175, 50)
	closeBtn:SetPos(ScrW() / 2 - 80, ScrH() / 2 + 300)
	
	closeBtn.DoClick = function()
		endFrame:Close()
	end
end

net.Receive("HL2CR_ClientMapResults", function() 
	local resultTbl = net.ReadTable()
	ResultScreen(resultTbl) 
end)
