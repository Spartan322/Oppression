local ply = FindMetaTable("Player")

include( "teams.lua" )

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
