class_name AvocadoStrategy extends CollisionStrategy
	
var _equipped_effect: AvocadoEquippedEffect

func _init(
	true_collision_result: CollisionResult,
	false_collision_result: CollisionResult,
	lifespan_seconds: float
).(
	true_collision_result,
	false_collision_result
):
	_equipped_effect = AvocadoEquippedEffect.new(
		EffectType.AVOCADO(),
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

class AvocadoEquippedEffect extends EquippedEffect:
	
	var _AVOCADO_MULTIPLIER: float = 10.0
	
	func _init(
		effect_type: int, lifespan_seconds: float
	).(
		effect_type, lifespan_seconds
	):pass
	
	func apply_effect(snake_properties: SnakeProperties) -> void:
		snake_properties.set_score_multiplier(
			snake_properties.get_score_multiplier() * _AVOCADO_MULTIPLIER
		)

	func revoke_effect(snake_properties: SnakeProperties) -> void:
		snake_properties.set_score_multiplier(
			snake_properties.get_score_multiplier() / _AVOCADO_MULTIPLIER
		)
