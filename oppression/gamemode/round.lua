Round = {}
Round.time = 0
Round.round = 0

Round:GetTime()
    return self.time
end

Round:SetTime(time)
    self.time = time
end

Round:AddTime(time)
    self.time += time
end

Round:SetRound(rounds)
    self.round = rounds
end

Round:AddRound(rounds)
    self.round += rounds
end
