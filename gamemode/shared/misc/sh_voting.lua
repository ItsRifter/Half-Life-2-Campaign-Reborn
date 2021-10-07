AddCSLuaFile()

---Helper function to get the postitive and negative votes from a voting state.
---@param state table
---@return integer positive
---@return integer negative
local function countVotes(state)
	local positive, negative = 0, 0
	for _, voter in ipairs(state.Voters) do
		if voter.Status then
			positive = positive + 1
		elseif not voter.Status then
			negative = negative + 1
		end
	end

	return positive, negative
end

-- List of voting types in the shared realm. Can add more fields to the types if necessary, like symbols, constraints, limits, vote options or callback functions.
votingTypes = {}

-- Template
votingTypes["Template"] = {
	Description = "[Insert text here]",
	Callback = function(state)
		local positive, negative = countVotes(state)
		print(string.format("There were %d positive and %d negative votes!", positive, negative))
	end
}

votingTypes["Lobby"] = {
	Description = "Return to the lobby?",
	Callback = function(state)
		local positive, negative = countVotes(state)
		print(string.format("There were %d positive and %d negative votes!", positive, negative))
		if positive > negative then
			for k, v in pairs(player.GetAll()) do
				BroadcastMessage(VOTE_SUCCESS_LOBBY)
			end
			timer.Simple(5, function()
				RunConsoleCommand("ChangeLevel", "hl2cr_lobby_v2")
			end)
		else
			BroadcastMessage(VOTE_FAILED)
		end
	end
}

votingTypes["Restart"] = {
	Description = "Restart the map?",
	Callback = function(state)
		local positive, negative = countVotes(state)
		print(string.format("There were %d positive and %d negative votes!", positive, negative))
		if positive > negative then
			BroadcastMessage(VOTE_SUCCESS_MAP)
			BroadcastSound("music/hl2_song23_suitsong3.mp3")
			timer.Simple(5, function()
				RunConsoleCommand("ChangeLevel", game.GetMap())
			end)
		else
			BroadcastMessage(VOTE_FAILED)
		end
	end
}

votingTypes["KickPlayer"] = {
	Description = "Kick ",
	Callback = function(state)
		local positive, negative = countVotes(state)
		print(string.format("There were %d positive and %d negative votes!", positive, negative))
		if positive > negative then
			BroadcastMessage(VOTE_SUCCESS_KICK)
			HL2CR_Voting.ShouldKick = true
		else
			BroadcastMessage(VOTE_FAILED)
		end
	end
}

local UPDATE_DIFF_MESSAGE = {
	[1] = "Very Easy",
	[2] = "Easy",
	[3] = "Medium",
	[4] = "Hard",
	[5] = "Very Hard",
}

votingTypes["VoteVEasy"] = {
	Description = "Set Difficulty to 'Very Easy'?",
	Callback = function(state)
		local positive, negative = countVotes(state)
		print(string.format("There were %d positive and %d negative votes!", positive, negative))
		if positive > negative then
			GetConVar("hl2cr_difficulty"):SetInt(1)
			BroadcastMessage(VOTE_DIFF .. UPDATE_DIFF_MESSAGE[GetConVar("hl2cr_difficulty"):GetInt()])
		else
			BroadcastMessage(VOTE_FAILED)
		end
	end
}
votingTypes["VoteEasy"] = {
	Description = "Set Difficulty to 'Easy'?",
	Callback = function(state)
		local positive, negative = countVotes(state)
		print(string.format("There were %d positive and %d negative votes!", positive, negative))
		if positive > negative then
			GetConVar("hl2cr_difficulty"):SetInt(2)
			BroadcastMessage(VOTE_DIFF .. UPDATE_DIFF_MESSAGE[GetConVar("hl2cr_difficulty"):GetInt()])
		else
			BroadcastMessage(VOTE_FAILED)
		end
	end
}
votingTypes["VoteMedium"] = {
	Description = "Set Difficulty to 'Medium'?",
	Callback = function(state)
		local positive, negative = countVotes(state)
		print(string.format("There were %d positive and %d negative votes!", positive, negative))
		if positive > negative then
			GetConVar("hl2cr_difficulty"):SetInt(3)
			BroadcastMessage(VOTE_DIFF .. UPDATE_DIFF_MESSAGE[GetConVar("hl2cr_difficulty"):GetInt()])
		else
			BroadcastMessage(VOTE_FAILED)
		end
	end
}
votingTypes["VoteHard"] = {
	Description = "Set Difficulty to 'Hard'?",
	Callback = function(state)
		local positive, negative = countVotes(state)
		print(string.format("There were %d positive and %d negative votes!", positive, negative))
		if positive > negative then
			GetConVar("hl2cr_difficulty"):SetInt(4)
			BroadcastMessage(VOTE_DIFF .. UPDATE_DIFF_MESSAGE[GetConVar("hl2cr_difficulty"):GetInt()])
		else
			BroadcastMessage(VOTE_FAILED)
		end
	end
}
votingTypes["VoteVHard"] = {
	Description = "Set Difficulty to 'Very Hard'?",
	Callback = function(state)
		local positive, negative = countVotes(state)
		print(string.format("There were %d positive and %d negative votes!", positive, negative))
		if positive > negative then
			GetConVar("hl2cr_difficulty"):SetInt(5)
			BroadcastMessage(VOTE_DIFF .. UPDATE_DIFF_MESSAGE[GetConVar("hl2cr_difficulty"):GetInt()])
		else
			BroadcastMessage(VOTE_FAILED)
		end
	end
}

