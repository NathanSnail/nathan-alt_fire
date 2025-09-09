local __draw_actions_for_shot = _draw_actions_for_shot
_draw_actions_for_shot = function(...)
	local me = GetUpdatedEntityID()
	local vscs = EntityGetComponent(me, "VariableStorageComponent") or {}
	for _, vsc in ipairs(vscs) do
		if ComponentGetValue2(vsc, "name") ~= "nathan-alt_fire_cause" then goto continue end
		local frame = ComponentGetValue2(vsc, "value_int")
		if frame ~= GameGetFrameNum() - 1 then
			EntityRemoveComponent(me, vsc)
			goto continue
		end
		local cause = ComponentGetValue2(vsc, "value_string")
		if cause == "alt_fire" then
			while #deck > 0 do
				local data = deck[1]
				table.insert(discarded, data)
				table.remove(deck, 1)
				if data.id == "NATHAN-ALT_FIRE_ALT_FIRE" then break end
			end
		else
			error("unknown cause of alt fire")
		end
		EntityRemoveComponent(me, vsc)
		::continue::
	end
	return __draw_actions_for_shot(...)
end
