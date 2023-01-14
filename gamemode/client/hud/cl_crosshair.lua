
Crosshair = {}
--Crosshair.Enabled = Crosshair.Enabled or false
Crosshair.Size = 16


function Crosshair.Draw()
	local midx = ScrW() * 0.5
	local midy = ScrH() * 0.5
	local size = Crosshair.Size
	if Client_Config.NewCross then
	    surface.SetDrawColor( 220, 220, 220, 255 ) 
		surface.DrawLine( midx - size, midy, midx- size * 0.2, midy)
		surface.DrawLine( midx + size, midy, midx+ size * 0.2, midy)
		surface.DrawLine( midx , midy - size, midx, midy - size * 0.2)
		surface.DrawLine( midx , midy + size, midx, midy + size * 0.2)
	    surface.SetDrawColor( 50, 50, 50, 255 ) 
		surface.DrawLine( midx - size, midy+1, midx- size * 0.2, midy+1)
		surface.DrawLine( midx + size, midy+1, midx+ size * 0.2, midy+1)
		surface.DrawLine( midx +1 , midy - size, midx+1, midy - size * 0.2)
		surface.DrawLine( midx +1 , midy + size, midx+1, midy + size * 0.2)
		--surface.DrawLine( midx, midy, midx, midy)
	end
end
hook.Add("HUDPaint", "Crosshair.Draw", Crosshair.Draw)


local function ToggleNewCross()
	Crosshair.Enabled = !Crosshair.Enabled
end

concommand.Add( "hl2cr_newcross", ToggleNewCross, "Toggle on test crosshair", 0 )