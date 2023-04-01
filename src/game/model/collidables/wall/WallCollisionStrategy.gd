class_name WallCollisionStrategy extends CollisionStrategy

func _init(
	true_collision_result: CollisionResult,
	false_collision_result: CollisionResult
).(
	true_collision_result,
	false_collision_result
): pass

func execute(
	snake_properties: SnakeProperties,
	effect_container: EquippedEffectsContainer
) -> CollisionResult:
	if !snake_properties.is_invincible():
		effect_container.set_is_alive(false) 
	return self._false_collision_result
