ENT.Base = "base_brush"
ENT.Type = "brush"

local achievement_items = {
	["models/props_c17/doll01.mdl"] = function()
		game.SetGlobalState("hl2cr_bringitem_whatbaby", GLOBAL_ON)
	end,

	["models/roller.mdl"] = function()
		if game.GetMap() == "d1_town_04" then
			for _, v in ipairs(player.GetAll()) do
				v:GrantAchievement("Ravenholm Ball")
			end
			
			game.SetGlobalState("hl2cr_bringitem_rollermine", GLOBAL_DEAD)
		end
		game.SetGlobalState("hl2cr_bringitem_rollermine", GLOBAL_ON)
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
	
	if ent:GetClass() == "prop_physics" and achievement_items[ent:GetModel()] then
		achievement_items[ent:GetModel()]()
		ent:Remove()
	end
	
	if ent:IsValid() and ent:IsPlayer() and ent:Team() == TEAM_ALIVE then
		
		if self.Func then
			self.Func()
		end

		ent:SetTeam(TEAM_COMPLETED_MAP)
		
		BroadcastMessageToAll(HL2CR_PlayerColour, ent:Nick(), HL2CR_StandardColour, translate.Get("Player_CompletedMap"), string.FormattedTime(CurTime(), "%02i:%02i"))

		ent:DisplayResults()

		if ent:InVehicle() then
			ent:ExitVehicle()
			if ent.vehicle then
				ent.vehicle:Remove()
			end
		end

		ent:ToggleSpectator(true)
		ent:Flashlight(false)
	end

	CheckPlayerCompleted()
end