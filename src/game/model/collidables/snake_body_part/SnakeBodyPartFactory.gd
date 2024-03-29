class_name SnakeBodyPartFactory extends Reference
# I need just one instance of SnakeBodyPartCollisionStrategy to be used
# in every SnakeBodyPart

var _collision_strategy: CollisionStrategy

func _init(
	true_collision_result: CollisionResult,
	false_collision_result: CollisionResult
):
	_collision_strategy = SnakeBodyPartCollisionStrategy.new(
		true_collision_result,
		false_collision_result
	)

func create_new(
	coordinates: Coordinates,
	preceding_part_direction: int,
	following_part_direction: int
) -> SnakeBodyPart:
	return SnakeBodyPart.new(
		coordinates,
		preceding_part_direction,
		following_part_direction,
		_collision_strategy
	)
