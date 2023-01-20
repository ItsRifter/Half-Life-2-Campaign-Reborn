
Crosshair = {}
--Crosshair.Enabled = Crosshair.Enabled or false
Crosshair.Size = 16

local cross = {
	[1] = function(midx,midy,size)	--Plus
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
	end,
	[2] = function(midx,midy,size)	--Circle
	    surface.SetDrawColor( 220, 220, 220, 255 ) 
		--local scale = Vector( size, size, 0 )
		size = size * 0.5
		--local segmentdist = 360 / ( 2 * math.pi * math.max( size, size ) / 2 )
		local segmentdist = 22.5
 
		for a = 0, 360 - segmentdist, segmentdist do
			surface.DrawLine( midx + math.cos( math.rad( a ) ) * size, midy - math.sin( math.rad( a ) ) * size, midx + math.cos( math.rad( a + segmentdist ) ) * size, midy - math.sin( math.rad( a + segmentdist ) ) * size )
		end
		
		surface.SetDrawColor( 50, 50, 50, 255 ) 
		--local scale = Vector( size, size, 0 )
		size = size -1
		for a = 0, 360 - segmentdist, segmentdist do
			surface.DrawLine( midx + math.cos( math.rad( a ) ) * size, midy - math.sin( math.rad( a ) ) * size, midx + math.cos( math.rad( a + segmentdist ) ) * size, midy - math.sin( math.rad( a + segmentdist ) ) * size )
		end
	end,
	[3] = function(midx,midy,size)	--Bars
	    surface.SetDrawColor( 220, 220, 220, 255 ) 
		surface.DrawLine( midx - size, midy- size * 0.1, midx- size * 0.2, midy- size * 0.1)
		surface.DrawLine( midx + size, midy- size * 0.1, midx+ size * 0.2, midy- size * 0.1)
		surface.DrawLine( midx - size, midy+ size * 0.1, midx- size * 0.2, midy+ size * 0.1)
		surface.DrawLine( midx + size, midy+ size * 0.1, midx+ size * 0.2, midy+ size * 0.1)
	    surface.SetDrawColor( 50, 50, 50, 255 ) 
		surface.DrawLine( midx - size, midy- size * 0.1+1, midx- size * 0.2, midy- size * 0.1+1)
		surface.DrawLine( midx + size, midy- size * 0.1+1, midx+ size * 0.2, midy- size * 0.1+1)
		surface.DrawLine( midx - size, midy+ size * 0.1+1, midx- size * 0.2, midy+ size * 0.1+1)
		surface.DrawLine( midx + size, midy+ size * 0.1+1, midx+ size * 0.2, midy+ size * 0.1+1)
	end,
	}

function Crosshair.Draw()
	local midx = ScrW() * 0.5
	local midy = ScrH() * 0.5
	local size = Crosshair.Size
	if Client_Config.NewCross then
		if cross[Client_Config.CrossType] then
			cross[Client_Config.CrossType](midx,midy,size)
	    end
		--surface.SetDrawColor( 220, 220, 220, 255 ) 
		--surface.DrawLine( midx - size, midy, midx- size * 0.2, midy)
		--surface.DrawLine( midx + size, midy, midx+ size * 0.2, midy)
		--surface.DrawLine( midx , midy - size, midx, midy - size * 0.2)
		--surface.DrawLine( midx , midy + size, midx, midy + size * 0.2)
	    --surface.SetDrawColor( 50, 50, 50, 255 ) 
		--surface.DrawLine( midx - size, midy+1, midx- size * 0.2, midy+1)
		--surface.DrawLine( midx + size, midy+1, midx+ size * 0.2, midy+1)
		--surface.DrawLine( midx +1 , midy - size, midx+1, midy - size * 0.2)
		--surface.DrawLine( midx +1 , midy + size, midx+1, midy + size * 0.2)
		--surface.DrawLine( midx, midy, midx, midy)
	end
end
hook.Add("HUDPaint", "Crosshair.Draw", Crosshair.Draw)


local function ToggleNewCross()
	Crosshair.Enabled = !Crosshair.Enabled
end

concommand.Add( "hl2cr_newcross", ToggleNewCross, "Toggle on test crosshair", 0 )