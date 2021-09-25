
local hitboxCurrentlyRendering = false
local zeroAngle = Angle(0, 0, 0)

local function HitboxRender()
	for _, ent in pairs(ents.GetAll()) do

		if ent:GetHitBoxGroupCount() == nil then continue end

		for group = 0, ent:GetHitBoxGroupCount() - 1 do
		    
		 	for hitbox=0, ent:GetHitBoxCount( group ) - 1 do

		 		local pos, ang =  ent:GetBonePosition( ent:GetHitBoxBone(hitbox, group) )
		 		local mins, maxs = ent:GetHitBoxBounds(hitbox, group)

				render.DrawWireframeBox( pos, ang, mins, maxs, Color(51, 204, 255, 255), true )
			end
		end

		render.DrawWireframeBox( ent:GetPos(), zeroAngle, ent:OBBMins(), ent:OBBMaxs(), Color(255, 204, 51, 255), true )
	end
end 

concommand.Add( "hl2cr_renderhitbox", function( ply, cmd, args, str)
	if not ply:IsAdmin() then return end

	if hitboxCurrentlyRendering then
		hook.Remove("PostDrawOpaqueRenderables", "HitboxRender")
		hitboxCurrentlyRendering = false
	else
		hook.Add("PostDrawOpaqueRenderables", "HitboxRender", HitboxRender )
		hitboxCurrentlyRendering = true
	end
end)