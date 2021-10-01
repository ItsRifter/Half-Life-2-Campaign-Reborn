local VOICES = {
	[1] = "Medic",
	[2] = "Armor",
	[3] = "Ammo"
}

local lastVoice = lastVoice or 1

function ShowVoiceCMDMenu(shouldOpen)
	if not LocalPlayer():Alive() then return end
	
	if shouldOpen then
		voiceFrame = vgui.Create("DFrame")
		voiceFrame:SetSize(200, 250)
		voiceFrame:SetPos(0, ScrH() / 2.5)
		voiceFrame:SetTitle("")
		voiceFrame:ShowCloseButton(false)
		
		voiceFrame.Paint = function(pnl, w, h)
			surface.SetDrawColor(0, 0, 0, 185)
			surface.DrawRect(0, 0, w, h)
		end
		
		voiceFrame:SetKeyboardInputEnabled( true )
		
		requestLabel = vgui.Create("DLabel", voiceFrame)
		requestLabel:SetText("Press '+use'\nto confirm voice")
		requestLabel:SetPos(voiceFrame:GetWide() / 12, voiceFrame:GetTall() / 3.5)
		requestLabel:SetFont("HL2CR_VoicesHelp")
		requestLabel:SizeToContents()	
		
		voiceLabel = vgui.Create("DLabel", voiceFrame)
		voiceLabel:SetText(VOICES[lastVoice])
		voiceLabel:SetFont("HL2CR_Voices")
		voiceLabel:SetPos(voiceFrame:GetWide() / 4, voiceFrame:GetTall() / 2)
		voiceLabel:SizeToContents()	

		voiceLabel.Think = function(pnl)
			pnl:SetText(VOICES[lastVoice])
			pnl:SizeToContents()
		end
	else
		if voiceFrame:IsValid() then
			voiceFrame:Close()
		end
	end
end


function GM:OnContextMenuOpen()
	ShowVoiceCMDMenu(true)
end

function GM:OnContextMenuClose()
	ShowVoiceCMDMenu(false)
end

local fixScrolling = 0

hook.Add("InputMouseApply", "HL2CR_ScrollVoice", function(cmd, x, y, ang)
	
	if voiceFrame and voiceFrame:IsValid() then

		--if fixScrolling <= CurTime() then return end
		
		lastVoice = lastVoice + cmd:GetMouseWheel()
		
		if lastVoice > #VOICES then
			lastVoice = 1
		elseif lastVoice < 1 then
			lastVoice = #VOICES
		end
		
		fixScrolling = CurTime() + fixScrolling
	end
		
end)

hook.Add("KeyPress", "HL2CR_ConfirmVoice", function(ply, key)
	if voiceFrame and voiceFrame:IsValid() and key == IN_USE then
		net.Start("HL2CR_HelpNotify")
			net.WriteString(VOICES[lastVoice])
		net.SendToServer()
		ShowVoiceCMDMenu(false)
	end
end)

