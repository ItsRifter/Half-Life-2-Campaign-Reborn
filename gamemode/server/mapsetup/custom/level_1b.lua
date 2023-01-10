Custom_NextMap = "level_2"
Custom_ExpMul = 1

Custom_triggers = {
	["checkpoints"] = {
		[1] = {
			[1] = Vector(2051, 1369, 61), 		
			[2] = Vector(2107, 1340, 328)
		},
		[2] = {
			[1] = Vector(2361, 4223, 256), 		
			[2] = Vector(2462, 4115, 132)
		},
		[3] = {
			[1] = Vector(1817, 4309, 230), 		
			[2] = Vector(1666, 4233, 130)
		},
		[4] = {
			[1] = Vector(3072, 4356, 132), 		
			[2] = Vector(2977, 4480, 263)
		},
		[5] = {
			[1] = Vector(3459, 3662, 128), 		
			[2] = Vector(3582, 3764, 0)
		},
		[6] = {
			[1] = Vector(3577, 3301, 4), 		
			[2] = Vector(3420, 3209, 112)
		},
	},

	["checkpoint_spot"] = {
		[1] = Vector(2083, 1683, 260), 		
		[2] = Vector(2459, 4167, 152),
		[3] = Vector(1708, 4299, 152),
		[4] = Vector(3036, 4423, 152),
		[5] = Vector(3494, 3696, 0),
		[6] = Vector(3500, 3259, 0)
	},

	["checkpoint_angle"] = {
		[1] = Angle(0,90,0),
		[2] = Angle(0,180,0),
		[3] = Angle(0,90,0),
		[4] = Angle(0,0,0),
		[5] = Angle(0,-90,0),
		[6] = Angle(0,-90,0)
	},

	/*["changelevels"] = {
		[1] = Vector(3372, 2213, -69),
		[2] = Vector(3410, 2337, 20)
	},*/

	["checkpoint_functions"] = {
		[6] = function()
			CreateLevelChange(Vector(3372, 2213, -69),Vector(3410, 2337, 20),nil)
		end
	},
}

function Custom_Startup()
	for k, v in ipairs(ents.FindByClass("trigger_changelevel")) do
		v:Remove()
	end

	ents.FindByName("conveyor_gas_hurt")[1]:Fire("AddOutput", "OnHurtPlayer hl2crlua:RunPassedCode:FailedMap()")

	for _, j in ipairs(ents.FindByName("kit_junk")) do -- the part, which fixes the crash, done by Rifter before.
		j:Remove()
	end
	
	for _, j in ipairs(ents.FindByName("KitCeilingDebris")) do
		j:Remove()
	end
	
	for _, j in ipairs(ents.FindByName("MicrowaveKitDissolver*")) do
		j:Remove()
	end
	
	ents.FindByName("MicrowaveKitCore")[1]:Remove()
	ents.FindByName("MicrowaveKitTable")[1]:Remove()
	ents.FindByName("KitchenDoorBreak1")[1]:Remove()
	ents.FindByName("KitchenDoorBreak2")[1]:Remove()
end