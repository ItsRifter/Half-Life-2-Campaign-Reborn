Custom_NextMap = Lobby_map
Custom_ExpMul = 1

Custom_triggers = {
	["checkpoints"] = {
		[1] = {
			[1] = Vector(1534, -3070, -125), 		
			[2] = Vector(1022, -1432, -20)
		}
	},

	["checkpoint_spot"] = {
		[1] = Vector(1274, -3036, -104)
	},

	["checkpoint_angle"] = {
		[1] = Angle(0,130,0)
	}
}
function Custom_Startup()
	for k, v in ipairs(ents.FindByClass("trigger_changelevel")) do
		v:Remove()
	end
	ents.FindByName("strider_hit_count")[1]:Fire("AddOutput", "OnHitMax hl2crlua:RunPassedCode:FinishRnD():5:-1")
	RemoveShopWeapons()

	for _, ply in ipairs( player.GetAll() ) do
		timer.Simple(1, function()
			if ply:Alive() then
				ply:GodEnable()
			end
		end)
	end
end

function FinishRnD()
	for k, v in ipairs(player.GetAll()) do
		v:SetTeam(TEAM_COMPLETED_MAP)
		--v:GrantAchievement("Science Squared")
	end
	
	BroadcastMessageToAll(HL2CR_LevelupColour, translate.Get("Campaign_Finished_RnD"))
	
	StartFinalMapCountdown()
end

function Custom_Equipment()
	table.insert(SPAWNING_WEAPONS, "weapon_physcannon")
end