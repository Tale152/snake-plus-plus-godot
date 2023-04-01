class_name BananaStrategy extends CollisionStrategy
	
var _equipped_effect: BananaEquippedEffect

func _init(
	true_collision_result: CollisionResult,
	false_collision_result: CollisionResult,
	lifespan_seconds: float
).(
	true_collision_result,
	false_collision_result
):
	_equipped_effect = BananaEquippedEffect.new(
		EffectType.BANANA(),
		lifespan_seconds
	)

func execute(
	snake_properties: SnakeProperties,
	effect_container: EquippedEffectsContainer
) -> CollisionResult:
	if snake_properties.is_intangible():
		return self._false_collision_result
	else:
		effect_container.equip_effect(_equipped_effect, snake_properties)
		return self._true_collision_result

class BananaEquippedEffect extends EquippedEffect:
	
	var _BANANA_MULTIPLIER: float = 5.0
	
	func _init(
		effect_type: int, lifespan_seconds: float
	).(
		effect_type, lifespan_seconds
	):pass
	
	func apply_effect(snake_properties: SnakeProperties) -> void:
		snake_properties.set_score_multiplier(
			snake_properties.get_score_multiplier() * _BANANA_MULTIPLIER
		)

	func revoke_effect(snake_properties: SnakeProperties) -> void:
		snake_properties.set_score_multiplier(
			snake_properties.get_score_multiplier() / _BANANA_MULTIPLIER
		)
