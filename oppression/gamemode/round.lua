Round = {}
Round.time = 0

Round:GetTime()
    return self.time
end

Round:SetTime(time)
    self.time = time
end

Round:AddTime(time)
    self.time += time
end
