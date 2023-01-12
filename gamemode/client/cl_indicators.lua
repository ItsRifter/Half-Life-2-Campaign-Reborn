surface.CreateFont( "Tahoma32", 
                    {
                    font    = "Tahoma",
                    size    = 32,
                    weight  = 500,
                    antialias = true,
					})
					
surface.CreateFont( "Tahoma24", 
                    {
                    font    = "Tahoma",
                    size    = 24,
                    weight  = 500,
                    antialias = true,
					})


local tblIndacators = tblIndacators or {}
--local intLifeTime = 2
--local intGravity = 0.02
--local intFriction = 1.1
--local intAlphaMul  = (255 / intLifeTime) * 2

local IndicatorType = {
	[0] = --Damage Numbers
	{
		LifeTime = 2,
		Gravity = 100,
		Friction = 0.2,
		Velocity = 30,
		Eject = 50,
		--AlphaMul = 2,
		Font = "Tahoma32"
	},
	[1] = --Short Alert
	{
		LifeTime = 3,
		Gravity = 0,
		Friction = 0.25,
		Velocity = 0,
		Eject = 20,
		--AlphaMul = 1,
		Font = "Tahoma24"
	}

}

for _, ty in pairs(IndicatorType) do
	ty.AlphaMul = (255 / ty.LifeTime) * 2
end


local function DrawIndacators()
	for _, tblInfo in pairs(tblIndacators) do
		local Type = IndicatorType[tblInfo.Type]
		local posIndicatorPos = tblInfo.Position:ToScreen()
		local clrDrawColor = GetColour(tblInfo.Col, tblInfo.Alpha)
		local clrDrawColorBoarder = Color(20, 20, 20, tblInfo.Alpha)
		draw.SimpleTextOutlined(tblInfo.Text , Type.Font, posIndicatorPos.x, posIndicatorPos.y, clrDrawColor, 1, 1, 1, clrDrawColorBoarder)	
		tblInfo.Alpha = math.Clamp((tblInfo.DieTime -CurTime())*Type.AlphaMul, 0, 255) --Apply Fade
		tblInfo.Velocity.z = tblInfo.Velocity.z - Type.Gravity * FrameTime() --Apply Gravity
		tblInfo.Velocity = tblInfo.Velocity - (tblInfo.Velocity * Type.Friction) * FrameTime()  --Apply Friction
		tblInfo.Position = tblInfo.Position + tblInfo.Velocity * FrameTime() --Set Postion based on Velocity
	end
end
hook.Add("HUDPaint", "DrawIndacators", DrawIndacators)

net.Receive("HL2CR_Indicator", function()
	
	local indic = {}
	indic.Text = net.ReadString()
	indic.Position = net.ReadVector()
	indic.Col = net.ReadUInt( 7 )
	indic.Type = net.ReadUInt( 5 )
	
	local Type = IndicatorType[indic.Type]
	
	indic.Velocity = Vector(math.random(-Type.Velocity, Type.Velocity), math.random(-Type.Velocity, Type.Velocity), Type.Eject)
	indic.Alpha = 255
	indic.DieTime = CurTime() + Type.LifeTime
	
	table.insert(tblIndacators, 1, indic)
	timer.Simple(Type.LifeTime, function() table.remove(tblIndacators, #tblIndacators) end)
end)