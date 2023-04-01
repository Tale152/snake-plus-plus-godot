class_name WallFactory extends Reference
# I need just one instance of WallCollisionStrategy to be used in every Wall

var _wall_collision_strategy: WallCollisionStrategy

func _init(
	true_collision_result: CollisionResult,
	false_collision_result: CollisionResult
):
	_wall_collision_strategy = WallCollisionStrategy.new(
		true_collision_result,
		false_collision_result
	)

func create_new(coord: Coordinates) -> Wall:
	return Wall.new(coord, _wall_collision_strategy)
