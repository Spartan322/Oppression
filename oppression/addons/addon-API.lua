local addon = {}
addon.amount = 1
addon.new = {}
addon.functions = {}



function AddAddon(name)
	addon.new[addon.amount+1] = name
	addon.amount += 1
end

function GetRoundTime()
	return Round:GetTime()
end

function GetCurrentRound()
	return Round:GetRound()
end

function CreateAddonStart(name, func)
	addon.functions[addon.amount+1] = func
	AddAddon(name)
end

function RunAddonStart(addonID)
	return addon.functions[addonID]
end

function GetAddonName(id)
	return addon.new[id]
end

function GetAddonId(name)
	for _,v in pairs(addon.new) do
		if addon.new[v] == name
			return v
		end
	end
end

function GetAddons()
	print("Oppression Addon API started up.")
	print("Getting Addons...")
	local files, directories = file.Find("gamemode/oppression/addons/*.lua", "GAME")
	if directories then
		for _,v in pairs(directories) do
			AddAddon(directories[v])
			local innerfiles, innerdirectories = file.Find("gamemode/oppression/addons/" .. directories[v], "GAME")
			if innerfiles and innerdirectories then
				include(directories[v] .. "/base/init")
			end
			RunAddonStarts(v)
		end
	end

end
				
