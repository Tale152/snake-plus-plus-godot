class_name LossCoinStrategy extends CollisionStrategy

const _LOSS_COIN_SCORE = -2000

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
		var new_score: int = snake_properties.get_score() + (snake_properties.get_score_multiplier() * _LOSS_COIN_SCORE)
		snake_properties.set_score(
			new_score if new_score >= 0 else 0
		)
		return self._true_collision_result
