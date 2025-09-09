ModLuaFileAppend(
	"data/scripts/gun/gun_actions.lua",
	"mods/nathan-alt_fire/files/scripts/gun_actions.lua"
)
ModLuaFileAppend("data/scripts/gun/gun.lua", "mods/nathan-alt_fire/files/scripts/gun_append.lua")

local messages = {}
local _print = print
---@diagnostic disable-next-line: unused-function
local function print(...)
	local s = ""
	for _, v in ipairs({ ... }) do
		s = s .. tostring(v) .. "\t"
	end
	-- why did it lose the type??
	---@cast s string
	table.insert(messages, s:sub(1, s:len() - 1))
end

---@type OnPlayerSpawned
function OnPlayerSpawned(_)
	for _, message in ipairs(messages) do
		_print(message)
	end
end

local translations = ModTextFileGetContent("data/translations/common.csv")
local new_translations = ModTextFileGetContent("mods/nathan-alt_fire/files/translations.csv")
translations = translations
	.. "\n"
	.. new_translations
		:gsub("^\n*", "\n")
		:gsub("\n", "\nnathan-alt_fire_")
		:gsub("nathan%-alt_fire_$", "\n")
	.. "\n"
translations = translations:gsub("\r", ""):gsub("\n\n+", "\n")
ModTextFileSetContent("data/translations/common.csv", translations)
