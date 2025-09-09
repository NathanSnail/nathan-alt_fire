-- TODO: rewrite this library to have types so that it's usable
local ez_wand = dofile_once("mods/nathan-alt_fire/lib/EZWand/EZWand.lua")

local me = GetUpdatedEntityID()
local caster = EntityGetRootEntity(me)
local wand = EntityGetParent(me)
local controls = (EntityGetComponent(caster, "ControlsComponent") or {})[1]
if not controls then return end
---@type boolean
local alt_fire = ComponentGetValue2(controls, "mButtonDownThrow")
if alt_fire then
	local genome = (EntityGetComponent(caster, "GenomeDataComponent") or {})[1]
	if not genome then return end
	local from_x, from_y = EntityGetTransform(wand)
	print(wand)
	local hotspot = (
		EntityGetComponentIncludingDisabled(wand, "HotspotComponent", "shoot_pos") or {}
	)[1]
	print(hotspot)
	if hotspot then
		local offset_x, offset_y = ComponentGetValue2(hotspot, "offset")
		print(offset_x, offset_y)
		local cos, sin = ComponentGetValue2(controls, "mAimingVectorNormalized")
		from_x = from_x + offset_x * cos + offset_y * sin
		from_y = from_y + offset_y * cos + offset_x * sin
		print(offset_x, offset_y)
	end
	local target_x, target_y = ComponentGetValue2(controls, "mMousePosition")
	local herd = HerdIdToString(ComponentGetValue2(genome, "herd_id"))
	ez_wand.ShootSpellSequence({ "BOMB" }, from_x, from_y, target_x, target_y, herd)
end
