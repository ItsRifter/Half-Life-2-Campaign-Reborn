Custom_NextMap = "metastasis_4b"
Custom_ExpMul = 1.25

Custom_triggers = {
	["checkpoints"] = {
		[1] = {
			[1] = Vector(-819,-1173,-10655), 		
			[2] = Vector(-1122,-1370,-10779)
		},
		[2] = {
			[1] = Vector(-952,-201,-3516), 		
			[2] = Vector(-792,-377,-3661)
		},
		[3] = {
			[1] = Vector(-709,-219,-551), 		
			[2] = Vector(-512,-387,-474)
		}
	},
	
	["checkpoint_spot"] = {
		[1] = Vector(-994,-1252,-10745),
		[2] = Vector(-870,-284,-3635),
		[3] = Vector(-673,-290,-545)
	},
	
	["checkpoint_angle"] = {
		[1] = Angle(0,0,0),
		[2] = Angle(0,0,0),
		[3] = Angle(0,0,0)
	},
	
	["checkpoint_functions"] = {

	},
	
	["changelevels"] = {
		[1] = Vector(-450,-1362,530),
		[2] = Vector(-346,-1261,346)
	},
	
	["changelevel_func"] = 
	function()
		MovePlayers(Vector(-392,-1316,451),Angle(0,0,0), false)
	end
	
}

function Custom_Startup()
	--MoveSpawns(Vector(-397,-1301,-100),Angle(0,270,0))
	
	CreateCustomTrigger(Vector(-1110,-2020,-10426),Vector(-949,-1912,-10504), function(ent)
		if ent:IsPlayer() then
			MoveSpawns(Vector(0,0,-40),Angle(0,270,0),"shaft-lift")
			MovePlayers(Vector(-1023,-1968,-10393),Angle(0,140,0), false,ent)
			return true	
		end
		return false
	end,0,true)
end

function Custom_Equipment()
	
	table.insert(SPAWNING_ITEMS, 
	{
		[1] = {
			["Type"] = "Armor",
			["Amount"] = 25,
		}
	})
end
