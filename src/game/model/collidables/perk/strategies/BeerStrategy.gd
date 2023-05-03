class_name BeerStrategy extends CollisionStrategy
	
var _equipped_effect: BeerEquippedEffect

func _init(
	true_collision_result: CollisionResult,
	false_collision_result: CollisionResult,
	lifespan_seconds: float
).(
	true_collision_result,
	false_collision_result
):
	_equipped_effect = BeerEquippedEffect.new(
		EffectType.BEER(),
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

class BeerEquippedEffect extends EquippedEffect:
	
	func _init(
		effect_type: int, lifespan_seconds: float
	).(
		effect_type, lifespan_seconds
	):pass
	
	func apply_effect(snake_properties: SnakeProperties) -> void:
		snake_properties.set_inverted_controls(true)

	func revoke_effect(snake_properties: SnakeProperties) -> void:
		snake_properties.set_inverted_controls(false)
