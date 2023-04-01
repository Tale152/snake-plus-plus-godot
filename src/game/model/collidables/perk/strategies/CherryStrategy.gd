class_name CherryStrategy extends CollisionStrategy

const _CHERRY_SCORE = 1000

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
		snake_properties.set_potential_length(
			snake_properties.get_potential_length() + 5
		)
		snake_properties.set_score(
			snake_properties.get_score() + (snake_properties.get_score_multiplier() * _CHERRY_SCORE)
		)
		return self._true_collision_result
