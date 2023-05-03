class_name WatermelonStrategy extends CollisionStrategy
	
var _equipped_effect: WatermelonEquippedEffect

func _init(
	true_collision_result: CollisionResult,
	false_collision_result: CollisionResult,
	lifespan_seconds: float
).(
	true_collision_result,
	false_collision_result
):
	_equipped_effect = WatermelonEquippedEffect.new(
		EffectType.WATERMELON(),
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

class WatermelonEquippedEffect extends EquippedEffect:
	
	var _WATERMELON_MULTIPLIER: float = 2.0
	
	func _init(
		effect_type: int, lifespan_seconds: float
	).(
		effect_type, lifespan_seconds
	):pass
	
	func apply_effect(snake_properties: SnakeProperties) -> void:
		snake_properties.set_growth_multiplier(
			snake_properties.get_growth_multiplier() * _WATERMELON_MULTIPLIER
		)

	func revoke_effect(snake_properties: SnakeProperties) -> void:
		snake_properties.set_growth_multiplier(
			snake_properties.get_growth_multiplier() / _WATERMELON_MULTIPLIER
		)
