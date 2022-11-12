
local hl2cr_player = FindMetaTable( "Player" )

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

function hl2cr_player:HasAchievement(achName)
	local fixName = string.Replace(achName, " ", "_")

	return table.HasValue(self.hl2cr.Achievements, fixName)
end