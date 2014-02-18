con = {}
con.text = ""
con.rtime = Round:GetTime()

function con:AddText(text)
	con.text += "[" .. con:GetRoundTime() .. "]" .. ": " .. text .. "\n"
end

function con:GetRoundTime()
	return con.rtime
end

function con:PrintText()
	print(con.text)
end

function con:EndText()
	print("================= Round Begin =================\n")
	print(con.text)
	print("================= Round End ================="\n)
end
