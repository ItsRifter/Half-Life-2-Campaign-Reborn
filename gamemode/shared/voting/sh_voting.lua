AddCSLuaFile()

---Helper function to get the postitive and negative votes from a voting state.
---@param state table
---@return integer positive
---@return integer negative
function countVotes(state)
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

if SERVER then

	HL2CR_Voting = HL2CR_Voting or {}

	HL2CR_Voting.CurVote = nil
	---Start a new vote initiated by some player.
	---@param ply GPlayer
	---@param voteTypeKey string
	
	HL2CR_Voting.KickUser = nil
	HL2CR_Voting.ShouldKick = false
	
	--function GM:ShowHelp(ply)
	--	HL2CR_Voting:PlayerVote(ply, true)
	--end
	
	--function GM:ShowTeam(ply)
	--	HL2CR_Voting:PlayerVote(ply, false)
	--end

	function HL2CR_Voting:StartVote(ply, voteTypeKey)
		-- If there is already a state, there is a vote in progress.
		local initator = ply or nil
		
		if self.State then
			return
		end

		-- Get the vote type object.
		local voteType = votingTypes[voteTypeKey]

		if not voteType then
			return
		end

		-- (Re)set internal and global vote state.
		self.State = {
			Creator = initator,
			VoteTypeKey = voteTypeKey,
			Voters = {}, -- Table of players containing their votes and maybe some other data.
			CustomDesc = voteType.Description
		}

		-- Broadcast new vote to all players.
		self:SendToAll()

		-- Issue a vote for the creator if there is one.
		if initator then
			self:PlayerVote(initator, true)
		end
		
		self.CurVote = voteType
		
		if not timer.Exists("HL2CR_ServerVoteTimer") then
			timer.Create("HL2CR_ServerVoteTimer", 30, 1, function() 
				net.Start("HL2CR_EndVote")
				net.Broadcast()
				self:EndVote()		
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
		
		BroadcastMessageToAll(HL2CR_RedColour, translate.Get("Vote_Stopped_Admin"))
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

				net.WriteString(translate.Get("Vote_Instructions"))
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
		
		self.VoteFrame = vgui.Create("DFrame")
		self.VoteFrame:SetVisible(true)
		self.VoteFrame:ShowCloseButton(false)
		self.VoteFrame:SetTitle("")
		self.VoteFrame:SetDraggable(false)
		self.VoteFrame:SetSize(250, 200)
		self.VoteFrame:SetPos(20, ScrH() / 2 - 100)
		self.VoteFrame.Paint = function(pnl, w, h)
			draw.RoundedBoxEx( 16, 0, 0, w, h, Color(255, 140, 50, 125), true, true, true, true)
		end

		self.VoteTitleFrame = vgui.Create("DPanel", self.VoteFrame)
		self.VoteTitleFrame:SetSize(self.VoteFrame:GetWide(), 30)
		self.VoteTitleFrame.Paint = function(pnl, w, h)
			draw.RoundedBoxEx( 16, 0, 0, w, h, Color(255, 170, 55), true, true, false, false)
		end

		self.Title = vgui.Create("DLabel", self.VoteFrame)
		self.Title:SetText(voteType.Description)
		self.Title:SetFont("hl2cr_voting_title")
		self.Title:SetPos(self.VoteFrame:GetWide() / 8, 0)
		self.Title:SetColor(Color(0, 0, 0))
		self.Title:SizeToContents()

		self.VoteFrame:SetSize(self.VoteFrame:GetWide() + #voteType.Description + 30, self.VoteFrame:GetTall())
		self.VoteTitleFrame:SetSize(self.VoteTitleFrame:GetWide() + #voteType.Description + 30, self.VoteTitleFrame:GetTall())

		self.Instructions = vgui.Create("DLabel", self.VoteFrame)
		self.Instructions:SetText(state.Instructions)
		self.Instructions:SetPos(self.VoteFrame:GetWide() / 6, 50)
		self.Instructions:SetFont("hl2cr_voting")
		self.Instructions:SetColor(Color(0, 0, 0))
		self.Instructions:SizeToContents()
		
		self.VoterPnl = vgui.Create("DPanel", self.VoteFrame)
		self.VoterPnl:SetSize(self.VoteFrame:GetWide(), self.VoteFrame:GetTall() - 75)
		self.VoterPnl:SetPos(0, self.VoteFrame:GetTall() - 125)
		self.VoterPnl.Paint = function(pnl, w, h)
			draw.RoundedBoxEx( 16, 0, 0, w, h, Color(255, 145, 0, 255), false, false, true, true)
		end
		
		local nextRow = 10
		local hasUppedRow = false

		for k, voter in pairs(state.Voters) do	
			self.Voter = vgui.Create("AvatarImage", self.VoterPnl)
			self.Voter:SetSize(38, 38)
			self.Voter:SetPlayer(voter.Player, 38)
			if k >= 5 and not hasUppedRow then
				nextRow = nextRow + 10
				hasUppedRow = true
			end

			self.Voter:SetPos(( (k-1) * 40), nextRow)

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
			Instructions = net.ReadString(),
		}
		
		HL2CR_ClientVoter:StartOrUpdate(state)
	end)

	net.Receive("HL2CR_EndVote", function(len)
		HL2CR_ClientVoter:End()
		totalVotes["yes"] = 0
		totalVotes["no"] = 0
	end)
	
end