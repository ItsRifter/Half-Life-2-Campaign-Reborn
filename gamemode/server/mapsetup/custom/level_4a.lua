Custom_NextMap = "level_4b"
Custom_ExpMul = 1

Custom_triggers = {
	["checkpoints"] = {
		[1] = {
			[1] = Vector(3974, 1473, 133), 		
			[2] = Vector(4501, 1339, 298)
		},
		[2] = {
			[1] = Vector(3710, 2686, 0), 		
			[2] = Vector(3389, 2594, 135)
		},
		[3] = {
			[1] = Vector(1794, 1627, -244), 		
			[2] = Vector(1534, 1451, -150)
		}
	},

	["checkpoint_spot"] = {
		[1] = Vector(4618, 1554, 132), 	
		[2] = Vector(3597, 2575, 24),
		[3] = Vector(1673, 1523, -250)
	},

	["checkpoint_angle"] = {
		[1] = Angle(0,0,0),
		[2] = Angle(0,0,0),
		[3] = Angle(0,-90,0)
	},

	["checkpoint_functions"] = {
		[1] = function()
			ents.FindByName("whirly_build_fan_phys")[1]:Fire("EnableMotion")
		end,
		[3] = function()
		CreateLevelChange(Vector(1417, 622, 43),Vector(1408, 128, -126),nil)
		end
	}
}
function Custom_Startup()
	--for k, v in ipairs(ents.FindByClass("trigger_changelevel")) do
	--	v:Remove()
	--end
	RemoveShopWeapons()
end

function Custom_Equipment()
	table.insert(SPAWNING_WEAPONS, "weapon_physcannon")
end