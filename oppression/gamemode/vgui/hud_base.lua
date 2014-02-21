function hidehud(name) -- Removing the default HUD
	for k, v in pairs({"CHudHealth", "CHudBattery", "CHudAmmo", "CHudSecondaryAmmo", })do
		if name == v then return false end
	end
end
hook.Add("HUDShouldDraw", "HideOurHud:D", hidehud)

function DrawBaseHealthBar()
  	local ply = LocalPlayer()
  	local He = ply:Health()
  
	surface.CreateFont( 
		"OPPbasefont",
	{
		font = "ScoreboardText",
		size = 60,
		weight = 400,
		antialias = false,
		shadow = false
	})
  
  	draw.RoundedBox( 4, 120, ScrH() - 110, 300, 90, Color( 10, 10, 10, 255 ) )
  	draw.RoundedBox( 4, 130, ScrH() - 100, 200, 40, Color( 25, 30, 35, 80 ) )
	draw.RoundedBox( 4, 130, ScrH() - 100, math.Clamp( He, 0, 200 )*2, 40, Color( 140, 80, 60, 200 ) )
  	draw.RoundedBox( 4, 130, ScrH() - 100, math.Clamp( He, 0, 200 )*2, 40, Color( 255, 60, 20, 60 ) )
  	
  	draw.DrawText( "Health:"..He, "OPPbasefont", 115, ScrH() - 90,  Color( 140, 80, 60, 200 ) ) 
end
hood.Add("HUDPaint", "DrawBaseHealthBar", DrawBaseHealthBar)
