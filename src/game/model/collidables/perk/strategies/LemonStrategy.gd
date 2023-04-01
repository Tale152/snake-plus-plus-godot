class_name LemonStrategy extends CollisionStrategy

func _init(
	true_collision_result: CollisionResult,
	false_collision_result: CollisionResult
).(
	true_collision_result,
	false_collision_result
): pass

func execute(
	snake_properties: SnakeProperties,
	_effect_container: EquippedEffectsContainer
) -> CollisionResult:
	if snake_properties.is_intangible():
		return self._false_collision_result
	else:
		if snake_properties.is_intangible(): return self._false_collision_result
		if snake_properties.get_potential_length() > 1:
			snake_properties.set_potential_length(
				int(round(snake_properties.get_potential_length() / 2))
			)
		snake_properties.set_score(snake_properties.get_score() / 2)
		return self._true_collision_result
