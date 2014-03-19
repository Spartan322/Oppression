teams = {}

teams[TEAM_CIVIL] = {name = "Civilians", color = Vector(0/255,255/255,0/255), dweapons = {"weapon_crowbar"}}
teams[TEAM_FEDS] = {name = "Federal Agents", color = Vector(0/255,0/255,255/255), dweapons = {"weapon_pistol", "weapon_smg1"}}
teams[TEAM_RESIS] = {name = "Resistance", color = Vector(255/255,0/255,0/255), dweapons = {"weapon_crowbar"}}
teams[100] = {name = "Spectator", color = Vector(0/255,255/255,255/255), dweapons = {}}

function ply:SetGamemodeTeam( n )
  if not teams[n] then n = 100 end

  self:SetTeam( n )

  if resistanceColored then
    self:SetPlayerColor( teams[n].color )
  elseif not teams[n].name == "Resistance" then
    self:SetPlayerColor( teams[n].color )
  end
  
  if n == 100 then
    self:Spectate()
    return true
  end
  self:SetTeamWeapons()
  

  return true
end

function ply:SetTeamWeapons()
  local n = self:Team()
  self:StripWeapons()

  for k, wep in pairs(teams[n].dweapons) do
    local weps = self:Give(wep)
    weps = weps:GetPrimaryAmmoType()
    self:GiveAmmo(100,weps, true)
    end
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
