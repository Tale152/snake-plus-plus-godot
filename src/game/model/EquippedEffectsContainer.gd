class_name EquippedEffectsContainer extends Reference

var _equipped_effects: Array = []

func equip_effect(
	effect: EquippedEffectTODO, 
	snake_properties: SnakePropertiesTODO
) -> void:
	effect.get_expire_timer().reset()
	if effect in _equipped_effects: return
	_equipped_effects.push_back(effect)
	effect.apply_effect(snake_properties)

func revoke_effect(
	effect: EquippedEffectTODO,
	snake_properties: SnakePropertiesTODO
) -> void:
	effect.revoke_effect(snake_properties)
	_equipped_effects.erase(effect)

func get_equipped_effects() -> Array:
	var res = []
	for e in _equipped_effects: res.push_back(e)
	return res
