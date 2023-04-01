class_name GainCoinStrategy extends CollisionStrategy

const _GAIN_COIN_SCORE = 2000

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
		snake_properties.set_score(
			snake_properties.get_score() + (snake_properties.get_score_multiplier() * _GAIN_COIN_SCORE)
		)
		return self._true_collision_result
