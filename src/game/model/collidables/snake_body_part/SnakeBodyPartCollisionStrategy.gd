class_name SnakeBodyPartCollisionStrategy extends CollisionStrategy
	
var _collision_result: CollisionResult = CollisionResult.new(false)

func execute(snake_properties: SnakeProperties) -> CollisionResult:
	if !snake_properties.is_invincible():
		snake_properties.set_is_alive(false) 
	return _collision_result