votingTypes["Custom"] = {
	Description = "[Custom text should be here]",
	Callback = function(state)
		local positive, negative = countVotes(state)
		print(string.format("There were %d positive and %d negative votes!", positive, negative))
	end
}

votingTypes["BeginHL2"] = {
	Description = "Start Half-Life 2?",
	Callback = function(state)
		local positive, negative = countVotes(state)
		print(string.format("There were %d positive and %d negative votes!", positive, negative))
		if positive > negative then
			BroadcastMessage(VOTE_SUCCESS_HL2)
			BroadcastSound("hl2cr/begin_game.wav")
			timer.Simple(10, function()
				RunConsoleCommand("ChangeLevel", "d1_trainstation_01")
			end)
		else
			BroadcastMessage(VOTE_FAILED)
		end
	end
}

if SERVER then

	HL2CR_Voting = HL2CR_Voting or {}

	HL2CR_Voting.nextVoteTime = 180 + CurTime()
	HL2CR_Voting.CurVote = nil
	---Start a new vote initiated by some player.
	---@param ply GPlayer
	---@param voteTypeKey string
	
	HL2CR_Voting.KickUser = nil
	HL2CR_Voting.ShouldKick = false
	
	function HL2CR_Voting:StartVote(ply, voteTypeKey)
		-- If there is already a state, there is a vote in progress.
		if self.State then
			ply:ChatPrint("A vote is currently in progress!")
			return
		end

		-- Get the vote type object.
		local voteType = votingTypes[voteTypeKey]
		
		-- Check if type exists.
		if not voteType then
			ply:ChatPrint(string.format("Unknown vote type %q!", voteTypeKey))
			return
		end

		-- (Re)set internal and global vote state.
		self.State = {
			Creator = ply,
			VoteTypeKey = voteTypeKey,
			Voters = {}, -- Table of players containing their votes and maybe some other data.
			CustomDesc = voteType["Description"]
		}

		-- Broadcast new vote to all players.
		self:SendToAll()

		-- Issue a vote for the creator.
		self:PlayerVote(ply, true)
		
		self.CurVote = voteType
		
		if not timer.Exists("HL2CR_ServerVoteTimer") then
			timer.Create("HL2CR_ServerVoteTimer", 30, 1, function() 
				net.Start("HL2CR_EndVote")
				net.Broadcast()
				self:EndVote()
				self.nextVoteTime = 180 + CurTime()				
			end)
		end
	end
	
	function HL2CR_Voting:ServerStartVote(voteTypeKey)
		-- If there is already a state, there is a vote in progress.
		if self.State then
			print("A vote is currently in progress!")
			return
		end

		-- Get the vote type object.
		local voteType = votingTypes[voteTypeKey]
		
		-- Check if type exists.
		if not voteType then
			print(string.format("Unknown vote type %q!", voteTypeKey))
			return
		end

		-- (Re)set internal and global vote state.
		self.State = {
			Creator = ply,
			VoteTypeKey = voteTypeKey,
			Voters = {}, -- Table of players containing their votes and maybe some other data.
			CustomDesc = voteType["Description"]
		}

		-- Broadcast new vote to all players.
		self:SendToAll()
	
		self.CurVote = voteType
		
		if not timer.Exists("HL2CR_ServerVoteTimer") then
			timer.Create("HL2CR_ServerVoteTimer", 30, 1, function() 
				net.Start("HL2CR_EndVote")
				net.Broadcast()
				self:EndVote()
				self.nextVoteTime = 180 + CurTime()
			end)
		end
	end
	
	function HL2CR_Voting:StartKickVote(ply, voteTypeKey, target)
		-- If there is already a state, there is a vote in progress.
		if self.State then
			ply:ChatPrint("A vote is currently in progress!")
			return
		end

		-- Get the vote type object.
		local voteType = votingTypes[voteTypeKey]
		
		-- Check if type exists.
		if not voteType then
			ply:ChatPrint(string.format("Unknown vote type %q!", voteTypeKey))
			return
		end

		HL2CR_Voting.KickUser = target

		-- (Re)set internal and global vote state.
		self.State = {
			Creator = ply,
			VoteTypeKey = voteTypeKey,
			Voters = {}, -- Table of players containing their votes and maybe some other data.
			CustomDesc = voteType["Description"] .. target:Nick() .. "?"
		}

		-- Broadcast new vote to all players.
		self:SendToAll()

		-- Issue a vote for the creator.
		self:PlayerVote(ply, true)
		
		self.CurVote = voteType
		
		if not timer.Exists("HL2CR_ServerVoteTimer") then
			timer.Create("HL2CR_ServerVoteTimer", 30, 1, function() 
				net.Start("HL2CR_EndVote")
				net.Broadcast()
				self:EndVote()
				self.nextVoteTime = 180 + CurTime()
				
				timer.Simple(1, function()
					if HL2CR_Voting.ShouldKick then
						target:Kick("You have been voted off")
					end
				end)
			end)
		end
	end
	
	function HL2CR_Voting:CustomVote(ply, desc)
		-- If there is already a state, there is a vote in progress.
		if self.State then
			ply:ChatPrint("A vote is currently in progress!")
			return
		end
		
		local voteType = votingTypes["Custom"]
		
		-- Check if type exists.
		if not voteType then
			ply:ChatPrint(string.format("Unknown vote type %q!", "Custom"))
			return
		end
		
		-- (Re)set internal and global vote state.
		self.State = {
			Creator = ply,
			VoteTypeKey = "Custom",
			Voters = {}, -- Table of players containing their votes and maybe some other data.
			CustomDesc = desc
		}

		-- Broadcast new vote to all players.
		self:SendToAll()
		
		self.CurVote = voteType
		
		if not timer.Exists("HL2CR_ServerVoteTimer") then
			timer.Create("HL2CR_ServerVoteTimer", 30, 1, function() 
				net.Start("HL2CR_EndVote")
				net.Broadcast()
				self:EndVote()
				self.nextVoteTime = 180 + CurTime()
			end)
		end
	end

	---Stop the vote prematurely, discarding any result.
	function HL2CR_Voting:StopVote()
		if self.State == nil then return end
		self.State = nil

		-- Broadcast closed vote to all players. This will not send the result of the vote.
		self:SendToAll()
		
		if timer.Exists("HL2CR_ServerVoteTimer") then
			timer.Remove("HL2CR_ServerVoteTimer")
		end
		
		BroadcastMessage(VOTE_FAILED_ADMIN)
	end
	
	---End the vote in a normal way.
	function HL2CR_Voting:EndVote()
		-- Call the callback for the vote type.
		if self.CurVote and self.CurVote.Callback then self.CurVote.Callback(self.State) end

		-- Reset vote state.
		self.State = nil

		-- Broadcast closed vote to all players. This will not send the result of the vote.
		self:SendToAll()
	end

	---Issues a vote for the given player.
	---@param ply GPlayer
	---@param status boolean
	function HL2CR_Voting:PlayerVote(ply, status)
		--If no vote is in progress, stop here
		if not self.State then return end
		
		-- Stupid linear search to check if the player already voted.
		for _, voter in ipairs(self.State["Voters"]) do
			if voter.Player == ply then
				ply:ChatPrint(string.format("You have already voted!"))
				return
			end
		end

		-- Add a new vote to the state.
		table.insert(self.State["Voters"], {
			Player = ply,
			Status = status,
		})

		-- Broadcast new vote state to all players.
		self:SendToAll()
	end

	---Internal function for broadcasting the current vote state to all players.
	function HL2CR_Voting:SendToAll()
		if self.State then
			-- There is a voting state, vote is in progress.
			net.Start("HL2CR_Vote")
				net.WriteString(self.State["VoteTypeKey"])
				net.WriteTable(self.State["Voters"])
				
				net.WriteString(self.State["CustomDesc"])
			net.Broadcast()
		else
			-- There is no voting state. Tell the client to close all panels and stuff.
			net.Start("HL2CR_EndVote")
			net.Broadcast()
		end
	end
