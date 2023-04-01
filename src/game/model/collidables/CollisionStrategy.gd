class_name CollisionStrategy extends Reference
# is ment to be used as an Abstract Class

var _true_collision_result: CollisionResult
var _false_collision_result: CollisionResult

func _init(
	true_collision_result: CollisionResult,
	false_collision_result: CollisionResult
):
	_true_collision_result = true_collision_result
	_false_collision_result = false_collision_result

func execute(
	_snake_properties: SnakeProperties,
	_effect_container: EquippedEffectsContainer
) -> CollisionResult:
	push_error(
		"You called the execute function of CollisionStrategy, " + 
		"which is ment to be used as an interface"
	)
	return null
