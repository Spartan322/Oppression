local ply = FindMetaTable("Player")

local teams = {}

teams[TEAM_CIVIL] = {name = "Civilians", color = Vector(0/255,255/255,0/255), dweapons = {"weapon_crowbar"}}
teams[TEAM_FEDS] = {name = "Federal Agents", color = Vector(0/255,0/255,255/255), dweapons = {"weapon_pistol", "weapon_smg1"}}
teams[TEAM_RESIS] = {name = "Resistance", color = Vector(255/255,0/255,0/255), dweapons = {"weapon_crowbar"}}

function ply:SetGamemodeTeam( n )
	if not teams[n] then return end
	
	self:SetTeam( n )
	
	if resistanceColored then
		self:SetPlayerColor( teams[n].color )
	elseif not teams[n].name == "Resistance" then 
		self:SetPlayerColor( teams[n].color )
	end
	
	self:SetTeamWeapons()
	
	return true
end

function ply:SetTeamWeapons()
	local n = self:Team()
	self:StripWeapons()
	
	for k, wep in pairs(teams[n].dweapons) do
		self:Give(wep)
		local weps = string.gsub(wep,"weapon_","")
		self:GiveAmmo(100,weps)
	end
end

function ply:SetTeamDefaultModel( n )
	if ply:DetermineModel() == true then
		if ply:Team() == TEAM_CIVIL then
			ply:SetModel("models/player/group01/male_07.mdl")
		elseif ply:Team() == TEAM_FEDS then
			ply:SetModel("models/player/combine_soldier_prisonguard.mdl")
		elseif ply:Team() == TEAM_RESIS then
			ply:SetModel("models/player/guerilla.mdl")
		end
	else
		ply:SetModel(ply:DetermineModel())
	end
end

function ply:Rank()
	local currents = self:databaseGetValue("currents")
	return currents.rank
end

function ply:DetermineModel()
	local te = ply:Team()
	local ra = ply:Rank()
	if te == TEAM_FEDS then
		if ra <= 2 then 
			return true
		elseif ra == 3 then
			return true
		elseif ra > 3 and ra < 7 then
			return true
		elseif ra == 7 then
			return true
		elseif ra == 8 then
			return true
		else
			return true
		end
	elseif te == TEAM_RESIS then
		if ra <= 3 then
			return true
		elseif ra == 4 then
			return true
		elseif ra >= 5 and ra < 7 then
			return true
		elseif ra == 7 then
			return true
		else
			return true
		end
	else
		return true
	end
end