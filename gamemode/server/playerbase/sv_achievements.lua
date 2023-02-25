function hl2cr_player:GrantAchievement(achName)
	
	local ach = nil

	for i, a in ipairs(GAMEMODE.Achievements) do
		if a.Name == achName then
			ach = a
			break
		end
	end

	--Grab the achievement from the list unless its an invalid name

	if not ach then 
		MsgC(HL2CR_RedColour, string.format("\nCouldn't find the achievement %s", achName) )
		return 
	end
	
	local fixupName = string.Replace(achName, " ", "_") 

	--If player already has the achievement, stop here
	if self:HasAchievement(fixupName) then return end

	--Insert the achievement to the player's data
	table.insert(self.hl2cr.Achievements, fixupName)
	
	local displayAch = {
		["Name"] = ach.Name,
		["Desc"] = ach.Desc,
		["Mat"] = ach.Mat,
		["IsRare"] = ach.IsRare,

		["Rewards"] = {
			["XP"] = ach.Rewards.XP
		}
	}

	--Show the popup achievement similar to steam's achievements
	net.Start("HL2CR_AchievementEarned")
		net.WriteTable(displayAch)
	net.Send(self)

	--Notify everyone of the achiever
	if ach.IsRare then
		BroadcastMessageToAll(HL2CR_PlayerColour, self:Nick(), HL2CR_StandardColour, translate.Get("Server_Announce_Achievement_Rare"), HL2CR_PlayerColour, ach.Name)
	else
		BroadcastMessageToAll(HL2CR_PlayerColour, self:Nick(), HL2CR_StandardColour, translate.Get("Server_Announce_Achievement_Normal"), HL2CR_PlayerColour, ach.Name)
	end

	if ach.Rewards.XP > 0 then
		self:AddXP(ach.Rewards.XP)
	end

	if ach.Rewards.Items then
		ach.Rewards.Items(self)
	end

	self:UpdateNetworks()
end

function hl2cr_player:UpdateAchievement(achName, value)
	if self:HasAchievement(achName) then return end

	local achFixup = string.Replace(achName, " ", "_") 

	if self.hl2cr.AchProgress[achFixup] == nil then
		self.hl2cr.AchProgress[achFixup] = 0
	end

	self.hl2cr.AchProgress[achFixup] = self.hl2cr.AchProgress[achFixup] + value
	local ach = nil
	for i, v in ipairs(GAMEMODE.Achievements) do
		if v.Name == achName then
			ach = v
			break
		end
	end

	if table.Count(self.hl2cr.AchProgress[achFixup]) >= ach.Max then
		self:GrantAchievement(achName)
		self.hl2cr.AchProgress[achFixup] = nil
	elseif self.hl2cr.AchProgress[achFixup] % ach.Update == 0 then 
		net.Start("HL2CR_AchievementUpdate")
			net.WriteTable({
				["name"] = ach.Name,
				["icon"] = ach.Mat,
				["progress"] = table.Count(self.hl2cr.AchProgress[achName]),
				["max"] = ach.Max
			})
		net.Send(self)
	end
end

function hl2cr_player:UpdateLambdaLocator(value)
	if self:HasAchievement("Lambda Locator") then return end

	if self.hl2cr.AchProgress["lambda_locator"] == nil then 
		self.hl2cr.AchProgress["lambda_locator"] = {}
	end

	if table.HasValue(self.hl2cr.AchProgress["lambda_locator"], value) then return end

	table.insert(self.hl2cr.AchProgress["lambda_locator"], value)
	
	local ach = nil
	for i, v in ipairs(GAMEMODE.Achievements) do
		if v.Name == "Lambda Locator" then
			ach = v
			break
		end
	end

	if table.Count(self.hl2cr.AchProgress["lambda_locator"]) >= ach.Max then
		self:GrantAchievement("Lambda Locator")
		table.Empty(self.hl2cr.AchProgress["lambda_locator"])
		self.hl2cr.AchProgress["lambda_locator"] = nil  
	else
		net.Start("HL2CR_AchievementUpdate")
			net.WriteTable({
				["name"] = ach.Name,
				["icon"] = ach.Mat,
				["progress"] = table.Count(self.hl2cr.AchProgress["lambda_locator"]),
				["max"] = ach.Max
			})
		net.Send(self)
	end
end

-----------------------------------Rewrite all above-----------------------------------
---------------------------------------------------------------------------------------
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

