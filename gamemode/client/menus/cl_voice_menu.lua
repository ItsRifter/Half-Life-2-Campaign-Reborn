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
		requestLabel:SetText("Press 'Enter'\nto confirm voice")
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
		voiceFrame:Close()
	end
end


function GM:OnContextMenuOpen()
	ShowVoiceCMDMenu(true)
end

function GM:OnContextMenuClose()
	ShowVoiceCMDMenu(false)
end

hook.Add("InputMouseApply", "HL2CR_ScrollVoice", function(cmd, x, y, ang)
	
	if voiceFrame and voiceFrame:IsValid() then
		lastVoice = lastVoice + cmd:GetMouseWheel()
		
		if lastVoice > #VOICES then
			lastVoice = 1
		elseif lastVoice < 1 then
			lastVoice = #VOICES
		end
	end
end)

hook.Add("KeyPress", "HL2CR_ConfirmVoice", function(ply, key)
	if voiceFrame and key == IN_USE then
		net.Start("HL2CR_HelpNotify")
			net.WriteString(VOICES[lastVoice])
		net.SendToServer()
	end
end)

