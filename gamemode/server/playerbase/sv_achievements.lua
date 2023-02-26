
-----------------------------------Rewrite all above-----------------------------------
---------------------------------------------------------------------------------------

function hl2cr_player:HasAchievement(id)
	return table.HasValue(self.hl2cr.Achievements, id)
end

function hl2cr_player:GiveAchievement(group,id)
	if self:IsBot() then return end
	if self:HasAchievement(id) then return end

	local ach = HL2CR_GetAchievement(group,id)
	if !ach then
		MsgC(HL2CR_RedColour, "Invalid Achievement "..group.." "..id )
		return
	end
	
	table.insert(self.hl2cr.Achievements, id)
	net.Start("HL2CR_AchievementEarned")
		net.WriteString(group)
		net.WriteString(id)
	net.Send(self)
	
	if ach.Secret then
		BroadcastMessageToAll(HL2CR_WarningColour, self:Nick(), HL2CR_PlayerColour, translate.Get("Server_Announce_Achievement_Secret"), HL2CR_WarningColour, ach.Name)
	else
		BroadcastMessageToAll(HL2CR_PlayerColour, self:Nick(), HL2CR_StandardColour, translate.Get("Server_Announce_Achievement_Normal"), HL2CR_PlayerColour, ach.Name)
	end

	if ach.Rewards then
		if ach.Rewards.XP and ach.Rewards.XP > 0 then
			self:AddXP(ach.Rewards.XP)
		end
		if ach.Rewards.Items then
			for k, v in pairs( ach.Rewards.Items ) do
				self:GiveItem(v)
			end
		end
		if ach.Rewards.AP then
			self:AddAP(ach.Rewards.AP)
		end
	end
	
end

function hl2cr_player:ProgressAchievement(group,id,value)
	if self:IsBot() then return end
	if self:HasAchievement(id) then return end
	
	local ach = HL2CR_GetAchievement(group,id)
	if !ach then
		MsgC(HL2CR_RedColour, "Invalid Achievement "..group.." "..id )
		return
	end
	
	if !ach.Max then 
		MsgC(HL2CR_RedColour, "Not a progression Achievement "..group.." "..id )
		return 
	end

	local newcount = 0
	
	if !ach.Count then	--Achievements that use a key table
		if !self.hl2cr.AchProgress[id] then self.hl2cr.AchProgress[id] = {} end
		if table.HasValue(self.hl2cr.AchProgress[id], value) then return end
		table.insert(self.hl2cr.AchProgress[id], value)
		newcount = table.Count(self.hl2cr.AchProgress[id])
		if newcount >= ach.Max then
			self:GiveAchievement(group,id)
			table.Empty(self.hl2cr.AchProgress[id])
			self.hl2cr.AchProgress[id] = nil  
			return
		end
	else
		if !self.hl2cr.AchProgress[id] then self.hl2cr.AchProgress[id] = 0 end
		newcount = self.hl2cr.AchProgress[id] + value
		self.hl2cr.AchProgress[id] = newcount
		if newcount >= ach.Max then
			self:GiveAchievement(group,id)
			self.hl2cr.AchProgress[id] = nil  
			return
		end
	end
	
	net.Start("HL2CR_AchievementUpdate")
		net.WriteString(group)
		net.WriteString(id)
		net.WriteUInt(newcount,32)
		net.Send(self)
	
end

----------------Network----------------

function hl2cr_player:SendAchievements()
	local datajson = util.TableToJSON( self.hl2cr.Achievements )
	local compressed = util.Compress( datajson )
	local bytes = #compressed

	net.Start( "HL2CR_AchievementSend" )
		net.WriteUInt( bytes, 16 )
		net.WriteData( compressed, bytes )
	net.Send( self )
	
	local progress = {}
	
	for k, v in pairs( self.hl2cr.AchProgress) do
		if istable(v) then
			progress[k] = #v
		else
			progress[k] = v
		end
	end
	
	datajson = util.TableToJSON( progress )
	compressed = util.Compress( datajson )
	bytes = #compressed
	
	net.Start( "HL2CR_AchievementProg" )
		net.WriteUInt( bytes, 16 )
		net.WriteData( compressed, bytes )
	net.Send( self )
	
end

