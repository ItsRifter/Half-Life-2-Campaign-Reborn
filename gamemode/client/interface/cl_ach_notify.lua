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
--------------------------------
--------------------------------
local PANEL = {}

function PANEL:Init()
	self.achname = nil
end

function PANEL:Setup(achTbl, count)
	self:SetSize(ScrH() * 0.4,ScrH()* 0.1)
	local wide = self:GetWide()
	local tall = self:GetTall()
	self:SetPos(ScrW() - wide, ScrH() + tall)
	self.count = count or false
	if achTbl.Secret then self.Secret = true end
	local icon = vgui.Create("DImage", self)
	icon:SetPos(tall*0.05, tall*0.05)
	icon:SetSize(tall*0.9, tall*0.9)
	icon:SetImage(achTbl.Mat)
	
	local Txt = New_ThemeText(self,tall, tall * 0.05,achTbl.Name,"Font2_Small",0,0)
	if !self.count then
		local txt = New_ThemeTextMulti(self,tall, tall * 0.4,achTbl.Desc,"Font2_Micro",0,0,2)
	else
		self.max = achTbl.Max
		local Txt = New_ThemeText(self,(tall+wide)*0.5, tall * 0.63,self.count.."/"..self.max,"Font2_Tiny",0.5,0)
	end

    table.insert(curNotifications, self)
	self:MoveTo(ScrW() - wide, ScrH() - (tall +1) * #curNotifications , 1, 0, 0.5, function()
		self:MoveTo(ScrW() - wide, ScrH() + tall, 4, 3, 2, function() 
            table.remove(curNotifications, #curNotifications)
			self:Remove()
		end)
	end)
end

function PANEL:Paint()
	local wide = self:GetWide()
	local tall = self:GetTall()
	draw.RoundedBox( 6, 0, 0, wide, tall, Theme.buttonout)
	
	if self.Secret then
		draw.RoundedBoxEx( 6, 2, 2, wide-4, tall * 0.32, Theme.secret1,true,true,false,false)
		draw.RoundedBoxEx( 6, 2, 2+tall * 0.32, wide-4, tall * 0.68-4, Theme.secret2,false,false,true,true)
	else
		draw.RoundedBoxEx( 6, 2, 2, wide-4, tall * 0.32, Theme.box,true,true,false,false)
		draw.RoundedBoxEx( 6, 2, 2+tall * 0.32, wide-4, tall * 0.68-4, Theme.box3,false,false,true,true)
	end
	if self.count then
		local size = math.floor((wide-tall-8)/self.max*self.count)
		draw.RoundedBox( 6, tall, tall * 0.6, wide-tall-8, tall * 0.3, Theme.buttonout)
		draw.RoundedBox( 6, tall, tall * 0.6, size, tall * 0.3, Theme.fontgreen)
	end

	return true
end
vgui.Register( "NewAchPanel", PANEL, "Panel" )

--------------------------------
--------------------------------

function NewAchNotice(achTbl,count)
	local achPopUp = vgui.Create("NewAchPanel")
	achPopUp:Setup(achTbl,count)
	
	if !count then
		if not achRare then
			surface.PlaySound("hl2cr/ach_unlock_new.wav")
		else
			surface.PlaySound("hl2cr/rare_ach_unlock_new.wav")
		end
	else
		surface.PlaySound("ambient/levels/prison/radio_random11.wav")
	end
end

function TestPopup(group,id,count)
	local ach = HL2CR_GetAchievement(group,id)
	NewAchNotice(ach,count)
end

net.Receive("HL2CR_AchievementEarned", function()
	local group = net.ReadString()
	local id = net.ReadString()

	local ach = HL2CR_GetAchievement(group,id)
	NewAchNotice(ach)
	table.insert(GAMEMODE.AchEarned,id)
	if GAMEMODE.AchProgress[id] then GAMEMODE.AchProgress[id] = nil end
	--AchNotice(achTbl)
	--AchNotice(net.ReadTable())
end)

net.Receive("HL2CR_AchievementUpdate", function()
	local group = net.ReadString()
	local id = net.ReadString()
	local count = net.ReadUInt(32)

	local ach = HL2CR_GetAchievement(group,id)
	--NewAchNotice(ach,count)
	if !GAMEMODE.AchProgress[id] then
		GAMEMODE.AchProgress[id] = 0
	end
	if ach.Interval then
		if math.floor(count/ach.Interval)-math.floor(GAMEMODE.AchProgress[id]/ach.Interval) > 0 then
			NewAchNotice(ach,count)
		end
	else
		NewAchNotice(ach,count)
	end
	GAMEMODE.AchProgress[id] = count
	--local achNotifyTbl = net.ReadTable()
	--AchUpdateNotice(achNotifyTbl)
end)