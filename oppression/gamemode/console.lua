con = {}
con.text = ""
con.rtime = GetRoundTable():GetTime()

function con:AddText(text)
	con.text += "Oppression : [" .. con:GetRoundTime() .. "]" .. ": " .. text .. "\n"
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
hook.Add("RoundOver", "EndPrint", con:EndText())