end

if CLIENT then

	HL2CR_ClientVoter = HL2CR_ClientVoter or {}
	
	local totalVotes = {
		["yes"] = 0,
		["no"] = 0
	}
	
	function HL2CR_ClientVoter:StartOrUpdate(state)
		self:End()

		-- Get the vote type object.
		local voteType = votingTypes[state.VoteTypeKey]
		if not voteType then
			error(string.format("This shouldn't happen, there is no corresponding vote type for %q!", state.VoteTypeKey))
		end
		
		if state.CustomDesc then
			voteType.Description = state.CustomDesc
		end
		
		self.VoteFrame = vgui.Create("DFrame")
		self.VoteFrame:SetVisible(true)
		self.VoteFrame:ShowCloseButton(false)
		self.VoteFrame:SetTitle("")
		self.VoteFrame:SetDraggable(false)
		self.VoteFrame:SetSize(350, 300)
		self.VoteFrame:SetPos(20, ScrH() / 2 - 200)
		self.VoteFrame.Paint = function(pnl, w, h)
			surface.SetDrawColor(0, 0, 0, 185)
			surface.DrawRect(0, 0, w, h)
		end

		self.Title = vgui.Create("DLabel", self.VoteFrame)
		self.Title:SetText(voteType.Description)
		self.Title:SetFont("HL2CR_VoteTitle")
		self.Title:SetPos(0, 0)
		self.Title:SizeToContents()

		self.Instructions = vgui.Create("DLabel", self.VoteFrame)
		self.Instructions:SetText("F1 = Yes | F2 = No")
		self.Instructions:SetPos(75, 50)
		self.Instructions:SetFont("HL2CR_VoteFont")
		self.Instructions:SizeToContents()
		
		self.VoterPnl = vgui.Create("DPanel", self.VoteFrame)
		self.VoterPnl:SetSize(250, 125)
		self.VoterPnl:SetPos(50, 100)
		self.VoterPnl.Paint = function(pnl, w, h)
			surface.SetDrawColor(130, 130, 130, 200)
			surface.DrawRect(0, 0, w, h)
		end
		
		for k, voter in pairs(state.Voters) do	
			self.Voter = vgui.Create("AvatarImage", self.VoterPnl)
			self.Voter:SetSize(32, 32)
			self.Voter:SetPlayer(voter.Player, 64)
			self.Voter:SetPos(( (k-1) * 35), 0)

			self.VoteStat = vgui.Create("DImage", self.Voter)

			if voter.Status == true then
				self.VoteStat:SetImage("icon16/tick.png")
				surface.PlaySound("buttons/button15.wav")
			else
				self.VoteStat:SetImage("icon16/cross.png")
				surface.PlaySound("buttons/button16.wav")
			end

			self.VoteStat:SetSize(16, 16)
		end
	end

	function HL2CR_ClientVoter:End()
		if self.VoteFrame and IsValid(self.VoteFrame) then
			self.VoteFrame:Close()
		end
	end

	net.Receive("HL2CR_Vote", function(len)
		local state = {
			VoteTypeKey = net.ReadString(),
			Voters = net.ReadTable(),
			CustomDesc = net.ReadString(),
		}
		
		HL2CR_ClientVoter:StartOrUpdate(state)
	end)

	net.Receive("HL2CR_EndVote", function(len)
		HL2CR_ClientVoter:End()
		totalVotes["yes"] = 0
		totalVotes["no"] = 0
	end)
	
end