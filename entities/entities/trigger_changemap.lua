ENT.Base = "base_brush"
ENT.Type = "brush"

local achievement_items = {
	["models/props_c17/doll01.mdl"] = function()
		game.SetGlobalState("hl2cr_bringitem_whatbaby", GLOBAL_ON)
		BroadcastMessageToAll(HL2CR_AchNotifyColour, translate.Get("Achievement_HL2_WhatBaby_Name"), HL2CR_StandardColour, translate.Get("Achievement_Notify_Progress"))
		BroadcastSoundToAll("hl2cr/standardbeep.wav")
	end,

	["models/roller.mdl"] = function()
		if game.GetMap() == "d1_town_04" then
			for _, v in ipairs(player.GetAll()) do
				v:GrantAchievement("Ravenholm Ball")
			end
			
			game.SetGlobalState("hl2cr_bringitem_rollermine", GLOBAL_DEAD)
			return 
		end

		BroadcastMessageToAll(HL2CR_AchNotifyColour, translate.Get("Achievement_HL2_RavenBall_Name"), HL2CR_StandardColour, translate.Get("Achievement_Notify_Progress"))
		BroadcastSoundToAll("hl2cr/standardbeep.wav")
		game.SetGlobalState("hl2cr_bringitem_rollermine", GLOBAL_ON)
	end,
	
	["models/props_junk/gnome.mdl"] = function()
		BroadcastMessageToAll(HL2CR_AchNotifyColour, translate.Get("Achievement_EP2_Gnome_Name"), HL2CR_StandardColour, translate.Get("Achievement_Notify_Progress"))
		BroadcastSoundToAll("hl2cr/standardbeep.wav")
		game.SetGlobalState("hl2cr_bringitem_gnome", GLOBAL_ON)
	end
}

function ENT:Initialize()
	self:DrawShadow(false)
	self:SetCollisionBoundsWS(self.Min, self.Max)
	self:SetSolid(SOLID_BBOX)
	self:SetCollisionGroup(COLLISION_GROUP_WORLD)
	self:SetMoveType(0)
	self:SetTrigger(true)
end

function ENT:Touch(ent)	
	
	if achievement_items[ent:GetModel()] then
		achievement_items[ent:GetModel()]()
		ent:Remove()
	end
	
	if ent:IsValid() and ent:IsPlayer() and ent:Team() == TEAM_ALIVE then
		
		if self.Func then
			self.Func(ent)
		end

		ent:SetTeam(TEAM_COMPLETED_MAP)
		ent:Flashlight(false)

		BroadcastMessageToAll(HL2CR_PlayerColour, ent:Nick(), HL2CR_StandardColour, translate.Get("Player_CompletedMap"), string.FormattedTime(CurTime(), "%02i:%02i"))

		ent:DisplayResults()

		if ent:InVehicle() then
			ent:ExitVehicle()
			if ent.vehicle then
				ent.vehicle:Remove()
			end
		end

		ent:ToggleSpectator(true)
		ent:UpdateClass()
	end

	CheckPlayerCompleted()
end