ModLuaFileAppend("data/scripts/gun/gun_actions.lua", "mods/nathan-alt_fire/files/scripts/gun_actions.lua")

local translations = ModTextFileGetContent("data/translations/common.csv")
local new_translations = ModTextFileGetContent("mods/nathan-alt_fire/files/translations.csv")
translations = translations
	.. "\n"
	.. new_translations:gsub("\n", "\nnathan-alt_fire_"):gsub("\nnathan-alt_fire_$", "\n")
	.. "\n"
translations = translations:gsub("\r", ""):gsub("\n\n+", "\n")
ModTextFileSetContent("data/translations/common.csv", translations)
