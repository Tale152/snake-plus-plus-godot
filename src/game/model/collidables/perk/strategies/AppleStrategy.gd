class_name AppleStrategy extends CollisionStrategy
	
var _collision_result: CollisionResult = CollisionResult.new(false)

func execute(snake_properties: SnakeProperties) -> CollisionResult:
	snake_properties.set_potential_length(
		snake_properties.get_potential_length() + 1
	)
	return _collision_result
