class_name GhostStrategy extends CollisionStrategy
	
var _equipped_effect: GhostEquippedEffect

func _init(
	true_collision_result: CollisionResult,
	false_collision_result: CollisionResult,
	lifespan_seconds: float
).(
	true_collision_result,
	false_collision_result
):
	_equipped_effect = GhostEquippedEffect.new(
		EffectType.GHOST(),
		lifespan_seconds
	)

func execute(
	snake_properties: SnakeProperties,
	effect_container: EquippedEffectsContainer
) -> CollisionResult:
	effect_container.equip_effect(_equipped_effect, snake_properties)
	return self._true_collision_result

class GhostEquippedEffect extends EquippedEffect:
	
	func _init(
		effect_type: int, lifespan_seconds: float
	).(
		effect_type, lifespan_seconds
	):pass
	
	func apply_effect(snake_properties: SnakeProperties) -> void:
		snake_properties.set_intangible(true)

	func revoke_effect(snake_properties: SnakeProperties) -> void:
		snake_properties.set_intangible(false)
