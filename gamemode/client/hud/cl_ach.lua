--Achievement Popup
function AchNotice(achTitle, achDesc, achImg, achRare, achXP)
	
	if not achTitle then achTitle = "BUG" end
	if not achDesc then achDesc = "MISSING DESCRIPTION" end
	if not achImg then achImg = "entities/npc_kleiner.png" end
	if not achRare then achRare = false end
	
	local achPopUp = vgui.Create("DNotify")
	achPopUp:SetSize(340, 100)
	achPopUp:SetPos(ScrW() - 280, ScrH())
	achPopUp:SetLife(6)
	
	local BGPnl = vgui.Create("DPanel", achPopUp)
	BGPnl:Dock(FILL)
	BGPnl:SetBackgroundColor(Color(120, 75, 15)) 
	
	local FGPnl = vgui.Create("DPanel", BGPnl)
	FGPnl:SetSize(260, 80)
	FGPnl:SetBackgroundColor(Color(227, 163, 0))
	FGPnl:SetPos(10, 10)
	
	local icon = vgui.Create("DImage", FGPnl)
	icon:SetPos(5, 10)
	icon:SetSize(64, 64)
	icon:SetImage(achImg)
	
	local text = vgui.Create("DLabel", FGPnl)
	text:SetPos(75, 5)
	text:SetText("Achievement Unlocked! \n		" .. achTitle)
	text:SetTextColor(Color(230, 230, 230))
	text:SetFont("ChatFont")
	text:SizeToContents()
	
	local desc = vgui.Create("DLabel", FGPnl)
	desc:SetPos(70, 45)
	desc:SetText(achDesc)
	desc:SetTextColor(Color(230, 230, 230))
	desc:SetFont("Default")
	desc:SizeToContents()
	
	achPopUp:Add(BGPnl)
	
	if achXP > 0 then
		chat.AddText(Color(240, 175, 0), "XP Gained: " .. achXP)
	end
	
	achPopUp:MoveTo(ScrW() - 280, ScrH() - 100, 2, 0, -1, function()
		achPopUp:MoveTo(ScrW() - 280, ScrH() + 120, 6, 3, -1, function() 
			achPopUp:Remove()
		end)
	end)
	
	if not achRare then
		surface.PlaySound("hl2cr/ach_unlock_new.wav")
	else
		surface.PlaySound("hl2cr/rare_ach_unlock_new.wav")
	end
end

function AchUpdateNotice(achTitle, achImg, achProgress, achMaxValue)
	
	if not achTitle then achTitle = "BUG" end
	if not achImg then achImg = "entities/npc_kleiner.png" end
	if not achProgress then achProgress = -1 end
	
	local achPopUp = vgui.Create("DNotify")
	achPopUp:SetSize(340, 100)
	achPopUp:SetPos(ScrW() - 280, ScrH())
	achPopUp:SetLife(6)
	
	local BGPnl = vgui.Create("DPanel", achPopUp)
	BGPnl:Dock(FILL)
	BGPnl:SetBackgroundColor(Color(120, 75, 15)) 
	
	local FGPnl = vgui.Create("DPanel", BGPnl)
	FGPnl:SetSize(260, 80)
	FGPnl:SetBackgroundColor(Color(227, 163, 0))
	FGPnl:SetPos(10, 10)
	
	local icon = vgui.Create("DImage", FGPnl)
	icon:SetPos(5, 10)
	icon:SetSize(64, 64)
	icon:SetImage(achImg)
	
	local text = vgui.Create("DLabel", FGPnl)
	text:SetPos(75, 5)
	text:SetText(achTitle)
	text:SetTextColor(Color(230, 230, 230))
	text:SetFont("ChatFont")
	text:SizeToContents()
	
	local progress = vgui.Create("DLabel", FGPnl)
	progress:SetPos(70, 45)
	progress:SetText(achProgress .. "/" .. achMaxValue)
	progress:SetTextColor(Color(230, 230, 230))
	progress:SetFont("ChatFont")
	progress:SizeToContents()
	
	achPopUp:Add(BGPnl)
	
	surface.PlaySound("ambient/levels/prison/radio_random11.wav")
	
	achPopUp:MoveTo(ScrW() - 280, ScrH() - 100, 1, 0, -1, function()
		achPopUp:MoveTo(ScrW() - 280, ScrH() + 120, 3, 3, -1, function() 
			achPopUp:Remove()
		end)
	end)
end

net.Receive("HL2CR_AchievementEarned", function()
	local achTitle = net.ReadString()
	local achDesc = net.ReadString()
	local achImg = net.ReadString()
	local achRare = net.ReadBool()
	local achXP = net.ReadInt(32)
	AchNotice(achTitle, achDesc, achImg, achRare, achXP)
end)

net.Receive("HL2CR_AchievementUpdate", function()
	local achTitle = net.ReadString()
	local achImg = net.ReadString()
	local achProgress = net.ReadInt(16)
	local achMaxValue = net.ReadInt(16)
	AchUpdateNotice(achTitle, achImg, achProgress, achMaxValue)
end)