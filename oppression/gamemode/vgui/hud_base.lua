local HUDbase = {}

--Fonts
surface.CreateFont( 
		"OPPbasefont",
	{
		font = "ScoreboardText",
		size = 60,
		weight = 400,
		antialias = false,
		shadow = false
	})
--Hide Hud function (found on Facepunch)
local function hidehud(name)
	for k, v in pairs({"CHudHealth", "CHudBattery", "CHudAmmo", "CHudSecondaryAmmo", })do
		if name == v then return false end
	end
end
hook.Add("HUDShouldDraw", "HideOurHud", hidehud)

HUDbase.ply = LocalPlayer()

--Draw Health Bar
local function HUDbase:DrawBaseHealthBar()
	if self.ply:IsAlive() then
  		local He = self.ply:Health()
  		local maxHealth = 100
  		
  		local healthBoxY = ScrH() - 100
  		local healthBoxH = 40
  
  		draw.RoundedBox( 4, 110, ScrH() - 80, 300, 150, Color( 10, 10, 10, 255 ) )
  		draw.RoundedBox( 4, 130, healthBoxY, 200, HealthBoxH, Color( 25, 30, 35, 80 ) )
		draw.RoundedBox( 4, 130, healthBoxY, math.Clamp( He, 0, 200 )*2, heathBoxH, Color( 140, 80, 60, 200 ) )
  		draw.RoundedBox( 4, 130, healthBoxY, math.Clamp( He, 0, 200 )*2, healthBoxH, Color( 255, 60, 20, 60 ) )
  	
  		draw.DrawText( "Health: "..maxHealth.."/"..He, "OPPbasefont", 115, helathBoxY - (healthBoxY/healthBoxH),  Color( 140, 80, 60, 200 ) ) 
	end
end

hood.Add("HUDPaint", "DrawBaseHealthBar", HUDbase:DrawBaseHealthBar)

--Draw Ammo Bar
local function HUDbase:DrawAmmoBar()
	if self.ply:GetActiveWeapon then
		local Clip = self.ply:GetActiveWeapon():Clip1()
		local MaxClip = ply:GetActiveWeapon().Primary.ClipSize
		local AmmoLeft = ply:GetActiveWeapon():Ammo1()
		
		local clipBoxXY = {130, ScrH() - 50}
		local reserveXY = {130, ScrH() - 20}
		local clipBoxH = 30
		local reserveBoxH = 15
		
		draw.RoundedBox( 4, clipBoxXY[1], clipBoxXY[2], math.Clamp( Clip, 0, 200 )*2, clipBoxH, Color( 140, 80, 60, 200 ) )
  		draw.RoundedBox( 4, clipBoxXY[1], clipBoxXY[2], math.Clamp( MaxClip, 0, 200 )*2, clipBoxH, Color( 255, 60, 20, 60 ) )
  	
  		draw.DrawText( "Clip: "..MaxClip.."/"..Clip, "OPPbasefont", 115, clipBoxXY[2] - (clipBoxXY[2]/clipBoxH),  Color( 140, 80, 60, 200 ) )
  	
  		draw.RoundedBox( 4, 130, ScrH() - 20, 200 *2, 15, Color( 140, 80, 60, 200 ) )
  	
  		draw.DrawText( "Reserve: "..AmmoLeft, "OPPbasefont", 115, reserveBoxXY[2] - (reserveBoxXY[2]/reseveBoxH),  Color( 140, 80, 60, 200 ) )
  	end
end

hook.Add("HUDPaint", "DrawAmmo", HUDbase:DrawAmmoBar)

