surface.CreateFont( "Tahoma32", 
                    {
                    font    = "Tahoma",
                    size    = 32,
                    weight  = 500,
                    antialias = true,
					})

local tblIndacators = tblIndacators or {}
local intLifeTime = 2
local intFadeRate = 1
local intGravity = 0.03
local intFriction = 1.2
local function DrawIndacators()
	for _, tblInfo in pairs(tblIndacators) do
		local posIndicatorPos = tblInfo.Position:ToScreen()
		local clrDrawColor = GetColour(tblInfo.Col, tblInfo.Alpha)
		local clrDrawColorBoarder = Color(20, 20, 20, tblInfo.Alpha)
		draw.SimpleTextOutlined(tblInfo.Text , "Tahoma32", posIndicatorPos.x, posIndicatorPos.y, clrDrawColor, 1, 1, 1, clrDrawColorBoarder)	
		tblInfo.Alpha = math.Clamp(tblInfo.Alpha - intFadeRate, 0, 255) --Apply Fade
		tblInfo.Velocity.z = tblInfo.Velocity.z - intGravity --Apply Gravity
		tblInfo.Velocity = tblInfo.Velocity / intFriction --Apply Friction
		tblInfo.Position = tblInfo.Position + tblInfo.Velocity --Set Postion based on Velocity
	end
end
hook.Add("HUDPaint", "DrawIndacators", DrawIndacators)

net.Receive("HL2CR_Indicator", function()
	
	local indic = {}
	indic.Text = net.ReadString()
	indic.Position = net.ReadVector()
	indic.Col = net.ReadUInt( 7 )
	indic.Velocity = Vector(math.random(-3, 3), math.random(-3, 3), 3)
	indic.Alpha = 400
	
	table.insert(tblIndacators, 1, indic)
	timer.Simple(intLifeTime, function() table.remove(tblIndacators, #tblIndacators) end)
end)