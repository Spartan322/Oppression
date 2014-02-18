GM.Name = "Oppression"
GM.Author = "Spartan322"
GM.Email = "Spartan322@Live.com"
GM.Website = "BaricadeGames.weebly.com"

oppress = {name = "Oppression", version = "0.1.0"}

--Team Designation
TEAM_CIVIL = 0
TEAM_FEDS = 1
TEAM_RESIS = 2

team.SetUp( TEAM_CIVIL , "Civilians", Color(0,255,0) )
team.SetUp( TEAM_FEDS , "Federal Agents", Color(0,0,255) )
team.SetUp( TEAM_RESIS , "Resistance", Color(255,0,0) )

function GM:Initialize()
	GetAddons()
	self.BaseClass.Initialize( self )
	print("Gamemode" .. oppress.name .."Version" .. oppress.version .. "started up")
end 
