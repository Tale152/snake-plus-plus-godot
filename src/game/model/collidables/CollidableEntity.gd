class_name CollidableEntity extends Reference

var _coordinates: Coordinates
var _collision_strategy: CollisionStrategy

func _init(
	coordinates: Coordinates,
	collision_strategy: CollisionStrategy
):
	_coordinates = coordinates
	_collision_strategy = collision_strategy

func get_coordinates() -> Coordinates:
	return _coordinates

func collide(snake_properties: SnakeProperties) -> CollisionResult:
	return _collision_strategy.execute(snake_properties)
