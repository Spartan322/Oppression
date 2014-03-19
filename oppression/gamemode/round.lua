local Round = {}
Round.time = 0
Round.round = 0

local function CreateRoundBase()
    CreateConVar("opp_roundtime_seconds", "0")
    CreateConVar("opp_roundtime_mintues", "30")
    CreateConVar("opp_roundtime_hours", "0")
    CreateConVar("opp_mapchangerounds", "5")
    CreateConVar("opp_votemaps", "true")
    CreateConVar("opp_round_prepare", "true")
    CreateConVar("opp_preparetime_seconds", "0")
    CreateConVar("opp_preparetime_mintues", "5")
    CreateConVar("opp_time_use_nice", "true")
    SetGlobalBool("opp_round_started", if (GetConVar("opp_round_prepare"):GetBool()) then false else true end)
    SetGlobalBool("opp_round_time_left", Round.time or 0)
    SetGlobalBool("opp_roundover", Round:IsRoundOver() or false)
end
hook.Add("Initialize", "SetupRound", CreateRoundBase)
local dtime = 0
local ptime = 0

if GetGlobalBool("opp_round_started") then
    dtime  = GetConVar("opp_roundtime_seconds"):GetInt()
    dtime += GetConVar("opp_roundtime_mintues"):GetInt() * 60
    dtime += GetConVar("opp_roundtime_hours"):GetInt() * 60 * 60
else
    ptime  = GetConVar("opp_preparetime_seconds"):GetInt()
    ptime += GetConVar("opp_preparetime_mintues"):GetInt() * 60
end

if Round.round <= 0 then
    Round.round = 1
    Round.time = dtime
end

Round.hasStarted = GetGlobalBool("opp_round_started")

local function Round:GetTime()
    return self.time
end

local function Round:NiceTime()
    if not GetConVar("opp_time_use_nice"):GetBool() then
    	return self.time
    else
    	local tim = self.time/60
    	local seconds = self.time % 60
    	return tim":"seconds
   	end
end

local function Round:SetTime(tim)
    self.time = tim
end

local function Round:AddTime(tim)
    self.time += tim
end

local function Round:DecreaseTime(tim)
	tim = tim * (-1)
	Round:AddTime(tim)
end

local function Round:SetRound(rounds)
    self.round = rounds
end

local function Round:AddRound(rounds)
    self.round += rounds
end

local function Round:GetRounds()
    return self.round
end

local function Round:IsRoundOver()
    if self:GetTime <= 0 then
        return true
        
    else
        return false
    end
end

function Round:IsPrepare()
    return not self.hasStarted
end

local function Round:NotRound()
    if self:IsPrepare or self:IsRoundOver then
        return true
    else
        return else
    end
end

--Prepare Round Section
Round.Prepare = {}
Round.Prepare.time = ptime

local function Round.Prepare:GetTime()
	return self.time
end

local function Round.Prepare:SetTime(tim)
	self.time = tim
end

local function Round.Prepare:AddTime(tim)
	self.time += tim
end

local function Round.Prepare:DecreaseTime(tim)
	tim = tim * (-1)
	self:AddTime(tim)
end

--End of Prepare Round Section


--End Round Section
Round.End = {}
Round.End.time = 0

local function Round.End:SetTime(tim)
	self.time = tim
end

--End of End Round Section

function GetRoundTable()
	return Round
end

--Hook for Round End
function GM:RoundOver( round )
    if Round:IsRoundOver() then
    	print("Round Over.")
    	print("Preparing New Round...")
    	Round.Prepare:SetTime(ptime)
    	Round.End:SetTime(30)
    	SetGlobalBool("opp_round_started", "false")
    end
end
hook.Add( "RoundCheck", "RoundOver", RoundOver )
function RoundCheck()
	if Round:IsRoundOver() then
		hook.Call( "RoundOver", GAMEMODE, Round.round )
	end
end
hook.Add("Think", "RoundCheck", RoundCheck)
--Hook Over

if Round:GetRounds == GetConVar("opp_mapchangerounds"):GetInt() and Round:NotRound then
    if GetConVar("opp_votemaps"):GetBool() then
        print("Map Vote coming soon")
    else
        print("Map Change coming soon")
    end
end
