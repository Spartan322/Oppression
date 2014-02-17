local ply = FindMetaTable("Player")
util.AddNetworkString( "database" )

function ply:ShortSteamID()
	local id = self:SteamID()
	local id = tostring(id)
	local id = string.gsub(id, "STEAM_0:0:", "")
	local id = string.gsub(id, "STEAM_0:1:", "")
	return id
end

local oldPrint = print
local function print(s)
	oldPrint("Server database: " .. s)
end

function ply:databaseDefault()
	self:databaseSetValue( "skill", 0 )
	self:databaseSetValue( "points", 0 )
	self:databaseSetValue( "highestrank", 1 )
	local i = {}
	i["currents"] = { rank = 1 }
	self:databaseSetValue( "currents", i )
end

function ply:databaseNetworkedData()
	local skill = self:databaseGetValue( "skill" )
	local points = self:databaseGetValue( "points" )
	local highestrank = self:databaseGetValue( "highestrank" )
	self:SetNWInt("skill", skill)
	self:SetNWInt("points", points)
	self:SetNWInt("highestrank", highestrank)
	
	self:KillSilent()
	self:Spawn()
end

function ply:databaeFolders()
	return "server/oppression/players/" .. self:ShortSteamID() .. "/"
end

function ply:databasePath()
	return self:databaseFolders() .. "database.dat"
end

function ply:databaseSet( tab )
	self.database = tab
end

function ply:databaseGet()
	return self.database
end

function ply:databaseCheck()
	self.database = {}
	local f = self:databaseExists()
	if f then
		self:databaseRead()
	else
		self:databaseCreate()
	end
	self:databaseSend()
	self:databaseNetworkedData()
end


function ply:databaseSend()
	net.Start( "database" )
		net.WriteTable( self:databaseGet() )
	net.Send( self )
end

function ply:databaseExists()
	local f = file.Exists(self:databasePath(), "DATA")
	return f
end

function ply:databaseRead()
	local str = file.Read(self:databasePath(), "DATA")
	self:databaseSet( util.KeyValuseToTable(str) )
end

function ply:databaseSave()
	local str = utilTableToKeyValuse(self.database)
	local f = fileWrite(self:databasePath(), str)
	self:databaseSend()
end

function ply:databaseCreate()
	self:databaseDefault
	local b = fileCreate( self:databaseFolders )
	self:databaseSave()
end

function ply:databaseDisconnect()
	self:databaseSave
end

function ply:databaseSetValue( name, v )
	if not v then return end

	if type(v) == "table" then
		if name == "currents" then
			for k,b in pairs(v) do
				if b.rank <= 1 then
					v[k] = nil
				end
			end
		end
	end
	
	local d = self:databaseGet()
	d[name] = v
	
	sel:databaseSave()
end

function ply:databaseGetValue( name )
	local d = self:databaseGet()
	return d[name]
end