AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
AddCSLuaFile("database/cl_database")

include( "shared.lua" )
include( "player.lua" )
include( "database/database.lua" )
include( "./addons/addons-API.lua" )

function GM:PlayerConnect( name, ip )
	print(name .. " has requested to join game")
end

function GM:PlayerInitialSpawn( ply )
	print(ply:Nick() .. "'s entity has spawned for the first time on this map.")
	con:AddText(ply:Nick() .. "'s entity has spawned for the first time on this map at " .. con:GetRoundTime())
	ply:SetGamemodeTeam( 0 )
end

function GM:PlayerSpawn( ply )

	ply:SetTeamDefaultModel(ply:Team())
	ply:SetTeamWeapons()
	con:AddText(ply:Nick() .. " has respawned at " .. con:GetRoundTime())
end

function GM:PlayerAuthed( ply, steamID, uniqueID )
	print(ply:Nick() .. " has been proven as a valid team account for Garry's Mod")
	ply:databaseCheck()
end

function GM:PlayerDisconnected( ply )
	ply:databaseDisconnect()
end
