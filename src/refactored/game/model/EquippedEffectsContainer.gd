class_name EquippedEffectsContainer extends Reference

var _equipped_effects: Array = []

func equip_effect(
	effect: EquippedEffectTODO, 
	snake_properties: SnakePropertiesTODO
) -> void:
	for i in range(0, _equipped_effects.size()):
		if _equipped_effects[i].get_type() == effect.get_type():
			_equipped_effects[i] = effect
			return
	_equipped_effects.push_back(effect)
	effect.apply_effect(snake_properties)

func revoke_effect(
	effect_type: int,
	snake_properties: SnakePropertiesTODO
) -> void:
	for i in range(0, _equipped_effects.size()):
		if _equipped_effects[i].get_type() == effect_type:
			_equipped_effects[i].revoke_effect(snake_properties)
			_equipped_effects.remove(i)
			return

func get_equipped_effects() -> Array:
	var res = []
	for e in _equipped_effects: res.push_back(e)
	return res

func contains_equipped_effect(equipped_effect: EquippedEffectTODO) -> bool:
	for eff in _equipped_effects:
		if eff == equipped_effect: return true
	return false
