AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "vgui/*.lua" )
AddCSLuaFile("database/cl_database")

include( "shared.lua" )
include( "player.lua" )
include( "database/database.lua" )
include( "round.lua" )
include( "console/lua" )

function GM:PlayerConnect( name, ip )
	print(name .. " has requested to join game")
end

function GM:PlayerInitialSpawn( ply )
	con:AddText(ply:Nick() .. "'s entity has spawned for the first time on this map change")
	ply:SetGamemodeTeam( 0 )
end

function GM:PlayerSpawn( ply )

	ply:SetTeamDefaultModel(ply:Team())
	ply:SetTeamWeapons()
	con:AddText(ply:Nick() .. " has respawned")
end

function GM:PlayerAuthed( ply, steamID, uniqueID )
	print(ply:Nick() .. " has been proven as a valid steam account for Garry's Mod")
	con:AddText(ply:Nick() .. " validated")
	ply:databaseCheck()
end

function GM:PlayerDisconnected( ply )
	ply:databaseDisconnect()
	con:AddText(ply:Nick() .. " disconnected from the server")
end
