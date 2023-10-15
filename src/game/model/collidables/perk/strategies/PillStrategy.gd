class_name PillStrategy extends CollisionStrategy

const _PILL_SCORE = 10000

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
		snake_properties.set_potential_length(9999)
		snake_properties.set_score(
			snake_properties.get_score() + (snake_properties.get_score_multiplier() * _PILL_SCORE)
		)
		return self._true_collision_result
