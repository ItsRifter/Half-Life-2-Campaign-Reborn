Custom_NextMap = "level_3"
Custom_ExpMul = 1

Custom_triggers = {
	["checkpoints"] = {
		[1] = {
			[1] = Vector(-7083, 3187, 63), 		
			[2] = Vector(-6963, 3200, 120)
		},
		[2] = {
			[1] = Vector(-3814, -1868, 41), 		
			[2] = Vector(-3964, -2204, 120)
		},
		[3] = {
			[1] = Vector(5537, -10615, -31), 		
			[2] = Vector(5658, -10494, -183)
		}
	},

	["checkpoint_spot"] = {
		[1] = Vector(-6970, 3186, 42), 	
		[2] = Vector(-3875, -1927, 47),
		[3] = Vector(5600, -10562, -167)
	},

	["checkpoint_angle"] = {
		[1] = Angle(0,90,0),
		[2] = Angle(0,90,0),
		[3] = Angle(0,90,0)
	},

	["checkpoint_functions"] = {
		[1] = function()
			timer.Simple(0.1, function()
				local cart = ents.FindByName("Tracktrain_1")[1]
				for l, spawn in pairs(ents.FindByClass("info_player_start")) do
					spawn:SetPos(cart:GetPos() + Vector(0, 0, 68))
					spawn:SetParent(cart)
				end
			end)
		end,
		[2] = function()
			for l, spawn in pairs(ents.FindByClass("info_player_start")) do
				spawn:SetParent(nil)
			end
			timer.Simple(0.1, function()
				local cart2 = ents.FindByName("Tracktrain_2")[1]
				for l, spawn in pairs(ents.FindByClass("info_player_start")) do
					spawn:SetPos(cart2:GetPos() + Vector(0, 0, 68))
					spawn:SetParent(cart2)
				end
			end)
		end,
		[3] = function()
			for l, spawn in pairs(ents.FindByClass("info_player_start")) do
				spawn:SetParent(nil)
			end
			CreateLevelChange(Vector(5524, -10794, -90),Vector(5680, -10794, -120),nil)
		end
	},
}
function Custom_Startup()
	for k, v in ipairs(ents.FindByClass("trigger_changelevel")) do
		v:Remove()
	end
	for k, spawn in ipairs(ents.FindByClass("info_player_start")) do 
		if k ~= 1 then
			spawn:Remove()
		end
	end
	ents.FindByName("RailTrack_Br_1")[1]:Fire("AddOutput", "OnPass hl2crlua:RunPassedCode:FailedMap()")
	ents.FindByName("RailTrack_Br_3")[1]:Fire("AddOutput", "OnPass hl2crlua:RunPassedCode:FailedMap()")
	ents.FindByName("CombineTrack_Br_2")[1]:Fire("AddOutput", "OnPass hl2crlua:RunPassedCode:FailedMap()")
	ents.FindByName("CombineTrack_Br_56")[1]:Fire("AddOutput", "OnPass hl2crlua:RunPassedCode:FailedMap()")
	ents.FindByName("CombineTrack_Br_147")[1]:Fire("AddOutput", "OnPass hl2crlua:RunPassedCode:FailedMap()")
end

function Custom_Equipment()
	table.insert(SPAWNING_WEAPONS, "weapon_physcannon")
end