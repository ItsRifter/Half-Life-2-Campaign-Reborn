local curNotifications = {}

--Achievement Popup
function AchNotice(achTbl)
	
	local achTitle = achTbl.Name or "BUG"
	local achDesc = achTbl.Desc or "MISSING DESCRIPTION"
	local achIcon = achTbl.Mat or "entities/npc_kleiner.png"
	local achRare = achTbl.IsRare or false
	
	local achPopUp = vgui.Create("DNotify")
	achPopUp:SetSize(380 + string.len(achDesc), 140)
	achPopUp:SetPos(ScrW() - achPopUp:GetWide(), ScrH())
	achPopUp:SetLife(6)
	
	local BGPnl = vgui.Create("DPanel", achPopUp)
	BGPnl:Dock(FILL)
	BGPnl:SetBackgroundColor(Color(120, 75, 15)) 
	
	local FGPnl = vgui.Create("DPanel", BGPnl)
	FGPnl:SetSize(achPopUp:GetWide() - 20, 80)
	FGPnl:SetBackgroundColor(Color(227, 163, 0))
	FGPnl:SetPos(10, 10)
	
	local icon = vgui.Create("DImage", FGPnl)
	icon:SetPos(5, 10)
	icon:SetSize(64, 64)
	icon:SetImage(achIcon)
	
	local text = vgui.Create("DLabel", FGPnl)
	text:SetPos(70, 5)
	text:SetText(achTitle)
	text:SetTextColor(Color(0, 0, 0))
	text:SetFont("hl2cr_ach_title")
	text:SizeToContents()
	
	local desc = vgui.Create("DLabel", FGPnl)
	desc:SetPos(70, 30)
	desc:SetText(achDesc)
	desc:SetTextColor(Color(0, 0, 0))
	desc:SetFont("hl2cr_ach_desc")
	desc:SetSize(FGPnl:GetWide() / 2, 60)
	desc:SizeToContents()

	if achTbl.Rewards.XP > 0 then
		local reward = vgui.Create("DLabel", FGPnl)
		reward:SetPos(70, 55)
		reward:SetText(translate.Get("Achievement_XPReward") .. achTbl.Rewards.XP)
		reward:SetTextColor(Color(0, 0, 0))
		reward:SetFont("hl2cr_ach_title")
		reward:SizeToContents()
	end
	
	achPopUp:Add(BGPnl)
	
    table.insert(curNotifications, achPopUp)
	achPopUp:MoveTo(ScrW() - achPopUp:GetWide(), ScrH() - 100 * #curNotifications, 1, 0, 0.75, function()
		achPopUp:MoveTo(ScrW() - achPopUp:GetWide(), ScrH() + 120, 4, 3, -1, function() 
            table.remove(curNotifications, #curNotifications)
			achPopUp:Remove()
		end)
	end)
	
	if not achRare then
		surface.PlaySound("hl2cr/ach_unlock_new.wav")
	else
		surface.PlaySound("hl2cr/rare_ach_unlock_new.wav")
	end
end

function AchUpdateNotice(achTbl)
	
	if not achTbl.name then achTbl.name = "BUG" end
	if not achTbl.icon then achTbl.icon = "entities/npc_kleiner.png" end
	if not achTbl.progress then achTbl.progress = -1 end
	if not achTbl.max then achTbl.max = -1 end
	
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
	icon:SetImage(achTbl.icon)
	
	local text = vgui.Create("DLabel", FGPnl)
	text:SetPos(75, 5)
	text:SetText(achTbl.name)
	text:SetTextColor(Color(230, 230, 230))
	text:SetFont("ChatFont")
	text:SizeToContents()
	
	local progress = vgui.Create("DLabel", FGPnl)
	progress:SetPos(70, 45)
	progress:SetText(achTbl.progress .. "/" .. achTbl.max)
	progress:SetTextColor(Color(230, 230, 230))
	progress:SetFont("ChatFont")
	progress:SizeToContents()
	
	achPopUp:Add(BGPnl)
	
	surface.PlaySound("ambient/levels/prison/radio_random11.wav")
	
	achPopUp:MoveTo(ScrW() - 280, ScrH() - 100, 0.5, 0, -1, function()
		achPopUp:MoveTo(ScrW() - 280, ScrH() + 120, 2.5, 3, -1, function() 
			achPopUp:Remove()
		end)
	end)
end

net.Receive("HL2CR_AchievementEarned", function()
	AchNotice(net.ReadTable())
end)

net.Receive("HL2CR_AchievementUpdate", function()
	local achNotifyTbl = net.ReadTable()
	AchUpdateNotice(achNotifyTbl)
end)