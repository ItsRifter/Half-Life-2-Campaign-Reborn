function ToggleBoard(toggle)
	if toggle then
		scoreboard = vgui.Create("HL2CR_Tab")
		scoreboard:SetSize(1000, 650)
		if ScrW() == 1920 and ScrH() == 1080 then
			scoreboard:SetPos(ScrW() / 2 * .5, ScrH() / 2 * 0.1)
		else
			scoreboard:SetPos(ScrW() / 2 * .12, ScrH() / 2 * 0.1)
		end
		scoreboard:SetVisible(true)
		
		scoreboard:SetAlpha(0)
		scoreboard:AlphaTo(255, 0.30, 0, function() end)
		scoreboard:SetKeyboardInputEnabled(false)
		
		local mainPanel = vgui.Create("DPanel", scoreboard)
		mainPanel:SetPos(0, 103)
		mainPanel:SetSize(1000, 0)
		
		mainPanel:SizeTo(1000, 500, 0.35, 0.2, -1, function() end)
		
		mainPanel.Paint = function(self, w, h)
			surface.SetDrawColor(Color(250, 184, 12, 255))
			surface.DrawRect(0, 0, w, h)
		end
		
	elseif not toggle and scoreboard:IsValid() then
		scoreboard:Remove()
	end
	
	
end

hook.Add("ScoreboardShow", "HL2CR_ScoreboardShow", function()
	ToggleBoard(true)
	return false
end)


hook.Add("ScoreboardHide", "HL2CR_ScoreboardHide", function()
	ToggleBoard(false)
end)