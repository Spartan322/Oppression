local addon = {}
addon.amount = 1
addon.new = {}



function AddAddon(name)
	addon.new[addon.amount+1] = name
end

function GetRoundTime()
	return Round:GetTime()
end

function GetCurrentRound()
	return Round:GetRound()
end

function GetAddons()
	local files, directories = file.Find("gamemode/oppression/addons/*.lua", "GAME")
	if directories then
		for _,v in pairs(directories) do
			AddAddon(directories[v])
			local innerfiles, innerdirectories = file.Find("gamemode/oppression/addons/" .. directories[v], "GAME")
			if innerfiles and innerdirectories then
				include(directories[v] .. "/base/init")
			end
		end
	end
end
				
